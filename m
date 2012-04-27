From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 14:09:53 +0800
Message-ID: <4F9A3831.1020203@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com> <20120426120043.GH17184@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:13117
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788Ab2D0GGE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 02:06:04 -0400
In-Reply-To: <20120426120043.GH17184@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, B20223@freescale.com, r58066@freescale.com, B20596@freescale.com

Hi,
>> +/* see the "i.MX61 SDMA Scripts User Manual.doc" for the parameters */
> I can't see how the manual helps here.
sorry, the comment is in the wrong place. it should placed at 
configuring the `slave_config`.
> Please test this patch at least on one more SoC. There should be nothing
> i.MX6 specific in here, the fact that the i.MX6 is mentioned several
> times in the comments make me suspicious.
There are bugs in the UART DMA code in the firmware before the imx6q.  
So we can not test the UART DMA except the imx6q arm2 board.

thanks

Huang Shijie



