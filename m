From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Fwd: Bug in USB FTDI SIO driver
Date: Sat, 8 Sep 2012 08:45:22 -0700
Message-ID: <20120908154522.GA2976@kroah.com>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42633 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab2IHPp0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 11:45:26 -0400
Received: by pbbrr13 with SMTP id rr13so995112pbb.19
        for <linux-serial@vger.kernel.org>; Sat, 08 Sep 2012 08:45:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: peter.sheeren@axiris.be
Cc: linux-serial@vger.kernel.org

On Sat, Sep 08, 2012 at 12:14:39PM +0200, peter.sheeren@axiris.be wrote:
> Hello
> 
> At the suggestion of Greg's friendly e-mail bot I'm sending my
> report to this e-mail address. I hope it's the right one.
> 
> Peter
> 

> Date: Sat, 08 Sep 2012 04:21:06 +0200
> From: peter.sheeren@axiris.be
> To: jhovold@gmail.com, greg@kroah.com
> Subject: Bug in USB FTDI SIO driver
> 
> 
> Hello
> 
> I didn't find an easy way to file a bug report so I extracted the
> source file ftdi_sio.c from the latest Linux kernel and browsed for
> the e-mail addresses hence this e-mail.
> 
> I've been struggling with an annoying plug-and-play issue involving
> an FT232RL-based USB device on ARM machines with Linux lately
> (including Raspberry Pi and BeagleBoard). In a nutshell the
> following is happening:
> * I plug in the FT232RL-based USB device. /dev/ttyUSB0 is created.
> * I run an application that communicate with the device via
> /dev/ttyUSB0. The application sets a baudrate - this is important.
> The application reads and writes data successfully.
> * I unplug the USB device. /dev/ttyUSB0 remains in existence - this
> is important too.

Huh?  The device node should go away, as the application was told that
the device went away, is the application somehow still keeping the
device node open?  If so, that's the issue here.

> * I replug the USB device. /dev/ttyUSB0 is still there.
> * I rerun the application. The application again connects with
> /dev/ttyUSB0 but it fails to transfer data. So it seems.

That's because it is trying to still talk to the old device, not the new
one, which should have showed up on ttyUSB1.

What kernel version are you using here?

greg k-h
