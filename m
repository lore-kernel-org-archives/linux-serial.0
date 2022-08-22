Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB9C28D13
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 12:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiHVMHX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiHVMHW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 08:07:22 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750339BBC;
        Mon, 22 Aug 2022 05:07:21 -0700 (PDT)
X-QQ-mid: bizesmtp89t1661170001txl6mzdn
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:06:39 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: CR3LFp2JE4m1XgG8B6AP/kJtqaE0mJj6j7qwJI03u6WS7tx5jEQ2pm9PxITr5
        rbUSKzKwoz9OWwCOsRVzPKH36fxal0QFN/sqdebBghyMp1Bp+Kj3R5km95KemhjB6U/boD/
        UQBRkll3ZbAylv4awr24cisZa8GpgLqEiv7wTa3Ewg+phDdDL91k4p44Q5gV+1y99j1e4Mb
        wi503zQyMBObcvvSDnpXSCWTPmCucWpDIa72G4+/TId8GNoVgWtPXxgrXm+seJCedOSU2Cc
        Ykfta4mlJxUp6aNoX7MDEZaLSLOWI8Fp4lRdcX7snQGoiRyUmsdVuSdQaWCftUskXNuEqJg
        P7XjUtycrAEI7o4gS1P0WeDP22/3cOWX7LAop5wo6Xr/hJ9AOwnL2bwUunLdQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] tty/seria: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:06:33 +0800
Message-Id: <20220822120633.16753-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

 Delete the redundant word 'as'.
 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 drivers/tty/serial/kgdboc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0d6e62f6bb07..fff4fa8d73ca 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2787,7 +2787,7 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
 		 * EDMA driver during suspend will forcefully release any
 		 * non-idle DMA channels. If port wakeup is enabled or if port
 		 * is console port or 'no_console_suspend' is set the Rx DMA
-		 * cannot resume as as expected, hence gracefully release the
+		 * cannot resume as expected, hence gracefully release the
 		 * Rx DMA path before suspend and start Rx DMA path on resume.
 		 */
 		if (irq_wake) {
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 79b7db8580e0..a471fc132acb 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -343,7 +343,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	 * Configure with the new params as long as init already ran.
 	 * Note that we can get called before init if someone loads us
 	 * with "modprobe kgdboc kgdboc=..." or if they happen to use the
-	 * the odd syntax of "kgdboc.kgdboc=..." on the kernel command.
+	 * odd syntax of "kgdboc.kgdboc=..." on the kernel command.
 	 */
 	if (configured >= 0)
 		ret = configure_kgdboc();
-- 
2.36.1

