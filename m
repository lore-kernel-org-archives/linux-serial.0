Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C10C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DB260EE2
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 14:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhHMO7X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:59:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43687 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240982AbhHMO7W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 10:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628866734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9ouu5+RoAH5oQyO2vQCYm1c3cwUaJgMLT5gpBEaBSY=;
        b=a7GWDPdfeynW/OF27lJcGBHgwuGZ3rvNRxsB/F1BTO1pRqMhk9oEYA5KnJn61C0MBZay4/
        lXIB7XBBfb8S/FXItJTxpP6XbYc66yO0dgAc9wBZqRwKuk8cQzP1tVat+UzQvgrv6k6PAQ
        +DcktHfOfU6HVc8kCzCvoEpxYn3YRmQ=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-fziMKt4SMc-o61nZKcN6kw-1; Fri, 13 Aug 2021 16:58:52 +0200
X-MC-Unique: fziMKt4SMc-o61nZKcN6kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMGujTw2mp2SpWarWKOhKSBkAlC32X3F4lGYJVjCi3YVaJdlCuhst9zIEL08IGs2Ccx8yFc3W8vA5PXbXCKQNSk/pdZYkR2Ixee/VRksDRqrOxjC8hWR8MIbGcsRhkK6/LZ3a9fYGkiKj1xHZn2HcdCQpm+o1lsZZPkUo0kVpxqO3xnk4kU4Z7fpevm4SlPJt23+aOe8VfSZbQpERRelNLNkF9C5kxuvxwd4MeufarH4edKV+FIVJUVSMwwOLyn3xyds5BMoPDRFi9DtC98Vm3ASENVXTsOTQ77BwymT2ny73wNPr/cZKiAjyJAVsK52yz7y4dUVIgbXXqTCiTuUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS8C0pkN0vHQGFwTWdHgix5dvfrtmZmz39hr/iteA84=;
 b=Z69M7ZJjOW07BkiiiGCkjHG2BCnQ6ElpKRTH1nOpW5wDKEi2bGQIONNgzOcUtNAafPYSZ12qKV1gRguG6kYBwXgcwYos+DBR53Q6lArXxB/uDvTXOvlr5T+cqB8U10wZy5GGb8pZL0RPbtawRGzYcRzxhRDSAwhfpVca93KplZxRMTufepE1MPeaopt/lQSLwW2tsU0WH9akXL8meRayA3n4iS0mt54KCejZk4lWgrjU+6ZrO2BBOrYA45hbQR+ytFboaO4HQ3ihFM9+vkQ0nKVhlKbH7sE/p+9G3PznqK9mEjL/5K5hO99EE+VP4nttt8AYGHi7AiiRZNYnNv5GqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4528.eurprd04.prod.outlook.com (2603:10a6:803:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 14:58:50 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 14:58:50 +0000
Date:   Fri, 13 Aug 2021 22:58:29 +0800
From:   Chester Lin <clin@suse.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
CC:     Rob Herring <robh+dt@kernel.org>, s32@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 7/8] arm64: dts: s32g2: add memory nodes for evb and rdb2
Message-ID: <YRaIlYiYH6P7UolW@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-8-clin@suse.com>
 <17ab7b71-2dbe-0c66-e180-4cc2e8310441@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <17ab7b71-2dbe-0c66-e180-4cc2e8310441@suse.de>
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.198) by HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 14:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ee7560-71a3-4302-9cca-08d95e6adbd8
X-MS-TrafficTypeDiagnostic: VI1PR04MB4528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4528D376E81AEB9CA55A8BF8ADFA9@VI1PR04MB4528.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1qh7jXumogndrMQPuwhadwRBo+n1jz/zKkh3shsO+fv27v0e1ZiCHA4SL0JUMKHGZDsl3wrDgOwU87NcgTgn0f4B7xYA/t3bdUePxXr+8vggyxyxCcY0dZ5wdCJQ/BgWOmuw6+H7WqO7zw2h+q+UaV68vtu+LHwq0O7QJEqkg2r4pxW1qJKpdNLqMznBV0HX2fLgRqi6CPEckKeucBe+WvWPI37+4kpRSC1kW3WKmRJ3ekstVknS/9pSaYl+4jIyuJYWWIWsChSIUmzm/lJdGV2Yu76m5FfHba5sqjiPiN4E7OmXIUz1qtF3McVm3kWv3teX64eGF0T38jbGIZh1pEbezCDCZKLiUoFw9VHzkTnYkh6Q2aD2UpSOHQCerth4wG6aS/pYYZ6tUJKh7My2T5xRYuYwyDNnvT4tvj7pNa+8UjFPH8RhoQotoW5N33jQWhlcylvRtFnHT0qu5M4gx24qR0vAQRuF3J3suDhXszBH1kJPWBdXG4A8lih/u0K+W3JSFnThr59FsD07ae3xHg99SfJfW+M1BrYLfoBu45vnsIFE+mcTtsKHaFyKjqp594ko1DhMZRng0cvCQzKnLyq0GHbHFCMPeFgO/OioHAD5yo/3SUncSOkrNNi7HZ8oYKNgFQy38z2ts5DaVno6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39850400004)(136003)(346002)(376002)(55236004)(53546011)(54906003)(6666004)(83380400001)(66574015)(6916009)(55016002)(8676002)(9686003)(7416002)(6496006)(186003)(478600001)(5660300002)(2906002)(8936002)(66946007)(4326008)(66556008)(38100700002)(33716001)(66476007)(956004)(316002)(26005)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+5xg4kO4n/1YY1/l62fEgIAzf9Vb71HH4zLcF+Y23hoU7njIPhvgV3NsgzU?=
 =?us-ascii?Q?SSW9fwHaWPAbJZtFbU7wrAo8dTCCzwsEtXultaNr0RzSSNPsm1PtRzDkJdfl?=
 =?us-ascii?Q?1eoqTVV5w9ZKaSpOoWASr3jtS00kKErQ0WYhinCUXeylhH5sI/zGJqlhkIJi?=
 =?us-ascii?Q?wRG99ivn+o3NkPSOsAhWmpf666fEgwHiJHtrVHCNLAGOgxKKOv5rgSlQhahm?=
 =?us-ascii?Q?AhMBrlmBL5KrE+Uqqcip9wKN4UlY00Fq8sBZwfBCZw9upwkNIdZOGjqtg4wd?=
 =?us-ascii?Q?IN2Gei3AQJVmp/J8qqmpLv19psLxa+DuBjdvW2mCsGYY33a/LoZHK/xirG9q?=
 =?us-ascii?Q?4zT0tMaIaWXok1+eaFm9J3Dl6IyFu3+whP9eum8hgMXlyH65rkCWt8r2vaKm?=
 =?us-ascii?Q?yCA64FS+KcNPXCQFZjmRmb1l6YX6YeWwB17HSKPkTZHC5S4tXos9lSLFFZCg?=
 =?us-ascii?Q?fc7KeHvHDXrTMEiTjb5zbuzzM9djsnUXCf5x27PeZFT6+WyQz9xeI996yM6f?=
 =?us-ascii?Q?UTOsf17qvpXqzi6NiCfRL2PdxjyOHmQUR8S7IDb98ccbIntc1zLfuAMjzh0w?=
 =?us-ascii?Q?E0R0CA+KXGEoFhjxeiD6UpULxGMzloA6NQrLN/FCfDmuMlKg6Q1VCbo0DgMG?=
 =?us-ascii?Q?MbLfyfR8jRabkN6TjGHB00qpuABIFKEVLTlEYsvm8iC5GKvBXoex5IVY4ojZ?=
 =?us-ascii?Q?NXqBthfTt4wG58mwE/Eq0sDo4ryg+8ju/0Q/YssyD/U0V2KZ/9QTn1uXc9rs?=
 =?us-ascii?Q?mFebDQV8h6K2pBToDUWBJmxa3c+VfIlWlKdfSDJgNaRVipZGgl1RVVPj8hLS?=
 =?us-ascii?Q?Mmu9JTpiWl/TvLnwpcjXR30BM0Hc/+OWAFse6tN6yGZ+BswEsNGxP36qCD54?=
 =?us-ascii?Q?k7J0dxBYOcVn0hw00yP1W+UMZoqcGcBbK4cMDUC1XBXDlYk1tPAtxq0sf5ti?=
 =?us-ascii?Q?uhEY5lvIPp5Ka1xRlOdWMDG7Sqcuv4F9laDCmwybeRRvqyN6br+mSzjC5rZI?=
 =?us-ascii?Q?rPP2QXqsPgWf2BFDwV8r1/PzBl22OurzJdsudmLkalb0ww0k2LgmgDqVQnDk?=
 =?us-ascii?Q?Y27+Jbrz5mJUXXDbQ9O6yDaqJ+u94H1UWRS5S72d+t2/C55DuIyfAzK7qgOs?=
 =?us-ascii?Q?+nz47cO8VkX87z4z0Zyit93r/Gqvis/ag4nmiLle9jsMm3Czyk/Pjo259/l9?=
 =?us-ascii?Q?sEaOoQb8w6ZkgyvjaNS8olDeKDACJQ5dfYXucqoUiJZijNXw/X4Gc4yStO1z?=
 =?us-ascii?Q?dBvk471vQ6UI0MfDrBHQyeC/wfPkOYJSnkMhM6ZF0Bc28COUT13YLanSSQ5H?=
 =?us-ascii?Q?sV9vLvemNi+HOTo4agtaVTfQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee7560-71a3-4302-9cca-08d95e6adbd8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 14:58:50.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6SLCF4tUgVtbcRqLnRE1fJZRVe1N9jnaqD3uQvNky+X4ARjjYP1bxDVYblEHF+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4528
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 12, 2021 at 08:25:00PM +0200, Andreas F=E4rber wrote:
> Hi Chester et al.,
>=20
> On 05.08.21 08:54, Chester Lin wrote:
> > Add memory nodes for S32G-VNP-EVB and S32G-VNP-RDB2 since they have fix=
ed
> > RAM size.
>=20
> You can drop "since they have fixed RAM size" - if they didn't, you
> would simply choose the lowest size and rely on the bootloader (U-Boot)
> to overwrite it with the actually detected size.
>=20
> Please expand why this patch is separate - BSP based, I assume?
>=20

