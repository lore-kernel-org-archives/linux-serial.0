From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Wed, 24 Dec 2008 00:23:07 +1100
Message-ID: <1230038587.17555.68.camel@thetriton.toftronix.com.au>
References: <200812190048.35249.mfuchs@ma-fu.de>
	 <1229853004.3216.14.camel@thewinkle.toftronix.com.au>
	 <20081222155956.GA13526@pengutronix.de>
	 <200812221902.27752.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:42758 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750758AbYLWNLo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Dec 2008 08:11:44 -0500
In-Reply-To: <200812221902.27752.mfuchs@ma-fu.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org

Recent discussions on RS485 auto direction control seem to be split over
a number of threads.

Here are the threads that I'm aware of:
http://marc.info/?t=121805745200001&r=1&w=2
http://marc.info/?t=121690034200007&r=1&w=2
http://marc.info/?t=122821576400003&r=1&w=2
http://marc.info/?t=122822457300004&r=1&w=2
http://marc.info/?t=122954923400001&r=1&w=2
http://marc.info/?t=122964426200001&r=1&w=2
http://marc.info/?t=121566595900001&r=1&w=2
http://marc.info/?t=121805198200004&r=1&w=2


Also of interest is the set of patches by Aristeu Rozanski on 
http://marc.info/?l=linux-serial&r=1&b=200809&w=2
An issue related to a RS485 support is also covered in the message
http://marc.info/?l=linux-serial&m=121811414618759&w=2

Apologies to all if I've missed any thing, feel free to add to the list.

or some of the same on the gmane site:
http://thread.gmane.org/gmane.linux.serial/2563/focus=2568
http://thread.gmane.org/gmane.linux.serial/2957
http://thread.gmane.org/gmane.linux.serial/2936
http://thread.gmane.org/gmane.linux.serial/2612/focus=2618


On Mon, 2008-12-22 at 19:02 +0100, Matthias Fuchs wrote:
> Oops,
> 
> I must admit that I was not aware of that thread. Mea culpa!
> I will go through those arguments and see if I can take some
> effort from that. 
> 
> Again, I will not take care of any software RS485 and I will
> never use any name that contains RTS. 
> 
> I will also keep my ioctl implementation instead of any termios stuff
> - when nobody contradicts.
> 
> Matthias
> 
> > Hello Chris,
> >
> > On Sun, Dec 21, 2008 at 08:50:04PM +1100, Chris Gibson wrote:
> > > Two and a half weeks ago I submitted a patch to implement RS485 auto
> > > direction control on either (or both) the RTS and the DTR lines with
> > > varying pre and post delay settings that would work for _all_ uarts that
> > > support mctrl.
> >
> > Just observing the case, I assume that this concern about software RS485
> > is still valid:
> >
> > http://article.gmane.org/gmane.linux.serial/2568
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Christopher Gibson <chris@toftronix.com.au>

