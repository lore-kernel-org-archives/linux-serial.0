From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: relocate remaining serial drivers from tty/ to tty/serial/
Date: Wed, 4 Jan 2012 23:27:33 +0000
Message-ID: <201201042327.33739.arnd@arndb.de>
References: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com> <4F04BFA8.9010100@windriver.com> <20120104220332.GA22985@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53365 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab2ADX2M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 18:28:12 -0500
In-Reply-To: <20120104220332.GA22985@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.cz>, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Wednesday 04 January 2012, Greg KH wrote:
> > 
> > My thinking was that having a drivers/tty/serial dir and then
> > not having all the serial drivers in that dir violated the
> > principle of least surprise.  Is there a reason why the dir should
> > be the exclusive domain of drivers with a dependency on SERIAL_CORE?
> 
> Because that is what the directory is for?  :)
> 
> We have other "serial" like drivers all over the kernel, this was for
> the SERIAL_CORE drivers only at the moment.

My initial plan when moving some files to drivers/tty was to have a separate
directory for the non-SERIAL_CORE serial drivers next to drivers/tty/serial.

I would still prefer this solution, but I think we never agreed on a good
name for that directory. IIRC, I had suggested drivers/tty/legacy believing
that SERIAL_CORE was the modern way to implement a serial driver, but that
turned out not to be true and at lease one of these (bfin_jtag) is not
a legacy driver in practice.

Maybe drivers/tty/hw? I think that one has been suggested before, too.
I don't remember any argument against it and I think it would be nice
to separate the core implementation from actual device drivers.

	Arnd
