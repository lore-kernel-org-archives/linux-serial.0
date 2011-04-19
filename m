From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] tty/serial: add support for Xilinx PS UART
Date: Tue, 19 Apr 2011 16:22:00 -0600
Message-ID: <8d05c32c-9ff1-4eda-9563-6857ede6541a@VA3EHSMHS020.ehs.local>
References: <e35578a9-909d-4594-bbe4-41d89b5f9b3e@VA3EHSMHS014.ehs.local> <20110419221530.7370d013@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:20136
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751617Ab1DSWXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Apr 2011 18:23:50 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110419221530.7370d013@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Tuesday, April 19, 2011 3:16 PM
> To: John Linn
> Cc: linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
> 
> On Tue, 19 Apr 2011 14:14:52 -0600
> John Linn <john.linn@xilinx.com> wrote:
> 
> > The Xilinx PS Uart is used on the new ARM based SoC. This
> > UART is not compatible with others such that a seperate
> > driver is required.
> 
> Joyous. I wish people would standardise.
> 
> > +		 213 = /dev/ttyPS0		Xilinx PS serial port 0
> > +		 214 = /dev/ttyPS1		Xilinx PS serial port 1
> > +		 215 = /dev/ttyPS2		Xilinx PS serial port 2
> > +		 216 = /dev/ttyPS3		Xilinx PS serial port 3
> 
> Is there a specific reason you need fixed minor numbers ? If not
please
> use a dynamic range and keep Linus happy.

Hi Alan,

I hope you don't mind me asking a bit more to better understand.  Here's
my
concerns (maybe not valid).

It seems like since this is a console it can get hard to debug with
dynamic 
nodes for this driver.

This driver is for an embedded device where we don't want to require
udev 
or mdev to assign nodes. 

It seems like the static device nodes are typical for serial consoles in
the 
drivers. I'm still digging in on the subject.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


