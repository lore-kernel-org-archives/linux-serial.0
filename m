Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A200C54E8E
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20119206DD
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589209158;
	bh=h6Ea4lLoHxX7Auk/jUvpA6sDRTJxI89bcfhFCCCylgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W09peYm2Ldm6A6/M4jGWwsuVZHJ7WNfL9kPP1N50prphNg7RzWxIWtB2nRTYs1rke
	 7QtaBU1yQrazJvhxZvoB7ZI/qIQ/n79AxyPnWTot0WbdeNIiT9sBNRH/UTkvoT6PK7
	 Lr+evuRIZH1zylHCIvXs5tsnDRq8t/DF3dYSodK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgEKO7R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 10:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgEKO7R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 10:59:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B959420643;
        Mon, 11 May 2020 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589209157;
        bh=h6Ea4lLoHxX7Auk/jUvpA6sDRTJxI89bcfhFCCCylgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKZwMCRGb/qPVQrXagi72UbQrDDDpUCfscELhKXUCYWtWz/96oJ3TsTAVuOo9hq3N
         OTup9e3bn90dJWWmHxlKrSdmxAXWW+8b1fClhGGt1d9f8pbz6odwWVeOYY4PQ/tUpC
         Fx64l5wovGXZdTUhdEqOyQyid+5J32xaXo4AOdek=
Date:   Mon, 11 May 2020 15:59:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org, agross@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, catalin.marinas@arm.com,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org,
        corbet@lwn.net, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, frowand.list@gmail.com, bp@alien8.de,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
Message-ID: <20200511145908.GA22040@willie-the-truck>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Doug,

On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 48222a4760c2..59c353dfc8e9 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
>  	unregister_debug_hook(&hook->node);
>  }
>  
> -static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> +int call_break_hook(struct pt_regs *regs, unsigned int esr)
>  {
>  	struct break_hook *hook;
>  	struct list_head *list;
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cf402be5c573..a8173f0c1774 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
>  	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
>  		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
>  #endif
> +	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> +		return 0;

I think this just means we're not running debug_traps_init() early enough,
and actually the KASAN early handler is unnecessary too.

If we call debug_traps_init() directly from setup_arch() and drop the
arch_initcall(), can we then drop early_brk64 entirely?

Will
