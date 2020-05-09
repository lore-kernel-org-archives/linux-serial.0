Return-Path: <SRS0=wdWf=6X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE361C47255
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 01:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D473E24956
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 01:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEIBes (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 21:34:48 -0400
Received: from mail-mw2nam12olkn2060.outbound.protection.outlook.com ([40.92.23.60]:10433
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgEIBer (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 21:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxAt6Yw3a29xPbXCUIsYdXRk6+e7v+cGmZ/HjG1MQRm90Qw0f4jDLLxPsCzc2btto6evkEMWWlycdSelN5yMXhsSRiue/rvTQ4+17C0lyencFn2z4EOfTj0XhEptbe/h7alIN/mGo07vyHr7bVkcniicOTGIu+dTi3kfNLBOcGetWZRiJjZ4RVrLQsvx9CZ9IDIuPqaH8R3jXqbkVzKCu6MXNdc7ZlHld+hRRZFEvqw3NSPfZZgbJn9maqHSQwhAEibtwqqNkg9aA2C38j45HsDX/g+w4dLY5zCowBLOizKhmA6yJcLCEzvnfkx2PyAVnhOICva56pANf3+ge0iP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg0OsvzlU1eLMvS0vAoFzf9f4nkJrus+FNqiK+LOu2I=;
 b=Xnc79Th8Cj+D6eh6Iv2z+22qULBstWjonQ6ShBeGpxY1gbm4LLU8XebPkvQUVg/r7/EhGY5ldLWZv1dvMmGwzUUqe1sbr3HxyzPWFTxFaw/eV8uWF77LM7/Sf2wVYoJqzEbsfDaL81TN/y4F1HYVSdYEByjsQYu63mVzXTBL765xj437Hb3giebRq0Gs/OhMOM50DabHS5ct3VIaae6QCxugStItk0uK+aXJDC2hgRgUqp8EEbtOs+mW3lWL+6TfGx8zdOLbGtEed9iBn5t3mihALBLwDfUyU0BPkLn1Nmj9owKZg3/pYmj2ua1Q14hXyKqD2PC9bMJ7rPuYjLhDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::51) by
 BN8NAM12HT197.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::385)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Sat, 9 May
 2020 01:34:44 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::49) by BN8NAM12FT019.mail.protection.outlook.com
 (2a01:111:e400:fc66::416) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Sat, 9 May 2020 01:34:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D3D0BD23F8AD38415164C897CD7B9247A5EB6F568E4DEB138FB449DB98DEBD0E;UpperCasedChecksum:059D37F2A3F4A1A387B49EDA450D39FF8E59769650961E57C50C8618236AF017;SizeAsReceived:7738;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 01:34:44 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] tty: serial: samsung: Correct clock selection logic
Date:   Fri,  8 May 2020 18:34:33 -0700
Message-ID: <BN6PR04MB06604E63833EA41837EBF77BA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:102:1::17) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200509013433.23152-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:102:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Sat, 9 May 2020 01:34:43 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200509013433.23152-1-xc-racer2@live.ca>
X-TMN:  [NN/Ci17XNAwKoNPXso5hxFZpP2g50cHt4TsXayU35974VRbh31XZ/ItSSL84vS+8]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 78b3340d-b96b-452d-59f6-08d7f3b926bc
X-MS-TrafficTypeDiagnostic: BN8NAM12HT197:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+Pmf+7X1j1nLgegg525J2+23iYcy2bhoHxH+EkC2ENEuS36A+dHlaKl+L/r2a5je2rG37sXbLxkR0w215OhBM0UKKp04P/s0wk3jwcy9hGo3M1Vge4l4nd5xjDKwqKhahvyoqrNBQ5M5b9dHXA4KfXbqT1bM1UOOpfNWTNeWOCOBshLsAXZlb9EYGUaOA76nZjJuun1WKmBTTQe2tW87Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: osNfQuONJHWs8koab4YCXiQIb3SnKhMK3W9431E2kJQRg+sFYCTBJJbSS+BrWYQwCVZN/+BEsywDEW5Bf/Dg8yq/4lOHipVOl0ZJ8eCrcWrH/z+zuzqateBKfPQLVNXhlFe9I6HHfFUumU3qoDh2nys89Ndyg6tH7szq/RW7yAf/LOn9UKRpv9xoLXr6AhG5E3eCcXnXno2nlNKa/mUQHw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b3340d-b96b-452d-59f6-08d7f3b926bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 01:34:44.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT197
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some variants of the samsung tty driver can pick which clock
to use for their baud rate generation.  In the DT conversion,
a default clock was selected to be used if a specific one wasn't
assigned and then a comparison of which clock rate worked better
was done.  Unfortunately, the comparison was implemented in such
a way that only the default clock was ever actually compared.
Fix this by iterating through all possible clocks, except when a
specific clock has already been picked via clk_sel (which is
only possible via board files).

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..9d2b4be44209 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1281,14 +1281,14 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 	struct s3c24xx_uart_info *info = ourport->info;
 	struct clk *clk;
 	unsigned long rate;
-	unsigned int cnt, baud, quot, clk_sel, best_quot = 0;
+	unsigned int cnt, baud, quot, best_quot = 0;
 	char clkname[MAX_CLK_NAME_LENGTH];
 	int calc_deviation, deviation = (1 << 30) - 1;
 
-	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
-			ourport->info->def_clk_sel;
 	for (cnt = 0; cnt < info->num_clks; cnt++) {
-		if (!(clk_sel & (1 << cnt)))
+		/* Keep selected clock if provided */
+		if (ourport->cfg->clk_sel &&
+			!(ourport->cfg->clk_sel & (1 << cnt)))
 			continue;
 
 		sprintf(clkname, "clk_uart_baud%d", cnt);
-- 
2.20.1

