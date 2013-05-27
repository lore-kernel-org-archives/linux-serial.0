From: Jin Zhengxiong-R64188 <R64188@freescale.com>
Subject: RE: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Mon, 27 May 2013 09:12:25 +0000
Message-ID: <13F8657A829DAB49A2A937FD6FC10F790B3D644B@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130523025059.GB2704@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130527055734.GD7782@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:46686
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753275Ab3E0JMs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 May 2013 05:12:48 -0400
In-Reply-To: <20130527055734.GD7782@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo@linaro.org]
> Sent: Monday, May 27, 2013 1:58 PM
> To: Jin Zhengxiong-R64188
> Cc: grant.likely@linaro.org; Lu Jingchang-B35083; linux-
> serial@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; s.hauer@pengutronix.de
> Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
> 
> On Mon, May 27, 2013 at 01:27:04AM +0000, Jin Zhengxiong-R64188 wrote:
> > By the way, we'll change the SoC name from mvf600 to vf610 to align the
> description in the document.
> >
> 
> Such product renaming in documents happen on IMX as well, but we do not
> bother to churn the source tree (file, function renaming) to catch up
> with it, as long as we know what it is.
> 
> For this mvf600 to vf610 renaming, if you want to catch up with it, you
> will need to rename a bunch of files functions, compatibles in
> Jingchang's series, and it's probably fine even though it's not really
> necessary since they haven't been merged.  But for those which have been
> merged, like fec compatible string, doing this will probably piss off
> maintainers.  So I would suggest that we stick to name mvf600 in the
> source tree, and just be aware of it's the equivalent of vf610.
> 
> Shawn
[Jason Jin-R64188] I think we need to align with the document as it's posted at Freescale website, otherwise, the inconsistency will confuse the customer. 
please refer to:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=VF6xx&fsrch=1&sr=5
http://www.freescale.com/webapp/sps/site/homepage.jsp?code=VYBRID
As the development work is ahead of the formal name posted outside, we continued to use the name for upstreaming patches. Sorry for taking into the confusion. For those patches aren't merged, please help to review them based on the new SoC name.

For the merged FEC patch, we'd like to explain it to the maintainer, Or can we just keep the FEC compatible string as before("fsl, mvf600-fec")? And be aware of it's the equivalent of "fsl,vf610-fec"?

Jason

