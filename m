Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBD6C64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458E02168B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yc1l69A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgLAQnq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgLAQnq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 11:43:46 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC31206C1;
        Tue,  1 Dec 2020 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606840979;
        bh=QiWRNieJdF6tgJhKrlOVcaaFrsOwulRSCoTFwHEsMm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yc1l69A5mYYwjRy+2oo91foSfJ/DmhA3rwR9yRvmupDvv47Arm0FNiqpZkEsBYmmB
         MDeq33z6kBd9ij7k7vnDJbBqQI1Ht1o8goj5PixEI1Hov9FyJAZRnJpy2HgfEpbwv0
         rqsNQCb9ucGitAkzhJtGa0ykg2A/ihSbKwOwdhR8=
Date:   Tue, 1 Dec 2020 17:44:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready
 signalling on open
Message-ID: <X8Zy2uVyhzZfseUd@kroah.com>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-3-johan@kernel.org>
 <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
 <X8X9B1jYujUIWXaK@localhost>
 <CAHp75VfQud=QxwZyhYRU9mtNvrudj0tS6LOuutfJDVdv=-ptXw@mail.gmail.com>
 <X8Yjc0+Q7fM0nZP+@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8Yjc0+Q7fM0nZP+@localhost>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 12:05:23PM +0100, Johan Hovold wrote:
> On Tue, Dec 01, 2020 at 12:55:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 1, 2020 at 10:20 AM Johan Hovold <johan@kernel.org> wrote:
> > > On Mon, Nov 30, 2020 at 08:27:54PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
> > 
> > > > > +       ret = kstrtouint(buf, 0, &val);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > >
> > > > > +       if (val > 1)
> > > > > +               return -EINVAL;
> > > >
> > > > Can't we utilise kstrtobool() instead?
> > >
> > > I chose not to as kstrtobool() results in a horrid interface. To many
> > > options to do the same thing and you end up with confusing things like
> > > "0x01" being accepted but treated as false (as only the first character
> > > is considered).
> > 
> > And this is perfectly fine. 0x01 is not boolean.
> 
> 0x01 is 1 and is generally treated as boolean true as you know.
> 
> So why should a sysfs-interface accept it as valid input and treat it as
> false? That's just bad design.

The "design" was to accept "sane" flags here:
	1, y, Y mean "enable"
	0, n, N mean "disable"

We never thought someone would try to write "0x01" as "enable" for a
boolean flag :)

So it's not a bad design, it works well what it was designed for.  It
just is NOT designed for hex values.

If your sysfs file is "enable/disable", then please, use kstrtobool, as
that is the standard way of doing this, and don't expect 0x01 to work :)

thanks,

greg k-h
