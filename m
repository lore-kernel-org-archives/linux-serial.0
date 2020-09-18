Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D1C43464
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AA223730
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396884;
	bh=+P+U9mSFO151Sii+XC9R1Csq/D/2a2HmBrKt3rEpPxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KO25lBoOJrP/e8kBmcyV4CAIcxnMr4qfeWwVmzXJy12jk6oTsMzcnIM74BPY3E3vW
	 XPcqKYAkqfpWksBuxgOhma+7wVqjB2FoCInoUmJz4hfy+W9SxlFYJzpklnbz6qkYKB
	 lYfryTV1myGCb2iVJTevqwufhVGGVxP0NZcZvDZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgIRClV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgIRCLV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Sep 2020 22:11:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA22F208E4;
        Fri, 18 Sep 2020 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395080;
        bh=+P+U9mSFO151Sii+XC9R1Csq/D/2a2HmBrKt3rEpPxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1abwTGpm3s4PiGqkUPcN/x2ON7hPuwvimmZ0kOhgE+AhP0upTASM35nA1t1cIXwao
         PW5amRDz3wkg9/jlbp3EwnlWyKvNJ0IEhTI4cc9fBDS+iRh0x8Yzxfq5OA80RgCyKd
         Z95DvcZPb/Y1veK7V0SpzmH3hkHaw9SAagLz3VkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 163/206] tty: serial: samsung: Correct clock selection logic
Date:   Thu, 17 Sep 2020 22:07:19 -0400
Message-Id: <20200918020802.2065198-163-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit 7d31676a8d91dd18e08853efd1cb26961a38c6a6 ]

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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/BN6PR04MB06604E63833EA41837EBF77BA3A30@BN6PR04MB0660.namprd04.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index fcb89bf2524d1..1528a7ba2bf4d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1187,14 +1187,14 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
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
2.25.1

