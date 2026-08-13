Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29E40B0EC;
	Thu, 13 Aug 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617319; cv=none; b=o8cw/rONngX0/BhBI2tqz6Hb/Hw04lCGwr6r3FX7KMAN1xkcb909Axb4uO5f+OZyMMAKifJc3vOoGOuESvUZDK1OGSwzBNbVt+K9kviCzGcLI6sz/TYrfgoQZMLh4qBmJg8yprZPSBDbKIwhI1oK4JUpEVdukxaS6l3OfKt7Hoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617319; c=relaxed/simple;
	bh=Qlg67X/kobKT+eFwxKXQ3z/kZm6+Os7ksYkYqj8PrC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8l/Op/XS/tlh/MuSTs7PeKOja3f4bfeHUIwA7e/C1Tf/xPHvM+jonI9RwVbW1L/2ilFU4FTyv8ZQQAjVSxoQ8zB1OZLdiopaGrP+PXmjnBhV61RZzDLgwrpk+7u2TbXTetR7TdqpnUpmzzmtqnckSPVfK2AFTtwzAXWtAAyJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND9WyMqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND9WyMqT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0F6CC2BCC7;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786617319;
	bh=Qlg67X/kobKT+eFwxKXQ3z/kZm6+Os7ksYkYqj8PrC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ND9WyMqTRSDeZHwZaTddaEDDBA9R+ak5Nl3GRnUJ3yLG1LOHn2tPRb95vrJD8eg0W
	 9QDL160Di98Q+48jqU+fbEt7Y09qZeV29BHaWF4/QjAfVhJh/vJmKK2CHMihW9I4HB
	 sGoWXdsvoSK6+uWo1nySTD2sKernWd2LmWnSTeRyN7oI9BUxHXCiuRk+T/9X1wGJk7
	 Yu1HGCxXXOcQgVCz3qkKFLQi5bkdQ8Jqt4S45PFwggYhorRPMsVHxTSRslHpUZoS8X
	 5OThNfCvTIcN+qxFpEybFSjFTQ86k+9OtNyAKFC1dfxPUU+UFqNpH32fi6mp13MO+3
	 EwHrYOt2uJ1Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214DC5DF66;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 13 Aug 2026 18:35:13 +0800
Subject: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
In-Reply-To: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617317; l=2923;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=XSAN/JBo4TbrQ7CY2sRl+6NMf5TA6SIWR2Keo4EKJvU=;
 b=gnaylrcPeuS6xs0Jkt0AkOlSBVkkbXmt/hrQO1Hz7xVQQFYFfCQVtrvAzSoOe3RDXxx3wzfmf
 wl+7jPs3iLPAeWrdL7qbYZ88UCnQXuePH5O6utAPzW3L3TiLGw880x4
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add CV75 platform data with an ETOI IER mask and skip-set-rate so the
DesignWare 8250 driver can drive the Ambarella UART for console use.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/tty/serial/8250/8250_dw.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..e8aa592924d4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -43,6 +43,9 @@
 #define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
+/* Ambarella specific register fields */
+#define AMBARELLA_UART_IER_ETOI		BIT(5)
+
 /* Quirks */
 #define DW_UART_QUIRK_OCTEON		BIT(0)
 #define DW_UART_QUIRK_ARMADA_38X	BIT(1)
@@ -60,6 +63,7 @@
 
 struct dw8250_platform_data {
 	u8 usr_reg;
+	u8 ier_mask;
 	u32 cpr_value;
 	unsigned int quirks;
 };
@@ -572,6 +576,23 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 	dw8250_writel_ext(up, RZN1_UART_RDMACR, val);
 }
 
+static int dw8250_ier_mask_startup(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = serial8250_do_startup(p);
+	if (ret)
+		return ret;
+
+	/* Keep variant-specific bits in the shadow across subsequent updates. */
+	up->ier |= d->pdata->ier_mask;
+	serial_port_out(p, UART_IER, up->ier);
+
+	return 0;
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	unsigned int quirks = data->pdata->quirks;
@@ -606,6 +627,8 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_in = dw8250_serial_in32;
 		data->uart_16550_compatible = true;
 	}
+	if (data->pdata->ier_mask)
+		p->startup = dw8250_ier_mask_startup;
 }
 
 static void dw8250_reset_control_assert(void *data)
@@ -879,6 +902,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
 	.quirks = DW_UART_QUIRK_IER_KICK,
 };
 
+static const struct dw8250_platform_data dw8250_ambarella_cv75_data = {
+	.usr_reg = DW_UART_USR,
+	.ier_mask = AMBARELLA_UART_IER_ETOI,
+	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
+};
+
 static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 	.usr_reg = DW_UART_USR,
 	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
@@ -889,6 +918,7 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 };
 
 static const struct of_device_id dw8250_of_match[] = {
+	{ .compatible = "ambarella,cv75-uart", .data = &dw8250_ambarella_cv75_data },
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },

-- 
2.34.1


