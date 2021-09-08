Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4747C4332F
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F35161158
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347808AbhIHGrv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:42686 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347785AbhIHGrt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdNnI22oka0i6JwRZhfp85lQ3LQL29r3/nJR6XUZzJ8=;
        b=T7St2Kurm2osF+TWAH/adPSxSPz11va1xJuas7M1ypxrVdk0K31kftPsNGYegX15ydL2DJ
        fCMY/EEkMT5XQq8XYei/t+iYhLK5A7xCL85d5vrdmh66lOH9MSFgvgpbRh1Tv7E58iXZDh
        1frdiIrlDaHkDXwnN0N4r2moW9PwExo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-a4p4zbq_OKm5ZziKYDW5lw-1; Wed, 08 Sep 2021 08:46:40 +0200
X-MC-Unique: a4p4zbq_OKm5ZziKYDW5lw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4nFQEf5e1MnhimyNSYIspplVa+bWeH/68d8suKWeWiyfTGm5wXHW1ZB/RZ7UHSyrnPYJTXnIfuQ+WgGnM83oEeNaA53azlVwLbgFQlnpCjfg0UHBBKHkcByZxxD6OViGB9r/ESTQUgbKSz0BuoLSgtcI8l3SGMd9GWtgQYcfdDDSdd1apCERG5h/LkR0X6FaEQtNJDIeU9JOyvpx545CmBEyj+Wc8aE6eNf2djtAe9aLjrLzrqqk4CbnAV+yTo4JDroHpACNOmCzBRYUii1P1/obH/+ov7VPIVB2osaIxlrPUmvIVcfdN8a3DvJMA4qV50hmPb7Pym1Z0up81RxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=isJn3/Sf+1r8g9H0NjrwpJHvm3JI/mMtv/vwliKSQFs=;
 b=Dl8qyWpgqpTBkWSX0MgNAE+DsdILR9bdtEzp7vLglnB/NrV2M/AX2Ln/gDOqJVjAe0FdwAOYrutRPaaMcoz6OrIW7eGvOfNIlbxdKDadurbp/LSWOOVI6qNFAqrgiR5Opo7i0yvUf9k68UeAzG0n48UXK0uEIm+6/POw0GiLPzaa5uluAC0K/iHz9USO4hprzwqs7zZ6llyRpJZGmUm8Gqhc/c7nrNLvk7nS/fxLcMZoXDSG1wICbN2Hj11Vp1iZ4RJSsAHq2JTi4lFSrfbn3Lfk519e3QZXNFh9QmG8IFkYM7LuZrVzkUBrO6lC2k4CAAK6tdhNFz0ucKn/pPIiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:38 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:38 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
