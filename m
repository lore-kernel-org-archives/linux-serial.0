Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C43C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90E76109D
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 09:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhHMJz3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:55:29 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:59013
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239987AbhHMJz2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 05:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaoODnTORCa6+NvbFYLpFtPbYfq2YSUS1ydFnh1gX52ClNVy23W5swwd4awtIzcboAOr0zDfoQbvvIIcdqts77C6Y7Z/HjA0itfc4S1y52O34Wi2QEGZnAghHbJO+fQ0/AUcq9IMAFJ19TiMeTzQAQbrrzkdGqcC9pBpKz96CRGhfYsG6ttW0+F3n3jfIB5DOgvNW1Y4f0hZ4CdKrDeUjfwTtCXhlHA6S/BGHVcgMx98CRUbYXoNoL3e+s3Luqq4TU44Hw117TtEcm1PZLwB7vu3O7fV6RHkI0JBn3lBvpcCOZIcsVZz0llf3rmnLKh/p+wArUtdK2eYPzVWakEijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6FPdadMcTceJQmAZVjWfrq4HN7PFm9qjpGw16n7ayk=;
 b=m9CWrFdBsezUuYgP6D+R77ORLfcilBE1auqHSKtYF+ZArG1bllz83mTwasZeLssMpKbN6biUT9HxyvtGVdXd+2oLNBYD33DQDWOcBptRTkdJcTAyYxuM7FgOhV4kKMUzV+HIj3xfSZhcTMSeXKJPgT9ljX19XNq0DcEyYDmPbx6iTWSDe10sLlxyDjGO+I+JGyK+9oLiPQY7GYYXryKASNGeQIE0Gupxg1QJfC4g+CKaHblNPeuS/GCSynfTwIWbjQ3OHqxLmepIxigkcSGo3jyvv9oGlDviQtuT/C3fB4QWlFDcXuExd23mYUCKlz8Q45qCK9qbgBIxtmbSf5ivmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6FPdadMcTceJQmAZVjWfrq4HN7PFm9qjpGw16n7ayk=;
 b=cW3ohxEs2kYUI0HNIAT88cYBcSt/Z3AaMaTAqyeBT9aeTxU4xfJQIRLGWZwQQ24pAmepA5MvqEoADHAmEZWRsAVBtzDU088Mz1IBD1NGXWtkow9yRKmzM8wHkDdM5HmhHmfQk7rJ0Vy2gJs4h+hB+LAJDs692bkNr9V2SKe9duE=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com (2603:10a6:803:5f::31)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 09:54:59 +0000
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::ddcf:cac8:c7df:47d7]) by VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::ddcf:cac8:c7df:47d7%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 09:54:59 +0000
Message-ID: <8a38d66032f875d35834e50943aa02786e2a0517.camel@oss.nxp.com>
Subject: Re: [PATCH 5/8] arm64: dts: s32g2: add serial/uart support
From:   "Radu Nicolae Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        s32@nxp.com
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
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Date:   Fri, 13 Aug 2021 12:54:53 +0300
In-Reply-To: <93978882-4b47-4c4a-cd43-60cb5bcdf471@suse.de>
References: <20210805065429.27485-1-clin@suse.com>
         <20210805065429.27485-6-clin@suse.com>
         <93978882-4b47-4c4a-cd43-60cb5bcdf471@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To VI1PR04MB5101.eurprd04.prod.outlook.com
 (2603:10a6:803:5f::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.141] (89.45.21.213) by AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 09:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72cfdbd0-1f1f-4856-0b34-08d95e406960
