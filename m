From: johnlinn@comcast.net
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Wed, 27 Apr 2011 20:57:39 +0000 (UTC)
Message-ID: <2016772931.1967511.1303937859543.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110427214045.6f6d179d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:38173 "EHLO
	qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756589Ab1D0U5l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Apr 2011 16:57:41 -0400
In-Reply-To: <20110427214045.6f6d179d@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, greg@kroah.com, John Linn <john.linn@xilinx.com>

> On Wed, 27 Apr 2011 12:17:36 -0600
> <johnlinn@comcast.net> wrote:
> 
> > From: John Linn <john.linn@xilinx.com>
> > 
> > The Xilinx PS Uart is used on the new ARM based SoC. This
> > UART is not compatible with others such that a seperate
> > driver is required.
> > 
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> Acked-by: Alan Cox <alan@linux.intel.com>

Thanks a bunch Alan, appreciate the help.
