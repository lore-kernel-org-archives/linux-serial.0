From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Mon, 27 May 2013 19:34:16 +0800
Message-ID: <20130527113414.GA7737@S2101-09.ap.freescale.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130523025059.GB2704@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130527055734.GD7782@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3D644B@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:34177
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758032Ab3E0Ley (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 May 2013 07:34:54 -0400
Content-Disposition: inline
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3D644B@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jin Zhengxiong-R64188 <R64188@freescale.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

On Mon, May 27, 2013 at 09:12:25AM +0000, Jin Zhengxiong-R64188 wrote:
> [Jason Jin-R64188] I think we need to align with the document as it's posted at Freescale website, otherwise, the inconsistency will confuse the customer. 
> please refer to:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=VF6xx&fsrch=1&sr=5
> http://www.freescale.com/webapp/sps/site/homepage.jsp?code=VYBRID
> As the development work is ahead of the formal name posted outside, we continued to use the name for upstreaming patches. Sorry for taking into the confusion. For those patches aren't merged, please help to review them based on the new SoC name.
> 

Okay.

> For the merged FEC patch, we'd like to explain it to the maintainer, Or can we just keep the FEC compatible string as before("fsl, mvf600-fec")? And be aware of it's the equivalent of "fsl,vf610-fec"?
> 

I'm fine with either way.  But if you do want to change it, please
change it as early as possible.

Shawn

