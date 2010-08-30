From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH] CRIS RS485: Check SER_RS485_RTS_BEFORE_SEND before delaying.
Date: Mon, 30 Aug 2010 10:32:27 +0200
Message-ID: <4C7B6C9B.2050801@evidence.eu.com>
References: <4C62BD2B.2010508@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from borg.asidev.net ([95.141.32.69]:37408 "EHLO borg.asidev.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab0H3Icc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Aug 2010 04:32:32 -0400
In-Reply-To: <4C62BD2B.2010508@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: starvik@axis.com, linux-cris-kernel <linux-cris-kernel@axis.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Hinko Kocevar <hinko.kocevar@cetrtapot.si>, Janez Cufer <janez.cufer@cetrtapot.si>, Andy Whitcroft <apw@canonical.com>, Linux Kernel <linux-kernel@vger.kernel.org>, dev-etrax <dev-etrax@axis.com>, linux-serial@vger.kernel.org

Claudio Scordino ha scritto:
> Hi Jesper,
> 
> 	the following patch fixes the usage of the delay in RS485 mode
> on the Cris architecture.
> 
> Very recently, the RS485 interface has been fixed by adding two further
> fields (see commit 1b6331848b69d1ed165a6bdc75c4046d68767563).
> 
> This patch checks the value of the flag SER_RS485_RTS_BEFORE_SEND before
> delaying.


Hi all,

	so far I didn't receive any acknowledgement about this patch.

As I said, recently (see commit 1b6331848b69d1ed165a6bdc75c4046d68767563) the
Linux RS485 interface has been fixed by adding two missing fields.

With the "new" interface, you have to check the SER_RS485_RTS_BEFORE_SEND flag
before using the delay_rts_before_send field.

The Atmel serial driver has been already fixed (with commit
1b6331848b69d1ed165a6bdc75c4046d68767563 itself).

This patch fixes the usage of the interface in the Cris driver too.

Best regards,

		Claudio
