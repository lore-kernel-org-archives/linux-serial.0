Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B0C43334
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 00:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiF2ACo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiF2ACn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 20:02:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F46137A1F;
        Tue, 28 Jun 2022 17:02:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EABA153B;
        Tue, 28 Jun 2022 17:02:42 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8A173F792;
        Tue, 28 Jun 2022 17:02:41 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-serial@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/2] Revert "serial: 8250: dw: Move the USR register to pdata"
Date:   Tue, 28 Jun 2022 19:02:31 -0500
Message-Id: <20220629000232.3440704-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629000232.3440704-1-jeremy.linton@arm.com>
References: <20220629000232.3440704-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pdata is only setup by DT machines, leaving ACPI machines
with null pdata. Since I don't know the exact mapping of
ACPI ID's to dw 8250 variations I can't add pdata to them
without possibly breaking something. As such the simplest
fix here is probably just to revert this commit.

This reverts commit ffd381445eac2aa624e49bab5a811451e8351008.
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 9 +++------
 drivers/tty/serial/8250/8250_dwlib.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..53e488beb8c2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -275,7 +275,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR */
-		(void)p->serial_in(p, d->pdata->usr_reg);
+		(void)p->serial_in(p, d->usr_reg);
 
 		return 1;
 	}
@@ -447,6 +447,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			p->serial_out = dw8250_serial_outq;
 			p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 			p->type = PORT_OCTEON;
+			data->usr_reg = OCTEON_UART_USR;
 			data->skip_autocfg = true;
 		}
 #endif
@@ -536,6 +537,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->data.dma.fn = dw8250_fallback_dma_filter;
+	data->usr_reg = DW_UART_USR;
 	data->pdata = device_get_match_data(p->dev);
 	p->private_data = &data->data;
 
@@ -738,27 +740,22 @@ static const struct dev_pm_ops dw8250_pm_ops = {
 };
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
-	.usr_reg = DW_UART_USR,
 };
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
-	.usr_reg = OCTEON_UART_USR,
 	.quirks = DW_UART_QUIRK_OCTEON,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {
-	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_ARMADA_38X,
 };
 
 static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
-	.usr_reg = DW_UART_USR,
 	.cpr_val = 0x00012f32,
 	.quirks = DW_UART_QUIRK_IS_DMA_FC,
 };
 
 static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
-	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 055bfdc87985..9870ad0d54e4 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -26,7 +26,6 @@ struct dw8250_port_data {
 };
 
 struct dw8250_platform_data {
-	u8 usr_reg;
 	u32 cpr_val;
 	unsigned int quirks;
 };
@@ -35,6 +34,7 @@ struct dw8250_data {
 	struct dw8250_port_data	data;
 	const struct dw8250_platform_data *pdata;
 
+	u8			usr_reg;
 	int			msr_mask_on;
 	int			msr_mask_off;
 	struct clk		*clk;
-- 
2.35.1

