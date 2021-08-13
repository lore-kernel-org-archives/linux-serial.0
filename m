Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DBC432BE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C9361038
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhHMLoH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 07:44:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:35817 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239392AbhHMLoG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 07:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628855019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVwPfKDC8Iw0H+ktDvAT/5PKvV6UKDIRQwi8tN8/qRM=;
        b=mUm5AezXww5YF/0t014oZSK3DYjDkz7l6fNJQdU8j8P+wtgr7AcIq5ZncLH/hCACA5g+KM
        MYZg9L2A+/2NyMYg6SBsGNT9e6NnhhJ7f4o5FLwfG+9g2UpvV1N3udTzeOMtUvHZZdZUSL
        A73OWR5SXqRFjrwI09E7YpNH8qqZyYQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-2-luxq68jwNZOSaAAzXB2ERg-1;
 Fri, 13 Aug 2021 13:43:38 +0200
X-MC-Unique: luxq68jwNZOSaAAzXB2ERg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsfoC6B/k6wZaSCgT/ZhxI0gEq/uzdUg+8qFW49Ee5xTXlx44w7KICWtIXJ1xgvKabDJkI6N1cUjiPoB09NVr+LJ8VWDjOMk7RtfK9oW4BgAdKWu372tdVHRIDgpnHJYMyOcPR7oe5T5vMfj8F2mBrPyQENuWkzaz+JRtRbS2saKvwZRP/SSJLnAHSG4HG3MHVi6vzk1yJqPNmZNHvHJTPDRn0L0Y3oauFLjmfux6gErC7n35WAj9UB9n8YOLNtDx5u8imMSRnX+L+d5fOQ7J8YZrUkHJwtrZ2vAQAOfQBSAmnzd/gutwilgwDdjohmcBo9apHyBTD4W/88Kwfn9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IfJlhlHglGw3DCZ/+1JXzoHUnD3KZlayIStNm7SXHk=;
 b=kLz1UhRwf2eX41DnfmDwuJ9rXDhuGk4crkqDdomx6FS90udVvcuOEy+DmJXGFyAcaBweyPCGI07kY7RC27wFenX7kRve7geR1BA9Xfki0BOK/6UcopakurvBkK0+Q1BBC1+nw8INpRqYDkl/0x9igyWJuRFF7LllCkNgctC/WG3gI9VvjhAdGyqA2F0Kx6P3eKi4MIK0xUirC+nC1XgTUUMM4EUlvx7eRPAbYZfP1P4DgikEMthBOZ10+gCE61C0Von62Oo6dv6NZhBdVpwRJkHW47tUH9ZQWh5ER8wgHoVyPx+Io6RxHk/1f/5G5dTnAEMcjDGQWGg90ak7lyMPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 11:43:34 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:43:34 +0000
