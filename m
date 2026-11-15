Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794765774;
	b=rqrP1MJE5j2KVm9e6LeH+XpCTajP6IZAFa2pP0d2W5Z2tDfxbuNpXtkIYecm5EL4+ivV
	 vINY5SIR3iAySf5rACafywr9yHhIpyelDteyyimDYKYm6xvo5EmdZUz4gWztxqJnQG7yy
	 fHYtDDvkM4aSN2gp7aZDB6eR6Rg4L+BiV1G+Vcfcob9u/Ru8mzeIapaaDhY+h2Yc5Xeki
	 xMkAv1xz57++iMXoQf1no3lsURBViT6MVxiz0PFGIr6UXmI6zjCezJb6o1xuhGVauUluQ
	 SowsU8msHvvHPYxcboPoLGDeD93NAkbkVU7daKkAsa6q8otlvhUjU1IcIroLSKIz1Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765774;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q+b3u9B3rUlwvY8if6gmnakNtlb1aRyLJn1OsLsRjLc=;
	b=ibFfyX/1IRY76KkYT35tzv0yV9gpAltKOlZGbPaCfuX3RjPAHlK+DLhwmlRrAMLJVT+t
	 jNMsW4pZ2flg/BZfbbKlnr4gfu04WbPR2nUGk0AXlHemWbe3gc8GD1cqoQPDrk3OruF89
	 iW836aGe1FL41jTWnpfjkY14BbET95WkqtYmecHjXsZPHrMNlwWpvjwONI2J0jYIjq8EX
	 yllyMWKmHbJS7yF8qpKTu+l1LA4Xv8Wi6KqJg0yP0f38I2yjtL/qoCQzQTg3CH8m9nIt1
	 ctVciusvawjkO4zCIuO1+Afo7qSQgdTRA+ncfegk2/itlBXJWSbx9jsjJSxuppAbkFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A32P+OVT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69F606A329;
	Sun, 15 Nov 2026 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A32P+OVT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794765774;
	b=DW/4LD7xyFf4+1TdaltilNtF6N3SKloS6fVjIfsSYX0DzuRcxdRpFugQfCRnnxDeA2Bz
	 WJw5h6oRcdneDU1Nx9NQNRZzA7FSZjIJSCj3yT6NFfBglJ1AGjN2h3gtybgSaMn5T3NIj
	 6TNjDc1fO25sCDvKhf07sXkxsgMK2GE8P3W4aDLaHxqOaB9kBnzCU3ctuxct5HtyHE/aU
	 NZn/TzLUULayVPqEdkG2LdfaF/My1otD/TKvPlFgL4XhNvVdMTMPSisS0NAnC9va4Goxn
	 APduHqub7buRGBX63H2VjL1+GIgWLAEIMbETUZ4RpTzK6cB6EPd2wGMj6OBia7yBWFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794765774;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q+b3u9B3rUlwvY8if6gmnakNtlb1aRyLJn1OsLsRjLc=;
	b=oNP5NRVHb0g+H0QDMD8ZFhQ/m6QJ+J7iHj+EV7S2daOSj5EPGo+JQMbcL4JBlCT26Sbe
	 i9EBeR+30+Cac8rnGBPG4W6S6qHfAQBaKrDC5f9muPUvNG3PdX5BHnkMS4TZLje+LD5Io
	 sf6PNOHK/YkjKMQic/ovpHQSoF0R2fs8bkEEPa/WSKLDVujf0Jh+r5NyMCxiLuqQhcuNI
	 wkHyUYb7+HiRWb/OGcSfONnxil5FyYWIPi3Kuwd+xnKgH/Wp33iT0V4IJo0GzX/AVMfsE
	 eEPdxXLQPo9XPqHu9yyhB2k/xvgLIA4avglIDVLxAYCpP2FewrlNkBwp5M7sKweM/Aw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 415321F000C6;
	Sun, 15 Nov 2026 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794765774;
	bh=Q+b3u9B3rUlwvY8if6gmnakNtlb1aRyLJn1OsLsRjLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A32P+OVTnfIQEEbDTaA/f+YBe0T2uajEUqqdjn4tbdu3Y92BCAih3a6KefSNjTplH
	 8JY7zsTd3vJuWFpGvE32M5oSIEYECZ+mNcAQycoLHAS3uQUz+hPTtm6S+L95a7EOO5
	 JGw0SE1ujdsXI6nwBjrfuPVSszrHI2LPJ58e+ca22ORNNWwarir7qT6iYO8DLgbVox
	 JeisT45zW+i2avhMjGrhS4JDIcPplVrL7edQBBpN0/LPRsNtogF4ymvCrRuTfjRLiQ
	 lRu0VVpBW33zy+XFdZ3fOHoTeExMSz0iA5wh3kHmtxpXkMcrhwLz4dIJ4ALYsZiNcm
	 t9i2W9dI1sCmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C71614A139;
	Sun, 15 Nov 2026 18:02:52 +0000 (UTC)
From: Jonas Juffinger via B4 Relay <devnull+jonas.juffinger.liebherr.com@kernel.org>
Date: Sun, 15 Nov 2026 19:01:57 +0100
Subject: [PATCH 2/2] serial: fsl_lpuart: Enable DMA for TX in console mode
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-fsl_lpuart_8_bit_break_detection-v1-2-b7ac2307dd55@liebherr.com>
References: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
In-Reply-To: <20261115-fsl_lpuart_8_bit_break_detection-v1-0-b7ac2307dd55@liebherr.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 michael@walle.cc, sherry.sun@nxp.com, 
 Jonas Juffinger <jonas.juffinger@liebherr.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794765771; l=1112;
 i=jonas.juffinger@liebherr.com; s=20260615; h=from:subject:message-id;
 bh=zZRMKoyeC9YMN9R+VfYb8J2pz3w2Cn5KLcq4SMSFGqo=;
 b=ZrF0cygrknpH4jHd2y0FEXoyanAO02iZiHY6APb+nEpCl3hINnwKyED8EOcxFwYsC674YELSE
 x4bRmdzCd09C+sb7s3nq6jKvZFXv5GrPF4GsuX9u6mLvj1uggpvD7Pu
X-Developer-Key: i=jonas.juffinger@liebherr.com; a=ed25519;
 pk=57Vzs2aKTP3E7TDrBuZMQibGR+Koattc4oIhiMOs3FI=
X-Endpoint-Received: by B4 Relay for jonas.juffinger@liebherr.com/20260615
 with auth_id=821
X-Original-From: Jonas Juffinger <jonas.juffinger@liebherr.com>
Reply-To: jonas.juffinger@liebherr.com
Content-Transfer-Encoding: 7bit

From: Jonas Juffinger <jonas.juffinger@liebherr.com>

Remove the check that disabled TX DMA if the device is in console mode.

The reason for this check was that break detection cannot be efficiently
implemented with DMA. See commit 8cac2f6eb854 ("serial: fsl_lpuart:
disable DMA for console and fix sysrq").
However, break detection only affects the RX path, not the TX path.

The 8-bit LPUART hardware supports using DMA only for TX and not for RX.
I do not have a CPU with the 32-bit LPUART hardware to verify that this
change also work with the 32-bit LPUART. It probably does.

Signed-off-by: Jonas Juffinger <jonas.juffinger@liebherr.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5817c47e4db3..e569e2c6ffe9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1765,9 +1765,6 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 	u32 uartbaud;
 	int ret;
 
-	if (uart_console(&sport->port))
-		goto err;
-
 	if (!sport->dma_tx_chan)
 		goto err;
 

-- 
2.43.0


