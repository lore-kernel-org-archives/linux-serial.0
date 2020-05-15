Return-Path: <SRS0=qiNw=65=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C098C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A5C2075F
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeXeGnfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOQSS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 May 2020 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOQSR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 May 2020 12:18:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BDC061A0C
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2020 09:18:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so3296961wmc.2
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2020 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzQ9ZWRTK7rD/i+H1Fdnru9+VEPfr4nmpUnSitdS5yc=;
        b=qeXeGnfRgM72ebjuFUB6ERbL/h88bKA9mwClRvT0KfI4TXNsMYUMlqBYktfQqXjRZL
         0ighIUR4ASoO9pFh2zujdCDnCUNdLe8G3Xbip+Md8UTLMZlZAWSFElhZjjJZtjfCo8IP
         yA8H9lYeH4KP0RlH9R0bRro0VDoUhPSqPI83cpa1t1auVVtF5KyNQVDJrhi2ZR+fuiM8
         MNlH1B/3cKl8pLyl/T/qSBR6e6e0KcrYUucZsfnE7QV0H1DCojgKOT4FVS8MODPJ8CbS
         tQRLiRfDXqF852Lsj/2NmZOCZYqmHOembRHZtCpZcghpvqvUm5Zf/ciL6nT7qFRQeZz0
         jF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzQ9ZWRTK7rD/i+H1Fdnru9+VEPfr4nmpUnSitdS5yc=;
        b=eCx2m3Fn35mUXFqb56PveFbbClJu4b5uPWZkayLAXUvw38dgMCQBtQYW0vFDbdqGBK
         tbkZpt62tb4Tw4899LbO7NKZgSs8jbfNEOyoG1W/IMtIe6Lo4MdoduD98vAtt688Ik1y
         sZZUE0mIMQJQSnop40FgTU9gxTjZcn7O38F5Wb4cBQeAXxepetu3VpgZ6Cnhy5DhYoNJ
         0ew09PbN9g3ovctqG5HeQN99lHa/Qn/GpDOHoM47DpvW+CwPfCzclGvQghWmUHCW5QbN
         9uqYl7CXHc3OQjJcYXTNOi2K+KlXsbR5HSm08nRNVKcPgLfH87xeggOe6YJ3Fr5KlCH3
         llBw==
X-Gm-Message-State: AOAM531/xl1EIAQSb0cV0z0r/+OQpxvuoZCQG8er1GbYTxlVDqLXG2G+
        0p3j6C7/HZowEyXeP92GYOBh1465w71+kA==
X-Google-Smtp-Source: ABdhPJw70SKNTdBO7mqaC0EQIvTVFUm5UR9NBgEfdtSQLl3OBanMBVtF7U5pOLOUXrhj3AZ4WtaL1w==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr4710092wmm.178.1589559494828;
        Fri, 15 May 2020 09:18:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z124sm2931929wmg.20.2020.05.15.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:18:14 -0700 (PDT)
Date:   Fri, 15 May 2020 17:18:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 04/12] kgdb: Delay "kgdbwait" to dbg_late_init() by
 default
Message-ID: <20200515161812.vs3ry35qcatgf7ut@holly.lan>
References: <20200507200850.60646-1-dianders@chromium.org>
 <20200507130644.v4.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507130644.v4.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 07, 2020 at 01:08:42PM -0700, Douglas Anderson wrote:
> Using kgdb requires at least some level of architecture-level
> initialization.  If nothing else, it relies on the architecture to
> pass breakpoints / crashes onto kgdb.
> 
> On some architectures this all works super early, specifically it
> starts working at some point in time before Linux parses
> early_params's.  On other architectures it doesn't.  A survey of a few
> platforms:
> 
> a) x86: Presumably it all works early since "ekgdboc" is documented to
>    work here.
> b) arm64: Catching crashes works; with a simple patch breakpoints can
>    also be made to work.
> c) arm: Nothing in kgdb works until
>    paging_init() -> devicemaps_init() -> early_trap_init()
> 
> Let's be conservative and, by default, process "kgdbwait" (which tells
> the kernel to drop into the debugger ASAP at boot) a bit later at
> dbg_late_init() time.  If an architecture has tested it and wants to
> re-enable super early debugging, they can select the
> ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
> It should be noted that dbg_late_init() is still called quite early in
> the system.
> 
> Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> is set to initialize early it will still initialize when parsing
> early_param's.  This patch _only_ inhibits the initial breakpoint from
> "kgdbwait".  This means:
> 
> * Without any extra patches arm64 platforms will at least catch
>   crashes after kgdb inits.
> * arm platforms will catch crashes (and could handle a hardcoded
>   kgdb_breakpoint()) any time after early_trap_init() runs, even
>   before dbg_late_init().
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I hope to pull this set into the kgdb tree shortly. Any objections to
the arch/x86 changes this would bring?


