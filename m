Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41626C54E4A
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B42206F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABJ9An36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgEKWwd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 18:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKWwd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 18:52:33 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211AAC061A0C
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2020 15:52:33 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id k13so3696371uap.13
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2020 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oQAHkHCTjdXQutqjFpnQFKkQXPKWu36loMHxr/U/Bw=;
        b=ABJ9An36QqvDTKUmlo81w3VPI+NywC5sRr3Udf1h5mkJQruw2r+/d0TK5KCxAvQnkM
         AnX6dF0ESk/0FMYf94bsuWf7TyAgd59x096hAtrjjgg+oqFcAzxb3dsZhEMl1OgQwajx
         UeNlEyLzrUVksn8Oh25g81dOCnaTLldN7BPyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oQAHkHCTjdXQutqjFpnQFKkQXPKWu36loMHxr/U/Bw=;
        b=EsIGcUHRFpeLDI5fFVbvfGqFXknjxwObhWl7pVzK/EYBWmEy4VK3RkxnZdL1EWez2T
         fv0cJkJfjZihlWpKqOvzUoEIzzTnHMPPqWOOp1LOcyvtDATFguTZPeEsfl4gfhTu60Fv
         pUy7zkfuCBQ7YJnLjIgTDu5zx3nPjjXJeJi+Nmq9plxDluOryemGbf4CHxVTZ7wTN3Ep
         sD35wAVwYJXXz2B2Ww4R0vMgC8ImEhr4Xg++rK3fEyg9+5uVU7G9h4MxnpASJTsLEU/d
         Ut3juReIIO5L+ivnLEAcCemoKPaYAHKUdMiCwcJGRTJIBw87jEESLTCp5naPK7+J+DSO
         jY+w==
X-Gm-Message-State: AGi0PubRHycAQrxuMYX/pQCSLLXDrqMF0L4HMv44bBD5GrZu6pHGV/xC
        U9ozcIaapRq6gyvuDGl3G8jimWQHiKs=
X-Google-Smtp-Source: APiQypLUzRaC4nHD+p8ZTS8F0dMYvUYIrs2VT8UV+0txeRXmNtEIzhAJwumBKLt1/s2FM2vixltUTg==
X-Received: by 2002:ab0:e17:: with SMTP id g23mr13394163uak.31.1589237551332;
        Mon, 11 May 2020 15:52:31 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id s3sm9988330uao.0.2020.05.11.15.52.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 15:52:31 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id x136so6711675vsx.2
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2020 15:52:31 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr13653102vsk.106.1589237114125;
 Mon, 11 May 2020 15:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200428211351.85055-1-dianders@chromium.org> <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
 <20200511145908.GA22040@willie-the-truck>
In-Reply-To: <20200511145908.GA22040@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 May 2020 15:45:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
Message-ID: <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
To:     Will Deacon <will@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, May 11, 2020 at 7:59 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Doug,
>
> On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > index 48222a4760c2..59c353dfc8e9 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
> >       unregister_debug_hook(&hook->node);
> >  }
> >
> > -static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> > +int call_break_hook(struct pt_regs *regs, unsigned int esr)
> >  {
> >       struct break_hook *hook;
> >       struct list_head *list;
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index cf402be5c573..a8173f0c1774 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
> >       if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
> >               return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> >  #endif
> > +     if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> > +             return 0;
>
> I think this just means we're not running debug_traps_init() early enough,
> and actually the KASAN early handler is unnecessary too.
>
> If we call debug_traps_init() directly from setup_arch() and drop the
> arch_initcall(), can we then drop early_brk64 entirely?

It seems to work in my testing.  ...but the worry I have is the
comment right before trap_init().  It says:

/* This registration must happen early, before debug_traps_init(). */

By moving debug_traps_init() early we're violating that comment.  Do I
just remove that comment, or was there a good reason for it?  ...or am
I reading it wrong and I should have read it as if it said:

/* NOTE: this registration happens early, before debug_traps_init(). */

...then removing it is fine.  Maybe that's right?

I coded this up and put it on the Chrome OS gerrit at
<https://crrev.com/c/2195061>.  I'm happy to post this on the list as
a loner patch to replace this one or spin the whole series depending
on what people want.


-Doug
