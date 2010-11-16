From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 20:04:26 +0000
Message-ID: <20101116200426.75085b68@lxorguk.ukuu.org.uk>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
	<4CBD8EE4.5040808@evidence.eu.com>
	<i9ka0s$4ua$1@dough.gmane.org>
	<201010191727.53314.alexander.stein@systec-electronic.com>
	<i9kk4o$svc$1@dough.gmane.org>
	<4CC418A9.6090602@evidence.eu.com>
	<4CDA630F.4060903@atmel.com>
	<20101110172842.GC12371@suse.de>
	<4CDBC3EC.6020707@evidence.eu.com>
	<20101116143016.GB6527@ucw.cz>
	<AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
	<20101116172013.102e06a6@lxorguk.ukuu.org.uk>
	<ibuh1v$uh6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42514 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932166Ab0KPUFg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Nov 2010 15:05:36 -0500
In-Reply-To: <ibuh1v$uh6$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> Comtrol, Moxa, B&B, Sealevel, and others all sell PCI cards and
> Ethernet attached serial ports that have selectable interfaces
> (typically RS-232/422/485).  Comtrol and Moxa have had drivers in the
> kernel tree for ages, but they've always had to use custom ioctl calls
> for things like configuring 232/485/422 mode and half/full-duplex
> mode.

Ok so what is needed that isn't covered by the current termiox and
TIOCG/SRS485 ioctls ?

> Having a standard API for things like interface mode, half-full
> duplex, inter-character timeout, 9-bit mode, and so on would be life a
> lot easier for those of us who maintain Linux serial drivers...

9bit mode is a real problem with the tty layer defined in terms of 8bit
streams but yes.
