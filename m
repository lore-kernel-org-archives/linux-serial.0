From: Jin Zhengxiong-R64188 <R64188@freescale.com>
Subject: RE: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Mon, 27 May 2013 01:27:04 +0000
Message-ID: <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130523025059.GB2704@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:17962
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755677Ab3E0B11 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 May 2013 21:27:27 -0400
In-Reply-To: <20130523025059.GB2704@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Shawn Guo' <shawn.guo@linaro.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

> On Wed, May 22, 2013 at 08:59:20AM +0000, Jin Zhengxiong-R64188 wrote:
> > [Jason Jin-R64188] For the lpuart itself, I do not think it will have
> different version IP.
> 
> You can never tell in 5 or 10 years.  Also no major version doesn't
> necessarily mean no minor updates or revise.
> 
> > The general name is sufficient and soc related name can introduce the
> minor difference. If the there are update version, we can name it
> lpuart2.0 or something like that.
> >
> 
> Yeah, if IP designers name it lpuart2.0, it surely works.  But from my
> experience on IMX, hardware guys are not always properly updating IP name.
> Then the version 2.0 becomes a versioning given by software people which
> is improper to be used in compatible string.
> 
[Jason Jin-R64188] We had some internal discussion on this. For the lpuart itself, as we cannot get the version information at run time from the version register and lpuart is not publicly versioned, we agree to use the SoC name for lpuart. 
However, if the version information can be got from the register at run time, or the version was publicly versioned. the general name still useful than the SoC name. 
on the other side, the SoC itself may also have new versions, So the SoC name is also not a perfect solution.

> >
> 
> Think about it from "compatibility" point of view.  It does not cause
> confusion but just help understand the compatible history.  Saying the
> same IP is reused on LS-1 SoC, I do not see a problem with putting the
> following compatible into LS-1 <soc>.dtsi under UART node, to tell that
> the UART block on LS-1 is completely compatible with the one used on
> MVF600.
> 
>   compatible = "fsl,ls1-uart", "fsl,mvf600-uart";
> 
[Jason Jin-R64188] We'll leverage this compatible strings for compatible history. Thanks.
By the way, we'll change the SoC name from mvf600 to vf610 to align the description in the document. 

