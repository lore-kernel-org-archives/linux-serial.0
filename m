From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: Saving data from the serial port
Date: Mon, 21 Apr 2003 12:37:16 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <00a901c30824$44d8a740$294b82ce@connecttech.com>
References: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE> <20030418000627.GB442@lafn.org> <015801c305f6$2eebb9c0$294b82ce@connecttech.com> <20030419063939.GA393@lafn.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:62731 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S261595AbTDUQVE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Apr 2003 12:21:04 -0400
List-Id: linux-serial@vger.kernel.org
To: David Lawyer <dave@lafn.org>, linux-serial@vger.kernel.org

From: "David Lawyer" <dave@lafn.org>
> On Fri, Apr 18, 2003 at 06:02:19PM -0400, Stuart MacDonald wrote:
> > From: "David Lawyer" <dave@lafn.org>
> > > I don't think so (but of course you should use flow control).  There
> > > just isn't any way to use flow control to protect the FIFO buffers
from
> > > overruns in Linux.  Flow control (for the input flow into a PC) only
> > > protects the serial 8K buffer in main memory.
> >
> > Not true. Many modern uarts have on-board flow control both hardware
> > and software based. Turn it on and the hardware does the magic when it
> > finds its fifos getting full.
>
> Does the Linux serial driver support this?  I didn't think that it did.
> David Lawyer

linux-2.4.20/drivers/char/serial.c:1774

Although support seems to be only for auto-cts. I coulda sworn it was
for both. The hardware based soft-flow control isn't being used
though.

..Stu


