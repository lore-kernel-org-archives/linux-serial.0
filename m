Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1511185;
	Mon,  9 Jun 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455340; cv=none; b=I5B6j0nP7ZcobZdcnCOxC+QVTVfiQ0dCr+F9PZuC4gpKOG4D0C9IJP5SXB8Et64lkzFHmePBk2IFXIC1fqf9BXZzup4rHMuLK372C7/jZ7rMAEc8+SGkUCGoslG4DuGCal8MfE9K57085dv37MSEJe6EkPmME9t8sQjWX2e1SSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455340; c=relaxed/simple;
	bh=MfXFjxrBzTof+d+yK1Q+a+zQOzKcP3+f+P3hYnAry5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwdgJJerC3jd5OmZOjR0ehZ9gcg9dvfsIA4nTfZUNsPqmmfoWa2AHi/ci+VWCdS19k9hHlWBsvS1FYor1UZmVGhBDUcKOuoKPAChfxaKJhOZPZ9bjMy7F0wPqEkqbbMb+NikXx3c68ooEKwtae1dswMXb5j79u5IdwphtAwaBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXf+KT54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXf+KT54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EADC4CEEB;
	Mon,  9 Jun 2025 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749455339;
	bh=MfXFjxrBzTof+d+yK1Q+a+zQOzKcP3+f+P3hYnAry5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QXf+KT54DdqtqutcXoYOkkEka5sL25QPGDie958NNcHENr0/TGOIU5tH5GUfx8fUM
	 +UgAJcP60JL3GKCfYcN3P8yUCLg6aH5TlcjizxdlToSGXZ/O87c2+WZF6W7ERNW08p
	 vvGgSB58mwIxImvFZF6f6Cz69jwDlsucuAjzBziA03HivxAz1ZIbn9G8q3HBzUGqUc
	 p+WBIP2TW4MpRE/ZaPMVBlz9E8dl217FuU5U1GzoyIipjVsW41ZFa2cg6QpNhPGRUx
	 vNiH0v2xaz60T9g0tht7nPJmcWgtyTg4vBCSvvugDKSphQN0CZUvMz/g2YbsSid/ll
	 wzkrrHLS+DA4g==
Message-ID: <d50ec9ca-2a43-4300-856a-087d97fd8239@kernel.org>
Date: Mon, 9 Jun 2025 09:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
To: Marwan Seliem <marwanmhks@gmail.com>, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250607151957.222347-1-marwanmhks@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250607151957.222347-1-marwanmhks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 06. 25, 17:19, Marwan Seliem wrote:
> This commit introduces a new Kconfig option, CONFIG_MAGIC_SYSRQ_CRASH_ONLY,
> which allows for a significant hardening of the system by restricting
> the Magic SysRq functionality at compile time.
> 
> Security Impact:
> - Reduces attack surface by disabling non-essential SysRq commands
> - Maintains critical crash-dump capability required for debugging
> - Eliminates runtime configuration vulnerabilities
> 
> When CONFIG_MAGIC_SYSRQ_CRASH_ONLY is enabled:
> 
> 1.  Restricted Commands: Only the 'c' (trigger a system crash/dump)
>      SysRq command remains operational. All other built-in SysRq commands
>      (e.g., reboot, sync, show-memory, SAK) are disabled.

I must admit I don't much understand the purpose of this. It can be 
spelled as: you can crash the system only by sysrq-c from now on. Don't 
use sysrq-r or others. Who did ask for this?

...

> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c

> @@ -584,7 +620,6 @@ void __handle_sysrq(u8 key, bool check_mask)
>   {
>   	const struct sysrq_key_op *op_p;
>   	int orig_suppress_printk;
> -	int i;
>   
>   	orig_suppress_printk = suppress_printk;
>   	suppress_printk = 0;
> @@ -599,7 +634,15 @@ void __handle_sysrq(u8 key, bool check_mask)
>   	 */
>   	printk_force_console_enter();
>   
> +#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
> +	if (key != 'c') { /* In CRASH_ONLY mode, only 'c' is considered */
> +		op_p = NULL;
> +	} else {
> +		op_p = __sysrq_get_key_op(key);
> +	}
> +#else
>   	op_p = __sysrq_get_key_op(key);
> +#endif

These inline #ifdefs are horrid.

>   	if (op_p) {
>   		/*
>   		 * Should we check for enabled operations (/proc/sysrq-trigger
...
> @@ -1104,6 +1157,10 @@ static inline void sysrq_unregister_handler(void)
>   
>   int sysrq_toggle_support(int enable_mask)
>   {
> +#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
> +	pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Runtime toggle is not allowed.\n");

This can be invoked from userspace. So you can nicely DoS the machine by 
the added warn, right? Hint: use ratelimiting.

> +	return -EPERM;
> +#else
>   	bool was_enabled = sysrq_on();
>   
>   	sysrq_enabled = enable_mask;
...
> @@ -1145,12 +1203,30 @@ static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
>   
>   int register_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
>   {
> +#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
> +	/*
> +	 * In CRASH_ONLY mode, do not allow registering new SysRq ops.
> +	 */
> +	pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot register new SysRq key '%c'.\n", key);
> +	return -EPERM;
> +#endif
>   	return __sysrq_swap_key_ops(key, op_p, NULL);
>   }
>   EXPORT_SYMBOL(register_sysrq_key);
>   
>   int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
>   {
> +#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
> +	/*
> +	 * In CRASH_ONLY mode, do not allow unregistering the crash op.
> +	 * Other ops should be NULL anyway due to sysrq_init_crash_only_table.
> +	 */
> +	if (op_p == &sysrq_crash_op) {
> +		pr_warn("SysRq: CONFIG_MAGIC_SYSRQ_CRASH_ONLY is set. Cannot unregister the crash SysRq key '%c'.\n", key);
> +		return -EPERM;

No need for this return ^^.

> +	}
> +	return -EPERM; /* Attempt to unregister anything else is also an error */
> +#endif
>   	return __sysrq_swap_key_ops(key, NULL, op_p);
>   }
>   EXPORT_SYMBOL(unregister_sysrq_key);
> @@ -1209,6 +1285,7 @@ static inline void sysrq_init_procfs(void)
>   static int __init sysrq_init(void)
>   {
>   	sysrq_init_procfs();
> +	sysrq_init_crash_only_table();
>   
>   	if (sysrq_on())
>   		sysrq_register_handler();
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6..c05b80cfb8aa 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -640,6 +640,19 @@ config MAGIC_SYSRQ_DEFAULT_ENABLE
>   	  This may be set to 1 or 0 to enable or disable them all, or
>   	  to a bitmask as described in Documentation/admin-guide/sysrq.rst.
>   
> +config MAGIC_SYSRQ_CRASH_ONLY
> +	bool "Restrict Magic SysRq to crash command only"
> +	depends on MAGIC_SYSRQ
> +	default n
> +	help
> +	  If you say Y here, the Magic SysRq key functionality will be
> +	  severely restricted at compile time. Only the 'c' command (trigger
> +	  a system crash) will be available. All other SysRq commands will be
> +	  disabled, and no new SysRq commands can be registered at runtime.
> +	  The /proc/sys/kernel/sysrq setting will be ineffective for
> +	  non-crash commands, and attempts to change it may be blocked.
> +	  This is a security hardening option.

Is it for real?

thanks,
-- 
js
suse labs
