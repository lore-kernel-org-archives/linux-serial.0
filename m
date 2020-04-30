Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49401C47255
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D820873
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKOnI1/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgD3QnN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgD3QnM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:43:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F6C035494
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:43:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so920556pjb.3
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHOM9ScIACBAlj+EOQQZskvxADzU4dEs6BpxOZoTWCg=;
        b=DKOnI1/+M5kE4JIw2Yp+nF/RAd2KxfFdck3bIvzB9AlctHyy+RL1/A4oFRifDlFDEi
         0HGkvP4KvdCdEiWI0FOxU1i/5oaMPU9AQ604Ft4OEZSfP6sSdZMBMFR3ppk0v8YSwefO
         lOIJjZR+alCUq3QcUCj+hoKzU3y8Oq/vJ6riI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHOM9ScIACBAlj+EOQQZskvxADzU4dEs6BpxOZoTWCg=;
        b=Vw1LI+cPgycgPTcqh5Xb1EckmRNLs5XgiqRGnP3A2k8jyhPC1s6a9GXufJ3PaEzsK5
         rC960mTEUqBzRSWTK5NiQyCDXa06+wW0MhbZVCtX8od5IuZioxzYRUEwhTUYCAtKvyzt
         xD+S36ubWqKB2RzqvOFeSzTRPGCUrSPVbLS43lYhbU2tSIsgIYILT2Fkv71vUK+breBD
         NooVVe7rGAP4dNRR+/7oziNUqMmBq/QExzZU0X0jpoId5/daSEfVCTdMoMg0t0HlueXz
         g6wMbblm7ltsE7sP4F9zKccX5jIJ5F9OksNWV1cOTqF9X6wdBCKQnzTPeUVyNwp2UHMT
         73Mg==
X-Gm-Message-State: AGi0PuY0/aNX0O3fm1KQwcjrYY0GozICqhsJuWPADr7Ouu6/7pFV07jH
        0T/RnH7i1M1DQbst2ZCs3ZX08tfSxHA=
X-Google-Smtp-Source: APiQypJUrL2iWjT88b2nsW2k0x0Guxcf/cEy0bBxTjdEaIbkZ1eVs0M22Tib6yhS8agA1nsUUTX8BQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr4677251plt.189.1588264990523;
        Thu, 30 Apr 2020 09:43:10 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id z190sm285830pfb.1.2020.04.30.09.43.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:43:09 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id p25so37972pfn.11
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:43:09 -0700 (PDT)
X-Received: by 2002:a92:ca81:: with SMTP id t1mr2769977ilo.187.1588264549492;
 Thu, 30 Apr 2020 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200428211351.85055-1-dianders@chromium.org> <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
 <20200430154927.vhkhoffqwirb2fmm@holly.lan>
In-Reply-To: <20200430154927.vhkhoffqwirb2fmm@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Apr 2020 09:35:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
Message-ID: <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] kgdb: Delay "kgdbwait" to dbg_late_init() by default
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 8:49 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Apr 28, 2020 at 02:13:44PM -0700, Douglas Anderson wrote:
> > Using kgdb requires at least some level of architecture-level
> > initialization.  If nothing else, it relies on the architecture to
> > pass breakpoints / crashes onto kgdb.
> >
> > On some architectures this all works super early, specifically it
> > starts working at some point in time before Linux parses
> > early_params's.  On other architectures it doesn't.  A survey of a few
> > platforms:
> >
> > a) x86: Presumably it all works early since "ekgdboc" is documented to
> >    work here.
> > b) arm64: Catching crashes works; with a simple patch breakpoints can
> >    also be made to work.
> > c) arm: Nothing in kgdb works until
> >    paging_init() -> devicemaps_init() -> early_trap_init()
> >
> > Let's be conservative and, by default, process "kgdbwait" (which tells
> > the kernel to drop into the debugger ASAP at boot) a bit later at
> > dbg_late_init() time.  If an architecture has tested it and wants to
> > re-enable super early debugging, they can select the
> > ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
> > It should be noted that dbg_late_init() is still called quite early in
> > the system.
> >
> > Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> > is set to initialize early it will still initialize when parsing
> > early_param's.  This patch _only_ inhibits the initial breakpoint from
> > "kgdbwait".  This means:
> >
> > * Without any extra patches arm64 platforms will at least catch
> >   crashes after kgdb inits.
> > * arm platforms will catch crashes (and could handle a hardcoded
> >   kgdb_breakpoint()) any time after early_trap_init() runs, even
> >   before dbg_late_init().
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> It looks like this patch is triggering some warnings from the existing
> defconfigs (both x86 and arm64). It looks like this:
>
> ---
> wychelm$ make defconfig
>   GEN     Makefile
> *** Default configuration is based on 'x86_64_defconfig'
>
> WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
>   Depends on [n]: KGDB [=n]
>   Selected by [y]:
>   - X86 [=y]
>
> WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
>   Depends on [n]: KGDB [=n]
>   Selected by [y]:
>   - X86 [=y]

Ah, thanks!  I hadn't noticed those.  I think it'd be easy to just
change the relevant patches to just "select ARCH_HAS_EARLY_DEBUG if
KGDB".  If you agree that's a good fix and are willing, I'd be happy
if you just added it to the relevant patches when applying.  If not, I
can post a v4.

-Doug
