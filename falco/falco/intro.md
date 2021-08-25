Falco is an open source, behavioral monitoring software designed to detect anomalous activity. Falco works as a intrusion detection system on any Linux host, although it is particularly useful when using containers since it supports container-specific context like **container.id**, **container.image** or **namespaces** for its rules.

Falco is an _auditing_ tool as opposed to _enforcement_ tools like [Seccomp](https://github.com/docker/labs/blob/master/security/seccomp/README.md) or [AppArmor](https://github.com/docker/labs/blob/master/security/apparmor/README.md). Falco runs in user space, using a kernel module to intercept system calls, while other similar tools perform system call filtering/monitoring at the kernel level. One of the benefits of a user space implementation is being able to integrate with external systems like Docker orchestration tools. [SELinux, Seccomp, Falco, and you: A technical discussion](https://bit.ly/3ydts9P) discusses the similarities and differences of these related security tools.

In this lab you will learn the basics of Falco and how to use it along with Docker to detect anomalous container behavior.

This scenario will cover the following security threats:

- Container running an interactive shell
- Unauthorized process
- Write to non user-data directory
- Sensitive mount by container

You will play both the attacker and defender (sysadmin) roles, verifying that the intrusion attempt has been detected by Falco.
