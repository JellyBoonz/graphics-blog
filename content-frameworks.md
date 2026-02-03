# Content Frameworks Reference

## Introduction

This document outlines the content frameworks for creating LinkedIn posts and blog posts that share transferable thinking skills with beginner-intermediate graphics programmers.

### Philosophy

**Core Principle**: "Share how I think through graphics problems, not just how to follow tutorials."

Each piece of content follows a consistent structure so readers learn the pattern and can apply it to new problems independently.

### How the Frameworks Work Together

- **LinkedIn Posts**: Share a complete insight that delivers value while filtering for serious learners
- **Blog Posts**: Deep dive with structured exploration that builds independent problem-solving skills
- **Bridge**: LinkedIn shares transferable insights → Blog deepens with constraint reasoning

---

## LinkedIn Post Framework

### Structure

```
[HOOK: Here's an insight I discovered and why it matters]
[BODY: The discovery - complete insight]
[CONCLUSION: This is what clicked for me, and why you might find it useful]
[CTA: Bridge to deeper exploration]
```

### Hook Guidelines

**Purpose**: Share a transferable insight + explain why it might matter

**Formula**: 
- "I used to think [wrong assumption]. Then I discovered [insight/reframing] that applies to [broader context]"
- "Here's why this matters: [stakes/consequences]"

**Alternative Formula**:
- "Here's an insight that reframed how I think about [problem]: [skill/pattern]"
- "Here's why it matters: [stakes/consequences]"

**Key Principles**:
- Be explicit about the insight (no guessing required)
- Connect to broader applications beyond graphics
- Add stakes to make it compelling
- Frame as personal discovery, not instruction
- Filter for serious learners, not just scrollers

**Examples**:

✅ **Strong Hook:**
> "I used to think noisy renders were a sampling problem. Then I discovered they're actually variance problems—and that reframing applies to ML, simulations, and any Monte Carlo method. Here's why it matters: most people waste compute asking the wrong questions."

❌ **Weak Hook:**
> "I made a bubble with math 🫧"

### Body Guidelines

**Purpose**: Share a complete insight that provides real value

**Structure**:
1. Show the problem/failure mode
2. Explain the insight (what I discovered is really happening)
3. Show the result/application

**Key Principles**:
- Don't just tease—actually share something valuable
- Make it a standalone insight (readers should feel they discovered something)
- Use visual comparisons when possible
- Keep it concise but complete
- Frame as "here's what I found" not "here's what you should know"

**Example Structure**:
```
[Problem] → [Insight] → [Result]
```

### Conclusion Guidelines

**Purpose**: Reflection on what clicked, not just a summary

**Formula**:
- "This reframing changed how I approach [problem class]"
- "If this insight clicks for you too, you've discovered [skill/pattern]"
- "This thinking pattern applies to [other contexts]"

**Key Principles**:
- Reinforce the transferable insight
- Connect to broader applications
- Create a sense of completion
- Make it a reflection moment, not redundancy
- Frame as personal discovery that might resonate

**Examples**:

✅ **Strong Conclusion:**
> "This reframing changed how I approach Monte Carlo problems. If it clicks for you too, you've discovered a diagnostic pattern that applies anywhere you're using random sampling: financial modeling, physics simulations, machine learning."

❌ **Weak Conclusion:**
> "Check out my blog for more!"

### CTA Guidelines

**Purpose**: Bridge to deeper content naturally

**Formula**:
- "Full breakdown with [specific framework element] on my blog"
- "Link in comments"

**Key Principles**:
- Reference what they'll get (constraint reasoning, diagnostic thinking, etc.)
- Keep it low-commitment
- Place link in comments (better for LinkedIn algorithm)

### Complete LinkedIn Post Example

**Topic**: Importance Sampling

```
I used to think noisy renders were a sampling problem. Then I discovered they're actually variance problems—and that reframing applies to ML, simulations, and any Monte Carlo method. Here's why it matters: most people waste compute asking the wrong questions.

Noisy renders aren't a sampling problem. They're a variance problem.

When you randomly sample light directions, you're treating all directions as equally important. But light isn't uniform—some directions matter way more than others. The noise is feedback telling you you're being inefficient.

The solution: importance sampling. Instead of sampling everywhere, bias your effort toward directions that actually drive the result. The visual difference is dramatic: uniform sampling creates noise; importance sampling creates clean images with fewer samples.

This reframing changed how I approach Monte Carlo problems. If it clicks for you too, you've discovered a diagnostic pattern that applies anywhere you're using random sampling: financial modeling, physics simulations, machine learning.

Full breakdown with constraint reasoning on my blog. Link in comments.

#ComputerGraphics #MonteCarlo #Rendering
```

---

## Blog Post Framework

### Structure: Spot → Think → Build

