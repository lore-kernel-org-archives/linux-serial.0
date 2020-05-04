Return-Path: <SRS0=QloM=6S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE41C3A5A9
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21452078C
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcitaMAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgEDOnL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 May 2020 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEDOnK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 10:43:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F238C061A0E
        for <linux-serial@vger.kernel.org>; Mon,  4 May 2020 07:43:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so21290171wrq.2
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2020 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IRCeHkqSilUjU3FHunFBHRyW1Y2SXfHm0MWEUqYs4/A=;
        b=xcitaMAX9gw+29GendB+8mdnWfteLl6Rm11E72yMhQbVlvTkMInBBYhb4kQT/E0Ee2
         RpgEOuBQ9xT8A4YL7gTNTKJ5zh+TWrGPNuLh64057pVrkt7H7DWcmVQrKFXjQeDH3Z1G
         YCFsMQC8kQ9CMB/oF2OxkJCUhr8/5PDqbAhJ4ks+5YxBltonIWm/PSuzLJD4lbO5C8/X
         IVOJFT4D78B16tVPI1OguBr0sC8OyIjijzRgZWEz0zkNTW/iglAwowEqku4oyIjAVbwL
         ownV/fwyJUskK7lI4VXncd03/fUtqP6ly+MFZn69UW2qU+OO761P5e16fgXuwmKiQawd
         5f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRCeHkqSilUjU3FHunFBHRyW1Y2SXfHm0MWEUqYs4/A=;
        b=JKa19iAs8C1m9yFcDEAfmpOqQaX0ci/ob4rUcnbO9ySE9GdX9IqOo+jjpF3ctRejJ+
         ReG80rK9gkaaOJsfQ54KtzU9rV/fiEEUi4iY0UZ9D4Ygf6x3npAT+opTKpI5OATvv7Jn
         s+iPAzU6oAaUDe07TAxLcOF7hRk2ch4baJpxV4bAd59xHOBe2mvEqkpY+IZf+e9OdIu9
         Oi18M7ius3+4IHtHbVrvFkQmunzD0ELeNJ9w7/C/M1RKk644saSfZWR/xPJsTbts7d6s
         bfMwb0k5ypKiJ+g79+D9I/xd/YedNccWOJ9VL2E9CE1eFDdNAXacyaUZXzuJnyYQQH09
         Bflw==
X-Gm-Message-State: AGi0PuaR4uhTYGICxNhZUrFk8MYA3DxSA/Wh+chbuikTPxrUn04J31HR
        0qk/I7ZSrEnJ7UdDWpmmX1mqPQ==
X-Google-Smtp-Source: APiQypI9FXPMW4DbDRyPEO7LTd72jUgL9qg/5tOovENDnJ/SlF3XQVeCCTh4GFIUY0luJFYiAVo+KA==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr21086345wru.128.1588603388730;
        Mon, 04 May 2020 07:43:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t17sm18896607wro.2.2020.05.04.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:43:08 -0700 (PDT)
Date:   Mon, 4 May 2020 15:43:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, bp@alien8.de,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kgdb-bugreport] [PATCH v3 04/11] kgdb: Delay "kgdbwait" to
 dbg_late_init() by default
Message-ID: <20200504144306.zwac2jdlltvhekqm@holly.lan>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
 <20200430154927.vhkhoffqwirb2fmm@holly.lan>
 <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ut7kHr+V_+Yyk=+NC5qBrKEQ+O6Ra4HRHs5XoAHFcWeA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 30, 2020 at 09:35:30AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 30, 2020 at 8:49 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Apr 28, 2020 at 02:13:44PM -0700, Douglas Anderson wrote:
> > > Using kgdb requires at least some level of architecture-level
> > > initialization.  If nothing else, it relies on the architecture to
> > > pass breakpoints / crashes onto kgdb.
> > >
> > > On some architectures this all works super early, specifically it
> > > starts working at some point in time before Linux parses
> > > early_params's.  On other architectures it doesn't.  A survey of a few
> > > platforms:
> > >
> > > a) x86: Presumably it all works early since "ekgdboc" is documented to
> > >    work here.
> > > b) arm64: Catching crashes works; with a simple patch breakpoints can
> > >    also be made to work.
> > > c) arm: Nothing in kgdb works until
> > >    paging_init() -> devicemaps_init() -> early_trap_init()
> > >
> > > Let's be conservative and, by default, process "kgdbwait" (which tells
> > > the kernel to drop into the debugger ASAP at boot) a bit later at
> > > dbg_late_init() time.  If an architecture has tested it and wants to
> > > re-enable super early debugging, they can select the
> > > ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
> > > It should be noted that dbg_late_init() is still called quite early in
> > > the system.
> > >
> > > Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> > > is set to initialize early it will still initialize when parsing
> > > early_param's.  This patch _only_ inhibits the initial breakpoint from
> > > "kgdbwait".  This means:
> > >
> > > * Without any extra patches arm64 platforms will at least catch
> > >   crashes after kgdb inits.
> > > * arm platforms will catch crashes (and could handle a hardcoded
> > >   kgdb_breakpoint()) any time after early_trap_init() runs, even
> > >   before dbg_late_init().
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > It looks like this patch is triggering some warnings from the existing
> > defconfigs (both x86 and arm64). It looks like this:
> >
> > ---
> > wychelm$ make defconfig
> >   GEN     Makefile
> > *** Default configuration is based on 'x86_64_defconfig'
> >
> > WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
> >   Depends on [n]: KGDB [=n]
> >   Selected by [y]:
> >   - X86 [=y]
> >
> > WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
> >   Depends on [n]: KGDB [=n]
> >   Selected by [y]:
> >   - X86 [=y]
> 
> Ah, thanks!  I hadn't noticed those.  I think it'd be easy to just
> change the relevant patches to just "select ARCH_HAS_EARLY_DEBUG if
> KGDB".  If you agree that's a good fix and are willing, I'd be happy
> if you just added it to the relevant patches when applying.  If not, I
> can post a v4.

Happy with the approach to fix this.

Given the follow on discussion from the end of last week I suspect there
probably needs to be a v4 anyway so perhaps the last question is
applying a fix up is moot at this point?


Daniel.
