Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF1C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 10:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiADKoF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:44:05 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:43106 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbiADKoE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 05:44:04 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 05:44:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641293043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7YrM4OwneWPIzESywmhJ8kSOcgaUVy32jieCVjyab9E=;
        b=JFocJHizBkWXRdxyRz+VdlhfFJEl1n5JIw8ZLPKdcQnaXiqBt0L40/grxm4tQkPc4k2QYz
        Y7jEiT2cKVFYeF1YP/v3m3EG+SCo0gRl760ggiRSK9OywO/aaFThO+SFqH93Ej+QfXdlf6
        l6OtIR4rNA1dKQHKDSFyQWXHPMdLzE8=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2054.outbound.protection.outlook.com [104.47.21.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-100-F3Vs9vE2OMKOAY1q4ZECag-1; Tue, 04 Jan 2022 10:32:37 +0000
X-MC-Unique: F3Vs9vE2OMKOAY1q4ZECag-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWXP123MB6224.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 10:32:32 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:32:32 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH] serial: imx: reduce RX interrupt frequency
Date:   Tue,  4 Jan 2022 11:32:03 +0100
Message-ID: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f57c9a-8242-42f5-2d97-08d9cf6d83cb
X-MS-TrafficTypeDiagnostic: CWXP123MB6224:EE_
X-Microsoft-Antispam-PRVS: <CWXP123MB62249B35C07DC5EA4D3EA322924A9@CWXP123MB6224.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Kb2XwuXA12EmnRCuVDiEMqO1qaJwnWRUWiAPU1olZgGZlHmmcvjfIlv5aXGSoXKDjdWne1EwhLbZDpYxfixl8UoDGIaKjZWCrQdYuGEnUJtq5dPBhpBpyunqqHS+GLvgT7uWSk6t4+Q9ULAs07DG7UNrodw2Z8Pq+1O2clasE9M53vzzlp4Twdmlh0TdeAFZdm26U6OB9zWMLtOmjfSY/RCEXP2lG4yBD5qNTQAIVQe1svkQDZI/jO3GyFluc3iE3XFNfAN8b7+YqazGH5xYKfP8DgzBzzuZP8VzvYjMERrEFmRuohw0j7CNM2P6BCmnJ2ZLeVVFtg8X++8XvMwtGzf+BLKqU7mhfaiJtb7TkstWuiV9Ypqd8Tv/PXoWd5CDFgPsOKtnOtROH52vuUmuybVdj/MDIO+ZDD/8KHyGa34zHcGu4ACnrgOIYC5BqScsVfyhAf1lycHMF7IondDEuNfR1C+h3HFJoF7X8O1RcnwmufdMXla5hfrmHR0XH9Y+Jc3BLgXXpJIK/HaOgIfQ3ZCp3p1jS7CKP/FD5JGc5y6h1QIohYON7+jBtUid3ccAjyV1G8zjiJN95/Dr6YzTghLPNiRTQExNqfqrpmnVoaTrV6HtkGb6dBXEDUoT8cSJ5Fg77Lfs7VupThBG6dH/lXj59UNXiud/bkdv9+zk6/jW+pEwi6640ejjOQ/EDM9a/ZbfEgvpKGwrPb4P0387ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39840400004)(6666004)(5660300002)(316002)(52116002)(6916009)(107886003)(83380400001)(2616005)(6512007)(86362001)(8676002)(36756003)(54906003)(66946007)(6486002)(508600001)(2906002)(186003)(26005)(8936002)(1076003)(6506007)(4326008)(66476007)(66556008)(38100700002)(38350700002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8j+Cewz/a1ApMXibm7vPRP7b/bsCUFEsITqhXfwLOrU2u80gPNM8Ie+r9Xu?=
 =?us-ascii?Q?E/Z5ObpWLJePL+Lm5pvgt+vq5uFD/iBkI4f8iK1UmmoeClKs8gpsFDfM6izM?=
 =?us-ascii?Q?pyf7G6CWXlfQjsnd6eSX1JU/L6z9eVC4BxzebEP4iTO3XI3leehQOF+Dy3H2?=
 =?us-ascii?Q?wGpreNuRIJnRDwQK5RCTi4m1Y/0A3icnbqYRrpKT/ePBkjUMuZyxlidkBQKP?=
 =?us-ascii?Q?byeuS06hNrYFeEBy1+uVAUA1h1sAobTgoDnQOqe2/TKboYWcSKEPu/UQG0N/?=
 =?us-ascii?Q?L/proVrXx0ZRcHX54pxn5O7cIYBw8w6yKVtHwm2ypg3kJqyKEeB55DH16xlF?=
 =?us-ascii?Q?NU6tTlZNmvXr5U8j6dolao3/NawS7WeIA368kgMVx+2f+cg+Lp94+7X4e3JI?=
 =?us-ascii?Q?f2AcRJtwAIrAYWFlVGDZae53O3kQ3WUSdZ2lUNMlS4iB+blFKf4PoSMPfagH?=
 =?us-ascii?Q?B/iJIIyoegf5xMer5jSyCxjlK677bZzEWfqfHQnUkGeqAHGdAhbjHFULiG59?=
 =?us-ascii?Q?uSSzjqySmxhrcRCTUh/QWwR6PXoVnN5FCMXCeCodbFKScWXqzGLGPco+4KWS?=
 =?us-ascii?Q?mmwJBW/4U/Lb68vgOlnrx6KYXhwyomw4tDEjw9IZwrWeACGehQLI9tDeZ4kN?=
 =?us-ascii?Q?lOYPPWBjbIHnThUaz5BZDOmq8RxteXoopGwWmiGUMaGoNVdK94xHF9kUAoJp?=
 =?us-ascii?Q?qbY4xsmeLsueTbYXQUtDoxC/dnMaEkUtNxef10HgusNQRkCwtVb+4Uoa7ItB?=
 =?us-ascii?Q?fCRVGYLGxJOypyyX7zjwrR/pBWjTDNAnVKS2iTPjldvzEmvgdVt8a96r5sDn?=
 =?us-ascii?Q?dCdON+Xri4J2dKsueyWTAr1DQ63vby5OtUpKWrMaKdSBRhoEkOuQAfFraoxz?=
 =?us-ascii?Q?Vz0GccTdCgNWOY9ZbuwkHbA2fegYmyKYYBeeyNYL5vVdyorhPLgeTzySz2pE?=
 =?us-ascii?Q?A6mZB8so3YXvN9WFAHewXNMq8oS3i3+264viiNYIaPWdmjFooCRzrFXlQ9gK?=
 =?us-ascii?Q?8P06lQ0cNs3g4WVAOMKv41X5JeR4J/hFo5dMFgv+7DeVLvrwhRFKomSOBP1F?=
 =?us-ascii?Q?0o63ianVmQtHfmq6JB8F4kRvJ7eCFlUTQoupSN32Pr01nWVY/GLo62cS1Zsf?=
 =?us-ascii?Q?T7aIpdR1W1fHaCHYxu8dBIXfxRlDC+7670yaIKigdjn4hEN7Mo2RwqtvNGaE?=
 =?us-ascii?Q?gmfIv++4+JiJDrzxniopMsK0Zv1ZesC66b9H3DU/pbYd5G5bIcFwxa8PeHF8?=
 =?us-ascii?Q?xf1LC/LtL5l5RhHLCSgQGXND7ke4xmk9YaT5VB4Ih/A0hY1zgFgOF11KMVaG?=
 =?us-ascii?Q?l76F9tW3CT+KTPWIm/yjjlA/O7MyRNEXpQXSYU4tKxFD/YFOxYxZGE59eDJh?=
 =?us-ascii?Q?/HJTfmkXd38QdB4Az0yUoE8WVWWWI5rbysIGFPhDyb54IZP875WgMCx6Po3d?=
 =?us-ascii?Q?fJPzkQPV92HGAzochhpPyEZvq9/urt72oefQeX00cAT+KCebzH7f7KLRUzRx?=
 =?us-ascii?Q?Z0KXtmbu22fuZTjDSOQUOIQZ7MCxuFh9H6f/9AVoTrPJVj52LKPNxXvl+l7P?=
 =?us-ascii?Q?06cdX6HcJaHowRJnuA4cJD4YWkwwfAfmm/w3zUbjvbmeOeVO9NNdLgi4HOtI?=
 =?us-ascii?Q?VVcjes+HjZsGUa2Tmk/UopwX+V/2cGYtZPxLKd5R1jMx8OdLYOkX3SsNU0eI?=
 =?us-ascii?Q?QVLhkw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f57c9a-8242-42f5-2d97-08d9cf6d83cb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:32:32.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1qJkf0vhMirMiHy3EW9hze3eIu+9Ew8iDqNoexukvKxITfvPAQ+mhQtSeUcuFB/W8SLivPef/Wm8mCvl2a/Td7F2JymcwAU0zWJNt9xOtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6224
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Triggering RX interrupt for every byte defeats the purpose of aging
timer and leads to interrupt starvation at high baud rates.

Increase receiver trigger level to 8 to increase the minimum period
between RX interrupts to 8 characters time. The tradeoff is increased
latency. In the worst case scenario, where RX data has intercharacter
delay slightly less than aging timer (8 characters time), it can take
up to 63 characters time for the interrupt to be raised since the
reception of the first character.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90f82e6c54e4..3c812c47ecc0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1255,7 +1255,7 @@ static void imx_uart_clear_rx_errors(struct imx_port =
*sport)
 }
=20
 #define TXTL_DEFAULT 2 /* reset default */
-#define RXTL_DEFAULT 1 /* reset default */
+#define RXTL_DEFAULT 8 /* 8 characters or aging timer */
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
=20
--=20
2.25.1

