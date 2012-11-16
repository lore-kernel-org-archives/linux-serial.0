From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
Date: Fri, 16 Nov 2012 22:46:40 +0200
Message-ID: <CAFumwP24g0Rt4_fXSE7c8GehLJYumHzUD=UvWV88HThmUp_CGg@mail.gmail.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
	<E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
	<20121116095352.GF4398@game.jcrosoft.org>
	<50A6119E.8010303@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:51350 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KPUqk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 15:46:40 -0500
In-Reply-To: <50A6119E.8010303@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>

hi,

> Yes, during previous attempt to remove the files, Andrew said that it
> was used internally in his former company. I had no serious reason to
> remove it, so we kept it back then.
> But now it seems the situation has evolved and we must consider the move
> to a single kernel image and the will to clean the include/asm/mach
> directory.

SAN People will just need to maintain a custom patch / driver for this.
No reason to delay the progress of mainline.

Acked-By: Andrew Victor <avictor.za@gmail.com>
