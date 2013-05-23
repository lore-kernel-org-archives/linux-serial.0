From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Thu, 23 May 2013 10:51:01 +0800
Message-ID: <20130523025059.GB2704@S2101-09.ap.freescale.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:17752
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757227Ab3EWCvK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 May 2013 22:51:10 -0400
Content-Disposition: inline
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jin Zhengxiong-R64188 <R64188@freescale.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

On Wed, May 22, 2013 at 08:59:20AM +0000, Jin Zhengxiong-R64188 wrote:
> [Jason Jin-R64188] For the lpuart itself, I do not think it will have different version IP.

You can never tell in 5 or 10 years.  Also no major version doesn't
necessarily mean no minor updates or revise.

> The general name is sufficient and soc related name can introduce the minor difference. If the there are update version, we can name it lpuart2.0 or something like that.
> 

Yeah, if IP designers name it lpuart2.0, it surely works.  But from my
experience on IMX, hardware guys are not always properly updating IP
name.  Then the version 2.0 becomes a versioning given by software
people which is improper to be used in compatible string.

> For the compatible property itself, the ePAPR described it as:
> ---- 
> The compatible property value consists of one or more strings that define the specific programming model for the device. This list of strings should be used by a client program for device driver selection. The property value consists of a concatenated list of null terminated strings, from most specific to most general. 
> ----
> So for the IPs especially for the peripheral IPs, the compatible just used to select the driver for the device.

Not only select the driver but also the programing model implemented in
the driver.  Take a look at drivers/mmc/host/sdhci-esdhc-imx.c or
drivers/net/ethernet/freescale/fec_main.c, multiple compatible strings
select the same driver but the different programing model implemented in
the driver.

> It should not used to describe the version information.

Seriously?  The "version" equally means the compatibility here.  How can
a compatible string be not used to describe "version" - compatibility?

> If the version changed and the driver cannot be used for the device then another compatible strings should be used.
> 

If the IP gets a revise, the driver should be updated to support a new
programing model with a new compatible string.

> As I said, Another reason for the general strings used is the across platform issue, It's maybe reasonably to name the compatible strings as you recommended for the IPs share in the same SoC family. But for the IPs shared across platform, general name sound more reasonably to avoid the product line confusing. 
> 

Think about it from "compatibility" point of view.  It does not cause
confusion but just help understand the compatible history.  Saying the
same IP is reused on LS-1 SoC, I do not see a problem with putting the
following compatible into LS-1 <soc>.dtsi under UART node, to tell that
the UART block on LS-1 is completely compatible with the one used on
MVF600.

  compatible = "fsl,ls1-uart", "fsl,mvf600-uart";

> The compatible strings once named as you said for Power platform, but more general strings were used later as IPs shared for more SoCs.
> 

I think IMX device tree support is added more recently than Power.
Encoding SoC name in IP compatible string is a general practise for IMX
device tree bindings.

Shawn

> I was wondering what's kind of strings should be used for this kind of IPs across different platforms. I added Grant Likely for comments, Thanks.
> 
> Jason 
> 

