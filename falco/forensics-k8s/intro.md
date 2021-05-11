**Falco** is an open source project for intrusion and abnormality detection for Cloud Native platforms such as Kubernetes, Mesosphere, and Cloud Foundry.

It can detect abnormal application behavior, and alert via Slack, Fluentd, NATS, and more.

It can also protect your platform by taking action through serverless (FaaS) frameworks, or other automation.

If you have not done it yet, it's a good idea to complete the [Falco: Container security monitoring](https://katacoda.com/falco/courses/falco/falco) scenario before this one.

In this lab you will learn the basics of Falco and how to use it along with a Kubernetes cluster to detect anomalous behavior.

This scenario will cover the following security threats:

- Unauthorized process
- Write to non authorized directory
- Processes opening unexpected connections to the Internet

You will play both the attacker and defender (sysadmin) roles, verifying that the intrusion attempt has been detected by Falco.
