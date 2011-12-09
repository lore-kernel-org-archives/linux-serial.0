From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 2/8] serial: 8250: Add ioctl to enable auto rs485
 mode with some Exar UARTs
Date: Fri, 9 Dec 2011 19:00:19 +0000
Message-ID: <20111209190019.0b983f48@pyramind.ukuu.org.uk>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
	<1323450440-414-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36271 "EHLO
	pyramind.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751361Ab1LIS7o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Dec 2011 13:59:44 -0500
In-Reply-To: <1323450440-414-3-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Matthias Fuchs <mfuchs@ma-fu.de>

On Fri,  9 Dec 2011 18:07:14 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> From: Matthias Fuchs <mfuchs@ma-fu.de>
> 
> Some Exar UARTs support an auto rs485 mode. In this mode
> the UART's RTS# pin is activated during transmitting and
> can be used to enable a rs485 line driver. This has nothing
> to do with attempts to do this by manually asserting/
> deasserting handshake lines in software.

Please split this out so that the ioctl handler calls a pair of port->
methods or errors if NULL. That'll future proof it and keep chip specific
stuff out of the direct paths.

Other than that I'm fine with it. Functionality, locking etc.

Alan
