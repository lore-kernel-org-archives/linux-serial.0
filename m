From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
Date: Tue, 19 Apr 2011 16:21:41 -0700
Message-ID: <20110419232141.GA27491@kroah.com>
References: <e35578a9-909d-4594-bbe4-41d89b5f9b3e@VA3EHSMHS014.ehs.local>
 <20110419221530.7370d013@lxorguk.ukuu.org.uk>
 <8d05c32c-9ff1-4eda-9563-6857ede6541a@VA3EHSMHS020.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:52411 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab1DSXWO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Apr 2011 19:22:14 -0400
Content-Disposition: inline
In-Reply-To: <8d05c32c-9ff1-4eda-9563-6857ede6541a@VA3EHSMHS020.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Apr 19, 2011 at 04:22:00PM -0600, John Linn wrote:
> > -----Original Message-----
> > From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > Sent: Tuesday, April 19, 2011 3:16 PM
> > To: John Linn
> > Cc: linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org
> > Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
> > 
> > On Tue, 19 Apr 2011 14:14:52 -0600
> > John Linn <john.linn@xilinx.com> wrote:
> > 
> > > The Xilinx PS Uart is used on the new ARM based SoC. This
> > > UART is not compatible with others such that a seperate
> > > driver is required.
> > 
> > Joyous. I wish people would standardise.
> > 
> > > +		 213 = /dev/ttyPS0		Xilinx PS serial port 0
> > > +		 214 = /dev/ttyPS1		Xilinx PS serial port 1
> > > +		 215 = /dev/ttyPS2		Xilinx PS serial port 2
> > > +		 216 = /dev/ttyPS3		Xilinx PS serial port 3
> > 
> > Is there a specific reason you need fixed minor numbers ? If not
> please
> > use a dynamic range and keep Linus happy.
> 
> Hi Alan,
> 
> I hope you don't mind me asking a bit more to better understand.  Here's
> my
> concerns (maybe not valid).
> 
> It seems like since this is a console it can get hard to debug with
> dynamic 
> nodes for this driver.
> 
> This driver is for an embedded device where we don't want to require
> udev 
> or mdev to assign nodes. 

Why not use devtmpfs?  There's no need to use udev or mdev at all.

thanks,

greg k-h
