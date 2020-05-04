Return-Path: <SRS0=QloM=6S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B9CC3A5A9
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2222068E
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fl/W5MFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEDLxp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 May 2020 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728427AbgEDLxo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 07:53:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD8C061A0F
        for <linux-serial@vger.kernel.org>; Mon,  4 May 2020 04:53:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so20507607wrm.13
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2020 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gs1xFmz+UQYje3/SUc1v/efQgEXN1iSiEOtB3UyExs4=;
        b=Fl/W5MFN8DSWpViiz3IyhXwTpVMRhy6AlYeDekcWA2Ltc7Lu+qyw1BD2deXrCzXtR8
         Mu4LcreMgqQiD+ELQdJ4k+F92j9aVUTpv09kwZlOEKtmC2BBCWDO0kdPtXDPXPIsWMUV
         Sq9YqZoktFk0sS+IFHhiB69/k0YsUH0Uh5mL+ZbPVOOed0wnI+3RDkXSRqAdu1TVFTAE
         gZFvlg+vDS+PGkqzBiVcywpMym3Ez4YZ5jlew8IYKvMfJUTJEXD//S24uCqwTY+3JQXk
         aVy92IdBdFYVAwyVEI1XANYFil4ifFzc+68lrH18fE54Q48dTo6ZuQK49PGwWwbP94LV
         Q+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gs1xFmz+UQYje3/SUc1v/efQgEXN1iSiEOtB3UyExs4=;
        b=X+ngTDEHnYrS7tyZ3yZa2T6AoCdesLs+Ug3VE18ZKaHEatax5SzFa1DB8xvylCC6J4
         gsnDOq28NMVhwdSA3vmvcTCvB8YXrNRd9uVP9W2eA4r2Pyks2AVEeTOZ/Ni6u3LQ6tsG
         IZlAlVAA153Oe8gNznYbBrepdsEkYftxI6FUt/96JqwDkfLmNU7SMWYYPvHV/OzpvYrC
         PhtYXXceUoTcMdG4B7FEoghdGra2t0bvLGfHtafFsirGOtfzCMnqDSZHakzZjoTsRgXI
         Hmj50aLSiAZgzbeUwxFzQeOblYQZDD6nriOSwWo4BW3gba6ItjlczlkII6XEldUHjH/l
         Hh9g==
X-Gm-Message-State: AGi0PubEaCItGHd+k6HExEe6NS2O8IBHOsFF72FdAw+sN+l9vu9hPHje
        osZufEwM9ln+SACvTbIPajoXkw==
X-Google-Smtp-Source: APiQypJegcKZF/wweQ1RYqZk0HgHdf1LG8GEMgO8/vhPHmxPS+9FXmlsw+ezmIS+Gv8y0QK3+eOHbw==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr19745201wru.92.1588593223069;
        Mon, 04 May 2020 04:53:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b22sm12935177wmj.1.2020.05.04.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:53:41 -0700 (PDT)
Date:   Mon, 4 May 2020 12:53:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon
 leaving
Message-ID: <20200504115339.ndi3n4evklzidvb5@holly.lan>
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan>
 <20200501133202.GA2402281@wychelm.lan>
 <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 01, 2020 at 10:36:14AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 1, 2020 at 6:32 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, May 01, 2020 at 12:49:43PM +0100, Daniel Thompson wrote:
> > > On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > > > The original implementation of kgdboc_earlycon included a comment
> > > > about how it was impossible to get notified about the boot console
> > > > going away without making changes to the Linux core.  Since folks
> > > > often don't want to change the Linux core for kgdb's purposes, the
> > > > kgdboc_earlycon implementation did a bit of polling to figure out when
> > > > the boot console went away.
> > > >
> > > > It turns out, though, that it is possible to get notified about the
> > > > boot console going away.  The solution is either clever or a hack
> > > > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > > > need to do is head-patch the "exit" routine of the boot console.  We
> > > > know that "struct console" must be writable because it has a "next"
> > > > pointer in it, so we can just put our own exit routine in, do our
> > > > stuff, and then call back to the original.
> > >
> > > I think I'm in the hack camp on this one!
> > >
> > >
> > > > This works great to get notified about the boot console going away.
> > > > The (slight) problem is that in the context of the boot console's exit
> > > > routine we can't call tty_find_polling_driver().
> > >
> > > I presume this is something to do with the tty_mutex?
> > > > We solve this by
> > > > kicking off some work on the system_wq when we get notified and this
> > > > works pretty well.
> > >
> > > There are some problems with the workqueue approach.
> >
> > ... so did a couple of experiments to avoid the workqueue.
> >
> > It occured to me that, since we have interfered with deinit() then the
> > console hasn't actually been uninitialized meaning we could still use it.
> > This does exposes us to risks similar to keep_bootcon but in exchange
> > there is no window where kgdb is broken (and no need to panic).
> >
> > My prototype is minimal but I did wonder about ripping out all the
> > code to defend against removal of the earlycon and simply keep the
> > earlycon around until a new kgdbio handler is installed.
> 
> It took me a little while, but I finally see what you're saying.
> You're saying that we keep calling into the boot console even though
> it's no longer in the list of consoles.  Then we temporarily disable
> the boot console's exit routine until kgdb_earlycon() is done.  (side
> note: the exit routine was recently added and probably most consoles
> don't use it).

Certainly none of the devices with a read() method have an exit().


> OK, that doesn't seem totally insane.  It actually works OK for you?

I tested on qemu/x86-64 (8250) and qemu/arm64 (pl011). In both cases it
works well.


> It's probably at least worth a warning in the log if we detect that
> we're using the boot console and it's not in the console list anymore.
> Then if kgdb starts misbehaving someone might have a clue.

Yes, I'll add that.


> If your solution is OK we might also want to remove the call to
> cleanup_earlycon_if_invalid() in configure_kgdboc() too.

That's what I thought, yes. Although it might be best to handle that
by ripping it out of the original patch set.


> I think you might win the "hackiest solution" prize, but your solution
> definitely does seem better because I can't think of any other good
> way to handle people whose consoles register a long time before their
> tty.  ;-)

That's not a prize I was especially anxious to win...

However the results seem quite pleasing from a user point of view:
*if* we hit a breakpoint then the system really will be leaving no
stone unturned in its attempt to have talk (and listen) to the user.

If we want things to avoid hacking at the console structure  we could
provide a direct function call API from earlycon to kgdboc so we limit
earlycon_kgdboc so it can *only* attach to the earlycon (and either
defer the exit() or leave a comment in earlycon so that if exit() were
ever added it doesn't break kgdboc).


Daniel.
