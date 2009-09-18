From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH][bfin-sport-uart] Walk around RX underflow hardware issue
	in 32-bit SPORT RX reading
Date: Fri, 18 Sep 2009 11:14:38 -0400
Message-ID: <8bd0f97a0909180814i1ee3156dj8e2be2763f4eafa1@mail.gmail.com>
References: <1253264747.22138.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:49990 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZIRPOz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 11:14:55 -0400
In-Reply-To: <1253264747.22138.2.camel@eight.analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Fri, Sep 18, 2009 at 05:05, sonic zhang wrote:
> Disable local interrupts in 32-bit reading from SPORT RX MMR to walk
> around the RX underflow hardware issue when this reading is interrupted
> by the other IRQ.

ive cleaned up the code in svn, so if you want to grab the updated
version for sending out.
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
-mike
