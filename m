Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1864C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 21:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55F960ED7
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGWVMN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:12:13 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:37376
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231839AbhGWVMM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWoU1ehWxNM7HepqOjgzVvlmb1YAW7o6ug5GCgtyOdIOLHDYB4/INUgKZ53DTvTrwi7wmO9Y5ZSZZ578Eo1OIiYXJHThrwQG2m7czs9iCNcTb0OJei2Ii0FiX7PtJvaaha1A7anSUgmjnk71hwM9oQ2QgkqSzSogG5CFh746knNnMR118rIH9yQIFJsnXPtEF8+e55HXcFJPLkjI0wLGBpAh8kEC1ikScG/r8ztTxm0nao9P4qse7B7JqZzf86dopq8PCOPpxHjDoepcVGIMu8jaySJxN5fmyUHWWCxdqu2UbsZE5yCwqgS7sb05Tp12hI6+7d5JDa0sNNPeh5rCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaVcJD/ZHJDJS8lwbMVtG2LeehdHRLPPPBXj43R3psY=;
 b=eGJ1S/gDM2/NEUVUn1yYCcI39qDtEzKfiNelf0FHYJWsLgv6m0TJJxoRip6qDs2IQGVTnj8nqZvW7cWEhILAw7052l+fHkQr4FF30A2LWxmEB/gj0CWbb1CyBQ8WYe/1SdQRzi/OHjdxWgA6NaAfoVrfaoZOuxa1cmK8rjlxYeANg0iiAZaN2FaUhw0tSSL9AR2ws7tt/2nHEZmZv/q5dAedvlExcdCHziKaG7CxeO3RBtyf5+FQsRwrBJWaZ1lW4/kx9kTmphHDTJdBeRus6isp3xCItgck2zOjBHunFEx34HMExgzLqHj9CATjkSCz3jB8NPs5JBZoQJqzEBBlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaVcJD/ZHJDJS8lwbMVtG2LeehdHRLPPPBXj43R3psY=;
 b=3IvCQXzlH4u+Mgcxk+2gLQz9COXW5vgOBFI0yBDIcr3/Dr/3mHiPwfVuLRv/orfntr5slYmrsx+2xZKqkNx2d3ZsFe64HFOgGahWxDBzsO3yTvVUWEu+uF6yvyYfFKYykAE+QqHs0giB1dbcU6kWx6+9oJVgKNhMjHH9KxUSm90=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3963.eurprd03.prod.outlook.com (2603:10a6:5:38::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Fri, 23 Jul
 2021 21:52:34 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 21:52:34 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-serial@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] tty: serial: uartlite: Use read_poll_timeout for a polling loop
