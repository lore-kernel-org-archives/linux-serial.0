Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA134AAF2;
	Wed, 22 Apr 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874383; cv=none; b=p60IBQxDFJ75xLufxlO8j6CKzV2W8YjC6Q3lRkRqK4TRniTo3ZoGM+BeTOj+298u+H9q9id6gTYWpOc3WPJ2cj1GxD67nDO/l66NldHjcylwGJckEefpM89qK59kgAXpzYRXQ/EJ74YOrjekXcVoVqrgu4aeq870qfRqA2UWjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874383; c=relaxed/simple;
	bh=eJ0a36I7/j8FH5FHeOZEdq81Loo97lCpU4oi/Xdboy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WG8uXsLiUrMQnnMuJXkf1hu13MdxrAvL63fPIxVQpspTSkzoBuUZY5WhtUUs/fn9HmqSuLbbLblOutQGmwT1+30Fzfw2TDU8dbBHhxYghfLep89IJ5KtuDC1fkwKKV/mQpCWgAC/sRSCLngeOKXigLMgmKMTB7Kl6qwSiOxDsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8iZbJs2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8iZbJs2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2116C19425;
	Wed, 22 Apr 2026 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874382;
	bh=eJ0a36I7/j8FH5FHeOZEdq81Loo97lCpU4oi/Xdboy8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=q8iZbJs2Ez5eInbGV7KJ5mDvmwzgpkUpi1i8G7VXwrX55mteiuza+fgFfC9CIqewU
	 EHUtg1pRcChLCFRbxX9HsSbb/95rD0tQNTDYHWzMKibHmRIMC1X88c4wlBD1XOKGdu
	 3F6x6aF49iYIf/tSuUngTfkPN5zvrGNufQkfKPZpADL3AFZfnRz8/e/k+DCKnARkea
	 om2DbsH466rytnPjZT1LtyMjXx+uIblRcEPztjYHmpLuZ2G4AyJCBhS3Ly4tX/bQMg
	 ++itE15QjpmCr1CqE76fee6Qu4SpCFTGf0cuckd4WFCoh03mCH87u+b81mRd5Gv3e0
	 wkUdHUniT6fsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D9FA1FCE;
	Wed, 22 Apr 2026 16:13:02 +0000 (UTC)
From: Vynnie Von Diktus via B4 Relay <devnull+vyndiktus.gmail.com@kernel.org>
Date: Wed, 22 Apr 2026 16:13:03 +0000
Subject: [PATCH] tty: serial: qcom-geni: re-arm RX DMA on spurious
 zero-length interrupt
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260422-qcom-geni-uart-dma-rearm-v1-1-76d13aac7fdf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI7z6GkC/yXMQQrCMBBG4auUWTvQxlrEq4iLMflTR0iqk1aE0
 rsbdfkt3lupwBSFTs1KhpcWnXJFt2vI3ySPYA3V5Fo3tL1z/PRT4hFZeRGbOSRhg1hiOYR43KM
 b+hip5g9D1Pdvfb78XZbrHX7+/mjbPp6KJ8h8AAAA
X-Change-ID: 20260422-qcom-geni-uart-dma-rearm-a5df83e164ff
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vynnie Von Diktus <vyndiktus@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143;
 i=vyndiktus@gmail.com; h=from:subject:message-id;
 bh=UiY+149QujQXOfkQa2K1XQKMarABztpKQOeIf3A0aRM=;
 b=owGbwMvMwCXGn2Ym8lOG8SzjabUkhswXn/tVj31W5uhs5Qw90y1oNbOg4mPNm77tK7KffQ+Q5
 nzR0bW0o5SFQYyLQVZMkaXmSmfV/cQTbJY7ZiyAmcPKBDKEgYtTACZSk8jwhzs+b03joUNcAmvf
 un1JrX9yeEf0oReC76xM6njKxH/osjP84Tg4rZN3Suys4uQNk9Vknljbh9+PrjoZpSUpEZNawMv
 JBAA=
X-Developer-Key: i=vyndiktus@gmail.com; a=openpgp;
 fpr=7CD4897ADF61C80639B898A00F663614F91C01CD
X-Endpoint-Received: by B4 Relay for vyndiktus@gmail.com/default with
 auth_id=747
X-Original-From: Vynnie Von Diktus <vyndiktus@gmail.com>
Reply-To: vyndiktus@gmail.com

From: Vynnie Von Diktus <vyndiktus@gmail.com>

qcom_geni_serial_handle_rx_dma() returns early when SE_DMA_RX_LEN_IN
reads as zero, interpreting it as a spurious interrupt. The early return
skips geni_se_rx_dma_prep(), leaving the RX DMA descriptor permanently
unarmed. All subsequently received bytes are silently dropped until the
port is closed and reopened.

On cold boots, chip startup transients on the UART lines can produce a
genuine spurious DMA interrupt with a zero-length count. The bug is
invisible on warm reboots (the UART stays powered and stable, so no
spurious interrupt fires), which makes it appear as an intermittent
failure only on power-cycle reboots.

Fix by restructuring the zero-length check to fall through to
geni_se_rx_dma_prep() in all cases. Only the data processing
(handle_rx_uart) is skipped when no bytes arrived.

Tested on SM8150 (Snapdragon 855) with a WCN3990 BT UART — Bluetooth
firmware download now succeeds on every cold boot without
"Frame reassembly failed" errors.

The same GENI serial IP block is used across SDM845, SM8150, SM8250,
SM8350 and many other Snapdragon SoCs; the bug and fix are expected to
apply to all of them.

Signed-off-by: Vynnie Von Diktus <vyndiktus@gmail.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 69a632fef..3c950bdc0 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -837,11 +837,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
 	if (!rx_in) {
 		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	} else if (!drop) {
 		handle_rx_uart(uport, rx_in, drop);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,

---
base-commit: 4a8d8848356e9e4c41e22de9b1ef1507ea21734a
change-id: 20260422-qcom-geni-uart-dma-rearm-a5df83e164ff

Best regards,
--  
Vynnie Von Diktus <vyndiktus@gmail.com>


