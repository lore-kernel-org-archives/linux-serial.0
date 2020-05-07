Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C38C4724C
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54DA216FD
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WacTyQsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEGUQQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728632AbgEGUQP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 16:16:15 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2AC05BD43
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 13:16:15 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l25so4232584vso.6
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQE2Pqn7s0Ks9OIhXkN/lBOad3DHjY4wcPRoAi0MgWs=;
        b=WacTyQsgLEEU7u0AtpRsYbxT75pb0I+6Dw5GqlzMzlyoGiEgKCaIIHSxj1lTkPvQAU
         O6b7zHfAh/vDRiIeL5bu2q6GRMeNCHryJ2/FsGV34iuplmWcYt9st/jc7aBEXeYucXcQ
         R1GrTAIJ/ptWsJcgVQeQZS3xbP4uAwlr7D1MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQE2Pqn7s0Ks9OIhXkN/lBOad3DHjY4wcPRoAi0MgWs=;
        b=fDgjC/9f3cSK2/DEORHjUXqgxWsYKA8761Iu20SWfosHiHu3/Y3AqHuVnH8FUwXjEV
         kjBlPYFvqnrGRZRtYpu+4sdfmvQ4sING7zo3jRP6r2KPB8e2QiaXNA/pcEOnW5wz4VC/
         W+xaUF0YXcVyqP9X/p6wOzC5qvnV+Za722dGzLjUjxDsOFQ1o2AYI1jRbbnJVa6J0+u+
         g7dCEP1J8ESYGLMuXDIxim8cRfITkj0YGXMnjYj4gLcuHQLelNnkkv5x4Gka19uBL3AY
         1ESDXiA/PIYjArYq6pGJgb3VskEQBIYE2kxKarLJYEzKoYjF4CVvNX+1HcuEDa4Rbzp6
         sbXQ==
X-Gm-Message-State: AGi0PuZALMlc1goV9I2kIB2r5aEnX9Tb0KE0d8OktgfVZr7N0XAtgtLJ
        LiLi92avdaIPDfIk1X8Zo30tWamERlQ=
X-Google-Smtp-Source: APiQypJ1Ugn7klynBUY3nHpnuSuy/bHr1WSf81s8UetFtPcRtXA2gIA/ku5qH3yMAYAZaRkYHwBUOw==
X-Received: by 2002:a67:f258:: with SMTP id y24mr14725575vsm.112.1588882573682;
        Thu, 07 May 2020 13:16:13 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id j15sm1246534vsg.34.2020.05.07.13.16.12
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 13:16:12 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id x136so4224188vsx.2
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:16:12 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr14014022vsk.106.1588882572099;
 Thu, 07 May 2020 13:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan> <20200501133202.GA2402281@wychelm.lan>
 <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com> <20200504115339.ndi3n4evklzidvb5@holly.lan>
In-Reply-To: <20200504115339.ndi3n4evklzidvb5@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 May 2020 13:16:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHUWs9X548=gmpn60-ywrM7OUOKdt-ngBdyyFgTfa3yw@mail.gmail.com>
Message-ID: <CAD=FV=VHUWs9X548=gmpn60-ywrM7OUOKdt-ngBdyyFgTfa3yw@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon leaving
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, May 4, 2020 at 4:53 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 01, 2020 at 10:36:14AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, May 1, 2020 at 6:32 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, May 01, 2020 at 12:49:43PM +0100, Daniel Thompson wrote:
> > > > On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > > > > The original implementation of kgdboc_earlycon included a comment
> > > > > about how it was impossible to get notified about the boot console
> > > > > going away without making changes to the Linux core.  Since folks
> > > > > often don't want to change the Linux core for kgdb's purposes, the
> > > > > kgdboc_earlycon implementation did a bit of polling to figure out when
> > > > > the boot console went away.
> > > > >
> > > > > It turns out, though, that it is possible to get notified about the
> > > > > boot console going away.  The solution is either clever or a hack
> > > > > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > > > > need to do is head-patch the "exit" routine of the boot console.  We
> > > > > know that "struct console" must be writable because it has a "next"
> > > > > pointer in it, so we can just put our own exit routine in, do our
> > > > > stuff, and then call back to the original.
> > > >
> > > > I think I'm in the hack camp on this one!
> > > >
> > > >
> > > > > This works great to get notified about the boot console going away.
> > > > > The (slight) problem is that in the context of the boot console's exit
> > > > > routine we can't call tty_find_polling_driver().
> > > >
> > > > I presume this is something to do with the tty_mutex?
> > > > > We solve this by
> > > > > kicking off some work on the system_wq when we get notified and this
> > > > > works pretty well.
> > > >
> > > > There are some problems with the workqueue approach.
> > >
> > > ... so did a couple of experiments to avoid the workqueue.
> > >
> > > It occured to me that, since we have interfered with deinit() then the
> > > console hasn't actually been uninitialized meaning we could still use it.
> > > This does exposes us to risks similar to keep_bootcon but in exchange
> > > there is no window where kgdb is broken (and no need to panic).
> > >
> > > My prototype is minimal but I did wonder about ripping out all the
> > > code to defend against removal of the earlycon and simply keep the
> > > earlycon around until a new kgdbio handler is installed.
> >
> > It took me a little while, but I finally see what you're saying.
> > You're saying that we keep calling into the boot console even though
> > it's no longer in the list of consoles.  Then we temporarily disable
> > the boot console's exit routine until kgdb_earlycon() is done.  (side
> > note: the exit routine was recently added and probably most consoles
> > don't use it).
>
> Certainly none of the devices with a read() method have an exit().
>
>
> > OK, that doesn't seem totally insane.  It actually works OK for you?
>
> I tested on qemu/x86-64 (8250) and qemu/arm64 (pl011). In both cases it
> works well.
>
>
> > It's probably at least worth a warning in the log if we detect that
> > we're using the boot console and it's not in the console list anymore.
> > Then if kgdb starts misbehaving someone might have a clue.
>
> Yes, I'll add that.
>
>
> > If your solution is OK we might also want to remove the call to
> > cleanup_earlycon_if_invalid() in configure_kgdboc() too.
>
> That's what I thought, yes. Although it might be best to handle that
> by ripping it out of the original patch set.

I've incorporated ideas from my patch and yours into a v4 patchset of
the original series.  Note that I didn't include your earlycon
deferral patchset [1] in my series which means it'll need to be
rebased.  Hopefully this is OK since I think the rebase will be easy,
but yell if you want an extra pair of eyes on it.

[1] https://lore.kernel.org/r/20200430161741.1832050-1-daniel.thompson@linaro.org


-Doug
