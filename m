Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2AC4320A
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BDD6103E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 08:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhHMIsa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:48:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20765 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239605AbhHMIs2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 04:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628844481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJaWxeeItuB7E4RN5esN6PXG68x7FaEmUtv0Xxqqtjo=;
        b=Zlw/CDicFDpjTN9pS0QBlt/KPdSL2WI22epPt8E632PBKmLq7qrB7Tl+QlHvFpQ4H2ORoe
        oecaRpcUDQJx5meYdpYTGItAVpGzxqEuxWqyrRa4eqIq0ZLmGrvaGViL9IHOk3JAGhjn+4
        0OIugj7uvN8qGy57Z1BNXVvQ8de9zes=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-3-MW_Onk5tNcS-azbrh4gPKA-1; Fri, 13 Aug 2021 10:47:59 +0200
X-MC-Unique: MW_Onk5tNcS-azbrh4gPKA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdXp3eUeGu6zhDrTq6mOEGtSzHmFOvGbrMzfqGI2cHXVjXaYpReC43dQKRre8agymGZP6mGI1k3i7zZnaWQcTbcSjs5fnqx+aBLTYlp2EN34+RCvJ1awAdqK+YDWdkkI1v7bU+VObB6MfoCZLcrD9HPQPj+p577EisbvKqLv3C+EZIXsT1Q/exV0eo8YdbUieFolV/HYsV/CXNUtjeERR2RvbKDmf+Hd75jmtBFAfgayvpRDrxGji8qLV3n3NB+JvOGsIWbP4L/QqtIdpXe/0xfLVfkF3v9cp9iycLkkk4OtU5w5YmZhpbu7ZbG1j8D6LFAvN27T1fyrYZXzkffd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRpVBcGPdOEgjo2gp9QEgbzS2xam+Q/kG8q6+GwqJY8=;
 b=eWHTL3YjOaHpR464cmFD9dTtOYNvuc8CBnEC1RNbCPGjWyJp8jTq5tlsDlfTH73WTFC/58F/9cYau54dBqKvZQw4WLlc6oINAi0AZ6tADnWdAFgWdxoekvbXVRl0lxtpQQfWG0VIE+/DbGAIhcaXuzm6K9tHXDTJt8oC8sZ3Ywru2fKuykxZNPtaZXtI0Aj7Ls6JQR+NQiL4UYrNoi/7QAOVgzMImZBYb2EUxkpV/GHtyYfVvAjxdbGiVAJpc296/h+D58RWkNvB4Ck81x6fd5xwH7OWYK8/5Z7cA0AhdU+Y+i9/eKhKTay854OcZ+/ZcjNj1hYcaM39U75WB1NmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4783.eurprd04.prod.outlook.com (2603:10a6:803:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 08:47:57 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 08:47:57 +0000
Date:   Fri, 13 Aug 2021 16:47:40 +0800
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
Subject: Re: [PATCH 6/8] arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
Message-ID: <YRYxrElAu1aPQrSb@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-7-clin@suse.com>
 <aef2fab4-078e-330b-28d0-1da964985f83@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aef2fab4-078e-330b-28d0-1da964985f83@suse.de>
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.198) by HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 08:47:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43655bc5-b39a-4c60-b6f4-08d95e370c52
X-MS-TrafficTypeDiagnostic: VI1PR04MB4783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4783691703C4F0C32E71EE10ADFA9@VI1PR04MB4783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+lo9iegO456JwMjSm7/I/D3pj0i6CO3kyHQnt8mSJSFrXFqI9I7YAzUf67AjhF2757jAMslTfAQyxO0ErVrW/J25uLruWHklO//Ey/ffYVgviCCikgn8nF3mPEyjznziiTCktOIRQPQ5VnG2i+Gow8UM+DHFqoIIGZKKcXbZp7Lmm+Fv2nXCf4wJu+xvW1fNwg308m6qQjsDkSn6O67b3Id1jf5KQwUKpeDkPqxlznMgn6IEdyJhlAhObYq1es8A+SR//+B5SQRW3bL3Zn+BWeDI2X6cWMZbi4XS1dt3T9VYF/I65DQajtbZB8MLuMKdwZm+mn/izfV1nhOHyL7FCzM19v0dp9wib+ojb58d+gfkXdCtKAO8NaFWnB1c8tHI+88jkFqNx4G5lZfFyeBK1BVn/jVy+brlr7S6C0mJPBn15VELDZ6aiVy5AasQeU3rVxbzBu33zelOLQqZarqFFPgbdL/fH2KXK5skjpIJkk+57TKO8wSjFwYIa0KP1nI8Fr5fx8O7o/b6PiCSv5+YPQ4N31qdAfZOH1y51wP6YUOSPpG1q1KB/XQkI6ZMVrZ1K7yLQLpEXZoXcksmZ+rzorV1dG/CKes+jxJqrneOToSmB3XI6/NIid/Ui7ji3tQGet2MCPaJAW6JWe5t9UgpGJzSxmBOq3FFF/5Q0tOR8ZYWxxGod6XA6kTYmTXFpy1FJTdIPjwtcdsp2AROkzcr1dvA+mSdch5f2XlZKrktV040Y0GmAaMKpm7N/9hMVna
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39850400004)(396003)(366004)(376002)(316002)(478600001)(33716001)(83380400001)(5660300002)(107886003)(6916009)(4326008)(7416002)(66476007)(6496006)(38100700002)(66556008)(956004)(53546011)(66574015)(6666004)(966005)(55016002)(55236004)(66946007)(8676002)(186003)(54906003)(8936002)(9686003)(2906002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81jZk1S27g4VKTcdms0DE9ItAeDfIWIN64U+NXhHXvA7qmyxAUIbP/y831w9?=
 =?us-ascii?Q?2PnuTARVbdrn+55szpCsNfezE9e3feGVe8A4fgmsUbl4/AJsgXKElfWxH++x?=
 =?us-ascii?Q?Gf8wXCBB8DrNBy5eLc2UstEJACYX11FssAwexMGXH5s8vJ5VEXWEXe1rWZjk?=
 =?us-ascii?Q?xGNG3OFhWt7TOKouNAhqZ85W+NQNaNcASoc1IB1gspGqSNUenxwtRPn2zCdi?=
 =?us-ascii?Q?b772ghyVtMH/BbngMGe1DAd64nPGDubXdWV2QoHmZMYqTJPv/1M2bu4ct9M5?=
 =?us-ascii?Q?8yJNHLlty8fSqv78px/oBMl++9teRB995fE9S5xDIAXWqa4uP3IvUP4SuVqD?=
 =?us-ascii?Q?Y/BPhvHDcJQ1hufFQGEkNxaCPks0IsCEKQSZOZxeHUZzw+3k0kn942Gq/Q6H?=
 =?us-ascii?Q?6dv2fA5Cs+97FQX1T0PwhjdXJOijJpk+WPyUcHGiKL7PQ9z21T/nIyhuOWc1?=
 =?us-ascii?Q?w7m7asutI28OvXOZ2DU369JksgnxEXscBcLyy6p2ZFV6NwnWQltoiU79hjv4?=
 =?us-ascii?Q?+wSR9h2rGwjfJmnfLwW3wjKTcfGn4OAFSuxsywb0bcQFfQHLoT6VZhfMFsEi?=
 =?us-ascii?Q?C736u057AaKeQpDNX4VTgMNn2V1HFKgBYL2zYIJ2hEJcruk0rTZroMXH3FDz?=
 =?us-ascii?Q?+V+jULaN32PnsucnAGRnss9FJnf96VK1KL09+hvo7uKa+rl8kmoIrsHDZcwc?=
 =?us-ascii?Q?/vsb4OvnK4qq+C19skioUg9JsIA9MZ6dl9rVob8Ezwa5HWhlu4zsA4ejKLk2?=
 =?us-ascii?Q?sELi0JJOPbSON1nFPMbsWQY0mahtmZVDNnpf4AaQRTrdW5194GA1aURX5IFK?=
 =?us-ascii?Q?UQuJ+JdL3NPgqku7VDI1oRURP2dos1ic1uNHIYOYktRaEOzVw0VXj98zNDTr?=
 =?us-ascii?Q?GgdnR0w15avl4t62jB+TiLeedRv0NlNp/aYZyEfcs/nYjqUiZReGfjHezQez?=
 =?us-ascii?Q?ErqtFgYWaQC9sMJbYSzaS7EU31Q9k2vCMXqJfnjZ4rIBg962R9Wwol93y8QG?=
 =?us-ascii?Q?1IfYFZPjjeQSveSyLpgPZ6T4Hnx1arMLjWa5wg1M9DnCVlFpUcBseAqOaZBo?=
 =?us-ascii?Q?bmg7SmJKpLtnEWr3/jtHgK0SlaitW8Zn1sSep547XWTnEtNJIFbTkpnL5AMm?=
 =?us-ascii?Q?ylo+d4zpY186oMNauLCM1MGPkRLmXfOpC3pLeCOyv0RFUA1r5KZrz1vvLlc5?=
 =?us-ascii?Q?rVwTqlrmAIyvLxsyExSybAnv6xBoZwFa5sQ1MRZcWwnnUI3KTqLOLSnTbs0H?=
 =?us-ascii?Q?rrGRgcjs1XFwt5YhtT8MZ6UB2ocwKWNyTe8CWFaP+QsfAn+lGvpcHXw1Ed8S?=
 =?us-ascii?Q?68821FO61UaeeUpsHWlHTYWV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43655bc5-b39a-4c60-b6f4-08d95e370c52
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 08:47:57.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O49pfe2GB1Dy5l67peOMpxbbowTgWlOmRaKtPvQ284UneVN18YotY6dmTkJuvEP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4783
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 12, 2021 at 08:00:01PM +0200, Andreas F=E4rber wrote:
> Hi Chester et al.,
>=20
> On 05.08.21 08:54, Chester Lin wrote:
> > Add initial device-trees of NXP S32G2's Evaluation Board (S32G-VNP-EVB)
> > and Reference Design 2 Board (S32G-VNP-RDB2).
>=20
> "Reference Design Board 2"?

It looks better. Will fix it.

>=20
> >=20
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> >  .../arm64/boot/dts/freescale/s32g274a-evb.dts | 21 ++++++++++++++++
> >  .../boot/dts/freescale/s32g274a-rdb2.dts      | 25 +++++++++++++++++++
> >  3 files changed, 48 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 4b4785d86324..2886ddd42894 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -67,4 +67,6 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-ai_ml.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-colibri-eval-v3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
> > =20
> > +dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-evb.dtb
> > +dtb-$(CONFIG_ARCH_S32) +=3D s32g274a-rdb2.dtb
>=20
> @NXP: Note that since there's no distinction between S32V and S32G on
> the Kconfig level, we decided not to add a white line here. If you wish
> to visually separate them, that could be changed.
>=20
> For reference:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
arch/arm64/Kconfig.platforms
>=20
> speaks about S32 (without V), so did not need to get updated for S32G2.
>=20
> >  dtb-$(CONFIG_ARCH_S32) +=3D s32v234-evb.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm6=
4/boot/dts/freescale/s32g274a-evb.dts
> > new file mode 100644
> > index 000000000000..a1ae5031730a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 SUSE LLC
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "s32g2.dtsi"
> > +
> > +/ {
> > +	model =3D "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
> > +	compatible =3D "fsl,s32g274a-evb", "fsl,s32g2";
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +};
> > +
>=20
> Is there any marking on the PCB that a /* ... */ comment could reference
> here? Right now uart0 is close to stdout-path above, but that will
> change once more device nodes get added and enabled alphabetically.
>=20

Yes, it's marked as "UART J58". Will add it in v2.

> > +&uart0 {
> > +	status =3D "okay";
>=20
> No clock-frequency or clocks property needed?
>=20

As a minimum support patch, it can still reply on TF-A's clock settings so =
no
clock property is required at the moment.

> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm=
64/boot/dts/freescale/s32g274a-rdb2.dts
> > new file mode 100644
> > index 000000000000..b2faae306b70
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 SUSE LLC
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "s32g2.dtsi"
> > +
> > +/ {
> > +	model =3D "NXP S32G2 Reference Design 2 (S32G-VNP-RDB2)";
>=20
> "Board" missing.

This model name is based on what I can find on the official main page of RD=
B2,
which is shorter without having an additional "Board" string:

https://www.nxp.com/design/designs/s32g-reference-design-2-for-vehicle-netw=
ork-processing:S32G-VNP-RDB2

But having a "Board" looks good to me as well.

>=20
> > +	compatible =3D "fsl,s32g274a-rdb2", "fsl,s32g2";
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +};
> > +
>=20
> Comment please.
>=20
> > +&uart0 {
> > +	status =3D "okay";
>=20
> No clock-frequency or clocks property needed?
>=20

Same as what I have explained in the evb dts.

> > +};
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +};
>=20
> What is uart1? Please add a comment. Does it actually work without
> clocks property?
>=20

RDB2 has an additional serial port [uart1] on the board. Please see:
https://www.nxp.com/document/guide/get-started-with-the-s32g-reference-desi=
gn-board-2-for-vehicle-network-processing:GS-S32G-VNP-RDB2

It's the same as the uart0, the uart1 is also driven by the same set of clk=
s
[S32GEN1_CLK_LINFLEXD, S32GEN1_CLK_LIN_BAUD] according to the downstream TF=
-A:
https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/tree=
/drivers/nxp/s32g/clk/s32gen1_scmi_ids.c?h=3Drelease/bsp29.0-2.3#n44

> Thanks,
> Andreas
>=20
> --=20
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer
> HRB 36809 (AG N=FCrnberg)
>=20

