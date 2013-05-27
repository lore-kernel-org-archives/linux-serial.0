From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Mon, 27 May 2013 13:57:37 +0800
Message-ID: <20130527055734.GD7782@S2101-09.ap.freescale.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
 <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130523025059.GB2704@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:37505
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615Ab3E0F50 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 May 2013 01:57:26 -0400
Content-Disposition: inline
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3D5056@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jin Zhengxiong-R64188 <R64188@freescale.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

On Mon, May 27, 2013 at 01:27:04AM +0000, Jin Zhengxiong-R64188 wrote:
> By the way, we'll change the SoC name from mvf600 to vf610 to align the description in the document. 
> 

Such product renaming in documents happen on IMX as well, but we do
not bother to churn the source tree (file, function renaming) to catch
up with it, as long as we know what it is.

For this mvf600 to vf610 renaming, if you want to catch up with it, you
will need to rename a bunch of files functions, compatibles in Jingchang's
series, and it's probably fine even though it's not really necessary
since they haven't been merged.  But for those which have been merged,
like fec compatible string, doing this will probably piss off
maintainers.  So I would suggest that we stick to name mvf600 in the
source tree, and just be aware of it's the equivalent of vf610.

Shawn

