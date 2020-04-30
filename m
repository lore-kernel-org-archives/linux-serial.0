Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F3C8300B
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E614C20787
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7syOuiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD3KXj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3KXj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 06:23:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBFC035495
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 03:23:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so6192766wrt.5
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xktt5P5u0NAYWQUqgkagzxErGUiYtbbOHd4C7ocDwU=;
        b=q7syOuiDaJye/Tlh74i5/Q/+CUSfNs10UstxUepBQ8o+1kxtVWXkeXa/IDVyPIKsIK
         i0X619XXZudkcvb4n+2glGp5cNEMyL3jBA5w9eZC0t/U62O5XSTV5Spt/Amov/vPJd9p
         0Jl5+USsGF8hpJZgo4vI90jL7LOgmUxAfN7lGLYCRdLL8Uz1PrySk+mNAKlZsVTHEkIt
         +SxcNCl1f9z/ekn45w+AR755sqBYVeAOQd5pM4wPPmHIZfnO/54V4YbVGef+JlNVd4qg
         IQ/OZdJERvEWMJ3nxHMX/1Ukn/sXCDARlo2zUj0CWvHw+UqCYPMZaAchiRMKAnoujpzC
         KbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xktt5P5u0NAYWQUqgkagzxErGUiYtbbOHd4C7ocDwU=;
        b=I+i1PqAlstowHuLMIOUwWv9yASX8mWtwr3+zwFy4bjhGHB/qCTgkZJUHY2QP6lDdjo
         MuY9Vscb7fUsxDxmoWxop+S5HKZhrCiswbxKi/h4bffng3Dt6S2D8IqojG0aBB8JtTol
         1S4uFo7+aL1ByjEwCOUXE9aOyU68fzD9LB/QbSdKwFPeIRkRIjTAR2qn1X7KX3pcYK9R
         IbvW/Tma8dEqLsVHV1Mf/6C3EpOOvvWOkgm7/wmTcl0xXvF93z32sjVRhlJ9DZyODQEY
         2gJGd1d6DZCQtguSHoZUT3JFdzW9kEx1e5G7ZSTI+ymHqy4mx6cLbwT0n/lU2qeRAWlU
         /1ug==
X-Gm-Message-State: AGi0PuYZNsgmo70HBg9pdUZLVVWtmp3HbvOP4SoB7j4A6RQA5KGeXbSH
        4oFzqSCHY97RIz2QwhqrrDsBiQ==
X-Google-Smtp-Source: APiQypK5gy7Wyv7ctT8UUbjQzI5nBdRyWE938/wjc15iBu08lS1jivEbgfEP/XpqXxXbSMlu36h9fg==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr2876869wrw.291.1588242217315;
        Thu, 30 Apr 2020 03:23:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t2sm11689230wmt.15.2020.04.30.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 03:23:36 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:23:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH] serial: kgdboc: Allow earlycon initialization to be
 deferred
Message-ID: <20200430102335.udgou23vyrbet3i2@holly.lan>
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
 <CAD=FV=UaABk9uejyDR73fW7DDsYvPHaWBD+DpJBGFftJ78UJLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UaABk9uejyDR73fW7DDsYvPHaWBD+DpJBGFftJ78UJLg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 29, 2020 at 05:32:01PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 29, 2020 at 10:08 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > As described in the big comment in the patch, earlycon initialization
> > can be deferred if, a) earlycon was supplied without arguments and, b)
> > the ACPI SPCR table hasn't yet been parsed.
> >
> > Unfortunately, if deferred, then the earlycon is not ready during early
> > parameter parsing so kgdboc cannot use it. This patch mitigates the
> > problem by giving kgdboc_earlycon a second chance during
> > dbg_late_init(). Adding a special purpose interface slightly increase
> > the intimacy between kgdboc and debug-core but this seems better than
> > adding kgdb specific hooks into the arch code (and much, much better
> > than faking non-intimacy with function pointers).
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Notes:
> >     Hi Doug,
> >
> >     This patch extends your patch set to make it easier to deploy on ACPI
> >     systems[1]:
> >       earlycon kgdboc_earlycon kgdboc=ttyAMA0
> >
> >     I have mixed feeling about it because it adds calls from debug-core
> >     into kgdboc and I don't think there are other examples of this.
> >     However earlycon auto-configuration is so awesome I'd like to
> >     be able to keep using it and this is the best I have come up with
> >     so far ;-).
> 
> It's a little gross, but it's OK with me.  I guess the other option
> would be to have "kgdboc_earlycon" try again at various different
> initcall levels...
> 
> Speaking of which, I wonder if you could just make kgdboc register to
> run at "console_initcall" level.  If I'm reading it properly:
> 
> start_kernel()
> - setup_arch(): ACPI stuff is done by the end of this, right?
> - console_init(): It would be easy to get called here, I think.
> - dbg_late_init(): Where you're hooking in now.
> 
> I didn't put printouts in any code and test it out, but if the above
> is right then you'll actually get called _earlier_ and with less
> hackiness if you just have kgdboc try again at console initlevel.

