From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 20:23:47 +0100
Message-ID: <20110406202347.61c5986e@lxorguk.ukuu.org.uk>
References: <ini5hh$7s3$1@dough.gmane.org>
	<20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
	<ini718$hfj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59707 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753888Ab1DFTXF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 15:23:05 -0400
In-Reply-To: <ini718$hfj$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> This raises a question I've been wondering about for some time.  While
> the kernel and the serial driver API support arbitrary baud rates,
> termios doesn't AFAICT.
> 
> How does one use the standard POSIX serial port API to obtain an
> abritrary baud rate?

The POSIX API is completely broken in this respect. So the kernel
provides its own interface.

> The only way I can find to get arbitrary baud rates from a user
> perspective is to use the ASYNC_SPD_xxxx mechanism.

Which is also not POSIX


Simple example app:
 
http://www.kerneltrap.com/mailarchive/linux-usb/2008/10/2/3484644

