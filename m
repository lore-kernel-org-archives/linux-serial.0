From: johnlinn@comcast.net
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Tue, 26 Apr 2011 21:19:34 +0000 (UTC)
Message-ID: <1722853311.1900521.1303852774744.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110426194740.GB17748@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:43877 "EHLO
	qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932356Ab1DZVTk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Apr 2011 17:19:40 -0400
In-Reply-To: <20110426194740.GB17748@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, grant likely <grant.likely@secretlab.ca>, alan@lxorguk.ukuu.org.uk

> On Tue, Apr 26, 2011 at 02:18:53PM +0000, johnlinn@comcast.net wrote:
> > It's not clear to me how owns the serial driver subsystem as I see
> that
> > you own the tty and a serial driver. I'm trying to figure out who I
> would
> > ask if they will merge this patch in to their tree?
> 
> Resend it, cc the linux-serial list and me and Alan Cox.  I'll pick
> it
> up in my "tty" tree if he acks it.

Great, thanks.  Alan responded with a bit more work, but now I know how
the process will eventually work.

Thanks,
John

> 
> thanks,
> 
> greg k-h