Date:   Fri, 23 Jul 2021 17:52:20 -0400
Message-Id: <20210723215220.624204-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:c0::37) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Fri, 23 Jul 2021 21:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 099f760f-ac1c-404a-41cc-08d94e242dba
X-MS-TrafficTypeDiagnostic: DB7PR03MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB396393CCD86AB16F74EE923996E59@DB7PR03MB3963.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CISzP6QVgx0YokaMJb5vuV5CjkXN7hOo3gzQZznZhjWzSO6/vTarKOzD27VVmAoSN08XK8MQBcdaKSP1NIoQ5+sn6potFsfjd9Nxtz0hGYm/NdOi+sDFMpt4nqXeyG9b2WguCExk3E+ZOmxDTFrdXKdMi9YAAGJrigWMn73MU1rAhikyD6G6ko6t++r6EUn+BqCXpqDhKyrGdMeyueZimwNtvO4UquOkVd1h8O9i5YGMNH737egggsTAIV8nFGe6u8fFD0tM1cEMDFn4idcyoH1YMsXc4TKFmh9QW/yqqDlX2ZxgagjKrWSkD4kXg7s45NDgPcBLW5f7BCgSPK8YiqqJd+E5MroyI+iONBjhHqFftMLuczGStaa5/fpPXgyLB7l+VjEPuEsclrNigH5yt+xU3HwFop93Zg2Wjp3sdsf8TC9L5aUFFO/ppOty5ksdTmsn49+s+srHqRI1nqkXtZ9uTSpiYw3dBw3g2WhcM+9YHmzp2lIT3vRUtJ6GqmAHVVQFoQeiKF2izbV58iQcfWubhCOAjELggQbgCEVZSLaiyLEHCzcaKoq0UgKdbXoLTdoZk+mZIVbsYJTXfwyi2duwV/0gxQgwysBreyn8kgi2xSD6ZJ8oti9IuJDfkWogfOWERcFxPg8YFDKj/wVjJhsVInAx7i2kJlDE2Q1jwPIkl6iipKZfu943ND1BTwvr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(8936002)(5660300002)(54906003)(956004)(6512007)(52116002)(4326008)(186003)(6506007)(2906002)(8676002)(38350700002)(38100700002)(6666004)(107886003)(86362001)(6486002)(83380400001)(508600001)(1076003)(316002)(2616005)(44832011)(6916009)(36756003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ew8TQfSqmpzIm3z1HeQuib2y9kgjjidB8uDOpREsx5sV/1RnenIKNwz5yslN?=
 =?us-ascii?Q?XrEAVipFS3CtkAYMg917JzYtWSj5JgQvAVGZsQ/m34bgVd57WeMY6O9r8Khs?=
 =?us-ascii?Q?vTt3OIQLctt0Z7DmmJ7v6U1egXXkZkvAyTzlhVxAxhL40RODjVwoqQoNbtGZ?=
 =?us-ascii?Q?BRgmYPiFjTdgOXw6RzH7Hl+5OcqJFWGmxHaBtmS3WUSdEd+bAicH5srFKDA1?=
 =?us-ascii?Q?WIl/zQRkOwbweQ/e/eQsDnU+/30/nfkbsHvi7KrRt4jxHLw2CQeBNmdHSL3N?=
 =?us-ascii?Q?8rhvaNftZe35tZ4xSjRVPml4y72gwINyhZNkaEXyKWb9tL11VlLLumvl1TW2?=
 =?us-ascii?Q?noOPPWjuzd97JXDTnv9HTgONFBoO4bWxquhEfd/MUAv+YQ4NKsp2zIpwBrrh?=
 =?us-ascii?Q?s1szgLY4/+mEsJ6im145g1QKrtikmEgZk/eEERbX7rD0aushtLscVcAT8IyB?=
 =?us-ascii?Q?Vz9G5Y6k9AF8IVh/Qf4gtflfq4wJT3MDqyd1JqD5qwjKLE0B/WHyfpDyDuoN?=
 =?us-ascii?Q?ygRjebM+9BRdwhBckmBZJHtu7kA3wxsehgyfN9jHppQZkJ5fMHHQlmd7KoRY?=
 =?us-ascii?Q?+yqHQX+1RN4RfLDJhstKEQyDgskNWkbYEUZ3wnfEJg83mWOjpAEKbPmxmqoP?=
 =?us-ascii?Q?JQ+ZXFkGztUmc5FNbGHJjDA9OqQkZTjt3iNfKQn4jJCEvgv8O11njmUIVgB9?=
 =?us-ascii?Q?sy0aEyA6TSJuCQET3Y1XYeMFiqZFU/ce41cZZQFvLPUnBSaWBx6MuYjE6t3v?=
 =?us-ascii?Q?hzBIj8Z908DUtNBMU5YTwrfuJvjDeks4WWea3krXyoqIxIMMdayPtqYfAiXj?=
 =?us-ascii?Q?z6FZwnApz4IRKuW7/54LuMGNu1CIN76aUpmhaQRU9+WCXQ4bILZNLre4snFX?=
 =?us-ascii?Q?DM1DA7QdWtteXb0vGeuY3wdjW9sWiv5sId6r7j9QtwF4cts0OV/o8u3k1ZYy?=
 =?us-ascii?Q?cQNQFft3yJ9t3c+pGMP0179tn55bg1nodo0fbXNSkBJ0pZxHaKsULbe63GaO?=
 =?us-ascii?Q?Qn/5OFKc2PYHFwFZ+D16WMVeRMM+VUQTX4l9Jrs5RD5LWxKmqdtjiVaID+Qs?=
 =?us-ascii?Q?I5a49zALMHJxr+w8p9bYmOeZ5fO/jBWQGMQsppj0QymhSj6jk02XKDpfcrBo?=
 =?us-ascii?Q?eUumiICPQWqzIqrOp0XFX+nFxDijgCqM9QJOXnRsu9M+fsflItdGZNQ5e5Gu?=
 =?us-ascii?Q?bDGIVdDhtX6EgRLSEo10Uu1TI6icrezAFnnvbaiv2bovm009BNAIbVgsOwiC?=
 =?us-ascii?Q?6iGCVEu6hNa61Bqdrvy4o2vqKmO4TFUd/Qjw1TRn++tXtPuSh2PsubB74+BV?=
 =?us-ascii?Q?vVytQH8QiQTy6wcj+dGVAKzs?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099f760f-ac1c-404a-41cc-08d94e242dba
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 21:52:34.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HfbmUHKo0mMgBPB2KgiPrESl9AOmx0SXKzZjhWhbKIKGcr5XeQlz9uX4oylWcpcFIb1tWqjRA2IA/8tWeRxLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3963
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This uses read_poll_timeout_atomic to spin while waiting on uart_in32.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/tty/serial/uartlite.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..106bbbc86c87 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -448,24 +449,15 @@ static const struct uart_ops ulite_ops = {
 static void ulite_console_wait_tx(struct uart_port *port)
 {
 	u8 val;
-	unsigned long timeout;
 
 	/*
 	 * Spin waiting for TX fifo to have space available.
 	 * When using the Microblaze Debug Module this can take up to 1s
 	 */
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (1) {
-		val = uart_in32(ULITE_STATUS, port);
-		if ((val & ULITE_STATUS_TXFULL) == 0)
-			break;
-		if (time_after(jiffies, timeout)) {
-			dev_warn(port->dev,
-				 "timeout waiting for TX buffer empty\n");
-			break;
-		}
-		cpu_relax();
-	}
+	if (read_poll_timeout_atomic(uart_in32, val, !(val & ULITE_STATUS_TXFULL),
+				     0, 1000000, false, ULITE_STATUS, port))
+		dev_warn(port->dev,
+			 "timeout waiting for TX buffer empty\n");
 }
 
 static void ulite_console_putchar(struct uart_port *port, int ch)
-- 
2.25.1

