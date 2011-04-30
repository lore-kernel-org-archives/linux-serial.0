From: johnlinn@comcast.net
Subject: Re: [PATCH V5] tty/serial: add support for Xilinx PS UART
Date: Sat, 30 Apr 2011 00:15:54 +0000 (UTC)
Message-ID: <360432418.2101963.1304122554428.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110429233719.GA25417@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:41719 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429Ab1D3AP4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Apr 2011 20:15:56 -0400
In-Reply-To: <20110429233719.GA25417@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, John Linn <john.linn@xilinx.com>


> On Fri, Apr 29, 2011 at 03:59:06PM -0600, johnlinn@comcast.net wrote:
> > From: John Linn <john.linn@xilinx.com>
> > 
> > The Xilinx PS Uart is used on the new ARM based SoC. This
> > UART is not compatible with others such that a seperate
> > driver is required.
> > 
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> That's fine, but:
> 
> > 
> > This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you
> are not the intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message and any
> attachments immediately.
> >
> 
> That means I can't apply this patch :(
> 
> {sigh}
> 
> Please fix this, as it does not allow you to participate in kernel
> development efforts.

Sorry for trying your patience, V6 is out and shouldn't have that
nasty issue.

Your patience is much appreciated as I'm fighting the good fight with
legal about this and working around it (not real smooth obviously).

Thanks
John

> 
> greg k-h
