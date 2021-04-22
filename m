Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A60C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C2B60551
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhDVM6t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:58:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVM6s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 08:58:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lZYuI-0000Mv-QL; Thu, 22 Apr 2021 12:58:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom-geni-se: remove redundant initialization to variable line
Date:   Thu, 22 Apr 2021 13:58:10 +0100
Message-Id: <20210422125810.248166-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable line being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 99375d99f6fa..c5f2a4fa2bb1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1338,7 +1338,7 @@ static const struct uart_ops qcom_geni_uart_pops = {
 static int qcom_geni_serial_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	int line = -1;
+	int line;
 	struct qcom_geni_serial_port *port;
 	struct uart_port *uport;
 	struct resource *res;
-- 
2.30.2

