From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2] serial: imx: remove the uart_console() check
Date: Wed, 17 Jul 2013 15:28:48 +0800
Message-ID: <51E647B0.7010509@freescale.com>
References: <1372397982-19017-1-git-send-email-b32955@freescale.com> <20130701160833.GC14172@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:42114
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727Ab3GQHYo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Jul 2013 03:24:44 -0400
In-Reply-To: <20130701160833.GC14172@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8802=E6=97=A5 00:08, Shawn Guo =E5=86=99=
=E9=81=93:
> On Fri, Jun 28, 2013 at 01:39:42PM +0800, Huang Shijie wrote:
>> The uart_console() check makes the clocks(clk_per and clk_ipg) opene=
d
>> even when we close the console uart.
>>
>> This patch enable/disable the clocks in imx_console_write(),
>> so we can keep the clocks closed when the console uart is closed.
>>
>> Also remove the clock enable/disable oprations in the probe, we do n=
ot
>> need them any more.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
> Acked-by: Shawn Guo<shawn.guo@linaro.org>
Hi Greg:
could you merge this patch?

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
