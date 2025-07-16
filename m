Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD53291C00;
	Wed, 16 Jul 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653125; cv=none; b=TioqaBwyIyRAfZusYlzsAMp/i4HkazzuA8Ebzy5qDhYFX1ORchUZCGnr9wQ8UBD5eRo7kmbbnzGWjTYSd/Y657mdoxRmpgfDLTrNqgrxqY+bkQ7oJabf6u5AqObFS0+/ViUjnGreOdrEnCRKorlRVuxBx8Sj0VojOFyb/k7F+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653125; c=relaxed/simple;
	bh=8qbPegzDRBzlWplhuGMyDYIRnilnuHyUzqx/BpKWE0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxuVbTXj1hWVi1UTMBnh6TkYTNf/0NkbvnuCnTTFBGqvA3H0wjCIhTlEZovSiW+eAujvLXHnFMRgi0Pr51k/mLpR6hHwQ/T6s6T3rfZDe3/eK/RshsS8GVVteXZ5BA1EEbOu1ljh3fDdav36E8Nky0zkhRFr/f6YpNHN1xjLlRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqL94Yuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqL94Yuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA467C4CEF0;
	Wed, 16 Jul 2025 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752653125;
	bh=8qbPegzDRBzlWplhuGMyDYIRnilnuHyUzqx/BpKWE0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqL94Yuf+pnwlUQWA19R8lZkukE0iAVmbq5wLa/sCq+VhR/RvyVA2LXCPEdNIf5ah
	 SGiIvrKQkzTXGoRKiZW5Z1xdMi6g8LCxjI4FZZ4PVnYesyMB76NfJivQrQoLzTJet7
	 EAHFjLqnSYu8E+gwJoAbsdtABFRmTPkl9kOXIyo4=
Date: Wed, 16 Jul 2025 10:05:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marwan Seliem <marwanmhks@gmail.com>
Cc: jirislaby@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: sysrq: Introduce compile-time crash-only mode
Message-ID: <2025071614-enlisted-railway-06b6@gregkh>
References: <20250708075701.22988-1-marwanmhks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708075701.22988-1-marwanmhks@gmail.com>

On Tue, Jul 08, 2025 at 10:57:01AM +0300, Marwan Seliem wrote:
> The Magic SysRq facility, while a powerful tool for debugging, presents a
> significant attack surface. A user with console access or sufficient
> privileges can use SysRq commands to reboot the system ('b'), terminate
> all processes ('i'), or perform other disruptive actions. These actions
> can lead to denial-of-service or be used to hide traces of an intrusion.
> 
> While SysRq can be disabled via a sysctl, a privileged user can often
> re-enable it at runtime. For hardened systems where the only required
> SysRq functionality is generating a kdump for post-mortem analysis, a
> stronger, permanent restriction is necessary.
> 
> This commit introduces the Kconfig option `CONFIG_MAGIC_SYSRQ_CRASH_ONLY`
> to provide a compile-time guarantee that only the 'c' (crash) command
> is available. This allows system administrators to build a kernel that
> supports critical crash dump generation while completely removing the
> attack surface presented by all other SysRq commands.
> 
> When `CONFIG_MAGIC_SYSRQ_CRASH_ONLY` is enabled, the kernel is hardened
> in the following ways:
> 
> 1.  Restricted Commands: Only the 'c' (trigger a system crash/dump)
>     SysRq command is operational. All other built-in SysRq commands are
>     disabled at compile time.
> 
> 2.  Runtime Registration Disabled: The kernel rejects any attempt to
>     register new SysRq key operations at runtime via `register_sysrq_key()`,
>     returning -EPERM.
> 
> 3.  Crash Command Unregistration Prevented: The 'c' (crash) command
>     cannot be unregistered.
> 
> 4.  Sysctl Hardening: The `/proc/sys/kernel/sysrq` interface is neutered.
>     Any write to this interface is rejected with -EPERM, preventing
>     runtime attempts to alter the SysRq mask. The kernel will only
>     permit the crash operation, regardless of the `sysrq_always_enabled`
>     kernel command line parameter.
> 
> 5.  Trigger Hardening: Writing any character other than 'c' to
>     `/proc/sysrq-trigger` is rejected with -EPERM.
> 
> 6.  Restricted Help Output: The help message, triggered by an invalid
>     SysRq key, will only list the 'c' (crash) command.
> 
> This feature provides a robust, compile-time mechanism to lock down
> SysRq functionality, ensuring that even a privileged user cannot bypass
> the intended security policy.
> 
> ---
> v2:
> - Adjust #ifdef style to align with existing patterns in sysrq.c.
> - Block writes to the /proc/sys/kernel/sysrq sysctl with -EPERM when
>   in crash-only mode, with a rate-limited warning.
> - Return -EPERM from the /proc/sysrq-trigger write handler if the
>   requested command is not 'c'.
> - Rate-limit warning messages generated from userspace-triggered events
>   to prevent log-flooding.
> 
> Affected files:
> - lib/Kconfig.debug: Added `CONFIG_MAGIC_SYSRQ_CRASH_ONLY`.
> - drivers/tty/sysrq.c: Implemented the conditional logic for
>   restricted mode.
> - kernel/sysctl.c: Use the sysrq_toggle_support return to deny illegal toggle
> 
> Signed-off-by: Marwan Seliem <marwanmhks@gmail.com>
> ---
>  drivers/tty/sysrq.c | 87 +++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c     |  4 +--
>  lib/Kconfig.debug   | 27 ++++++++++++++
>  3 files changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 6853c4660e7c..cccfdb0ed6d4 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -59,11 +59,25 @@
>  static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
>  static bool __read_mostly sysrq_always_enabled;
>  
> +#ifdef CONFIG_MAGIC_SYSRQ_CRASH_ONLY
> +	/*
> +	* In CRASH_ONLY mode, sysrq is considered "on" only for the purpose
> +	* of allowing the crash command. The actual check for individual
> +	* commands happens in sysrq_on_mask().
> +	* For general "is sysrq on?" queries (like for input handler reg),
> +	* it should reflect that at least something (crash) is possible.
> +	*/
> +static bool sysrq_on(void)
> +{
> +	return true;
> +}
> +#else
>  static bool sysrq_on(void)
>  {
>  	return sysrq_enabled || sysrq_always_enabled;
>  }
>  
> +#endif

As stated before, I really don't like this new config option, and feel
that it does not do anything.  But becides this, you have implemented it
in a way that is almost unmaintainable, with these #ifdef in the .c
file.  That's not the proper kernel style at all, and will be a pain if
this would be accepted, so independent of the "is this a good idea or
not", we couldn't take this patch.

thanks,

greg k-h
