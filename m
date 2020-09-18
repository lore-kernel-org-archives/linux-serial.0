Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37CC43466
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1DA23718
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395546;
	bh=sOCtSWmKPwPkZb6/PW0IcGF1QMutoq7hH15WnwEanmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epgQm3s4hSEFfst16Qi6OUFsO4zflLyFZjV+8gGHJ4D65a+GRzx4Cnr+CvhWyJQgU
	 ezj+eNXGcfmiDjIgQRevIUp9L7n9moL/8jo0BQlpTK0xYjzH6JtZy5GxDCOv6o/Wrk
	 AW5le5oPas9489ku8tDZdBTuFKrMKmXmGdb4mxTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgIRCRq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgIRCRq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Sep 2020 22:17:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD8C238A0;
        Fri, 18 Sep 2020 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395465;
        bh=sOCtSWmKPwPkZb6/PW0IcGF1QMutoq7hH15WnwEanmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDXY3ZGmJluT2C6ICan5oNUTWbWsSQzLB6GzzjPiU7AcP9yOmMKOkr1FrfmcvfzVN
         AhEeZeGkgqvFWcApxHv8G8XcWlc/HMGQp7cWsn8u/U8y8J6UCsw0JJY7RKvs6UnSCM
         ixlkhTs6jyFjLwn1x6SmGqInB0jbfTj0hc+vaoAQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 51/64] tty: serial: samsung: Correct clock selection logic
Date:   Thu, 17 Sep 2020 22:16:30 -0400
Message-Id: <20200918021643.2067895-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021643.2067895-1-sashal@kernel.org>
References: <20200918021643.2067895-1-sashal@kernel.org>
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
index 70a51d0bc6044..42aa37515e9bd 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1151,14 +1151,14 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
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

