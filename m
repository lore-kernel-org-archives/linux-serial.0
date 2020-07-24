Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2154CC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49C52073E
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOfqzWd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGXHQV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:16:21 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:3681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbgGXHQV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 03:16:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZrruoDVu77D6Z+9KU8sR6O9ZXj9oNIqShsOzhayGFN+sMBDihiqNtIu0UGffmp5Z1hWUVPUNOUH/ol/ZD6GiB/Ca9fYwQ5sXFrsgZI9zFWG2Mp64UdwqyW5JUn8QQqal1erZh5U+c2Ux8roUdIKTlNE7otNBeiTwVEJymG9A0rtt3Fan4NBnA4fHR4tAJNvqGLxyHpT/bUOhO8Veixp29pTNPp6t+IKu1c1gjydUyWXWUxhPlbHaDbVg5pY5eT/Kci7CudfNNNIzhzvl8+yuHaOsFQobNSvPpg0FtKHjYNNQ54dDxM0OnTHXkpJM5U3zw+osyDcwrzrksnrJQDHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXKmSVEMth29wSNETC4JVpVa4S9FLWrQ0AAn/tvymQ0=;
 b=RZWCamnKH4DlwtmzezwKkmftG3/WqH3TW06cDREGAF/pOe7TWuj4X4THyrij/SnrBxq4Z8+ZKsB6XjLAeyp3RQ0AEwiAddQwveoYjYnTh7trdCbIOzDo0ZJ4/Zkh6tFfW0Aev0lvCL+I4imJ9smxmG8W2FhoBnbBy/IdQmXHNh2MIXny0PdutFWi1d3xyuq0RGVfEaBTetjoFo8zr8u6cqgV5NlN8J/wMeFIR+9b6sE0g81LamL8hEsqcDZHp9SqbrraUtSqx3iEZ+iq+ztFm7mEFBQbRweo0nrI367eWGt55aqgtjiVuX0olvB7Zz+r7WB9pgs3H3D96320BIQNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXKmSVEMth29wSNETC4JVpVa4S9FLWrQ0AAn/tvymQ0=;
 b=EOfqzWd6UFSLd1RtrdlcEXgxDOd0190n7NlUxa74CPMnX4XBP0lS9NtPupsFB8EI1BtM/Nz4/QhVN0Inp0nqUAYR4TeysqZyx5tjcLh1rETlwZMn0EY94oewlODo/pqSceQku4nbMybkBjhqRpoOEx/Lx7TnEjUHu/pwTv8iOE0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM5PR0402MB2930.eurprd04.prod.outlook.com
 (2603:10a6:203:9a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 07:16:12 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 07:16:12 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de,
        s.hauer@pengutronix.de, kernel@pengutronix.de, fugang.duan@nxp.com,
        jslaby@suse.com
Subject: [PATCH tty/serial v3 0/2] Add support for building i.MX serial driver as module
Date:   Fri, 24 Jul 2020 15:08:13 +0800
Message-Id: <20200724070815.11445-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.67) by SG2PR03CA0108.apcprd03.prod.outlook.com (2603:1096:4:7c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Fri, 24 Jul 2020 07:16:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ca415af-d729-4a7c-cd70-08d82fa17200
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB293024EB57488BF8438AD3F5FF770@AM5PR0402MB2930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymUkxqyR96Yr0nUdBUnA5z0a4kQgBpxgjpY7WlST0zw1NDjAOEYPlDHOo/gQHquhtK0AL5JT4pg/6cB/1a8TyIkGXlH10ax/QS9VSmVsDitdRyiiiAhOhKg37rqUVVyE/NAyu4kMsjqr1a9wMHS8nDSX/UBxYJMSyfQ+N+3SEfJUSlH0t55omDBW3WW1E45lpDwgsQgcex8a/EmMQYgcNrfL2IijVOuJFV+AuKsa25QnmXdbIrxRjaBXDuY0n6VhcsxtcWx5DToQQCv+/QXZoZGxoKSRdcafcJw2fHKQSJ8NRd8TQb0bsPITLyVvu7e0g2OOhbHR2frQbHUiljqh6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(5660300002)(6916009)(4326008)(86362001)(6512007)(36756003)(6486002)(8676002)(8936002)(52116002)(44832011)(66946007)(2906002)(6506007)(956004)(186003)(83380400001)(66556008)(1076003)(316002)(478600001)(6666004)(16526019)(26005)(4744005)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6hxcoeydLlje2Ol/VhWz6IU0kd/ePUTOuLogKZyS/atLV2/EDgicwyA4uXdqFl8QWRcLJ2O4xpp7Q6C4s4jJg2U+QR3WbIZDG/pTIaRfmBwIoyxbJOPqHJiASNyE06+6uC7e27e+gfk4oXhv0E78U7M0nW3/Cb40mISTFXE+1RPJ+OgohaK+wtNGlbWPk/qYyJlDnihOPeOxe6dFv7nlYsL4YF+ZwiFddAy6UDPSwPZj2YzZxVSqy7YKs3y5GfRypxeij4seJOWCGLbTjUZOS5yDYXTOkTLMYRmKgvwixI+/fIkia5q6ihh9TsY/b3j4Q+wsx9/yXnGpWlZe0RLgjZcPgGSQbzyZiU07i12CLLYMRmXamMxICZza6TLX5sXY9Z3VEryJn0Z2KrmIi5m54wyPv2LhqIq8kvd7JbHRoMmKzXhXPDNjjP1Zac9ToDqPSH+NfF98z2nbq44r6aGTmPa6A5KasWRuMKhKkeNg173tr3lHeJjJ76Eoi3mMxMoA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca415af-d729-4a7c-cd70-08d82fa17200
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:16:12.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDpXaZt3SVaLSlPxYTnttTVdcliBdVqLi3Zi4q1f7da5sCjSFM+rmI/HYEuCFDmLlzd26AsJighEUDDSCA1Wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2930
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The changes of the two patches:
- imx console driver can be built as module.
- move out earlycon code to separated driver like imx_earlycon.c,
  and imx earlycon driver only support build-in.

Reviewed by Greg KH, add did below changes based on his comments.
v2->v3:
* split imx serial and earlycon driver into two patches.
* remove "GKI" string as it isn't relevant here.
v1->v2:
* fix kbuild error.

Fugang Duan (2):
  tty: serial: imx: enable imx serial console port as module
  tty: serial: imx: add imx earlycon driver

 drivers/tty/serial/Kconfig        | 17 +++++++----
 drivers/tty/serial/imx.c          | 37 ++---------------------
 drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 40 deletions(-)
 create mode 100644 drivers/tty/serial/imx_earlycon.c

-- 
2.17.1