Yes, the information of memory banks is from s32 downstream kernel, which i=
s
listed in the board DTs of older releases [bsp27] although newer releases
[bsp28 & bsp29] have moved it into s32 downstream u-boot as runtime fdt-fix=
up.
I think we should still reveal this information in kernel DTs in order to h=
ave
better understanding of system memory ranges that each board can have.

@NXP: Please don't hesitate to let me know if any better idea, thanks!

> >=20
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 8 ++++++++
> >  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 8 ++++++++
> >  2 files changed, 16 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm6=
4/boot/dts/freescale/s32g274a-evb.dts
> > index a1ae5031730a..cd41f0af5dd8 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > + * Copyright 2019-2020 NXP
>=20
> @NXP: Please review year, alignment. Do any Signed-off-bys apply?
>=20
> >   */
> > =20
> >  /dts-v1/;
> > @@ -14,6 +15,13 @@ / {
> >  	chosen {
> >  		stdout-path =3D "serial0:115200n8";
> >  	};
> > +
> > +	memory@80000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB RAM */
>=20
> This looks strange to me - either put /* 4 GiB RAM */ before the node,
> three lines above, and/or append comment /* 2 GiB */ on each line below.
> Note the space, and suggest to be precise about factor 1024 vs. 1000.
>=20

Thank you for the suggestion.

> > +		reg =3D <0 0x80000000 0 0x80000000>,
>=20
> Note that this gives you the range to use for the .dtsi /soc node:
> Address 0x0 with size 0x80000000 gets mapped to 0x0 0x0, excluding the
> upper 0x80000000 for the RAM here. Or address 0x0 0x0 for two /soc cells
> if there are high-memory peripherals.
>=20

I don't know if memory ranges might be changed for new boards or CPU revisi=
ons
in the future, which means the first memory range might be expanded as well
[e.g. 0~4GB]. Based this assumption, I think the size should also be change=
d
accordingly. Not sure if overlays can still work with this case but overwri=
ting
all reg properties under /soc could be awful.

However if we only have to think of current hardware spec, it's good to dec=
lare
"range =3D <0 0 0 0x80000000>".

Please feel free to let me know if any suggestions, thanks.

> > +		      <8 0x80000000 0 0x80000000>;
>=20
> Maybe use 0x8 here and 0x0 above? (second 0 stays same, so don't mind)
>=20

Will fix it.

> > +	};
> >  };
> > =20
> >  &uart0 {
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm=
64/boot/dts/freescale/s32g274a-rdb2.dts
> > index b2faae306b70..8fbbf3b45eb8 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > + * Copyright 2019-2020 NXP
>=20
> @NXP: 2021?
>=20
> >   */
> > =20
> >  /dts-v1/;
> > @@ -14,6 +15,13 @@ / {
> >  	chosen {
> >  		stdout-path =3D "serial0:115200n8";
> >  	};
> > +
> > +	memory@80000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB RAM */
> > +		reg =3D <0 0x80000000 0 0x80000000>,
> > +		      <8 0x80000000 0 0x80000000>;
> > +	};
>=20
> Same comments as for EVB.
>=20
> >  };
> > =20
> >  &uart0 {
>=20
> Regards,
> Andreas
>=20
> --=20
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer
> HRB 36809 (AG N=FCrnberg)
>=20

