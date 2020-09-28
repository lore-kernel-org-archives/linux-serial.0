Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272FC4346E
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 02:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A688A22207
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 02:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b61TyRrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1CrT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Sep 2020 22:47:19 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:37734
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbgI1CrS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 22:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO1IjUtNDgLvkn2oujv8P20Wr3PSSMfFnDo2CXT6dDXgG6S+NUiDYEyNtUPNDulVzaY3KBt5WSS5ZDq9Nb+PTLV/5I5v0HRCcuyK19s1IBywvy+UhvvKghvF3VYTvwlI9qsI5g37pCkZJxujQLjT3jlVshmdVdpmF8NMsPNogynecMeX3ZZCI5tICcNsbuPMqGrrK7Tnml9G72jREsIBCwnqQS069zyd4j0SSD/GaxWcV2eVh9ifgpx2z/a8AcC1czHeH8VJoD+Z6f/TkUJ5LceqLuNa0IFhBZYUIZ1z3KgYu1WLFF5jIGe66G6H+Pd43IBUTw3XMKcxQA/D4AB8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yykv/AA7wguh2ajWrPJJs4peoPTe7k7N1l7F+HPpV5c=;
 b=VxGM/zzj6sltVQe5pscUEbe4mbWpQF1RtwNFQnN3L7LkUp8TU/oe9jHZ0Z+iCE3gjiow0zt+1ubXEKCIFp8r66UOfWWSSEC2tWfEQQ55fwIYTp2/OlvCWDGyP7i5RvM0+SuSuZ+cunVMpWgEicu979anJttTdYu0eXyPaFtyvAI3QYLFgtd7wQNbvzEjflxHcNmem3Ki+EE3bD7PpTtVoxU3tCJIbDxCYIQoV5XmZV/0HW2TS/yDFDhzHdtlJagXs5/j2b4N2e3hza/DurlgKk+J9Nq9uHJZhYgdhyTjzRM1KF+Z5f99pH4IBnoyqDsZTpI0n4Zw/TFhNGqkrQYG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yykv/AA7wguh2ajWrPJJs4peoPTe7k7N1l7F+HPpV5c=;
 b=b61TyRrjJatB06QoGv8YEFEuVUIZLN61dKUo28wodjjvgJkzqfPYZ8wALBbEG5Ah0y6M/TpgKZAxnM8irTDT0Y7qGT5FCN852FmeCamJeon37rPPhY5kPzNj/Jp6g6KuSrVsgl78aesSLWQImTKKYMPqRwDeaI4+ShBgPs+70Rc=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 02:47:15 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.029; Mon, 28 Sep
 2020 02:47:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andrew.smirnov@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] tty: serial: lpuart: fix lpuart32_write usage
Date:   Mon, 28 Sep 2020 11:13:30 +0800
Message-Id: <20200928031330.12900-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0179.apcprd06.prod.outlook.com
 (2603:1096:1:1e::33) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0179.apcprd06.prod.outlook.com (2603:1096:1:1e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Mon, 28 Sep 2020 02:47:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25e6f8e6-b43e-4bdb-842b-08d86358cef2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB685898A8B8ED4ED98229AD6C88350@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eXjfLUnjU0WXsn0gKQ7i6S8LuK7Ob2k/BItvQgnBgzlBydeVmzytpt9fNKXDYdGZhjNpMftN3DOCLcgIFTe7351rZcLZkW98eekFaJX/Yj0QDrHWl34tyRxy/lv7xbrwlPQoewhimo0r02p4jj7yF4NCSP+sG1O0kNVTk6e/jVXEH2ZF0my4b7PQ5AobWGum6la0INiLJtcn8IYIq5q/KdMELGT8aDI/27kANor+QF13j2kxvQVz9JBn1t/E7tHvR8d2HICPVTpYesu0CBB5SdysDPE0GbC04Ok29R5ZXSL4ND1bCES4+atrSP+vyfGkVaO0Nm5nSZj8KD9+nLGYsBabSgtcqIZlHVu4973r3n3Zdkzsa8dUrXMECFaLkVj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(478600001)(86362001)(36756003)(83380400001)(52116002)(6666004)(44832011)(4326008)(8936002)(6506007)(2906002)(16526019)(6512007)(5660300002)(26005)(66556008)(66476007)(186003)(66946007)(4744005)(1076003)(956004)(316002)(2616005)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Fo9553py6J7q84ge0v0BAS3JCvJ665wjSCtqMal4OiTriUVXFkiZW4HcB5+NlQs7rwW7SoOvUUaHflFFehaVEwu1wXvEZiOtHUwbpXIgLteOf2hCTwbCA+CemslKJugVqenWgdq08Qz7Ivr1eoiBlxYqhqRsj4CSNeQkrUyaatrRuHsCvnhT5QOUkYsQ+rJZ+4ymAuF5P5URk7Zl1IvVjA48IyYJOLs2kwq/Q+iC6FGqGXYNQR7eWSsxyj1riEEvqU8BqzAzafknBN5CGHyPRb6om3gQyPF+D5qHzhfZvATtcTp5aWjesYyrlw7CsUCprVuuIi9NFTimvLPvl0mqK2oA9q4KrTEE6wMaldYWgsMFnqWYYBlXqjSAY/RlwAwBuudSx6USTmEfzzBN9IIR+BgVpAByXZLIAHusWKHclFKd8M33DnZ7Fnh3ngtCgKxkVilF74yJof+zjDUGSLK2ZK4W5gO8J1IJ9AooaRy31LLJjDakkWWUxjyxpbE31XTsWDy4u+D2NlG8JRaE5k1svoAeSvSTowzizqOykOEBt8hGu2K/kJ5W5PZshM0izc01ezhLNV3aZaCnAtm77n/eT1EDFyrNePEUh+kkLgZXKvz3LMbAkFSf90NeO1Du6NsGbTNQSMNxMarQlhHjB3kKmg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e6f8e6-b43e-4bdb-842b-08d86358cef2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 02:47:15.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pxq/DHpdj1O8Wenkm249VwiezA6I8ioA36xOuWrUtmAdToxNpSC/3yxrVq3atDWRPrHDtRZTRs0X715LsbUVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 2nd and 3rd parameter were wrongly used, and cause kernel abort when
doing kgdb debug.

Fixes: 1da17d7cf8e2c4("tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5a5a22d77841..8c6aef46c9f5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -677,7 +677,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
-	lpuart32_write(port, UARTDATA, c);
+	lpuart32_write(port, c, UARTDATA);
 }
 
 static int lpuart32_poll_get_char(struct uart_port *port)
-- 
2.28.0

