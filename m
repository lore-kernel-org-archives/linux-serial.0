Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DD13635C;
	Mon, 16 Mar 2026 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773642815; cv=none; b=AIQ33kmfPslA5frbIC46FrxZmahHh73RVFSUPbQIefWsCfXC1e8ruw7TVF0w+5L1OLoMTGY2fKVytFI3OCCiuZ2msBMgNNO/SBERaQ7/kM4o/PJu2erPoeEVG9baQ/7cAKgbirwh8lCOVwTOmrwe92FNDtpeEAQ94Lq8Q1yzNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773642815; c=relaxed/simple;
	bh=/cBRAudR782PfI6JZqOVzrGeBpkRDlrf5iNN8lqsEyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmfobSQFR2ZgdvehCOCC3dbo2uJjbOu0aBXbbYYG8Zo995sbOLLdDdlV3Qm+K0M22pHci5BPCQe0UNWFXU12l4S4FdHFDOtiNwWV/J1lYn38/csXL+xfH0/oct20B1s3ART/IGsXWynTHGVgiQ11/kg0Tc+nM46OYzN0vUFCF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kamfbimK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kamfbimK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71524C2BCAF;
	Mon, 16 Mar 2026 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773642815;
	bh=/cBRAudR782PfI6JZqOVzrGeBpkRDlrf5iNN8lqsEyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kamfbimK8WbBFJvpa9J4Mv6xtNo8mTh14NWAPg4Kf6ivrOcIdkH3MeiQIS3qvTOQE
	 YpnbosRb4+KI5gYXZUOnIAdNkM+marUjK6HiIyAjSGLDqXm5BUTPmRr+QMjCwnOxIw
	 v9YA6J5RiXqXwV3fXaYHGc/XZz0+WfMGEPs0ns9lp0eRSeuvxDFDVawcbxnz/hfbeI
	 0VyysXFMvQTEIdJojs9m9hOw6CDFYUPVbX3K2mU8Scks7VvP63VME++i5SypZdHZbO
	 2qjqrgAUWymv90Y7iXs2NACzlb6/UwY7Lx5NhEUNkjMTfzHyLnBy+4CU0zVXHX14yo
	 JLsqvqIGDh3RA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63775EFCBBB;
	Mon, 16 Mar 2026 06:33:35 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 16 Mar 2026 14:33:23 +0800
Subject: [PATCH v2 2/2] riscv: ultrarisc: 8250_dw: support DP1000 uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-ultrarisc-serial-v2-2-6ab3e7fa891c@ultrarisc.com>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
In-Reply-To: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>, 
 Zhang Xincheng <zhangxincheng@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773642814; l=2191;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=gRRSp55pRniZyx6sAoUvfL+vjmmUJve5ICYBYJttQq0=;
 b=lE6icoO2hEHbQKWQ48OM1Kw9YZjvib5LhszrMykHhbDQX2zTvBfTYY30YIYexqWCM0knHf563
 EmfvFVXAzMeBO74xu2ActGmCwxHWYHjEe8MkxIad730zdn+FOFn4xUH
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260309 with
 auth_id=682
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Zhang Xincheng <zhangxincheng@ultrarisc.com>

The UART of DP1000 does not support automatic detection of
buffer size. skip_autocfg needs to be set to true

Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/tty/serial/8250/8250_dw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index db73b2ae17fa..6a2acf173331 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -56,6 +56,7 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_FIXED_TYPE	BIT(6)
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -514,6 +515,11 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		data->data.dma.prepare_tx_dma = dw8250_prepare_tx_dma;
 		data->data.dma.prepare_rx_dma = dw8250_prepare_rx_dma;
 	}
+	if (quirks & DW_UART_QUIRK_FIXED_TYPE) {
+		p->flags |= UPF_FIXED_TYPE;
+		p->type = PORT_16550A;
+		data->skip_autocfg = true;
+	}
 	if (quirks & DW_UART_QUIRK_APMC0D08) {
 		p->iotype = UPIO_MEM32;
 		p->regshift = 2;
@@ -789,6 +795,11 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
+static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_FIXED_TYPE,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -796,6 +807,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
 	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
 	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);

-- 
2.34.1