CC:     s32@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 5/8] arm64: dts: s32g2: add serial/uart support
Date:   Wed,  8 Sep 2021 14:45:25 +0800
Message-ID: <20210908064528.922-6-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::26) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by PR0P264CA0110.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a7f7b6-07c8-4363-25d9-08d972946846
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4000A5952D1FDDF048BB2256ADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhHELrnKuyY++5njwWAQjxoD7LcEP4HN8QrkWt6sG4LR6givRzJySGqs2tPYJpeLKkKM9lTJx4gT0dkiZkbKfdUUgWBPrtEozaSWkcbHdHIQV8uhQJMNjKvUd3oAAOqLQX7lMdUnMInlRFu+6MSuozchGDRY9kw8qZ242xMX9OoQCt3VAlFlJ2xgbAS+rLB3Yw3ak2NCCUw9FZ/H49d3ZUwbfNBfrSzF4P8+afKpsAcNpZmF6W1iu89cz4fs3yqU7renWTwp829ACZmvDNz4ZtjdLLYHEfMGXAQCpiRXPLXlXm59pZG2YIwMc8eKd2k4m4Hb5c+5jDx22GMdDIoF5SIKCKa0wq58QvkqiXzbd51877U1AHXkf4RvOp1u1ChvDQROewRSXlPs45zesq0q83bzNI2kFr0JOsQkHR5U6AYZDHtLEX0s9GOnnbpX0IWD+uY4s3Oe/fvnWzHYiEYcVBTkUfHzDewOZ/ZBLDsC132wh9jvHxCnU1GDlNV9EJ4Te0Cs1g9v0MEmrO2gGfICumP8af2ZqwK7Dy9lBhBkLAbjEHFwLYzdCtm3df6uAgiDXWSUDW4Shy7Ixf3b+u+7ISHBvX2Gyr1U3bqSdgwTogek2cxvDHKPPFbq01aURl9x/QmcAajdfIlJXn08mHln+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(6636002)(2906002)(8936002)(83380400001)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCEStrNgd2zBmYPFStM3kQVQn/Lbd+y9n7NTry2E1GHJqbHdjokMDqfDsIHB?=
 =?us-ascii?Q?UxDw6RG/OgyyX3zUvHInQzqBhyDcf8HH76da8++NzJC7il+up9hcvkyqOb7H?=
 =?us-ascii?Q?9Kaqx+GkUiMLYkeo9vAWUcZgZbDYr+0aw3wc4LCMbyM9wR4kKUeO5xA2DH2i?=
 =?us-ascii?Q?u93scR8V7rtHzfhmEYtY9U1jcnbZEAzHtDxRkbk4ZKWzLUImYAccQklBmDLb?=
 =?us-ascii?Q?aLPEGyqR9INz7rH/XfYd9iGbfNOuHC8AuawMnRMrDmWwP+ujY4MlWUejZ6pV?=
 =?us-ascii?Q?EM/Slz6nSn9vyL3inw5KnvRkH5pWGSHq+K6h6gpYsgHolNr6ozofDZcn6RKJ?=
 =?us-ascii?Q?oL4j3i+K4lwRrs3VLAlYeNMm32z6Jn/qlaMALD6Jj/mZnT7atP10yfimIT0j?=
 =?us-ascii?Q?t+D6IZm8RIqEnIm4tBxdOH8bwFJdJBVzftr+kbUrePscPUfhykc2uI/RtXYH?=
 =?us-ascii?Q?3pESGh7jAbsqUJOo8sKRcfyIe+1Mwza8LUDN8/khETEI4hd+zSw1oY8QWCIH?=
 =?us-ascii?Q?8Jd4LHOeuNyjl3TgcOzTX7P9+mp3dKqeB1Zd6Brlfu+7JvwfVW0rzDo0YCIh?=
 =?us-ascii?Q?OXzz1RUqiFfkWWcW2X+tQ1gLZeF926ywYbfisM8IdrO3B+E9esTVGm/0ygAi?=
 =?us-ascii?Q?sg245CgFcj5sKgBnoLnNzpigFMhwxLxqgpuJ8uUMwAx3YmLfpVRdZCPGLDgK?=
 =?us-ascii?Q?ZqOQF4WcJxrXmATZj5fHzHMPc65YjMLOIyrL9V8Ss10Zw/7Zlec7xSvpTg0E?=
 =?us-ascii?Q?MShoHIq99a94D1ZWeCvA8lQkXRVmwA2fjTr3s+IW1ZKQBdiF82R3Op2qBBwe?=
 =?us-ascii?Q?RxqWDvnbeZ9doOxetUKrJpBGBsQ/DQAsyQMZRBS4jtV/75HPUBdZdlALYw3q?=
 =?us-ascii?Q?Dj0+aSE9hgm1oIuHP7aHhWdvb9S9jbyrbj4ZgOrl3dTOCnHu3KJFpjPZX4aT?=
 =?us-ascii?Q?bplhisfOjkUF7wjFJW5O8UJOvV5NZPK10hBhzaAIcdjQqh2Z3zDoCRj6T3h8?=
 =?us-ascii?Q?qhotTk81ggAebiaiV2zYLc+ZQSvTCUqHoAWNUdyjhK3nHOaKCShtGlDRNhSb?=
 =?us-ascii?Q?qxtcZk+bS6hsaWK9rl2Yut3uk4vhjtB33M922eTw4OR9lBYYz3LgtbrpDbrK?=
 =?us-ascii?Q?HdngBwK3ylCRtqDvMOTA49WIgYVgHOpwWi5Tw9K3xhyjSifq4LzJode1hjNW?=
 =?us-ascii?Q?UUAZ36Yt676Frz5OcfofH+OFdY/rETqLK5dunpDNpKTebqXZ2enaC7iAkXcV?=
 =?us-ascii?Q?EaQ/awz6KsJ5Hh4pK8Uwup/wz48SMClX3X5qz2qB0PaBM5WO3B6KXs8iOVHo?=
 =?us-ascii?Q?Xoj2t5aFxb0Pa8PilJ0a2N75?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a7f7b6-07c8-4363-25d9-08d972946846
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:38.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbXEi0z9zbRpS5UPPs5A+27XsR3Zasbme93qsKoWLebQjdCu9rsrGtce5q3xOXq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add serial/uart support for NXP S32G2 based on the information provided by
NXP's CodeAurora BSP.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Add new Signed-off-by.
- Fix the copyright string.
- Remove aliases.
- Revise reg properties based on new cell size.

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
index 53b18671deec..59ea8a25aa4c 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -3,6 +3,7 @@
  * NXP S32G2 SoC family
  *
  * Copyright (c) 2021 SUSE LLC
+ * Copyright (c) 2017-2021 NXP
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -84,6 +85,30 @@ soc {
 		#size-cells =3D <1>;
 		ranges =3D <0 0 0 0x80000000>;
=20
+		uart0: serial@401c8000 {
+			compatible =3D "nxp,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0x401c8000 0x3000>;
+			interrupts =3D <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@401cc000 {
+			compatible =3D "nxp,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0x401cc000 0x3000>;
+			interrupts =3D <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
+		uart2: serial@402bc000 {
+			compatible =3D "nxp,s32g2-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg =3D <0x402bc000 0x3000>;
+			interrupts =3D <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x50800000 0x10000>,
--=20
2.30.0

