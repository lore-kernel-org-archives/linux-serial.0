From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Mon, 19 Jun 2006 22:06:52 +0100
Message-ID: <1150751212.2871.44.camel@localhost.localdomain>
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
	 <20060619184706.GH3479@flint.arm.linux.org.uk>  <4496FEC2.8050903@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932305AbWFSUwI
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jun 2006 16:52:08 -0400
In-Reply-To: <4496FEC2.8050903@rtr.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Ar Llu, 2006-06-19 am 15:45 -0400, ysgrifennodd Mark Lord:
> If the drivers are written "correctly", they shouldn't grab the IRQ
> until someone actually opens the device.  Which means they should be
> able the share the IRQ, so long as both devices are not in use (open)
> at the same time.

This is not the case for ISA bus. Most ISA hardware is physically unable
to share and the drivers for such hardware intentionally grab the IRQ at
load time to avoid it being mis-reused.

Alan

