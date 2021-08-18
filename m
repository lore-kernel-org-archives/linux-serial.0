Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B7C4338F
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8631D610E6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 14:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbhHROf6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:35:58 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:21068 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238593AbhHROf5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 10:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629297321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEy9HqitGJ8txAA0JPgmnC3uLysz4jv1UBJNJvhZT+M=;
        b=fYr7CW25yvViPbDNVJq5dzAiwh3/OhoEWX0AtZ0Hr58NXU0A7XhtGQR8glYqhRufyfQ0ul
        Ojwi8i5cULbg5mOEFIslBCN/hVctpbqrNfD9KuWh4/2I8ZTa4EJ2SY6CDVUWxCCDJAWOm9
        H533nbYFYmFetC+N8Jf1KE/RRGtsSiY=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-O2n_3um7MN6nY_BhFzUUaQ-1;
 Wed, 18 Aug 2021 16:35:19 +0200
X-MC-Unique: O2n_3um7MN6nY_BhFzUUaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4VaIdR+3ULXSNeIN2Rsp40GJQEK30VhfA78w/wjY/cJBR9iGHHqP92rkEkWt4ZFSOPhIxLQWDKHrr74rLAETmnrS4vmHrtSSR+zxFYr8ZOtyuKkwRGl25zl6GgXDDKGvK1Wh6b8U6a/LuTXzyANOAygRqAoB/qCpl4EijIRZqqyUf+E0mhd0U7BjoiGe29IhbGeDH63u6GOsmK/5S1Yj9TsaOLNW+Gczwz/jG2CbBQPnNLOZJgPd2Sk7U/cvEdZ0vhtH6wOQLP7Aqen/cXus8Z33XkAbDjXZkN7ddb+7Z4JZh3vCnrbvITHfxTPggGtLsJ6iLvnmA85/jmCJucRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEy9HqitGJ8txAA0JPgmnC3uLysz4jv1UBJNJvhZT+M=;
 b=DPwaRPtR5LUK/zgyIsihOBPybCNkGscPw+mxfcm/RnOWk6E13rOKtL6UD61g0MlcLwmSsxIAA5+Xc2PaWdZaXwQut818RldyZwrVwt4htYvb3OgzCPaAfbQKpfv00fQRxllJRC7z1e9KD2h1Mvzcdxcxd7j7Ql6q2JRBt1IpdRN4Td06Gd7+9k6MYmQxyifcGfZfncf7hQuMElZZ9bbtfhGAHJqd4m7lmBF/koHwqiMM4D0tC0I7fydUedQYy0cdTN9G+jIERuDdNprBZAbi8GyHgEEv0vk45InwbPGO/oHY8sDPoCjQ+0xNtUzmVCf5H54GA7Z/KTnh6lESWf/Lsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB5630.eurprd04.prod.outlook.com (2603:10a6:803:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 14:35:15 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 14:35:15 +0000
Date:   Wed, 18 Aug 2021 22:34:57 +0800
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Message-ID: <YR0akXYPYthDuvCh@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-2-clin@suse.com>
 <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.160.215.224) by HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 14:35:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ed5084-123e-413a-7c2f-08d9625564d0
