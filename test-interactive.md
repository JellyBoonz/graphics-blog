---
layout: post
title: "Test Interactive Demo"
date: 2025-01-20 10:00:00 -0000
---

## Interactive Importance Sampling Demo

Here's the interactive demo for importance sampling. Drag the arrows to see how sample distribution affects noise on the ball.

{% include interactive/importance-sampling.html id="test1" %}

Notice how moving the arrows toward the light source (shown in yellow) reduces noise on the ball. This demonstrates importance sampling—we're biasing our samples toward directions that actually contribute to the final image.

### How to Use

1. **Drag the arrows**: Click and drag the circular handles at the end of each arrow to reposition sample directions
2. **Adjust sample count**: Use the slider to change the number of samples
3. **Reset**: Click "Reset to Uniform" to return to uniform sampling

The ball's noise pattern updates in real-time as you move the arrows. Arrows closer to the light source (yellow circle) have higher contribution and reduce noise more effectively.
