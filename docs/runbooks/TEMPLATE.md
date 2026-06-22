
# Runbook Template

## Purpose

Describe what this runbook is used for.

Example:
This runbook is used when a service is unavailable, unstable, or behaving unexpectedly.

## Symptoms

Describe how the problem appears.

Examples:
- Application returns errors
- Service is not responding
- Deployment failed
- Container keeps restarting
- High latency or timeouts

## Impact

Describe what is affected.

Questions to answer:
- Is this production, staging, or local?
- Are users affected?
- Is there business impact?
- Is there SLA risk?
- Is data processing or deployment blocked?

## Initial Checks

List the first things to verify before making changes.

Examples:
- Check recent deployments or configuration changes
- Check service status
- Check logs
- Check CPU, memory, disk usage
- Check network connectivity
- Check environment variables or secrets

## Commands

```bash
# Check service status
systemctl status <service-name>

# Check logs
journalctl -u <service-name> --since "30 minutes ago"

# Check disk
df -h

# Check memory
free -h

# Check processes
ps aux | grep <process-name>

# Check HTTP endpoint
curl -v http://localhost:5000/health
