From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH v3 0/3] serial: mxs-auart: add DMA support for auart in
 mx28
Date: Fri, 16 Nov 2012 17:08:14 +0200
Message-ID: <50A656DE.6080506@bluegiga.com>
References: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:43551 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab2KPPIR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 10:08:17 -0500
In-Reply-To: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, vinod.koul@intel.com

Hi Huang,

Thanks for new version. Now I don't get any errors and the CPU doesn't 
freeze any more but:

1) AUART corrupts data with baudrate over 1Mbits/s

2) We would need DMA support without flow control.

By the way, how do you test drivers? Is there any standard tools for 
uart data and throughput testing?

Lauri

On 11/16/2012 10:03 AM, Huang Shijie wrote:
> This patch set adds the DMA support for auart in mx28.
> patch 1:
> 	In mx23, the DMA has a bug(see errata:2836). We can not add the
> 	DMA support in mx23, but we can add DMA support to auart in mx28.
> 	So in order to add the DMA support for the auart in mx28, we should add
> 	the platform_device_id to distinguish the distinguish SOCs.
>
> patch 2: add the DMA support for mx28
> 	Only we meet the following conditions, we can enable the DMA support
> 	for auart:
>          (1) We enable the DMA support in the dts file, such as
>              arch/arm/boot/dts/imx28.dtsi.
>          (2) We enable the hardware flow control.
>          (3) We use the mx28, not the mx23. Due to hardware bug(see errata: 2836),
>              we can not add the DMA support to mx23.
>
> patch 3: enable the DMA support in dts for mx28
> 	You can use the /ttyAPP0 to test this patch set.
> 	I tested this patch in mx28-evk board.
>
>
> To Lauri: Please try this patch set. thanks.
>
>
> v2 --> v3:
> 	[1] fix a multi-open issue found by Lauri.
>
> v1 --> v2:
> 	[1] use the inline function, not a macro, to distinguish the SOCs.
> 	[2] remove the "inline" for mxs_auart_tx_chars().
> 	[3] use the `pio`, not the `pio[1]` to fill the DMA descriptor.
> 	[4] use bit operation to serialize the DMA TX.
> 	[5] use the RX/TX DMA channel to enable the DMA support, remove the
> 	    "fsl,auart-enable-dma".
>
> Huang Shijie (3):
>    serial: mxs-auart: distinguish the different SOCs
>    serial: mxs-auart: add the DMA support for mx28
>    ARM: dts: enable dma support for auart0 in mx28
>
>   .../bindings/tty/serial/fsl-mxs-auart.txt          |    8 +
>   arch/arm/boot/dts/imx28.dtsi                       |    1 +
>   drivers/tty/serial/mxs-auart.c                     |  364 +++++++++++++++++++-
>   3 files changed, 362 insertions(+), 11 deletions(-)
>
>
