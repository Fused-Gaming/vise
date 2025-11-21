# Module 1: Prompt Engineering - Exercises

## Foundation Exercises

### Exercise 1.1: Basic Prompt Writing
**Objective**: Learn to write clear, effective prompts

**Tasks**:
1. Write a prompt to explain blockchain to a 10-year-old
2. Write a prompt to generate a Python function that checks if a number is prime
3. Write a prompt to summarize a technical article in 3 bullet points
4. Write a prompt to translate code comments from English to Spanish

**Success Criteria**:
- Prompts produce expected output consistently
- Instructions are clear and unambiguous
- Output quality is high

### Exercise 1.2: Few-Shot Learning
**Objective**: Use examples to guide AI behavior

**Tasks**:
1. Create a prompt with 3 examples that teaches the AI to format function names in camelCase
2. Design a few-shot prompt for generating Solidity function NatSpec comments
3. Build a prompt that converts user stories to technical requirements (provide 2 examples)

**Success Criteria**:
- AI follows the pattern from examples
- Works with new inputs not in examples
- Consistent formatting

### Exercise 1.3: Prompt Refinement
**Objective**: Iterate to improve prompt quality

**Task**:
Given this vague prompt: "Make a token"

Refine it through 5 iterations to be specific enough to generate a complete ERC-20 token contract.

**Success Criteria**:
- Each iteration improves specificity
- Final prompt generates usable code
- Document what each iteration added

## Intermediate Exercises

### Exercise 1.4: Chain-of-Thought Prompting
**Objective**: Break down complex reasoning

**Tasks**:
1. Write a prompt that explains how a smart contract vulnerability works using step-by-step reasoning
2. Create a prompt that debugs a piece of code by thinking through it systematically
3. Design a prompt that solves a logic puzzle by showing its work

**Success Criteria**:
- AI shows reasoning steps
- Conclusion follows logically from steps
- Explanation is clear and educational

### Exercise 1.5: Role-Based Prompts
**Objective**: Use persona prompting effectively

**Tasks**:
1. Create a "Smart Contract Security Auditor" persona prompt
2. Design a "Web3 Teacher for Beginners" persona
3. Build a "Gas Optimization Expert" persona

Test each with relevant questions.

**Success Criteria**:
- Responses match the persona
- Expertise level is appropriate
- Consistent character voice

### Exercise 1.6: Context Management
**Objective**: Provide optimal context for tasks

**Tasks**:
1. Write a prompt to refactor code, including just enough context
2. Create a prompt for debugging that includes error messages and relevant code
3. Design a prompt for code review that includes project requirements

**Success Criteria**:
- Context is sufficient but not excessive
- AI has information needed for task
- Token usage is optimized

## Advanced Exercises

### Exercise 1.7: Prompt Chaining
**Objective**: Chain multiple prompts for complex tasks

**Task**:
Design a 4-prompt chain that:
1. Analyzes a smart contract for security issues
2. Categorizes issues by severity
3. Generates remediation code
4. Writes test cases for the fixes

**Success Criteria**:
- Each prompt builds on previous output
- Chain produces coherent final result
- Intermediate outputs are usable

### Exercise 1.8: Constraint Handling
**Objective**: Work within limitations

**Tasks**:
1. Write a prompt that generates code under 50 lines
2. Create a prompt that explains a concept in exactly 100 words
3. Design a prompt that writes Solidity code using only OpenZeppelin imports

**Success Criteria**:
- AI respects constraints
- Quality doesn't suffer significantly
- Constraints are clearly specified

### Exercise 1.9: Error Correction
**Objective**: Improve AI output when it's wrong

**Task**:
Given an AI-generated smart contract with bugs:
1. Write a prompt that identifies the bugs
2. Write a prompt that explains why they're bugs
3. Write a prompt that fixes them with explanation

**Success Criteria**:
- Bugs are correctly identified
- Explanations are accurate
- Fixes are appropriate

## Integration Exercises

### Exercise 1.10: Multi-Turn Conversation
**Objective**: Maintain context across conversation

**Task**:
Conduct a conversation where you:
1. Ask AI to design a smart contract
2. Request modifications to the design
3. Ask for implementation
4. Request tests
5. Ask for documentation

**Success Criteria**:
- AI maintains context throughout
- Changes are incorporated correctly
- Final output is cohesive

### Exercise 1.11: Prompt Library Creation
**Objective**: Build reusable prompts

**Task**:
Create a library of 10 reusable prompts for:
- Code generation
- Code review
- Documentation
- Testing
- Debugging

**Success Criteria**:
- Prompts are well-documented
- Prompts are parameterizable
- Prompts are tested and reliable

### Exercise 1.12: A/B Testing
**Objective**: Compare prompt effectiveness

**Task**:
Write 3 different prompts for the same task (e.g., "Generate an ERC-721 contract"). Test each 5 times and compare:
- Output quality
- Consistency
- Completeness
- Adherence to requirements

**Success Criteria**:
- Systematic testing methodology
- Clear documentation of results
- Identify best performing prompt
- Understand why it performed better

## Practical Application

### Exercise 1.13: Development Workflow Integration
**Objective**: Use AI in real development

**Task**:
Pick a real coding task and use AI assistance for:
1. Planning and architecture
2. Code generation
3. Testing strategy
4. Documentation
5. Debugging

Document the prompts you used and the results.

**Success Criteria**:
- Complete a real project feature
- AI assistance was helpful
- Document lessons learned
- Identify where AI helped most

### Exercise 1.14: Prompt Optimization
**Objective**: Minimize tokens while maintaining quality

**Task**:
Take a long prompt (>500 tokens) and optimize it to <200 tokens while maintaining output quality.

**Success Criteria**:
- 60%+ token reduction
- Output quality maintained
- Key instructions preserved
- Test with multiple inputs

### Exercise 1.15: Bias Detection
**Objective**: Identify and mitigate AI biases

**Task**:
1. Write prompts that might elicit biased responses
2. Identify the biases in outputs
3. Rewrite prompts to mitigate bias
4. Compare results

**Success Criteria**:
- Biases correctly identified
- Mitigation strategies effective
- Documentation of findings
- Understanding of AI limitations

## Bonus Challenges

### Challenge 1.1: Prompt Engineering Competition
Work with a partner. Each write a prompt for the same task. Compare outputs blindly and vote on quality.

### Challenge 1.2: Reverse Prompt Engineering
Given only AI output, reverse-engineer what prompt might have produced it.

### Challenge 1.3: Minimal Prompt
Write the shortest possible prompt that achieves a specific complex task.

### Challenge 1.4: Universal Prompt
Create a single prompt template that works for multiple related tasks with minimal modifications.

## Assessment Preparation

Complete these to prepare for your PE-1 assessment:

1. Build a portfolio of your 10 best prompts with documentation
2. Create a prompt pattern library (at least 5 patterns)
3. Write a reflection on prompt engineering best practices
4. Demonstrate prompt iteration and improvement process
5. Show effective use of AI in a coding project

## Resources

- Save all your prompts in a Git repository
- Document what worked and what didn't
- Share successful prompts with peers
- Learn from others' approaches
- Iterate based on feedback

## Submission Format

For each exercise, submit:
```
exercise-1-X/
├── README.md          # Explanation of approach
├── prompts.md         # The prompts you wrote
├── outputs/           # AI outputs
│   ├── attempt-1.md
│   ├── attempt-2.md
│   └── final.md
└── reflection.md      # What you learned
```

Good luck with your prompt engineering journey!
