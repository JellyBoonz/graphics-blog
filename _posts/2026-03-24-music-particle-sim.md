---
layout: post
title: "Particle simulation from Sound Input"
date: 2026-4-13 10:00:00 -0000
tags: [rendering, mathematics, computer-graphics]
author: "Jaiden Ortiz aka JellyBoonz"
---
### Introduction

---

The past couple of months, I've been thinking a lot about music. If your anything like me, music can be a way to transport you to some other place or even get in touch with feelings you didn't know you had. Wanting to leverage some of my newfound knowledge of computer graphics, I sought a way to augment the experience of music through real-time visualizations. Now, there are many music vizualizers out there, but most just respond to amplitude "loud = big, quiet = small" or something akin to this. I wanted to created a system that could understand and respond to not only how loud incoming sound is, but to the *music*. This meant going further than looking at raw audio and answering questions like "how do I know what chord is being played?" and "What makes something sound happy or sad?".

#### The pipeline at a glance
---
The pipeline roughly does five things:
- Take in audio input
- Send the raw samples to Musical Context
- Pull out musical information like emotion or chord type
- Pass musical context to Particle parameters through a bridge
- Render as a particle system visualization
<figure>
<img src="/assets/images/music-viz/Rough-pipeline-flow.png" alt="Noisy Render">
<figcaption>Rough pipeline flow</figcaption>
</figure>

#### Music from raw sound
---
Sound comes in using a technique called FFT. If you don't already know what FFT does, think of it this way: All sounds are made up of many waves at different frequencies, kind of like many colors are made up of a combination of different fundamental colors. FFT pulls out the relevant frequencies being played from a given sound (voice, piano note, car horn). Going with the color analogy, this would be like starting with a given color, and pulling out the basic colors that were mixed to make it in the first place. For those who want a more justifiable introduction to FFT, it's definitely worth checking out 3blue1brown's video on it [here](https://www.youtube.com/watch?v=spUNpyF58BY).

So I used FFT to parse out the component frequencies from a given sound.

But, when does that sound turn into music? There are three things I do in this project to decide what kind of musical qualities we are hearing:
1. Chroma vectors + chord template matching
2. Derive semantics
3. Use Pitch confidence as a visual gate

#### Chroma Vectors + Chord template matching
---
FFT gives us a spectrum: a list of magnitudes at each frequency bin. But a raw spectrum
isn't music — at least not yet. To get there, we need to map frequencies to pitch classes.

There are 12 pitch classes in Western music: C, C#, D, D#, E, F, F#, G, G#, A, A#, B.
Any frequency $f$ can be assigned to one of these 12 using its relationship to A4 (440 Hz)
as a reference:

$$
p = 12 \times \log_2\!\left(\frac{f}{440}\right)
$$

Why $\log_2$? Because differences in frequency aren't linear, but multiplicative. A4 is 
double the frequency as A3 (440 Hz to 220 Hz). Therefore, we measure differences in frequency
by powers of 2. 

$$
c = \bigl(\operatorname{round}(p) + 9\bigr) \bmod 12
$$

