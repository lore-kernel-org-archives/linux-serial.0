From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
Date: Wed, 9 Oct 2013 15:55:08 +0800
Message-ID: <52550BDC.70204@freescale.com>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com> <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:51072
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756593Ab3JIHwq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Oct 2013 03:52:46 -0400
In-Reply-To: <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

=D3=DA 2013=C4=EA10=D4=C203=C8=D5 15:32, Hector Palacios =D0=B4=B5=C0:
> This lead to many bytes not being transferred (specially at low
> baudrates), as they were still in the DMA buffer when the AUART was
> shutdown.
I meet a similar bug with the imx.c which is used for the I.MX.

I did not implement the uart_ops->flush_buffer() hook, so the DMA may f=
ails.

So could we add a new flush_buffer hook for mxs-auart?

Please see the Documentation/serail/driver.

thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