```
1. [What You'll Gain] - Capabilities, not just knowledge
2. [Spot the Real Problem] - Show failure mode, name problem class, identify constraints
3. [Think Through the Constraints] - Predict, constrain, derive
4. [Build with Diagnostic Confidence] - Implement, diagnose, generalize
```

### Essential Elements

#### At the Top: "What You'll Gain"

**Purpose**: Set expectations about transferable insights

**Include**:
- Specific thinking patterns I discovered
- Problem classes I learned to recognize
- Diagnostic approaches that helped me
- How these apply beyond this specific problem

**Example**:
> "Here's what I discovered that might help you:
> - How to recognize variance problems vs. sampling problems
> - A way to reason through constraints to derive solutions
> - How to diagnose when an implementation is wrong
> - A thinking pattern that applies to any Monte Carlo method"

#### Throughout: "Stop and Think" Moments

**Purpose**: Make readers think before revealing solutions

**Include**:
- Prediction prompts: "What would happen if we tried X?"
- Constraint questions: "What can't we do? What must be true?"
- Before revealing solutions, make them predict first

**Example**:
> "Before we jump to the solution, let's think: What would happen if we just sampled more uniformly? What constraints can't we violate? What must be true about our sampling distribution?"

#### At the End: Diagnostic Validation & Generalization

**Purpose**: Share debugging thinking and adaptation approaches

**Include**:
- "How would we know if this is wrong?" (diagnostic questions)
- "What's the pattern?" (generalization)
- "How might you adapt this to problem Y?" (application)

### Spot the Real Problem

**Purpose**: Share how I recognize problems, not just symptoms

**Structure**:
1. **Show the failure mode first** - Visual/example of the problem
2. **Name the problem class** - "This is a variance problem, not a sampling problem"
3. **Identify what must be true** - Constraints we can't violate

**Why**: Readers discover how to recognize problem classes, not just symptoms

**Example**:
> "Look at this noisy render. Most tutorials would tell you to add more samples. But the real problem isn't insufficient samples—it's high variance. The noise is feedback: you're asking the wrong questions. What must be true? We can't violate the rendering equation. We can't introduce bias. But we can change where we sample."

### Think Through the Constraints

**Purpose**: Share how I reason through constraints using first-principles thinking

**Structure**:
1. **Predict**: "What would happen if we tried X?" (make them think first)
2. **Constrain**: "What can't we do? What must we preserve?"
3. **Derive**: Build the solution from those constraints, not from a recipe

**Why**: Shares constraint reasoning and first-principles thinking approaches

**Example**:
> "Let's think through the constraints:
> 
> - What would happen if we sampled more toward bright lights? We'd get less noise, but we'd need to account for the non-uniform sampling.
> - What can't we do? We can't introduce bias—our estimate must still converge to the true value.
> - What must be true? We must divide by the PDF to keep our estimator unbiased.
> 
> From these constraints, the solution emerges: sample according to where light is bright, but divide by the probability of sampling that direction."

### Build with Diagnostic Confidence

**Purpose**: Share solutions I can debug and adapt

**Structure**:
1. **Implement**: Code appears only after reasoning is clear
2. **Diagnose**: "How would we know if this is wrong?" (share debugging thinking)
3. **Generalize**: "What's the pattern? How might you adapt this to problem Y?"

**Why**: Shares solutions readers can debug and adapt, not just copy

**Example**:
> "Now that we understand the constraints, here's the implementation:
> 
> [Code]
> 
> How would we know if this is wrong? Check for bias: does the estimate converge to the true value? Check for variance: does the noise decrease? If variance increases, our PDF doesn't match the integrand well enough.
> 
> What's the pattern? Importance sampling works when you can create a PDF that matches (or approximates) where the function is large. This applies to any Monte Carlo integration problem, not just rendering."

### Complete Blog Post Example Structure

```markdown
## What You'll Gain

Here's what I discovered that might help you:
- How to recognize variance problems vs. sampling problems
- A way to reason through constraints to derive solutions
- How to diagnose when an implementation is wrong
- A thinking pattern that applies to any Monte Carlo method

## Spot the Real Problem

[Show noisy render]

This isn't a sampling problem—it's a variance problem. The noise is feedback telling you you're being inefficient. What must be true? We can't violate the rendering equation. We can't introduce bias. But we can change where we sample.

## Think Through the Constraints

Before we jump to the solution, let's think:

- What would happen if we sampled more toward bright lights?
- What can't we do? (We can't introduce bias)
- What must be true? (We must divide by the PDF)

From these constraints, the solution emerges...

## Build with Diagnostic Confidence

[Implementation after reasoning]

How would we know if this is wrong?
- Check for bias: does the estimate converge?
- Check for variance: does noise decrease?

What's the pattern? This applies to any Monte Carlo integration problem...

## Putting It All Together

[Summary that reinforces the thinking pattern]
```

