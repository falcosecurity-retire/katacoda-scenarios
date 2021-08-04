Falco has two files of rules:

- a default rules file, installed at `/etc/falco/falco_rules.yaml`.  You should not modify this file.
- a local rules file, installed at `/etc/falco/falco_rules.local.yaml`. Your additions or modifications to the default rules should be in this file.

The default rules file contains detection patterns for many common threats.  This file is always read first, followed by the local rules file.

This makes easy to customize falco's behavior, and still allows to update the rules as part of software upgrades.

A falco rules file is a YAML file containing three kinds of elements: rules, macros, and lists.

- **Rules** consist of a condition under which an alert should be generated and a output string to send with the alert.
- **Macros** are simply rule condition snippets that can be re-used inside rules and other macros, providing a way to factor out and name common patterns.
- **Lists** are (surprise!) lists of items that can be included in rules, macros, or other lists. Unlike rules/macros, they can not be parsed as sysdig filtering expressions.

A Rule is a node in the YAML file containing at least the following keys:

- **rule**: a short unique name for the rule
- **condition**: a filtering expression that is applied against events to see if they match the rule.
- **desc**: a longer description of what the rule detects
- **output**: it specifies the message that should be output if a matching event occurs, and follows the Sysdig output format syntax.
- **priority**: a case-insensitive representation of severity and should be one of "emergency", "alert", "critical", "error", "warning", "notice", "informational", or "debug".

Additional optional keys are: `enabled`, `tags`, `warn_evttypes` and `skip-if-unknown-filter`.