Daniel.


> ---
> 
> Changes in v4:
> - Add "if KGDB" to "select ARCH_HAS_EARLY_DEBUG" in Kconfig.
> 
> Changes in v3:
> - Change boolean weak function to KConfig.
> 
> Changes in v2: None
> 
>  arch/x86/Kconfig          |  1 +
>  kernel/debug/debug_core.c | 25 +++++++++++++++----------
>  lib/Kconfig.kgdb          | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1197b5596d5a..5f44955ee21c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -60,6 +60,7 @@ config X86
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
> +	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FILTER_PGPROT
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 950dc667c823..503c1630ca76 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -950,6 +950,14 @@ void kgdb_panic(const char *msg)
>  	kgdb_breakpoint();
>  }
>  
> +static void kgdb_initial_breakpoint(void)
> +{
> +	kgdb_break_asap = 0;
> +
> +	pr_crit("Waiting for connection from remote gdb...\n");
> +	kgdb_breakpoint();
> +}
> +
>  void __weak kgdb_arch_late(void)
>  {
>  }
> @@ -960,6 +968,9 @@ void __init dbg_late_init(void)
>  	if (kgdb_io_module_registered)
>  		kgdb_arch_late();
>  	kdb_init(KDB_INIT_FULL);
> +
> +	if (kgdb_io_module_registered && kgdb_break_asap)
> +		kgdb_initial_breakpoint();
>  }
>  
>  static int
> @@ -1055,14 +1066,6 @@ void kgdb_schedule_breakpoint(void)
>  }
>  EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
>  
> -static void kgdb_initial_breakpoint(void)
> -{
> -	kgdb_break_asap = 0;
> -
> -	pr_crit("Waiting for connection from remote gdb...\n");
> -	kgdb_breakpoint();
> -}
> -
>  /**
>   *	kgdb_register_io_module - register KGDB IO module
>   *	@new_dbg_io_ops: the io ops vector
> @@ -1099,7 +1102,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  	/* Arm KGDB now. */
>  	kgdb_register_callbacks();
>  
> -	if (kgdb_break_asap)
> +	if (kgdb_break_asap &&
> +	    (!dbg_is_early || IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG)))
>  		kgdb_initial_breakpoint();
>  
>  	return 0;
> @@ -1169,7 +1173,8 @@ static int __init opt_kgdb_wait(char *str)
>  	kgdb_break_asap = 1;
>  
>  	kdb_init(KDB_INIT_EARLY);
> -	if (kgdb_io_module_registered)
> +	if (kgdb_io_module_registered &&
> +	    IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
>  		kgdb_initial_breakpoint();
>  
>  	return 0;
> diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> index 933680b59e2d..ffa7a76de086 100644
> --- a/lib/Kconfig.kgdb
> +++ b/lib/Kconfig.kgdb
> @@ -124,4 +124,22 @@ config KDB_CONTINUE_CATASTROPHIC
>  	  CONFIG_KDB_CONTINUE_CATASTROPHIC == 2. KDB forces a reboot.
>  	  If you are not sure, say 0.
>  
> +config ARCH_HAS_EARLY_DEBUG
> +	bool
> +	default n
> +	help
> +	  If an architecture can definitely handle entering the debugger
> +	  when early_param's are parsed then it select this config.
> +	  Otherwise, if "kgdbwait" is passed on the kernel command line it
> +	  won't actually be processed until dbg_late_init() just after the
> +	  call to kgdb_arch_late() is made.
> +
> +	  NOTE: Even if this isn't selected by an architecture we will
> +	  still try to register kgdb to handle breakpoints and crashes
> +	  when early_param's are parsed, we just won't act on the
> +	  "kgdbwait" parameter until dbg_late_init().  If you get a
> +	  crash and try to drop into kgdb somewhere between these two
> +	  places you might or might not end up being able to use kgdb
> +	  depending on exactly how far along the architecture has initted.
> +
>  endif # KGDB
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
