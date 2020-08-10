Return-Path: <SRS0=IIB/=BU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5EC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC642075D
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 06:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LAB3EM4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJGOz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:14:55 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:7905
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgHJGOz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Aug 2020 02:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq6D7+mhIDOJtWYFaAsZ9HordVGiXhdILlB/Dzl5YVYlxpM6nlD0QvAwq7f1HYG3+LEDegO5inMHbFooU2fXgJw4oN9hTDoCnu0koY1rSRPoTlw8Zt6ia6d6+LmKpZwjAXJBjuka7HotNwMBfvbMAY2PWtMlmk6Wbt7ytfZL6r4rdKOm1HXHTG+9sgFyJMjf16dpyvO9KzKKqpgo1l/Rh0nuVYWomlxxeg/LS3XZcnyh6ivtmLetVJbkHREZutdodoqCEIHLF5AOfeodtNKOASluhTCA2BwwQM4Itzg+26bGJpJiQitXA4cR7r9+rueeTeLMJEbtrJn7Nmj5xcJFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLI/rnEuWiXrjqlQHtM10qLZGmxXMBnHa1aju0yIvA8=;
 b=h+qdV+HyoQ927WHqjC06kEKGu9lVZ6Vjd4UU/dZhGTz1uLHD5PmLXLQlBxeDffS3UarvCSrATi2tpy9XzDeB43QKMYuDCF1UAwx0/aFk9XF5J10Df9CCpBpBy4Cn3xW3k10AzCvzN9WEX6bH3B7o+zSVC/CWrSmu8Boz2KY9o3LS5EQvJibjNFvEGE4MIDWM67qQwUSy8mMsJmqr06t56SRGMpHO7UQx/rSCAlvl3t8+Q9KSvksRlXPhaQTSyz2oO+pXv3ugCnGCxYfRSJd7xEzPnFOzXdmLQ9GtO943GFjdLucFicJbSxWzE7B6IhwMszTFUyxlB9U8pHJkgW8rPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLI/rnEuWiXrjqlQHtM10qLZGmxXMBnHa1aju0yIvA8=;
 b=LAB3EM4N6MHtYYEBUmVt7XJvTxI7UVulfpNVIrNRhMLrK9/Enc1fibjibEEkAXA6TwVXzb1oXo6OHjexXYNv2pn1tQ8DdUzhItYIC2UmiduzHIEt/CXm9D39uodx7dM9FS1HB1Fy37vgqfPEP4G61aPS1FcHJVMQ2DQqXUzNG9g=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5893.eurprd04.prod.outlook.com
 (2603:10a6:20b:af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 06:14:52 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 06:14:51 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, fugang.duan@nxp.com
Subject: [PATCH tty-next/serial 1/1] tty: serial: imx: add dependence and build for earlycon
Date:   Mon, 10 Aug 2020 14:06:52 +0800
Message-Id: <20200810060652.3436-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.67) by SG2PR06CA0088.apcprd06.prod.outlook.com (2603:1096:3:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 06:14:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61ff1802-ff1a-4f8d-bdf3-08d83cf4b13e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5893:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB589308C2AB67FE6C23F32759FF440@AM6PR04MB5893.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8/QtvB52HqCqAYCihno/vh+NbtEAge9azqa5fQXHHa+r4P287QK3a/A/Rb4PB0vLtmbevMR/pyzt7RvpZDS6kGfKytcWEtDKRWe5UuM+SLkPlbgo64J+dcQn1xpeqg8FOnRH0TdnIRf/I162wI0a//OGe1c4WWME/farrUVvhh50qIZUH7T7m5BMs/Vfh8iMdQlDwDr0QtEs1CKW9lRxWllznoqQkCHTMhRX6OZqxu5SUpAA2LDYafVo4c86FcV1AaTNSWb+QvzGIAF3avEdznEGfP1+5Pr69go5yMX6UBpcyDMXCAAw4UWP82OtR/4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(478600001)(86362001)(26005)(66556008)(66476007)(66946007)(6506007)(6486002)(5660300002)(8676002)(8936002)(52116002)(6512007)(316002)(4326008)(186003)(16526019)(1076003)(36756003)(44832011)(6916009)(956004)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QUvNI1ml9QoHvNWnB5oyH2milABub7dpt+++p/PVhiSUKR907lA5WoBokNDYayYDQydZpbKgWCF7oBjndu+E5gjh4YMESWVuBLuAynruvxsbUd80KLW2suCxQ12BN3DZeQE6rKN+KTRTkCsRLH+ePqDara9Ca0MU+3Pp2F8D0KQ955qglMU2JMSbVyAQUkXqa+LMfDhgVoWDd/i3SxTe/pG/UoZw34cMAhkKzVvBg5lpEkHT2yGLNUIjr5wUfDW/cn8vX6RP/OLUPwU2dudSNMPGBWa6YDdNa8wpov4n4NAr+nyH1yLVWmzmTErvwJ2Kh/mQCz4VwlDPDk5XguH3ejEljfiig8yrMkoJ+VANeC5/eW43ZlRWF2s9Cq7/MbWfiduIdsWoVpbmUP6GIGQMGArKajbLqGfWzYDuUzUDujf/LGz2ksvcXei8Y8arkU0hRyWqRDUg16gBKWnPU4ogxBmGXVUBwErd8GoYTC44KnE4pcgeXlrghnqiKOJLn+go2jQC1kk4hNDFn+6PvTs77CmTiehi5AWXd5mgxEtJ38PrgO793wb82XFjg3M8RLJsQB3e9MZLK/xVrPMgYpS1XLaxkuqCAWuo7xLVfuO30d2jdkkAIE+QuXXuAORtzxUZn71qj2SDhWHehwMNoDGPmA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff1802-ff1a-4f8d-bdf3-08d83cf4b13e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 06:14:51.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2PblFUPtLgkziYPxQDATm4vxUkcdvOr6/rtGBjMFL5mzaJDtLFWaaAjCx2OIPhN2lUQ+y2Z0PQ6dzPo0fB2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5893
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the earlycon dependence and add earlycon Makefile support
to allow to build the driver.

Fixes: 699cc4dfd140 ("tty: serial: imx: add imx earlycon driver")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/Kconfig  | 1 +
 drivers/tty/serial/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8a0352eb337c..9409be982aa6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -517,6 +517,7 @@ config SERIAL_IMX_CONSOLE
 
 config SERIAL_IMX_EARLYCON
 	bool "Earlycon on IMX serial port"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
 	select SERIAL_EARLYCON
 	help
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..caf167f0c10a 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SERIAL_ZS) += zs.o
 obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_IMX) += imx.o
+obj-$(CONFIG_SERIAL_IMX_EARLYCON) += imx_earlycon.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
 obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
-- 
2.17.1

