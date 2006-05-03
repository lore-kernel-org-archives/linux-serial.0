From: Sergei Organov <osv@javad.com>
Subject: High baud rates support for Quatech DSP-100.
Date: Wed, 03 May 2006 16:59:16 +0400
Message-ID: <e3a9g8$idv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030179AbWECNAP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


I've got a Quatech DSP-100 PCMCIA dual RS232 adapter. After adding the
adapter parameters into the 'multi_id' and 'serial_ids' tables of the
serial_cs.c driver, it is now automatically loaded and supports the card
almost fine. However, the card supports baud rates up to 460800, but
using serial_cs I get rates only up to 115200.

On the other hand, Quatech has GPL Linux driver (serial_qt.c) for this
card that has been made for some early 2.6.x kernel version and doesn't
compile for recent 2.6.16. I've managed to hack it to compile for
2.6.16.8, -- it does support 460800 indeed.

So the question is what to do next. I'd like to either modify serial_cs
to support high baud rates or to somehow get serial_qt to the linux
tree. For me it seems that the former is more appropriate as serial_qt
in fact looks like some earlier serial_cs modified by Quatech. OTOH,
supporting high baud rates seems to be very card-specific[1] and IMHO
doesn't fit well into rather generic serial_cs.

Is it OK to put card-specific code into serial_cs (provided it's invoked
only after manufacturer id is checked)? Should it be Kconfig option? Is
there a better way to go?

[1] It basically involves checking of some card-specific config
register(s), then setting another card-specific register accordingly and
setting of the 'uartclk' field of the 'struct uart_port' to
corresponding value.

-- 
Sergei.
