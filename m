From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Wed, 14 Nov 2012 12:12:22 +0000
Message-ID: <20121114121222.3e42860f@pyramind.ukuu.org.uk>
References: <20121114060724.GN30156@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52267 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722Ab2KNMHG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 07:07:06 -0500
In-Reply-To: <20121114060724.GN30156@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: linux-serial@vger.kernel.org

> The driver supports a wide range of Quatech DSC/ESC/QSC cards, including the
> custom functionality which allow various aspects of the signal routing to be
> altered under software control.

This has actually been kicked around with another couple of cards. We
have a draft but never test implemented API for binding gpio numbers on
a device to signals for the tty layer.

>  - the name of the module.  Anything with "qt" in it will confuse people.
>    I'm thinking along the lines of serial-quatech or quatech-serial:
>    comments welcome.

qt is fine in kernel - just be careful of the qt usb module.

I think in the same place I'd start by just adding the needed identifiers
to the 8250_pci driver along with any needed init helper.

For the ioctls a lot appear to be just exposing values which as you say
would fit sysfs. The tty layer now (as of 3.7rc) usefully supports sysfs
nodes on a tty itself too.

The basic ones are already handled by 8250_pci.c (QSC100, DSC100,
ESC100D, ESC100M).

As far as I can see the issues are

1.	Clock multiplier feature

Supportable by flags in 8250.c and worst case by providing a custom
set_termios. No API needed.

2.	RS485/RS422 options

Supportable by adding TIOCRS485 handling/callout to 8250.c (needs doing
anyway)

The RS485 ioctl might need some extending but we've been gradually doing
this as we hit chips with more features in hardware so that's not a
problem beyond synchronizing with other platforms who can use the extra
flags.

Alan