Date:   Fri, 13 Aug 2021 19:43:17 +0800
From:   Chester Lin <clin@suse.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
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
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <YRZa1ZX0gJb/yDrw@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
 <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de>
 <YRZTSJPFLFFIR+gx@linux-8mug>
 <0b42dc7e-a7c1-fe41-e39a-89627d44cbe4@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0b42dc7e-a7c1-fe41-e39a-89627d44cbe4@kernel.org>
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.198) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 11:43:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329f8089-305e-42e2-025f-08d95e4f94ad
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB34399026282DAB3767A64FA7ADFA9@VI1PR0402MB3439.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttgyEvuti42lPisc0ZeC0WGk0ShUYpifErOCZsRaw0OQdJqbGCG/LmVIaxv6VudEjOCy+UqP5WLjGIR3U+MgcIpXBxRpQRfoNcJ2HXMuSeG/JoySeP/nytbytHwNGLs3MdDc2usXxCMyirjJVizIWTFnOwc1Jr2RVoiOYH6dVdbe2RsR8MJ8+JvHh9+MSZ4EUFWNOq6gion5DO+iUtCMK+wH78+WS9/vw2y8tInV1KaJAml7bD3J07v4p9Euq+9+WNEtDBq2b18EYbHeKyQYSCh5KbXp3fQOs8+9aUzRyslr74WwnaaXKQycC1KE3YOmONzTNs2GlLzM82Tsc6fubCrIrIInPoZKKO7pgRX9RcULL6caYbaqMLdEDTypcuG1fyRTjuN8TOoRd9SeN0SOkgJDRMnbBZuoI8AR2TTwddkX9en0UiKQMnaR7WrUkwcwcWVXpa6WMyndKQ0fppds7+MNFY4nghxoBRyoyE71JsCdivEUFsdNYeHKztuZKnJW3BFpDP2VLSS35b0Qte61Vtpy9Z3UkC8PrmOFOVNVvwRkesesFlR0JaUHe07FphsxMNCkAP14sSjTaYFV4wMIHxCe9sIs5hT32v6yeQOG+Bk1Ut6p+CgWWXbcC0DM0hEWv/oB64r3ODcESyqxiV/gvICcfhMIs2ImeVqxLPeV5XzBNGzzX8HDGGFjk0kN3hH1UyxdZX7tW0EPCM0LjNgnP3iktWQedQmWtFEOZjqXNFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(376002)(346002)(396003)(366004)(54906003)(7416002)(66574015)(4326008)(19627235002)(316002)(6496006)(956004)(66946007)(6916009)(107886003)(186003)(38100700002)(55236004)(8676002)(478600001)(8936002)(55016002)(66556008)(966005)(5660300002)(33716001)(66476007)(83380400001)(6666004)(26005)(53546011)(2906002)(86362001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jbis8uGp/x0Ll6LBdFt+syo+9ScoHr5x39SsRg1uHvivoPHZhK5MQms+yy1W?=
 =?us-ascii?Q?Ti60hSxTLPuROUh9o4IwAM9ZPyYTzBira9ugoQ/YvpZfWHj02QZ9S4KT3gnm?=
 =?us-ascii?Q?nXDNClznMYvLOYXCgyvWk8ti1wwKRLI4x+33+NwSJ4b6d7HI3CS8Zgacs7Vg?=
 =?us-ascii?Q?oXPRE4USuDII1mubEAbQWfqpAc+SOC83fJh9fhEd80oJm7ePdjePDlKx8U9w?=
 =?us-ascii?Q?qAq3fhAoMEW6Hfsi90Goh2x/n42MBnFRIrDGVlY3E9YsqL1+yG8pLGEtrV87?=
 =?us-ascii?Q?0YDMEtzqPcST6j/+CNvNnDYTCygKr3fBhy/JzNQ03YmUyfqngzw4ES8PWMpl?=
 =?us-ascii?Q?bBxWcWCnFHAZLfIcc0eLuOEQTIg4/hDkNKsqzI1bW62itjas2aTe62BPE/MN?=
 =?us-ascii?Q?piF1n2+DOpd//UKPTfW/HC040ZjFqlNqqs+HT3MWkOrSivI4kw0OTeMSxSeP?=
 =?us-ascii?Q?pKGkBF7dNzLAkr0XPs5OmLbK8CPGn/ebIerGddIBhp7goegHfTl1wtKuJutI?=
 =?us-ascii?Q?tx9is6v1Ia6Pirhrdjpta3Ru/cZLue9zg412Yws4yxa2BOhd5yPfHYGWM7U1?=
 =?us-ascii?Q?/dsWgIgDgC2bGtbz86gL35RZEkf9mFCDW3FChu7mSWfziIcyXy4rXuuIjGVX?=
 =?us-ascii?Q?VqVzGl2mzaZwSNUrHH8awQnw6zs6nU1v3r++YH5CV7eNakpl2YR/af3rXHLj?=
 =?us-ascii?Q?gLgqnpIyw3oL66UB/n2Nh6gvhPbK1TH7VqMnVUTOb9kqKfFTEliBrmhkHs3P?=
 =?us-ascii?Q?c2xjQpqCdIDJr1z14oaRL9kALfsezwS8iR9I6lJe23NgyN8wbGhBpbL0A1wI?=
 =?us-ascii?Q?aeDsyGNT38Og63YSQs939qOmDP+rkjV+pmnkEIOQhjJRfskC1HIViaDnmkPq?=
 =?us-ascii?Q?thOMgCk1LUjYitLXNvU9jlSOKLG587cyc1xD0CgzmqpcHdKB5/+2BOZQPA7r?=
 =?us-ascii?Q?9o2C1LkEdAQTC7WPmPlW61Ke4YUZNIajAfUqD5P6mrtl48FYXzDRfGlegA6a?=
 =?us-ascii?Q?eiqbG8kqdLvvhS4EPiyLi7qvFcZjovUzdwjDs/9xsP7egOfrK1AHWdaUuWl+?=
 =?us-ascii?Q?Pz5ve6RESxCMX9tftrVtWS89ZL6dvKyAzxIz6xu94+5gADHi5cXCBW42/ID3?=
 =?us-ascii?Q?ws9zksO4l2/XaPhS1WWoE4PqofHeM9MnDx9jGDfgYH0HmZZiTXEsB8y5F6Le?=
 =?us-ascii?Q?FudDyr96MrOY2dOYQLFPnb8qJdBo/B2HZKMALugaI6yH5QxWGsp3UPGcxXgd?=
 =?us-ascii?Q?3hpq4MS0IseMzjIJrG1wtBq45DWzcGjAmj9/qjt9umpGo95kkWCxsxiwxZTW?=
 =?us-ascii?Q?K/1wxPUcL4NtINpdL5Ge6m+9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329f8089-305e-42e2-025f-08d95e4f94ad
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 11:43:34.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ixd/qdxoTQxGw0umBkhf8nli5QhFkQS9KKqtnSTSZiwlne8J8z2xgcfTW/LY7h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3439
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 01:28:40PM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2021 13:11, Chester Lin wrote:
> > Hi Andreas,
> >=20
> > On Thu, Aug 12, 2021 at 06:04:44PM +0200, Andreas F=E4rber wrote:
> >> On 05.08.21 08:54, Chester Lin wrote:
> >>> Convert the FSL LINFlexD UART binding to json-schema.
> >>>
> >>> Signed-off-by: Chester Lin <clin@suse.com>
> >>> ---
> >>>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
> >>>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++=
++
> >>>  2 files changed, 48 insertions(+), 22 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-=
linflexuart.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-=
linflexuart.yaml
> >>
> >> Thanks for your effort, Chester.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflex=
uart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> >>> deleted file mode 100644
> >>> index f1bbe0826be5..000000000000
> >>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.tx=
t
> >>> +++ /dev/null
> >>> @@ -1,22 +0,0 @@
> >>> -* Freescale LINFlexD UART
> >>> -
> >>> -The LINFlexD controller implements several LIN protocol versions, as=
 well as
> >>> -support for full-duplex UART communication through 8-bit and 9-bit f=
rames.
> >>> -
> >>> -See chapter 47 ("LINFlexD") in the reference manual[1].
> >>> -
> >>> -Required properties:
> >>> -- compatible :
> >>> -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, =
which
> >>> -    is compatible with the one integrated on S32V234 SoC
> >>> -- reg : Address and length of the register set for the device
> >>> -- interrupts : Should contain uart interrupt
> >>> -
> >>> -Example:
> >>> -uart0: serial@40053000 {
> >>> -	compatible =3D "fsl,s32v234-linflexuart";
> >>> -	reg =3D <0x0 0x40053000 0x0 0x1000>;
> >>> -	interrupts =3D <0 59 4>;
> >>> -};
> >>> -
> >>> -[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM
> >>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflex=
uart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.ya=
ml
> >>> new file mode 100644
> >>> index 000000000000..acfe34706ccb
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.ya=
ml
> >>> @@ -0,0 +1,48 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>
> >> Since this is dual-licensed and BSD-2-Clause would seem compatible wit=
h
> >> GPLv3, this could probably be s/GPL-2.0-only/GPL-2.0-or-later/ ? Not a
> >> blocker.
> >=20
> > There's no license identifier in the original file so it's not a proble=
m to
> > choose "GPL-2.0-or-later".
>=20
> That is not entirely correct. If there is no explicit license in the
> file, it's kernel's default so GPL-2.0-only. You cannot relicense
> derivative work without getting permission from authors and copyright
> holders.
>=20
> However if you did not copy the text/description from original bindings,
> your work won't be derivative so you can relicense it.
>=20

Sorry for my misunderstanding and thanks for the reminder.

Regards,
Chester

