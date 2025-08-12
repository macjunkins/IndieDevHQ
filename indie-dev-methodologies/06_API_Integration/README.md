# 06_API_Integration - API & Service Integration

> Comprehensive guides for integrating external APIs and AI services into your development workflow.

## 📁 Directory Contents

### Core Files

| File | Purpose | Priority |
|------|---------|----------|
| **general_api_guide.md** | Universal API integration patterns and best practices | 🔥 Essential |
| **anthropic_api_guide.md** | Specific guide for Anthropic Claude API integration | 🤖 AI-Specific |

## 🎯 Purpose

This directory provides everything needed to:
- Integrate external APIs securely and efficiently
- Connect AI services (ChatGPT, Claude, etc.) to your applications
- Implement authentication and rate limiting
- Handle errors and retries gracefully
- Monitor and optimize API usage

## 🔌 API Integration Overview

### Integration Layers

```
Application Layer
       ↓
   API Gateway
       ↓
  Rate Limiter
       ↓
   Auth Layer
       ↓
  External API
```

### Common API Types

| Type | Examples | Use Cases |
|------|----------|-----------|
| **AI/ML APIs** | OpenAI, Anthropic, Cohere | Text generation, analysis |
| **Payment APIs** | Stripe, PayPal, Square | Transaction processing |
| **Communication** | Twilio, SendGrid, Slack | Notifications, messaging |
| **Data APIs** | Weather, Maps, Analytics | External data integration |
| **Cloud Services** | AWS, GCP, Azure | Infrastructure, storage |

## 🤖 AI API Integration

### Supported AI Services

| Service | Best For | Context Window | Cost Model |
|---------|----------|----------------|------------|
| **GPT-4** | General purpose, coding | 128K tokens | Per token |
| **Claude 3** | Long context, analysis | 200K tokens | Per token |
| **Gemini** | Multimodal, search | 1M tokens | Per request |
| **Llama** | Open source, self-host | Variable | Self-hosted |

### Basic Integration Pattern

```javascript
// Generic AI API integration
class AIService {
  constructor(apiKey, endpoint) {
    this.apiKey = apiKey;
    this.endpoint = endpoint;
    this.rateLimiter = new RateLimiter();
  }
  
  async query(prompt, options = {}) {
    // Rate limiting
    await this.rateLimiter.checkLimit();
    
    // Build request
    const request = {
      model: options.model || 'default',
      messages: [{ role: 'user', content: prompt }],
      temperature: options.temperature || 0.7,
      max_tokens: options.maxTokens || 1000
    };
    
    // Make API call with retry logic
    return this.callWithRetry(request);
  }
  
  async callWithRetry(request, retries = 3) {
    try {
      const response = await fetch(this.endpoint, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${this.apiKey}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(request)
      });
      
      if (!response.ok) {
        throw new Error(`API error: ${response.status}`);
      }
      
      return await response.json();
    } catch (error) {
      if (retries > 0) {
        await this.delay(1000 * (4 - retries));
        return this.callWithRetry(request, retries - 1);
      }
      throw error;
    }
  }
}
```

## 🔐 Security Best Practices

### API Key Management

```yaml
# NEVER commit API keys to version control!

# Good: Environment variables
API_KEY: ${{ secrets.API_KEY }}

# Good: Secure vaults
vault:
  service: aws_secrets_manager
  key: api/keys/openai

# Bad: Hardcoded
apiKey: "sk-abc123..." # NEVER DO THIS!
```

### Security Checklist

- [ ] Store API keys in environment variables
- [ ] Use secrets management service
- [ ] Implement rate limiting
- [ ] Add request validation
- [ ] Use HTTPS only
- [ ] Implement timeout handling
- [ ] Add error logging
- [ ] Monitor usage patterns
- [ ] Set up alerts for anomalies
- [ ] Rotate keys regularly

## ⚡ Performance Optimization

### Caching Strategy

```javascript
class CachedAPIClient {
  constructor(apiClient, cacheTime = 3600) {
    this.api = apiClient;
    this.cache = new Map();
    this.cacheTime = cacheTime * 1000;
  }
  
  async query(prompt, options = {}) {
    const cacheKey = this.getCacheKey(prompt, options);
    
    // Check cache
    if (this.cache.has(cacheKey)) {
      const cached = this.cache.get(cacheKey);
      if (Date.now() - cached.timestamp < this.cacheTime) {
        return cached.data;
      }
    }
    
    // Make API call
    const result = await this.api.query(prompt, options);
    
    // Cache result
    this.cache.set(cacheKey, {
      data: result,
      timestamp: Date.now()
    });
    
    return result;
  }
}
```

### Rate Limiting

