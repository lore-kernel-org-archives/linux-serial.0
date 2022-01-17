Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73521C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 17 Jan 2022 06:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiAQGEu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Jan 2022 01:04:50 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:58429 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbiAQGEt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Jan 2022 01:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642399486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=72vRLPm/G6ncuhJNevv5mZRkyszMW/w91xRM8p65xQU=;
        b=bV6fdb3qzr6gDBa0ZNykBk5hleGvu36QtTdx6YKhz/ZknjsYm6phhSvBCpZHpsb83scmMG
        rdzTS6QgTRg60wlecSDWKtw7X+FwDTMzR1eIm8OiNJeW3f0ZniyTsMGACmEwZkfzKLoutd
        kS+nRmQztW12FdfShVCq3oN6T+7eJUo=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2053.outbound.protection.outlook.com [104.47.20.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-15-vrs0vxT-MBqHt6MYOl7ADQ-1; Mon, 17 Jan 2022 06:04:45 +0000
X-MC-Unique: vrs0vxT-MBqHt6MYOl7ADQ-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWXP123MB4728.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 06:04:43 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 06:04:43 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, k.drobinski@camlintechnologies.com,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3] serial: imx: reduce RX interrupt frequency
Date:   Mon, 17 Jan 2022 07:04:17 +0100
Message-ID: <20220117060417.624613-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77528e63-d3af-480a-3c8c-08d9d97f41c6
X-MS-TrafficTypeDiagnostic: CWXP123MB4728:EE_
X-Microsoft-Antispam-PRVS: <CWXP123MB4728D51B518A02C03DEB915192579@CWXP123MB4728.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: LynCYoMG5naO+Wmk5Kg7+6isyxTXAyJHvl/xpvkt+HsKWdRtTBfhuNCSySAqD3tivMuvd/2iUqX8XfHrqTP67L1zpbcISwpKcQO1Cx252suHrEXJIO7nRlnUFejGvbYCgKnhLNhNtGqYzvyqagoMIoWOhYmQ0S1xuB9eLzL1O3tBUQR40QPjaU8czfj03747C6sBU64pn7RYXmr5sI9Vkw7R9nHTQAmqs70EtD9XgcaROsbGn4JhXp+v+/t+LpkYn3MHao080ruawYVTG+FdNFUUtTf/8kSCvA13tjSq0bhDnrbl14sVjf0zxEQ5XiSbKgbZJEn2/0RJWo5pG8vldwuVud5oGHXxuv4eN5gLM+qX6OSkDzeMYQ9S90UYe9uJSCHWdpvNQx9t/RDtYKq36/mfGt+ONJniw3TBAA7FjFLafmYMpCf7wj0lg9tGrw3lGtf/Q3J0z+J4q0I+QNw6sUqLdvwVf15pRj2tKbMwUZQxQw1bUPXkBT7lwCgJQseUj+4HHlyQuSgBZb+U4BF8sgdTwdpkCwFU7G4I+MGoGCMys5rv3vaNhxIMxtlTbyyi+SX2kEWoY30uF1HrSl/iSCaBpTqvRaqYL1sovGrXiGwNwQkvrjV+O0DLOhj5yic9eoEszEI+bDMni1LGy4DwSEWA2BRAjqex5w7MSqYFJwMcn5Q/MEASyDP+cMw6fblKvtwMrfwLrIihxcHPUeibmWo9uBnkDAyCb+7C4mf+Ufs6Do75sHISF0li3a179fM8JhV1hFBw9MhRLgsv7FC8kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(966005)(316002)(54906003)(52116002)(6512007)(1076003)(38100700002)(38350700002)(6666004)(508600001)(186003)(2616005)(83380400001)(4326008)(8936002)(86362001)(6916009)(66476007)(26005)(66556008)(66574015)(36756003)(66946007)(6506007)(2906002)(8676002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLwmoNC88TBwq7v+BYK2A8/KegVhxPJ9T0N8pssYkf2KKa19PXQERa8xtB7v?=
 =?us-ascii?Q?nbH1JjBiVNlh6v8ghsmx+1y1AIghvBeqRDlGaqcgnjEE5Nkpkv6RShzDM68Z?=
 =?us-ascii?Q?s93uGZGnipFaFZByVcsps5ZvbKNDJZS22kN0MRyDLUu8tXaUTLXn2lapmu6O?=
 =?us-ascii?Q?BimVyME5ZsESFIVly51KBRDw1aLN4KRz9O9FqETZWMgvpK9ACL4qH6YWzzEw?=
 =?us-ascii?Q?pMV4lNblFL1oVcuELE1fbvAp0/tsNZvOaxhWfR5dTgSZO+q+t7WQtnaHVHm1?=
 =?us-ascii?Q?Nc4U5cN+/4tVLZttvYhDf1LRsZZ0HLZXOYpWSv8R+Jke6XpktnO9ixG54sao?=
 =?us-ascii?Q?c/+CrxOEF/HFKM8yiSobgmfiDaWX5fV4ww0MjCrTc9j5zn0VKY2tMVe2ij/d?=
 =?us-ascii?Q?V5OIE/EGeApKCxvotp/TFW3GKkEr6SdMTlm3d7uy7hhLjoMC2kw8D2jvLxrx?=
 =?us-ascii?Q?HzuW5MLHsvm3LRjfjHz4v5uXvoJj27xz5IrAhD91cbYYharsySoH09OsF6wt?=
 =?us-ascii?Q?fyo6U1n0ymeoeMkhQ7JPEgHYHxJ+jyXgGebrIKWVa9oaeKr5v/QrtLZffvk9?=
 =?us-ascii?Q?pHTmAJUhrhsdqF6iKdPDEsD9+qCly4/CcXv9PfhUetalTBc+C0Meuh2w7A7r?=
 =?us-ascii?Q?0zQspSuNApuOQiyE87MBelK6mooGO7aVIC/H7hbdWTw4/7PCiLjLGQzgrc6f?=
 =?us-ascii?Q?pFZXF+nrHlUqrNODwQgQog9SfppNpktGo5JsnKjrvEktyVxaM9q1eI/FfGCo?=
 =?us-ascii?Q?JdA10QhpQcXsFkoRWqaapZUGMR5pnkdqoMShCYtsvWkd+myOO4s43XqSughS?=
 =?us-ascii?Q?6e1leDp//8MJGjCa1zs0Cfq7BOJyP/aqj2+Q1pcZc8tob3AUFHUY9Wm+hb6W?=
 =?us-ascii?Q?5NfHTlSWQa+uwzMZFmC4r9I3lkay4EZVKWYOJRX5KRAt5d0BAUd1byF59hoT?=
 =?us-ascii?Q?4vjlSAOBpqi/P1wthiNvNjB+BsjAj8lCAxMvrAFacGkW7mkVZZfwnsF4chVX?=
 =?us-ascii?Q?CFYXZnPMt8TyOHc6uCyAkgaJO41N7/pKU5uY8G4GsXqXs9GyhyzcPjdeW/Y2?=
 =?us-ascii?Q?X8kiU1eIujV0kp+fKOCFoTQhZ4M8QpVkTz1FM8/GWpIbcWZW2tIag5e2MiTm?=
 =?us-ascii?Q?GISLO35NGrpIL/7ayth5KCzvQcIRMiopRn8/vxdA+59Xdmw3vIzVDlZ7pM8w?=
 =?us-ascii?Q?4dOQkMAhu8fpjGbxS6ulYBhm7GLk6kzp2VnahvrI+yn1+QwBvvWPdy8q+RBH?=
 =?us-ascii?Q?/DeslYNxI4UyQ+T2XJXPzTK/h3LKulnpr8PC2CcTtbS/eJI7LukcPYYpQwd0?=
 =?us-ascii?Q?DxkjbPZJFDVUMT3jn47H7sykFxSEgau96K/6e4w5SDGb1P0ignX/Exw99pjY?=
 =?us-ascii?Q?YwS1Syya/arynoHbQH0v798dykXX3aA1fZ8bkqu6IMUIRWu0RtKT/5RlcoA+?=
 =?us-ascii?Q?0xB0pAkLEzNbuU8G6fLs1Q6G0xKmPVDk75Jt7b9ag8mFGO5rB36ztkPLo+Lz?=
 =?us-ascii?Q?qw9DiQ6uLrWAzUVIpf1RgNO7CI1IcfrCXGXfVA8ozQV4N/mPC2nKlsjHoya6?=
 =?us-ascii?Q?jR9w9WcGQ21Zl/NeEgP4Jtod7XSBfxikZH1tpzr8dkrCv70ji5FQeZ+8lni7?=
 =?us-ascii?Q?73JxR3BOKpeAQP7xkg/sMHG/PgXY86FpZmzYxcuY/5hxSYGgGYuDbqQOA6oX?=
 =?us-ascii?Q?Yp7QEw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77528e63-d3af-480a-3c8c-08d9d97f41c6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:04:43.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6F9rDNu+Txk67sLSN8JepJlyp9Re3UlvOU1DLr5uidUzZ06hW/NkdC+YqwVk5IkUTKusoHQaCcSIat7z3M9jZHZhcsBi+PivvLjtSCcQiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4728
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
timer and leads to interrupt storm at high baud rates. The interrupt
storm can starve line discipline worker and prevent tty throttling,
rendering hardware/software flow control useless.

Increase receiver trigger level to 8 to increase the minimum period
between RX interrupts to 8 characters time. The tradeoff is increased
latency.

Aging timer resets with every received character. Worst case scenario
happens when RX data intercharacter delay is slightly less than the
aging timer timeout (8 characters time). The upper bound of the time
a character can wait in RxFIFO before interrupt is raised is:
  (RXTL - 1) * (8 character time timeout + received 1 character time)

Usually the data is received in frames, with low intercharacter delay.
In such case the latency increase is 8 characters time at the end of
the frame with probability (RXTL - 1) / RXTL.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
changes in v3:
  - clarify the upper bound is for raising interrupt itself

changes in v2:
  - reworded commit message based on review comments
  - added Acked-by by Uwe tag from V1 review

v2: https://lore.kernel.org/linux-serial/20220114074400.3417233-1-tomasz.mo=
n@camlingroup.com/
v1: https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.mo=
n@camlingroup.com/
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