X-MS-TrafficTypeDiagnostic: VI1PR04MB7197:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB7197AFF7C9CC44ABA8A935F89FFA9@VI1PR04MB7197.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsWHM1mYWi8nG9md9Z9jGYP1Z6LIWUJPXr7B5KW2nVun4oQK3D5oM1umbbObIkG28j4B4QT1UFs4yHVffL6nh20djAn94eqw/PIZEBpxMz1xO6PuACfAEpIT8+6EQf6mcIsJqJIqNhFPpmVOoG9C5e2Q8Yzku0Z7ZhQoL4XAhGpRWzTuqbdpK4jeb3jJDubtP+1NHDSTrXQg1MQsm9f2sbDbyEtDKGMO8043H4MQ2mHUWZfCflKSOnlxyktHwuxtCM71I1jy6EWVIwTsmk4nFKLKFlx5/BdZFSX6WnZlK6g8g33G8f6BaNyWFmmzmkiSaAc01Rdz7XzooOfaW7De7x2TnN+x96tmpQARBHhfqBKe9/3lUVbCeYSSmeibcfTeWgIqsFCn3zUJvY8ZOhszkNLLBLmCZRuTw2kSnviT6UsQCXCQQlPlKnKNIv1kwP9mT4e+oot0a8sKdxWXIOMpBRB3zDurTpZixcCxS1/EOwDeXSN/O2pP8xB+o/qAPrD5Z2f5LS81oaKW6xWsDLhXbRHtbbgyh67MKU9lEZMHIE6FenpuargIzFWJrCELKIQnfmjMmMzILS1OzVCzrQxkTNp0Lm1pUlEFKrYqFu1czlT/Ja1djibuhiME7EoxOf1jmmtddZyZZCYvkRuqd5UDAr/U6cwJVaBpZTw0oJqbTG8Jre4dItlzArEN5/O7LJIQfmorpO69IAQjj/AfK2iTy0xK16BYoDYeTOKySKr1cFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5101.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(5660300002)(7416002)(478600001)(53546011)(52116002)(83380400001)(66574015)(6666004)(8676002)(316002)(8936002)(6486002)(26005)(186003)(66556008)(66946007)(66476007)(38350700002)(38100700002)(110136005)(54906003)(86362001)(2616005)(2906002)(956004)(4326008)(16576012)(41350200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFheXBQMkZzWlhRaGNwYU5HR3o2Z2VnbVJZUzlva0s2OFZtWlZsdFRGRHRT?=
 =?utf-8?B?NHhWVm9CM3E3a3lTOGtwMjlLRDc2VnN4MnZ2K1ZBUXRxeTlodjRzUDNrQWFy?=
 =?utf-8?B?M013Y200L3kwNEhjd0k4UWdMdVExbDZFYm1IZEl6MHJjRTFrbkh2b2w1dGN0?=
 =?utf-8?B?TzdvSENCZ0xoRVpZZ1lGSUE3NytIdzQvMmxFTjQzdFdpeTdGcWFpVk8zTnBp?=
 =?utf-8?B?QWxJNWNrVURBRzByY2RLckZGb3FGaEVCOGtDcUpubkFHWmhkdWdySDJoOVMw?=
 =?utf-8?B?VG1nYU5EOUIvZVR4Y0gyREh1TDZvRjdkN3Q3SUxra0Ewa21VamFaVXJRbjlR?=
 =?utf-8?B?TkNuRFpSaGM1SHUzT3huYWlkVHhhbGxHUWZrNmRucW5KNmxIbzc4akZHR3gv?=
 =?utf-8?B?cjQ0Zkw2K3ZNcTRkajdwZWUwajZwc2wrUWtOSStOalJpSnFpb25RT0lGNnJo?=
 =?utf-8?B?OFFBL2VCam5PSHpCRXFuUWpzR2t3WHE3NzVNNlArZi9tNXBaeDBQSTRBcFZl?=
 =?utf-8?B?aEFrdnVPYk5YYVArbGJRZjdFLzlYNUZIbjl3bGkrdkJEb21MRkZ6a3NTZXhp?=
 =?utf-8?B?VUlEc05JZDJRYTRSWVRzVGgrblE0RDhLMVlyZ0dqdVMrQ0xrWTlJbCtZaFJX?=
 =?utf-8?B?NUdKdktNSy9GU2VBVDcxSGRaVmEwKzhhSGJtZGhVY00xVUs2aTkzcUhVcUNY?=
 =?utf-8?B?SHVuOUtnU0Q0Z0ZQZFM1a1pOcEpZamhZL2xMdGxLY2dudXpweGtNMkZDVmph?=
 =?utf-8?B?RklFR0FCdXA5cU1pNVRIUDk3OS8zdk1NcEU2dmQxdkN3ZzZUUUQ2bjByRmY4?=
 =?utf-8?B?bytEMHhqUXRveDNpSHFnZ1Bkc2tKLytQa3NPRE5Db2ZmM2xKYW12amxZcFl1?=
 =?utf-8?B?dTFqY3ArVWJhdit2UEE5M1FBY0FRRy9WOXkvOXdqZVcyL0M1amFFNjNGVnNC?=
 =?utf-8?B?RXlXVE1jZW9DZUxrWTVsUzFEWVdua3N1VTVodjRBNGtOOGRhdEhKMms0UGNF?=
 =?utf-8?B?RXRrQVpKNDhTM0FMQ0E2Z25TWFpUem82d0tRcGNlY25PT21YOXNSNGkrbXFD?=
 =?utf-8?B?WDFkYUhyU1hZR3ZsL3lRQ2ZyblNBMGxhRnhBUW1GQSs3Z3JRSHlCRmd5Rm9D?=
 =?utf-8?B?eFBLRnEwZ2d6TFFGbzJaOGlkL1BEYlI3ZnpmQXk3ZEhQd21Vci9zNWRIMDd5?=
 =?utf-8?B?amFMZFpWV3VVdjU0cmk1YXpmNUp5VTdkTTJyWWxCNzdkUXlKZW43MXROWHdY?=
 =?utf-8?B?TzhjYnVQRWRyWC9jU05NcDdTR3ZTLzdUNU9neUpPcnBXbU1ENlFvQ0MrbXFo?=
 =?utf-8?B?K1g1Sk8rQnQ2eVExOEFzdmhrc2R2cTFIa0o0Mk43a200Z0ZaK2thdlo1Q1o0?=
 =?utf-8?B?T3hFTmtqblB0Ny8zT2szMlZsTzcwL085dXV3YTB6bE9QV08zRTNOQnRjSVI0?=
 =?utf-8?B?aEVEMFZUNkwxeXBpTmc5bUJjcmRaRVJaYWJFY0dtR2NUOVUveldYNGk2alpC?=
 =?utf-8?B?VmNhd2dzaHZDaSszL1I5dXFIeVZzUEs1aFhkT2pXOEhVNllFZm5QOHlCKzl2?=
 =?utf-8?B?YkVETTJTbDgySHRpRVoxaE9RRXFkdGpWaUE1emgwSHJPRE90My9PVHFRcjUx?=
 =?utf-8?B?Z0NrV1crenpyU3BId0xUTW1tWkowUCthbVdMcUxNbjJDMFBwVlEvaStwSFF3?=
 =?utf-8?B?VTRrT2d0VDlCbU5laWdaRys3RDhoU2tGd1NOb3Z4REFkTUQyVUxGQXRxZlg2?=
 =?utf-8?Q?ahUcCZaSqnkzGBtnUiJDOegOHBP4o/nwgPOvBuB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cfdbd0-1f1f-4856-0b34-08d95e406960
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5101.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 09:54:59.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C/fwKUb/yDuWcUvjEEdrDk/nbUXjF+QxhZpY6eVnLpkuB0UWL8eAKzJguDADuyahI//8IEMwKuBSvLGCjmq94yZGGzFPXIJ6SlPMhGs+Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andreas
On Thu, 2021-08-12 at 19:42 +0200, Andreas Färber wrote:
> Hi Chester et al.,
> 
> On 05.08.21 08:54, Chester Lin wrote:
> > Add serial/uart support for NXP S32G2.
> 
> You might mention here that (following our initial stub) this commit
> is
> now apparently based on the CodeAurora BSP branch foo (and therefore
> adding its last-year copyright below and separate from 4/8).
> 
> > 
> 
> @NXP: If there are downstream Signed-off-bys that you would like to
> see
> included for this portion here, please speak up.

Larisa signed-off should be added.
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>

> 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi | 31
> > ++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index 3321819c1a2d..0076eacad8a6 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > + * Copyright 2017-2020 NXP
> 
> @NXP: Should this be updated to include 2021 from your latest BSP
> releases? Do you want it visually aligned by adding the ASCII-art?

Yes for both questions. The copyright year sould be updated to 2021 and
should be visually aligned.

> 
> >   */
> >  
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -11,6 +12,12 @@ / {
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> >  
> > +       aliases {
> > +               serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +       };
> 
> Note: In the past there had been controversies as to whether to
> define
> aliases globally for a SoC or in a .dts specific to a board's usage.
> In this case it does not seem to matter much, as uart0 is being used
> as
> console on the reference boards.
> 
> > +
> >         cpus {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > @@ -82,6 +89,30 @@ soc {
> >  
> >                 ranges;
> >  
> > +               uart0: serial@401c8000 {
> > +                       compatible = "fsl,s32g2-linflexuart",
> > +                                    "fsl,s32v234-linflexuart";
> > +                       reg = <0 0x401c8000 0 0x3000>;
> > +                       interrupts = <GIC_SPI 82
> > IRQ_TYPE_EDGE_RISING>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               uart1: serial@401cc000 {
> > +                       compatible = "fsl,s32g2-linflexuart",
> > +                                    "fsl,s32v234-linflexuart";
> > +                       reg = <0 0x401cc000 0 0x3000>;
> > +                       interrupts = <GIC_SPI 83
> > IRQ_TYPE_EDGE_RISING>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               uart2: serial@402bc000 {
> > +                       compatible = "fsl,s32g2-linflexuart",
> > +                                    "fsl,s32v234-linflexuart";
> > +                       reg = <0 0x402bc000 0 0x3000>;
> > +                       interrupts = <GIC_SPI 84
> > IRQ_TYPE_EDGE_RISING>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 gic: interrupt-controller@50800000 {
> >                         compatible = "arm,gic-v3";
> >                         #interrupt-cells = <3>;
> 
> Regards,
> Andreas
> 


