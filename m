From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match
 serial core
Date: Sat, 20 Sep 2008 15:01:56 +0200
Message-ID: <20080920150156.1de8f901@hskinnemo-gx745.norway.atmel.com>
References: <866907.89401.qm@web26206.mail.ukl.yahoo.com>
	<20080919203520.2969dffd@hskinnemo-gx745.norway.atmel.com>
	<48D41E69.8050308@artecdesign.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:39302 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbYITNCH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 09:02:07 -0400
In-Reply-To: <48D41E69.8050308@artecdesign.ee>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anti Sullin <anti.sullin@artecdesign.ee>
Cc: Michael Trimarchi <trimarchimichael@yahoo.it>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>

Anti Sullin <anti.sullin@artecdesign.ee> wrote:
> Haavard Skinnemoen wrote:
> > I don't think the gpio layer is supposed to touch the portmux. David
> > has always been very clear about that. But if we somehow manage to get
> > the pin configured as a GPIO, we can use the GPIO layer to request a
> > pin change interrupt.
> >
> > It _might_ work even if you don't reconfigure the pin as a GPIO...but
> > then I think we'd be relying on undocumented behaviour.
> >   
> I believe that you don't need to reconfigure the pin. The gpio hw does
> not require the pin to be multiplexed to any given state, so does not request_irq (correct?).
> I did this trick in my [2/3] MCI driver patch I sent to arm-linux-kernel at 18.03.2008 (the
> e-mail subject line was wrong, [1/3], though) and I'm using that patch still on my
> production devices to avoid some rare but critical SD data corruption (mainline kernel still 
> screws up the filesystem on SD sometimes). The same should be easily usable on serial port, too.

You're right. It works, and it's documented. I don't think it's
guaranteed by the GPIO API, but as long as it's guaranteed on AT91 and
AVR32, we should be fine.

> So in many applications we could not use this. But this might still come handy
> in a lot of cases we can poll and find out what caused the data on the serial
> port etc. Or on applications, where this loss of data does not matter (like debug
> console where the resume is usable even if it does not wake up on the first byte).

Yes, as long as you have some sort of timeout/retry mechanism in place,
it might be useful.

Haavard
