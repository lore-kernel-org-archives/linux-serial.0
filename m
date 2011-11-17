From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH 5/8] serial: 8250: reject delaying RTS with RS485
Date: Thu, 17 Nov 2011 10:43:11 +0100
Message-ID: <4EC4D72F.8030702@evidence.eu.com>
References: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de> <1321460685-15753-6-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35832 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461Ab1KQJnO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Nov 2011 04:43:14 -0500
In-Reply-To: <1321460685-15753-6-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>

Hi Wolfram,

Il 16/11/2011 17:24, Wolfram Sang ha scritto:
> There might be chips capable of doing this, but for now nothing is implemented,
> so reject usage of this feature.

The delay must not necessarily be done by hardware. The drivers/tty/serial/crisv10.c 
driver, for example, delays through a msleep.

I don't know if having a software delay in this driver can make sense in some particular 
circumstance.

Best regards,

	Claudio
