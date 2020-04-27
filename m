Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62AC54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3528D20656
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVyMRiMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgD0PmF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727801AbgD0PmF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 11:42:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237BAC0610D5
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 08:42:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so127518wmc.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lLZ7XRRaI1Gpl8c1cQLS2hZAOx8Bn/MZHFlY/EiF3y4=;
        b=zVyMRiMlwP+4cneNlBaaoQ92zIOVybC9w7sTqGp6acGraFBBzMNx47ZgVM0VG2/3EG
         NEPiBNjfdPgG4SDKj+0hZXH+JyVsqJmkXwHbH2YpKeWHODUK0z6FvTCLldhQr293Uflb
         v4gpmbFCPThW6+4w69f4HLq/2UwEkekOwNsS7TSBvs+QcpQtPe9usGuV5mRmPQGJthFY
         l2R0uRiURvPiQYByEuK2PWbtckwm3lDBYJPbjAHVmyfrI47bGJOozdGn8vxxHkK72v98
         SUV2DbWN4hTXtML0aeXUJ2ebaeinIsvIAqYBBhocdaABi06WiZ7LFXLH1YH7itElAiXH
         k5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lLZ7XRRaI1Gpl8c1cQLS2hZAOx8Bn/MZHFlY/EiF3y4=;
        b=ZE/YI5kZqmcnWvN/ZMYLmWZMzEU1WUcp9Sr00I9eVlZq2IILRER31bMcE+KlpCGirO
         2p6NNAsR/iMcCVYycuQMfbbAkS9RbjIm4Agv88pvkxSEl/Rmjc7DKZ3MMjCp4otvCmWc
         50qlkFcx5J8QVkYL155nP14uYFgJ7CIGbYEBFXa0AW/E2kFsvLAz1cpu28jRB01rQOpy
         gOJyjTIgY4J9Ue+ACwVCsIYePUKAcwz8KIPqPh2hDq+nJVEcK+HKw+wi12TAUKU5sANQ
         7qEqr+lmz6qhoIgqZeqMFAZNESXgJMkwfP4Fw3TI3OnyTkjzhvSDCbjluEhU4XLyMNrD
         dUOw==
X-Gm-Message-State: AGi0PuaVxiozcUr/kVqSuHW/0iM6Ic3pZhonS6yqW6IMFndLDm+LniB2
        afibkB/zps0rjGT5pnzLkzdYWA==
X-Google-Smtp-Source: APiQypJenGZpAvaB6iFtn3C1GjiCaFZUmaBJg7GJrDEvUU4GsYWVxuZ3cD66dGyGhTicTC8AaKBCkA==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr52891wme.115.1588002123816;
        Mon, 27 Apr 2020 08:42:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w10sm22463339wrg.52.2020.04.27.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 08:42:03 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:42:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Matt Mullins <mmullins@fb.com>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 4/9] kgdb: Delay "kgdbwait" to dbg_late_init() by
 default
Message-ID: <20200427154201.dxkoctjxta22u7hz@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:42PM -0700, Douglas Anderson wrote:
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
> re-enable super early debugging, they can implement the weak function
> kgdb_arch_can_debug_early() to return true.  We'll do this for x86 to
> start.  It should be noted that dbg_late_init() is still called quite
> early in the system.
> 
> Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> is set to initialize early it will still initialize when parsing
> early_params's.  This patch _only_ inhibits the initial breakpoint
> from "kgdbwait".  This means:
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

Overall this looks good but there is a small quibble below...


> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb1fd78..7371517aeacc 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -226,6 +226,28 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
>   */
>  extern void kgdb_arch_late(void);
>  
> +/**
> + *	kgdb_arch_can_debug_early - Check if OK to break before dbg_late_init()
> + *
> + *	If an architecture can definitely handle entering the debugger when
> + *	early_param's are parsed then it can override this function to return
> + *	true.  Otherwise if "kgdbwait" is passed on the kernel command line it
> + *	won't actually be processed until dbg_late_init() just after the call
> + *	to kgdb_arch_late() is made.
> + *
> + *	NOTE: Even if this returns false we will still try to register kgdb to
> + *	handle breakpoints and crashes when early_params's are parsed, we just
> + *	won't act on the "kgdbwait" parameter until dbg_late_init().  If you
> + *	get a crash and try to drop into kgdb somewhere between these two
> + *	places you might or might not end up being able to use kgdb depending
> + *	on exactly how far along the architecture has initted.
> + *
> + *	ALSO: dbg_late_init() is actually still fairly early in the system
> + *	boot process.
> + *
> + *	Return: true if platform can handle kgdb early.
> + */
> +extern bool kgdb_arch_can_debug_early(void);

Does this need to be a function? It looks like all implementations are
either return true or return false (e.g. CONFIG_ARCH_HAVE_EARLY_DEBUG
would do the same thing).


Daniel.
