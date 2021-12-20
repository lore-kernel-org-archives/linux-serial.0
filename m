Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC0C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 15:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhLTPnU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:43:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36414 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLTPnU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 10:43:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB559B80E22
        for <linux-serial@vger.kernel.org>; Mon, 20 Dec 2021 15:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B808C36AE5;
        Mon, 20 Dec 2021 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640014997;
        bh=RrAwe9seiqP85yjY4vmgFvwGF9XlFgcjccUdRKw5JJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQOaFJqx64yaEtaCTKFq7rQ+uvNI8t4o2R26Rhna4DCXuenjYEkEPEKL1Pz8qNm0g
         8K864uYF3t3TodnASh+I86r38jlwUZKG9/COYvkKA0x+ed1Amfj7PhQCnDmUB9XyfI
         GDuzZc3rjE3agwvqjKbOovJaxOuL8hr4pQzf8X6I=
Date:   Mon, 20 Dec 2021 16:43:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Peyrega <mathieu.peyrega@gmail.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        giometti@linux.it
Subject: Re: [PATCH] Allow PPS on CTS pin and non-RS232 UARTs
Message-ID: <YcCkk8ck91Nt4F0R@kroah.com>
References: <bc2d427e30e24978be5800c41f921b9d782570e7.camel@gmail.com>
 <YaoXfxwSeVVWUWUJ@kroah.com>
 <14a35918ecc95199066ea78c7814cf71bcd9e52e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a35918ecc95199066ea78c7814cf71bcd9e52e.camel@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Dec 04, 2021 at 04:57:56PM +0100, Mathieu Peyrega wrote:
> Le vendredi 03 décembre 2021 à 14:11 +0100, Greg KH a écrit :
> > On Thu, Dec 02, 2021 at 11:56:10AM +0100, Mathieu Peyrega wrote:
> > > Hello,
> > > 
> > > this is my first contribution to this list (and the Linux kernel)
> > > and I'd
> > > like trying to revive a subject already discussed in a 2017/2018
> > > thread about
> > > adding a possibility to use the CTS pin instead of the DCD pin for
> > > 1PPS line
> > > disciplining (cf. 
> > > https://www.spinics.net/lists/linux-serial/msg27604.html)
> > 
> > A few meta-comments about the patch.
> > 
> > Look at how other patches are submitted, there's no need for this
> > type
> > of introduction in the changelog text, and in fact, you have no
> > changelog text in your patch at all.  So the body of this email needs
> > to
> > go into the changelog area, please do so when you resend.
> 
> will do
> 
> > > The rationale is similar to the original poster's one: some TTL
> > > UARTs hardware
> > > implementations have an incomplete wiring and do not expose a DCD
> > > pin (e.g. on
> > > some SBCs). On those platforms only TX, RX, CTS and RTS are
> > > available. In such
> > > cases, being able to use the CTS pin for 1PPS time disciplining is
> > > useful.
> > > 
> > > In addition, to that primary need, I believe there is another
> > > missing feature
> > > in current implementation. Some non-RS232 UARTs (e.g. TTL UARTs
> > > also often
> > > found on SBCs) have an inverted behaviour with respect to RS232
> > > rising edge or
> > > falling edge vs. assert or clear logics. Not taking this inversion
> > > into account
> > > results in a disciplining where the kernel time ends with an offset
> > > from actual
> > > signal time. Offset value is the width/duration of the 1PPS square
> > > pulse signal.
> > > At least this is what I experienced in the testing process on an
> > > Odroid H2 SBC
> > > (Intel x86_64 based) and a GNSS driven 1PPS signal (from a CORS
> > > station that I
> > > manage). Maybe this can be handled from a later userland process
> > > (e.g. ntpd)
> > > but I believe that being able to handle it straight at kernel level
> > > is better.
> > > 
> > > As for the module behaviour control, I went with adding 2
> > > parameters to
> > > pps-ldisc:
> > > 
> > > -	activepin (charp) wich can be dcd (default) or cts and drives
> > > the pin
> > > 	which should be consider to detect the 1PPS signal
> > > -	invertlogic (bool) which can be false (default) or true and
> > > defines if
> > > 	the driver complies with a RS232 type signal where assert is on
> > > the
> > > 	rising edge or inverted as for some TTL UARTs. Default values
> > > match
> > > 	the current behaviour.
> > 
> > New module parameters should never be added, as they only affect the
> > whole system, and not on a per-device basis.  If you have to add new
> > options, please do it some other way.
> 
> I don't fully understand the point. Isn't the existing pps_ldisc module
> already affecting the whole system ? (with it's builtin fixed
> "options"). How different tunable options such as the proposal make
> things fundamentally different ? Still I agree that per device settings
> would be better.

Per device settings are required, this would prevent multiple devices
working in the same system, one using the existing line discipline
functionality, and one with your new changes.

> > Also, by adding new options, that means you are changing the logic
> > here,
> > why not create a new line discipline that acts the way you want it to
> > act?  The existing one is very small, it should not be much to make a
> > new one with just the new functionality, right?
> 
> I can retry on this track. However I believe , it will also need
> support from userland utility (especially ldattach). I don't know if
> this kind of consequences is in the scope of the discussion here.

Why would userspace need to be modified?

Try this as a new line discipline, should be much easier and simpler
overall for everyone.

thanks,

greg k-h