X-MS-TrafficTypeDiagnostic: VI1PR04MB5630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB56308D88310B16E2D24BB4D2ADFF9@VI1PR04MB5630.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMWGYx2J2yfRgyfj8Jwzj+6Pc/LF1jTJcSzvALkfswgzeKPyGLAgtdd9GP+3XffeWIttg/OOjHAHqQv1VC/B1f2hVymyF1aiq0/JRu7wns017w3UAq23tQTDGhqBMZV1QfBbGx3wqw7OmlZ+uj2Kdk6k6qIz9sH0um69akOtpAKx7rPw1RZg7CqzxfQY23+RpOVGvIHzQrNaNQnZzWkXifHUSkF5/S8/8eUZqyi94BX/Bkivl2ibjG2IVI6+4wgnYluysBxu0rRyn2kwJlSOnc0fgebh3+TcgIYsswpBuprkmaYVG5dYVpbFXefrKotAQpsToOsCruU2xq5bHgRaUou+tp5Pcr2oy1w8CVhFTo5OzG/F03Psksf0UkN1JzAKPw41liEZqGf6p2VJHLPDgLE7wTuGProOVm3tDRQsSr72/Ejv86zQkUObfvf/IlD7S9g65ln5nnoEZoBdrW3FemT1iafDf8POyeKYAmxqnPK62ZpW5HLKaEk3CNDUhUNOAJRj2am77O0788DoRC+JNEaN1FXvBWwV5XzdWYeiL5d9Pjo/L6bJDYzD2IjjmcKeHJtFxYF263loTsBR7lMwqJqNwCg33h6pSOjLAm+hfcQxFuWAS0lSa4POhnyLJk/4SI1HY+074QM1uCVhXV1QOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(316002)(86362001)(6916009)(54906003)(26005)(55016002)(9686003)(38100700002)(6666004)(508600001)(186003)(7416002)(66946007)(66476007)(66556008)(4326008)(5660300002)(33716001)(107886003)(6496006)(956004)(8936002)(2906002)(55236004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVtVKDifdlnSk+mL7W9Od1cxifRDV6yaV+4L94IMwC2i4WJaJAyOU0Xg+f3E?=
 =?us-ascii?Q?dQyauIkptsuGOY621/ILVbo2IVGSKw40wKP/Fpnez/Jd5lzv2S5Cy7V2NfnB?=
 =?us-ascii?Q?rreVQDqW580qvhWhOAo6RW28/cHnsB7H8oL5THJea6CzxzzxoQhQGsEGjvs1?=
 =?us-ascii?Q?OfNDxb049LIggZQgrcHJDo2+jU7bAHZ13/6bm3S6g45ssJ1E4V/1LsGupWye?=
 =?us-ascii?Q?UowtKwlah6Wv0wC3gD7SLn+3OjWScNRnVaWR7BEd8ei3/KjMFHN4mIxhhWWw?=
 =?us-ascii?Q?3dqraOAOJwPCW7doog7u9Gflm5xIjR0E7sqw+3E5GvniBZVdGEUMY78bcbTu?=
 =?us-ascii?Q?WJZiYu9NgOytV+OP4hK/eBRJOqJmM30aSVqMurYp/DS98ipMenY/raN2gRtJ?=
 =?us-ascii?Q?8JL4CaAiI/eEoG0OwCApj9TjPO7PiPBBZcMGUzueicFs9MLSqAtxiqFzbakV?=
 =?us-ascii?Q?3gQ27I90bUlfbNhWVa6QIS1Czl5mcLtXNNt+WrDdL0FaYvle2LhQmMzmgjeU?=
 =?us-ascii?Q?1MZ0Ym62i2Euino/r54MYKqjJDENKHQkd3GQMg1pdbTuunESqKhglESEOLf0?=
 =?us-ascii?Q?AiiczQ2MHfXCR3UIPke9k1p5/f1Wp1wOz0U5xTG9GaQ4GIHe46dFmKA5LKzG?=
 =?us-ascii?Q?c/XBOQ616JVTuvCVY29GYVnFFADz2TgqbINxNUe1R8HUn+OemMvpVZRnj6sP?=
 =?us-ascii?Q?/KQqt+bnZL86QiB0xYO4n0W039IZkO2gXXTccgSN/37OZRY1dN9x42Qdv+eV?=
 =?us-ascii?Q?CcyaPajeNLRtrfIZ1C2XV0EjQrmiIHqoW5nPj6b6D8f0d0RGU0bqNwBO2Xb/?=
 =?us-ascii?Q?EKU/ijmK2Iwm1YP3H8ZwenI3jV1L7k0OBtltLYOH+QvetjceA+BYX23rirsm?=
 =?us-ascii?Q?jf+fbwbHk3IEL4cCIPbMoz21aTHHqvKulm4A5qOWLwJGXIaNkS0rWeU5LhFU?=
 =?us-ascii?Q?yh/5JG3gpVtsfn0z32BSQziWg+ElGlkyWpx3y279PiM6m8napV8a8bXDy5cX?=
 =?us-ascii?Q?l6BXy+jF5a023V2DWddWQqwmMFyUMAR+GjXR0ONJWgb/3+rBZk+4Ms1zaXHr?=
 =?us-ascii?Q?bjpbxve/9hWVeKq0IJWFAMhsp3jkp22QQHUU0jLa1nQLRKMWjcOhGhcsu9E2?=
 =?us-ascii?Q?ZbsZp6EUzFk0Mk1Glxb9/DfAAx5mLAFhyqtsFYgMYx49qZfMKLWMxSiuKbUD?=
 =?us-ascii?Q?RV8gmNCjymBnDwQ3w0+1Ft7nMCbWzt7dLBj3O+w7OBc1y/Ws/xqJiMTYf6pw?=
 =?us-ascii?Q?rJGqyU01Mt7vXF3SnhcPzaOXHJPP7pIVC+Np7iLH7HPX3N4x8s+0ON8UC9yH?=
 =?us-ascii?Q?f+ws1lE6xotDFEhw4SC0OFh3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ed5084-123e-413a-7c2f-08d9625564d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 14:35:15.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbpLmWbUaDgO7D0pQhXrn1Crg1xG2GzztnfFxLk/RWcFNnG8D64vRczxJS9wFKp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5630
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 12:53:59PM -0500, Rob Herring wrote:
> On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
> > Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
> > design 2 board ( S32G-VNP-RDB2).
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index e2097011c4b0..3914aa09e503 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -983,6 +983,13 @@ properties:
> >            - const: solidrun,lx2160a-cex7
> >            - const: fsl,lx2160a
> >  
> > +      - description: S32G2 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,s32g274a-evb
> > +              - fsl,s32g274a-rdb2
> > +          - const: fsl,s32g2
> 
> Given this is an entirely different family from i.MX and new?, shouldn't 
> it use 'nxp' instead of 'fsl'? Either way,

It sounds good and Radu from NXP has mentioned a similar idea for the
compatible string of linflexuart. To keep the naming consistency, should we
change all 'fsl' to 'nxp' as well? For example, we could rename the fsl.yaml
to nxp.yaml. However, changing all of them would cause some impacts, which will
need more verifications on new strings. Otherwise we would have to tolerate the
naming differences only used by s32g2.

Thanks,
Chester

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Rob
> 