Here $p$ is the number of semitones from A4 and $c$ is the pitch class (0 = C, 1 = C#, … 11 = B).

For every FFT bin, I compute its pitch class and octave, then accumulate the magnitude
into a $12 \times 6$ matrix $M$ (12 pitch classes × 6 octaves). Collapsing the octave dimension by
summing across rows gives us a chroma vector $\boldsymbol{\chi}$ — 12 values representing how much energy is
present in each pitch class, regardless of which octave it came from.

$$
\chi_c = \sum_{k=0}^{5} M[c,\, k]
$$

Now the question is: given this chroma vector, what chord is being played? I use
template matching. For each of the 36 possible triads (12 roots ×
major/minor/diminished), I build a binary template vector $\mathbf{t}$ that marks which pitch classes
belong to that chord:

- Major: root, root+4, root+7 semitones
- Minor: root, root+3, root+7 semitones
- Diminished: root, root+3, root+6 semitones

Matching is just a normalized dot product — essentially cosine similarity — between
$\boldsymbol{\chi}$ and each $\mathbf{t}$:

$$
r = \frac{\boldsymbol{\chi} \cdot \mathbf{t}}{\|\boldsymbol{\chi}\| \cdot \|\mathbf{t}\|}
$$

The template with the highest $r$ above a threshold (0.5) wins. The output is a
chord root (0–11) and a quality (major/minor/diminished) with a confidence score.

#### Deriving Semantics
---

Once we have a chord identity, we can start extracting musical meaning. This is where
the system goes from "what notes are playing" to "how does this sound feel."

Inversion tells us the voicing of the chord — specifically, what note is in the bass. To
find it, I look at the lowest octave in the pitch-class matrix that has significant
energy and identify the dominant pitch class there. If the bass note matches the chord's
root, it's root position. If it matches the third or fifth, it's in first or second
inversion respectively.

This matters because inversions change the character of a chord. A C major chord in root
position sounds grounded and resolved. The same chord in second inversion sounds
unstable — it wants to move somewhere.

From chord quality and inversion I derive four semantic values used downstream:

| Property   | Rule |
|------------|------|
| Tension    | Diminished=0.9, Minor=0.5, Major=0.15 (+0.1 for second inversion) |
| Stability  | Root position=1.0, First inversion=0.7, Second inversion=0.4 |
| Melancholy | Diminished=0.9, Minor=0.7, Major=0.2 |
| Brightness | Treble energy / Total energy |

These aren't arbitrary — they loosely codify real music theory intuitions about how
chords feel. A diminished chord is high tension, high melancholy, low stability. A major
chord in root position is the opposite.

#### Pitch Confidence as a Visual Gate
---

Chord detection works best when there's clear harmonic content. But not all sound is
musical — noise, transients, and single percussive hits produce low-confidence results
where the best template match is weak.

I use the McLeod Pitch Method (MPM) to estimate the dominant pitch and a confidence
value (0–1) via autocorrelation. When confidence is low, the particle system shifts
toward a neutral, desaturated color instead of responding to chord data that isn't
reliable. This prevents visual noise from non-musical input while still allowing the
system to react to energy and rhythm.

#### The Bridge: Musical Context to Particle Parameters                                                                                                                               
---                                                                                                                                                                                   
                                                                                                                                                                                    
Now that we have semantic values, the question becomes: *what do we do with them?*
                                                                                                                                                                                    
The bridge is the translation step between the musical analysis and the visual system. Each semantic value is smoothed frame-to-frame with an exponential moving average to prevent   
jarring transitions:
                                                                                                                                                                                    
$$              
v_t = \alpha \cdot v_{\text{new}} + (1 - \alpha) \cdot v_{t-1}
$$

A small $\alpha$ means slow, gradual changes — a large $\alpha$ means the visualization snaps quickly to new input. Each smoothed value then drives a particle parameter:             

| Source         | Particle Parameter      | Effect                                              |                                                                                    
|----------------|-------------------------|-----------------------------------------------------|                                                                                    
| Chord root     | Hue                     | Each of the 12 roots maps to a distinct color       |                                                                                    
| Tension        | Saturation + velocity   | High tension = vivid color, faster particles        |                                                                                    
| Melancholy     | Value (darkness)        | High melancholy = darker, moodier particles         |                                                                                    
| Energy         | Spawn gate + base size  | Loud = more particles, larger                       |                                                                                    
| Stability      | Drag + direction bias   | High stability = particles drift and settle         |                                                                                    
| Chord quality  | Lifetime                | Major=2.0s, Minor=1.2s, Diminished=0.6s             |                                                                                    
| Dominant pitch | Spawn Y                 | Higher pitch = particles born higher on screen      |                                                                                             

Pitch confidence acts as a global gate multiplier. When it drops below the threshold, the bridge lerps every value back toward a neutral baseline rather than feeding unreliable chord
data downstream.
                                                                                                                                                                                    
#### The Particle System
---

Each frame, forces are accumulated from three overlapping fields and integrated with a simple Euler step:                                                                                                                                                             
                  
$$                                                                                                                                                                                    
\mathbf{v}_{t+1} = \mathbf{v}_t + \bigl(\mathbf{F}_{\text{swirl}} + \mathbf{F}_{\text{flow}} + \mathbf{F}_{\text{curl}}\bigr)\,\Delta t
$$                                                                                                                                                                                    

$$                                                                                                                                                                                    
\mathbf{p}_{t+1} = \mathbf{p}_t + \mathbf{v}_{t+1}\,\Delta t
$$                                                                                                                                                                                    

- $\mathbf{F}\_{\text{swirl}}$ orbits particles around a slowly drifting center point.                                                                                                   
- $\mathbf{F}\_{\text{flow}}$ is a sinusoidal directional field that shifts over time.
- $\mathbf{F}\_{\text{curl}}$ adds a curl-like rotational component using trig approximations.                                                                                           

All three are scaled by `flowStrength`, which is driven by tension — a tense diminished chord produces fast, turbulent motion while a stable major chord produces slow, looping orbits. A drag term proportional to stability keeps resolved chords from spiraling out of control.                                                                                                                                                                        
                
Particles are rendered as **oriented trail strokes**. Each particle maintains a short history of past positions. Each frame, quads are built along the tangent of the trail — wider at the head, tapering at the tail — giving particles a comet-like appearance that reveals direction of motion. The fragment shader applies a procedural elliptical falloff along the stroke, softening the edges. Color fades toward a neutral grey as pitch confidence drops, keeping the visuals from reacting to unreliable chord data.  
                                                                                                                                                                                    
#### Putting It Together
---

Here's a concrete example of the pipeline end-to-end. A C major chord lands:

1. FFT returns a clean spectrum with strong energy at C, E, G.
2. Chroma vector confirms — those three pitch classes dominate.
3. Template matching returns C major, root position, high confidence.                                                                                                                 
4. Semantics: low tension (0.15), high stability (1.0), low melancholy (0.2).
5. Bridge: attractor is strong, turbulence is low, hue sits in warm yellows and whites.                                                                                               
6. Particles pull inward, orbit slowly, glow warm.                                                                                                                                    

Then the chord shifts to D diminished. Tension spikes to 0.9, stability collapses. Turbulence climbs, the attractor weakens, particles scatter outward. Colors shift deep into        
purples. The system feels like it's breaking apart — because harmonically, it is.
                                                                                                                                                                                    
<figure>        
<img src="/assets/images/music-viz/particle-demo.gif" alt="Particle system responding to chord change">
<figcaption>C major → D diminished. The system reacts to the harmonic shift, not just the volume.</figcaption>
</figure>                                                                                                                                                                             

#### Conclusion                                                                                                                                                                       
---             

This was one of the more satisfying things I've built. Most visualizers treat sound as a raw signal to react to — louder means bigger, quieter means smaller. Building something that 
tries to *understand* what it's hearing, even in a limited way, felt genuinely different. There's something that hits different about watching a particle field mirror a chord 
progression, shifting in character between warm and cool, resolved and tense, stable and chaotic.                                                                                     
                
There's a lot left to explore. Key detection and tracking progressions over time could feed much richer context downstream. Rhythm and beat detection are completely absent from this 
pipeline — the system understands harmony but is blind to groove. And on the rendering side, there's plenty of room to push the visual language further.
                                                                                                                                                                                    
For now though, I'm pretty happy with where it landed. If you want to dig into the code, it's up on GitHub [here](https://github.com/JellyBoonz/MetalRenderer). And if you end up building something with it or on top of it — I'd genuinely love to see it