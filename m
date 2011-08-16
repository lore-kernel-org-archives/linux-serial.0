From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Tue, 16 Aug 2011 16:05:08 +0200
Message-ID: <201108161605.08811.arnd@arndb.de>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58673 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab1HPOFN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 10:05:13 -0400
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org

On Monday 15 August 2011, Jamie Iles wrote:
> 
> This is just a repost of a series from a couple of months ago to remove
> the special DWAPB 8250 handling from the generic driver.
> 
> Arnd, I'd have a platform that needs some special handlers like these
> using the device tree and of_serial.  Once these are merged I plan on
> passing the serial_{in,out} and handle_irq callbacks through
> platform_data to of_serial.  Does this seem sensible?

Do you mean passing through the uart_port? Yes, that seems sensible.
Depending on how complicated the callbacks are, it might be
simpler to write a new platform_driver based on of_serial.c for
your device that hardcodes these.

The of_serial driver started out with the goal of covering all sorts
of serial port devices based on device tree probing, but with the
direction that the platform drivers have moved to, this seems a bit
silly, and I think we should take the NWPSERIAL support out and
rename it to 8250_of.c.

	Arnd
