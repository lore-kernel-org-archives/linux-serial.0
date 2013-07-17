From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v4 0/6] serial: imx: add DMA support for imx6
Date: Wed, 17 Jul 2013 15:30:12 +0800
Message-ID: <51E64804.4080902@freescale.com>
References: <1373274862-2695-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:17009
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310Ab3GQH0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Jul 2013 03:26:06 -0400
In-Reply-To: <1373274862-2695-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

=D3=DA 2013=C4=EA07=D4=C208=C8=D5 17:14, Huang Shijie =D0=B4=B5=C0:
> (1) This patch set adds the DMA support for the imx serial driver.
>     The uart with the dma support is usually used by the Bluetooth.
>
>     For the firmware's limit, i only enable the DMA for imx6 serials.
>     If we have proper firmware for imx53 (or other chips), we can als=
o
>     enable the DMA for it.
>
> (2) We only enable the DMA support when the following are meet:
>
>     [1] The uart port supports the hardware flow control(CTS/RTS).
>       (Some uart port does not support the CTS/RTS.)
>
>     [2] The application enables the CTS/RTS.
>
>     [3] The Soc is imx6 serials.
>       For the sdma's firmware limit, we do not support the DMA except
>       the imx6 platform.
>
>     [4] The uart is not used as a console.
>
>
> (3) Tested this patch set by:
> 	connecting a imx6q-arm2 board(DTE) with a imx53 board(DCE).
>
> v3 --> v4:
> 	[0] add DTE pad for uart2
>
> v2 --> v3:
> 	[0] add a new patch to fix the RTS/CTS pad name issue.
> 	[1] rename the uart DTE pinctrl, remove the "dte" from the pinctrl.
> 	[2] add a similar UART DTE pinctrl for IMX6DL.
> 	[3] move the "fsl,imx6q-uart" to the first of the compatible table.
>
> v1 --> v2:
> 	[0] use the "fsl,imx6q-uart" as the new compatible value.
> 	[1] move dma_is_inited to imx_uart_dma_init();
> 	    move dma_is_enabled to imx_enable_dma();
> 	[2] move imx_disable_dma() to the front place of the imx_shutdown(),
> 	    just before calls the imx_uart_dma_exit().
> 	[3] misc   =20
> =09
>
> Huang Shijie (6):
>   serial: imx: distinguish the imx6q uart from the others
>   serial: imx: add DMA support for imx6q=20
Hi Greg:
Could you merge the two patches as above?


thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