---

## Integration Guide

### How to Use Both Frameworks Together

1. **Start with Blog Post Framework** (Spot → Think → Build)
   - This is your content strategy
   - Build the deep, pedagogical content first

2. **Extract Mini-Lesson for LinkedIn**
   - Take the "Spot" section → becomes problem in LinkedIn body
   - Take the key insight from "Think" → becomes insight in LinkedIn body
   - Take the result from "Build" → becomes result in LinkedIn body

3. **Craft LinkedIn Hook**
   - Share the transferable insight from "What You'll Gain"
   - Add stakes: why it matters beyond graphics

4. **Write LinkedIn Conclusion**
   - Reflect on what clicked for you from "Build"
   - Connect to broader applications

5. **Bridge with CTA**
   - Reference what they'll get: "constraint reasoning", "diagnostic thinking", etc.

### Workflow Example

**Step 1**: Write blog post using Spot → Think → Build
- Define "What You'll Gain"
- Structure problem → constraints → solution
- Add diagnostic questions

**Step 2**: Extract LinkedIn content
- Hook: "I used to think [wrong assumption]. Then I discovered [insight from What You'll Gain]..."
- Body: Problem → Insight → Result (condensed from blog)
- Conclusion: "This reframing changed how I approach [problem]. If it clicks for you too..."

**Step 3**: Refine for each platform
- LinkedIn: Complete insight, standalone value
- Blog: Deep dive with full constraint reasoning

---

## Quick Reference Templates

### LinkedIn Post Template

```
[HOOK]
I used to think [WRONG ASSUMPTION]. Then I discovered [INSIGHT/REFRAMING] that applies to [BROADER CONTEXT]. Here's why it matters: [STAKES/CONSEQUENCES].

[BODY]
[Problem/Failure Mode]

[Insight: What I discovered is really happening]

[Result/Application]

[CONCLUSION]
This reframing changed how I approach [PROBLEM CLASS]. If it clicks for you too, you've discovered [SKILL/PATTERN]. This thinking pattern applies to [OTHER CONTEXTS].

[CTA]
Full breakdown with [FRAMEWORK ELEMENT] on my blog. Link in comments.

#Hashtags
```

### Blog Post Template

```markdown
## What You'll Gain

Here's what I discovered that might help you:
- [Insight/Capability 1]
- [Insight/Capability 2]
- [Insight/Capability 3]

## Spot the Real Problem

[Show failure mode]

This is a [PROBLEM CLASS], not a [SYMPTOM]. [What must be true?]

## Think Through the Constraints

Before we jump to the solution, let's think:

- What would happen if we tried [X]?
- What can't we do? What must we preserve?
- What must be true?

From these constraints, the solution emerges...

## Build with Diagnostic Confidence

[Implementation after reasoning]

How would we know if this is wrong?
- [Diagnostic question 1]
- [Diagnostic question 2]

What's the pattern? This applies to [BROADER CONTEXT]...

## Putting It All Together

[Summary that reinforces the thinking pattern]
```

---

## Key Principles to Remember

### For LinkedIn Posts
- ✅ Share transferable insights upfront
- ✅ Deliver complete insight (not just teaser)
- ✅ Reflect on what clicked for you
- ✅ Use first-person discovery language
- ❌ Don't use emoji-first hooks
- ❌ Don't just say "I made X"
- ❌ Don't make conclusion redundant
- ❌ Don't use prescriptive "teach" language

### For Blog Posts
- ✅ Problem-first, not feature-first
- ✅ Constraint-driven, not recipe-driven
- ✅ Diagnostic-focused, not implementation-focused
- ✅ Share thinking patterns, not just knowledge
- ✅ Use first-person discovery language
- ❌ Don't jump to implementation without reasoning
- ❌ Don't skip "What You'll Gain"
- ❌ Don't forget diagnostic questions
- ❌ Don't use prescriptive "teach" language

### For Both
- ✅ Each post shares a thinking pattern I discovered
- ✅ Readers discover how to recognize problem classes
- ✅ Readers discover how to reason through constraints
- ✅ Readers discover how to build solutions they can debug and adapt
- ✅ Consistent structure so readers learn the pattern
- ✅ Use first-person, peer-to-peer language

---

## Notes

- These frameworks work together: LinkedIn shares insights and delivers value, Blog deepens with exploration
- The goal is to help build independent problem-solvers, not tutorial-followers
- Consistency in structure helps readers learn the pattern and apply it independently
- Always connect to broader applications beyond just graphics programming
- Use first-person, discovery-oriented language to maintain peer-to-peer tone
- Frame insights as personal discoveries that might resonate, not as instruction