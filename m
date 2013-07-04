From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
Date: Thu, 4 Jul 2013 16:56:28 +0800
Message-ID: <20130704085623.GA11209@S2101-09.ap.freescale.net>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
 <1372844557-3078-5-git-send-email-b32955@freescale.com>
 <20130704072344.GB11046@S2101-09.ap.freescale.net>
 <51D5357F.8040609@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:9260
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab3GDIz7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 04:55:59 -0400
Content-Disposition: inline
In-Reply-To: <51D5357F.8040609@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 04, 2013 at 04:42:39PM +0800, Huang Shijie wrote:
> But this pinctrl is only used in imx6q-arm2 board which uses a big
> armdillo board,
> so i did not add the same label to imx6dl.
> 
> Do we have a imx6dl-arm2 board? if we have , i can add it.

It does not matter whether or not the pin group is used on an imx6dl
board.  We have to add it for both SoCs, because it's the only way to
keep use same label for same pin group on two SoCs.

> 
> >>diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> >>index 9a69891..8a518c6 100644
> >>--- a/arch/arm/boot/dts/imx6q.dtsi
> >>+++ b/arch/arm/boot/dts/imx6q.dtsi
> >>@@ -266,6 +266,15 @@
> >>  							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
> >>  						>;
> >>  					};
> >>+
> >>+					pinctrl_uart2_dte: uart2grp-2 {

Forgot mentioning that in imx dts we generally do not encode function
name like "dte" in the label but just number.

> >>+						fsl,pins =<
> >>+							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
> >>+							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
> >>+							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
> >>+							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1
> >Why do you have two pads mux-ed on one function?
> I think the name of the PAD is wrong.

Fix the name first, then.

Shawn

