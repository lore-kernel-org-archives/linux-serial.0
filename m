Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726FC4338F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 08:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4136105A
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 08:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhHIIEP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233697AbhHIIEP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 04:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC43A60C41;
        Mon,  9 Aug 2021 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496235;
        bh=BgZ+4KPqzAbLsG8u4CXByZNOUReuukaF29yR436Xm60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaFZ1hlqVY2K0WlwjIEb4ulccFUv3JQrmQ7f9Ud1m0FBK0spesGU+ipppeGTxhMnO
         +4V4Cq9NwQWEbyKkAgF8xGwMBnRETvlylYwLL+zphIUX3OYH2tkx2wzKu6IAAFuqHD
         qAQP5OBxkG5bk2A1c+amL/l5ReV+wOZ+NNTv/nZmYZpvlR9hosT+EEinNCbZpX21OK
         AllR0G75t6ZD1VA2+h1a8p6+qecIePHptsEa7okHsk4qTfkpT2qbeuxyW50Xcb0IVs
         P2yEgBIaLIp4DFm4qAVjJ6OKR5u9wTvNxZWJEGvEv18SlIObOX+FaiYgSTSjCwGGW6
         sTqetlZDnLGkg==
Date:   Mon, 9 Aug 2021 16:03:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add an entry for NXP S32G2 boards
Message-ID: <20210809080346.GO30984@dragon>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-9-clin@suse.com>
 <32310c2a-9800-8b04-b6ac-d8ada044c0f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32310c2a-9800-8b04-b6ac-d8ada044c0f8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 05, 2021 at 09:49:51AM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2021 08:54, Chester Lin wrote:
> > Add a new entry for the maintenance of NXP S32G2 DT files.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 36aee8517ab0..3c6ba6cefd8f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2281,6 +2281,12 @@ F:	arch/arm/boot/dts/nuvoton-wpcm450*
> >  F:	arch/arm/mach-npcm/wpcm450.c
> >  F:	drivers/*/*wpcm*
> >  
> > +ARM/NXP S32G2 ARCHITECTURE
> > +M:	Chester Lin <clin@suse.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm64/boot/dts/freescale/s32g2*
> 
> I support the idea of sub-sub-architecture maintainers but I think idea
> of in-file addresses was preferred:
> https://lore.kernel.org/lkml/20200830122922.3884-1-shawnguo@kernel.org/

Thanks for reminding that the patch didn't land.  I just resent it with
your Reviewed-by tag added.  Thanks!

Shawn
