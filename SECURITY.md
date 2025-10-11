# Security Policy

## 🔒 Security Guidelines

This repository contains installation guides and scripts for AI CLI tools. Please follow these security guidelines:

### ✅ Safe to Share
- Installation scripts and guides
- Configuration templates with placeholder values
- Documentation and usage examples
- Open source tool references

### ❌ Never Commit
- Real API keys or credentials
- Personal information (emails, names, addresses)
- Private configuration files
- Environment files with actual secrets
- Log files containing sensitive data

## 🛡️ Security Checklist

Before committing any changes, ensure:

- [ ] No real API keys (only placeholders like `your-api-key-here`)
- [ ] No personal information or credentials
- [ ] No `.env` files with actual values
- [ ] No log files with sensitive data
- [ ] No private configuration files
- [ ] All sensitive data is in `.gitignore`

## 🔑 API Key Management

### Safe Examples ✅
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
export OPENAI_API_KEY="your-openai-api-key-here"
```

### Unsafe Examples ❌
```bash
export ANTHROPIC_API_KEY="sk-ant-abc123..."
export OPENAI_API_KEY="sk-abc123..."
```

## 📝 Reporting Security Issues

If you discover a security vulnerability, please:

1. **DO NOT** create a public issue
2. Email the maintainer privately
3. Provide details about the vulnerability
4. Wait for acknowledgment before public disclosure

## 🔄 Regular Security Audits

This repository is regularly audited for:
- Hardcoded credentials
- Sensitive data exposure
- Security best practices
- Dependency vulnerabilities

## 📚 Security Resources

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [API Key Security Guidelines](https://owasp.org/www-community/vulnerabilities/Use_of_hard-coded_credentials)
- [Environment Variable Security](https://12factor.net/config)

---

**Remember**: When in doubt, don't commit it. It's better to be safe than sorry!