```javascript
class RateLimiter {
  constructor(requestsPerMinute = 60) {
    this.limit = requestsPerMinute;
    this.tokens = requestsPerMinute;
    this.lastRefill = Date.now();
  }
  
  async checkLimit() {
    this.refillTokens();
    
    if (this.tokens <= 0) {
      const waitTime = 60000 - (Date.now() - this.lastRefill);
      await this.delay(waitTime);
      this.refillTokens();
    }
    
    this.tokens--;
  }
  
  refillTokens() {
    const now = Date.now();
    const timePassed = now - this.lastRefill;
    const tokensToAdd = (timePassed / 60000) * this.limit;
    
    this.tokens = Math.min(this.limit, this.tokens + tokensToAdd);
    this.lastRefill = now;
  }
}
```

## 📊 Monitoring & Analytics

### Key Metrics to Track

| Metric | Target | Alert Threshold |
|--------|--------|-----------------|
| **Response Time** | <500ms | >2000ms |
| **Error Rate** | <1% | >5% |
| **Rate Limit Hits** | <10/hour | >50/hour |
| **Cost per Request** | Budget/requests | >120% budget |
| **Cache Hit Rate** | >60% | <30% |

### Usage Tracking

```javascript
class APIMonitor {
  constructor() {
    this.metrics = {
      totalRequests: 0,
      totalErrors: 0,
      totalLatency: 0,
      costEstimate: 0
    };
  }
  
  recordRequest(duration, tokens, success) {
    this.metrics.totalRequests++;
    this.metrics.totalLatency += duration;
    
    if (!success) {
      this.metrics.totalErrors++;
    }
    
    // Estimate cost (example: $0.03 per 1K tokens)
    this.metrics.costEstimate += (tokens / 1000) * 0.03;
    
    // Log metrics periodically
    if (this.metrics.totalRequests % 100 === 0) {
      this.logMetrics();
    }
  }
  
  logMetrics() {
    console.log({
      requests: this.metrics.totalRequests,
      errorRate: (this.metrics.totalErrors / this.metrics.totalRequests) * 100,
      avgLatency: this.metrics.totalLatency / this.metrics.totalRequests,
      estimatedCost: this.metrics.costEstimate
    });
  }
}
```

## 🔄 Error Handling

### Common Error Types

| Error | Cause | Solution |
|-------|-------|----------|
| **401 Unauthorized** | Invalid API key | Check key configuration |
| **429 Rate Limited** | Too many requests | Implement backoff |
| **500 Server Error** | API service issue | Retry with backoff |
| **503 Unavailable** | Service down | Circuit breaker pattern |
| **Timeout** | Slow response | Increase timeout, retry |

### Retry Strategy

```javascript
async function exponentialBackoff(fn, maxRetries = 5) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      
      const delay = Math.min(1000 * Math.pow(2, i), 30000);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}
```

## 🚀 Quick Start Examples

### OpenAI GPT Integration
```javascript
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

const response = await openai.chat.completions.create({
  model: "gpt-4",
  messages: [{ role: "user", content: "Hello!" }]
});
```

### Anthropic Claude Integration
```javascript
const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY
});

const response = await anthropic.messages.create({
  model: "claude-3-opus-20240229",
  messages: [{ role: "user", content: "Hello!" }]
});
```

### Generic REST API Integration
```javascript
const api = new RestAPIClient({
  baseURL: 'https://api.example.com',
  apiKey: process.env.API_KEY,
  timeout: 5000,
  retries: 3
});

const data = await api.get('/endpoint', { 
  params: { query: 'value' } 
});
```

## ✅ Integration Checklist

### Before Integration
- [ ] Read API documentation thoroughly
- [ ] Understand rate limits and pricing
- [ ] Set up API keys securely
- [ ] Plan error handling strategy
- [ ] Design caching approach

### During Integration
- [ ] Implement authentication
- [ ] Add rate limiting
- [ ] Create error handling
- [ ] Set up monitoring
- [ ] Write integration tests

### After Integration
- [ ] Monitor usage and costs
- [ ] Optimize performance
- [ ] Document integration
- [ ] Set up alerts
- [ ] Plan for scaling

## 🔗 Related Documentation

### Prerequisites
- [Core Workflow](../01_Core_Workflow/README.md) - Understand the system
- [Implementation](../03_Implementation/README.md) - Development setup

### Deep Dives
- Read `general_api_guide.md` for universal patterns
- Study `anthropic_api_guide.md` for Claude specifics
- Check external API documentation

### External Resources
- [OpenAI API Docs](https://platform.openai.com/docs)
- [Anthropic API Docs](https://docs.anthropic.com)
- [REST API Best Practices](https://restfulapi.net/)

## 💡 Best Practices

### Do's
- ✅ Use environment variables for keys
- ✅ Implement proper error handling
- ✅ Cache responses when possible
- ✅ Monitor usage and costs
- ✅ Use TypeScript for type safety

### Don'ts
- ❌ Hardcode API keys
- ❌ Ignore rate limits
- ❌ Skip error handling
- ❌ Make synchronous blocking calls
- ❌ Forget to handle timeouts

---

*This directory provides comprehensive guidance for integrating external APIs and AI services securely and efficiently into your applications.*