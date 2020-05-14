Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A1EC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 16:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B97A206DC
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 16:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvPlZl0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgENQkZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgENQkZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 12:40:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B4C061A0C
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2020 09:40:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so12676141pjd.1
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2020 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWFeoUCCAGrwFNZxgc3//5BRvEIhNROwr+Wf1EbQfmY=;
        b=UvPlZl0iOaSxRCrz4fSlO6xyQ4m5RIN2qw1rZtiYNuvBFSSNHUv+z6jsScDG2JkoLZ
         9KPzqq9Yz+Xek9thEBwb1hxG4RE2BMXein7EOEaNp8aruvGk13N+6glTTIgL7iBjci/B
         OvS5nH3CBDh2XG23YTlRN04vrysWYTmp0OAqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWFeoUCCAGrwFNZxgc3//5BRvEIhNROwr+Wf1EbQfmY=;
        b=lH4j2wgfoczXI2JVtZCj34f6mGHmAvQFgp71aPc0aaDLPEhTQwiqvC2i0jaPlMJ3y6
         6BJQiNiOW21ayMyywWclMlLJ0bQZoj4D657M1Vs+ywrlemhFBGLrUMrd3o1yaYID9HGm
         LfvuMsT4jTnBoLxn9EfO+ilEAURdpnnDnhtPhP6VlJM23zSkOQHCUh6i8kQOrEMWzdSo
         2zOTfFbwU0a8lDkuB8Pp4SnHTKGcLe3GC0Si0wfj9Ni8WIEezYa/4ct5MJ5It08mnpGu
         upapN/pndB+fkC7alLyY2LrMxrwV8zPpVmD6YRfqUlM7rse9YfnkaSXjraf0a1NWOicD
         kUoQ==
X-Gm-Message-State: AOAM5303wqtSQXTgZBZiJvKJ8VxNSeTZeWQPBIlChbs8eOjknsmVrdLP
        wKFbEhoqcE5ix+wkeuhMgyLlq/32Xp8=
X-Google-Smtp-Source: ABdhPJwGsOgbW7NIN4IaeLF1jUzJ6ucHR1qa7V1ZpHR8LTZt2TF21eG5nAt627lWUC8C8gj/p2a6EA==
X-Received: by 2002:a17:90b:f86:: with SMTP id ft6mr10355864pjb.49.1589474424738;
        Thu, 14 May 2020 09:40:24 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id l3sm7603959pju.38.2020.05.14.09.40.24
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 09:40:24 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id s69so4475535pjb.4
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2020 09:40:24 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr4374233vsq.109.1589474077707;
 Thu, 14 May 2020 09:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200507200850.60646-1-dianders@chromium.org> <20200514162109.6qt5drd27hpilijh@holly.lan>
In-Reply-To: <20200514162109.6qt5drd27hpilijh@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 May 2020 09:34:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+t_Wg5KadZBTGHMSEXY3c-t6DZAtdaLXys31QJJpGGA@mail.gmail.com>
Message-ID: <CAD=FV=X+t_Wg5KadZBTGHMSEXY3c-t6DZAtdaLXys31QJJpGGA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] kgdb: Support late serial drivers; enable early
 debug w/ boot consoles
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-serial@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, bp@alien8.de,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, May 14, 2020 at 9:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, May 07, 2020 at 01:08:38PM -0700, Douglas Anderson wrote:
> > <snip>
> >
> > My first attempt was to try to get the existing "ekgdboc" to work
> > earlier.  I tried that for a bit until I realized that it needed to
> > work at the tty layer and I couldn't find any serial drivers that
> > managed to register themselves to the tty layer super early at boot.
> > The only documented use of "ekgdboc" is "ekgdboc=kbd" and that's a bit
> > of a special snowflake.  Trying to get my serial driver and all its
> > dependencies to probe normally and register the tty driver super early
> > at boot seemed like a bad way to go.  In fact, all the complexity
> > needed to do something like this is why the system already has a
> > special concept of a "boot console" that lives only long enough to
> > transition to the normal console.
> >
> > <snip>
> >
> > The devices I had for testing were:
> > - arm32: rk3288-veyron-jerry
> > - arm64: rk3399-gru-kevin
> > - arm64: qcom-sc7180-trogdor (not mainline yet)
> >
> > These are the devices I tested this series on.  I tried to test
> > various combinations of enabling/disabling various options and I
> > hopefully caught the corner cases, but I'd appreciate any extra
> > testing people can do.  Notably I didn't test on x86, but (I think) I
> > didn't touch much there so I shouldn't have broken anything.
>
> I have tested a slightly earlier version using qemu and will test this
> set before it moves forwards.
>
>
> >  .../admin-guide/kernel-parameters.txt         |  20 ++
> >  Documentation/dev-tools/kgdb.rst              |  24 ++
> >  arch/arm64/Kconfig                            |   1 +
> >  arch/arm64/include/asm/debug-monitors.h       |   2 +
> >  arch/arm64/kernel/debug-monitors.c            |   2 +-
> >  arch/arm64/kernel/traps.c                     |   3 +
> >  arch/x86/Kconfig                              |   1 +
> >  drivers/tty/serial/8250/8250_early.c          |  23 ++
> >  drivers/tty/serial/amba-pl011.c               |  32 +++
> >  drivers/tty/serial/kgdboc.c                   | 268 ++++++++++++++++--
> >  drivers/tty/serial/qcom_geni_serial.c         |  32 +++
> >  include/linux/kgdb.h                          |   4 +
> >  kernel/debug/debug_core.c                     |  52 +++-
> >  lib/Kconfig.kgdb                              |  18 ++
> >  14 files changed, 436 insertions(+), 46 deletions(-)
>
> Any thoughts on how best to land these changes?
>
> AFAICT the arm64

I was hoping to get an Ack from Will or Catalin for my most recent
arm64 patch [1] and then it could land in your tree.  However, it
wouldn't be the end of the world if that landed later.  "kgdbwait"
would be broken if you used it together with "kgdb_earlycon" but
overall we'd still be in a better place than we were.


> and 8250/amba-pl011/qcom_geni_serial code
> could be applied independently of the kgdb changes

Right, that would be OK.  Nobody would actually be able to use
"kgdb_earlycon" until those landed but there would be no problem with
those two landing separately.


> (though we must keep
> changes to drivers/tty/serial/kgdboc alongside the kgdb changes).
>
> I can hoover them up but I'd need a solid set of acks and
> I don't think we've got that yet.

It would be nice for it to be explicit, but "get_maintainer" says that
Greg KH is the maintainer of serial drivers.  Git log confirms that he
also has been the one landing changes to these files.  Early-on he
provided his Reviewed-by for the series as a whole, so he's aware of
it and maybe would be fine w/ the serial changes landing through the
kgdb tree?

Greg: is that correct?


> I'd also be happy to ack where needed and let someone else pick it up
> (the other changes queued for kgdb this cycle are pretty small so we
> shouldn't see much conflict in kernel/debug/ ).

It feels to me that the kgdb tree is the best destination for all
these patches if possible.


[1] https://lore.kernel.org/r/20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid

-Doug
