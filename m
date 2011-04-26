From: johnlinn@comcast.net
Subject: Re: [PATCH V3] tty/serial: add support for Xilinx PS UART
Date: Tue, 26 Apr 2011 14:18:53 +0000 (UTC)
Message-ID: <1494342619.1871798.1303827533853.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <342576875.1870580.1303826202211.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:36649 "EHLO
	qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756327Ab1DZOYl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Apr 2011 10:24:41 -0400
In-Reply-To: <342576875.1870580.1303826202211.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, grant likely <grant.likely@secretlab.ca>

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Friday, April 22, 2011 9:22 AM
> To: John Linn
> Cc: michal.simek@petalogix.com; linux-kernel@vger.kernel.org;
> linux-serial@vger.kernel.org; alan@lxorguk.ukuu.org.uk;
> grant.likely@secretlab.ca
> Subject: Re: [PATCH V2] tty/serial: add support for Xilinx PS UART
> 
> On Fri, Apr 22, 2011 at 09:12:42AM -0600, John Linn wrote:
> > This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may
> be
> proprietary, privileged or copyrighted under applicable law. If you
> are
> not the intended recipient, do not read, copy, or forward this email
> message or any attachments. Delete this email message and any
> attachments immediately.
> > 
> 
> Please remove these lines, they are incompatible with opensource
> kernel
> development efforts.

Hi Greg,

This should be better and not have that nasty footer.

It's not clear to me how owns the serial driver subsystem as I see that
you own the tty and a serial driver. I'm trying to figure out who I would
ask if they will merge this patch in to their tree?

Thanks,
John

> 
> sorry,
> 
> greg k-h
> 
> 