Thanks, I'll take a look at this. I had a nagging feeling I must be
missing something when I gave up and wrote the hack found in this
patch. Sounds like I should have paid that feeling closer attention!


> > @@ -529,7 +531,23 @@ static int __init kgdboc_earlycon_init(char *opt)
> >         console_unlock();
> >
> >         if (!con) {
> > -               pr_info("Couldn't find kgdb earlycon\n");
> > +               /*
> > +                * If earlycon deferred its initialization then we also need to
> > +                * do that since there is no console at this point. We will
> > +                * only defer ourselves when kgdboc_earlycon has no arguments.
> > +                * This is because earlycon init is only deferred if there are
> > +                * no arguments to earlycon (we assume that a user who doesn't
> > +                * specify an earlycon driver won't know the right console name
> > +                * to put into kgdboc_earlycon and will let that auto-configure
> > +                * too).
> > +                */
> > +               if (!kgdboc_earlycon_late_enable &&
> > +                   earlycon_acpi_spcr_enable && (!opt || !opt[0])) {
> > +                       earlycon_kgdboc_late_enable = true;
> > +                       pr_info("No suitable earlycon yet, will try later\n");
> > +               } else {
> > +                       pr_info("Couldn't find kgdb earlycon\n");
> > +               }
> 
> Personally I'd rather take all the caveats out and just make it
> generic.  Stash the name of the console in a string (you can make it
> initdata so it doesn't waste any space) and just always retry later if
> we didn't find the console.  Then you don't need to be quite so
> fragile and if someone else finds another reason to delay earlycon
> we'll still work.

Will do.


> Speaking of which, if we build kgdboc as a module won't you get an
> error accessing "earlycon_acpi_spcr_enable"?

Very likely. I have a note to test this as a module but was curious
whether having kgdb_earlycon_late_init() was the right approach
anyway.


> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 77a3c519478a..02867a2f0eb4 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -227,6 +227,8 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
> >  extern void kgdb_arch_late(void);
> >
> >
> > +extern void __init kgdb_earlycon_late_init(void);
> > +
> 
> It's not required to add "__init" for declarations, is it?

This is just matching styles with the rest of the file (like the
extern). Maybe I'll put polishing the header a little on my TODO
list.


> >   * struct kgdb_arch - Describe architecture specific values.
> >   * @gdb_bpt_instr: The instruction to trigger a breakpoint.
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 2d74dcbca477..f066ef2bc615 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -963,11 +963,15 @@ void __weak kgdb_arch_late(void)
> >  {
> >  }
> >
> > +void __init __weak kgdb_earlycon_late_init(void)
> > +
> 
> I assume the above is because "kgdboc" can be compiled as a module and
> you need to essentially no-op your call in that case?  If so, could
> you add a comment about it?  I also would have thought you'd actually
> need to define the weak function implementation, not just declare it.
> Maybe I'm confused, though.

Ah...

When I rebased this patch on your most recent patchset I did most of the
fix ups during the merge. The final few problems I caught *after* the
merge and it looks like I neglected to commit them. Sorry... and I'm
just relieved you didn't try and compile test this patch!


> >  void __init dbg_late_init(void)
> >  {
> >         dbg_is_early = false;
> >         if (kgdb_io_module_registered)
> >                 kgdb_arch_late();
> > +       else
> > +               kgdb_earlycon_late_init();
> >         kdb_init(KDB_INIT_FULL);
> 
> It feels like it'd be better not to make yourself an "else" but rather
> to add a 2nd "if" test either at the beginning or the end of this
> function.  I'm 99% sure it makes no difference, but it makes my brain
> hurt a little trying to prove it because you've added another flow of
> control to analyze / keep working.  Specifically you've now got a case
> where you're running a bunch of the "debug_core" code where
> "dbg_is_early = false" but you haven't yet run "KDB_INIT_FULL".
> 
> Anyway, I don't feel that strongly about it, so if you really like it
> the way it is that's fine...

It is done this way to prevent kgdb_arch_late() being called twice
(because I don't want to have to mandate that kgdb_arch_late() is
idempotent on every architecture).

However I guess a simple alternative would be to call
kgdb_earlycon_late_init() *before* setting dbg_is_early to false.

Anyhow, I hope you early review comments mean this issue can become
irrelevant anyway!


Daniel.
