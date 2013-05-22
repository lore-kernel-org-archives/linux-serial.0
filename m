From: Jin Zhengxiong-R64188 <R64188@freescale.com>
Subject: RE: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Wed, 22 May 2013 06:40:21 +0000
Message-ID: <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:27100 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755651Ab3EVGjp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 May 2013 02:39:45 -0400
In-Reply-To: <20130520030523.GB25113@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo@linaro.org]
> Sent: Monday, May 20, 2013 11:05 AM
> To: Lu Jingchang-B35083
> Cc: linux-serial@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; s.hauer@pengutronix.de
> Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
> 
> On Thu, May 16, 2013 at 02:18:15PM +0800, Jingchang Lu wrote:
> > Add Freescale lpuart driver support. The lpuart device can be founded
> > on Vybrid MVF600 and Layerscape LS-1 SoCs.
> >
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > ---
> > v3:
> >   change the uart driver name from mvf to lpuart for further share
> between SoCs.
> 
> I do not think it's going to be a problem to name the IP with mvf family
> name even though it will be used on LS-1 too.  That can simply telling
> the history that the IP is firstly used on mvf family and then get reused
> on LS-1.  But I'm fine you name the driver in a generic way, purely using
> the IP name, if you feel like to do that strongly ...
> 
[Jason Jin-R64188] Reuse the same LPUART on LS-1 with the compatible strings 'fsl,mvf600-lpuart' is technically OK, But it will fuss the route map of the product Line. The general name can show that the IP is shared between several product lines, and the history for which SOC firstly used the IP is not very important. With general compatible name, We can setup the general dts for the shared IPs.

That's also the case for the IPs used on Power platform, Take the IFC for example, this IP implemented on Power platform will also be reused LS-1, The compatible string is set as  "fsl,ifc", "simple-bus" but not the soc name on which the IP first used.

 Another example, though a little different, the nor flash driver, which is used for many platform, the compatible "cfi-flash" will be more reasonable than the soc/board name.

With the general name for the compatible string in the driver, if there is minor difference for the different implementation of the same IP, we can add the soc related compatible string to the driver to pass different .data structure for that soc.  

Jason



