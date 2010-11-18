From: Michael Haardt <michael@moria.de>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 21:58:17 +0100
Message-ID: <E1PJBYf-0000h6-9W@palantir.moria.de>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com> <E1PJAfx-0000gW-8e@palantir.moria.de>
 <20101118201125.GA26323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-gw.moria.de ([85.116.193.48]:38293 "EHLO gandalf.moria.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754211Ab0KRU6V (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 15:58:21 -0500
In-Reply-To: <20101118201125.GA26323@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org

> What is the BSD user/kernel api that they have to provide this?

BSD uses port-specific driver flags, so changing them requires a
reboot.

>From sio(4):

     For standard ISA ports:
	   device sio

	   In /boot/device.hints:
	   hint.sio.0.at="isa"
	   hint.sio.0.port="0x3f8"
	   hint.sio.0.flags="0x10"
	   hint.sio.0.irq="4"
	   hint.sio.1.at="isa"
	   hint.sio.1.port="0x2f8"
	   hint.sio.1.flags="0x0"
	   hint.sio.1.irq="3"
[...]
     Meaning of flags:
	   0x00001   shared IRQs
	   0x00002   disable FIFO
[...]

It is important that the setting is port-specific, not global.

Michael
