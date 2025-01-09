Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C5A2B9BF;
	Thu,  9 Jan 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446865; cv=none; b=TTBTlyr/7g9BvGt4EMiD5g4XXN6qCiFFXMYaTRwVcxmqMTp8I68k4uu4gllWPuX5SRinB1RxrqBGtEVoYXN31DMw0zCSOoYekLvwr3fJLetgvbcF5ixD80cs+f8wfvN0bK7kywbFeIfpURR3PxW/aESprMWIS5SrkKyMUSe/t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446865; c=relaxed/simple;
	bh=9xwfGrDRwaeoWzpz2c3lczm4EQbVN++eHX5GPG7HIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3B7Yoiv2OmPqPVcHSL4GW79PW8yc5FV1sOSVH5MOPJ7lRUSAgElX/U49hRhPqHC2TbfEgIGsjvW2MGYsoDUqXf+keC4MF+GMPuKtlhuszvVCuvrmBSXrCgjTx33XrppL1d/+8t/SJ9b+UiOx+mWQw3O/n1vQKofZysMj7XDsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJOl/HMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJOl/HMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F100C4CED2;
	Thu,  9 Jan 2025 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736446864;
	bh=9xwfGrDRwaeoWzpz2c3lczm4EQbVN++eHX5GPG7HIKs=;
	h=From:To:Cc:Subject:Date:From;
	b=bJOl/HMUb5+w4YS7aU3Le6e2oW7qCBnI1L1Vrb1T5pd6CRVvrpFrWKJqxnatQRAmF
	 NIGiIKqOIV9E0UyqKn20cj4SNJDGkRD5shflAyatw9GbYUk0Mvr+1xlAzvRb3fDb9x
	 rsDB1+tEOiJWCkTph2m5XYaAEvOtwpd35+XtSSq6cfvc9ZUFLn3/WNwH1j2hHYjm0D
	 Mq/hUSY60kuIBdDbu4ZYbRN6q6wlc8hXeb3T24MI2SzvMiqQtwWPf+VuTe6KXKEV6i
	 WaFm0+wmBiT5bJkcBSQQQivtTXnzsXCOsSK5qO8Diqhei6FFod92FEKimnWS/MWNW3
	 jujhwvAL/ve2A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tty: atmel_serial: Use of_property_present() for non-boolean properties
Date: Thu,  9 Jan 2025 12:20:52 -0600
Message-ID: <20250109182053.3970547-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

As of_property_present() returns a boolean, use that directly
and simplify the code a bit while we're here.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0cf05ac18993..f44f9d20a974 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1727,26 +1727,16 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
 
 	/* DMA/PDC usage specification */
 	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
-		if (of_property_read_bool(np, "dmas")) {
-			atmel_port->use_dma_rx  = true;
-			atmel_port->use_pdc_rx  = false;
-		} else {
-			atmel_port->use_dma_rx  = false;
-			atmel_port->use_pdc_rx  = true;
-		}
+		atmel_port->use_dma_rx = of_property_present(np, "dmas");
+		atmel_port->use_pdc_rx = !atmel_port->use_dma_rx;
 	} else {
 		atmel_port->use_dma_rx  = false;
 		atmel_port->use_pdc_rx  = false;
 	}
 
 	if (of_property_read_bool(np, "atmel,use-dma-tx")) {
-		if (of_property_read_bool(np, "dmas")) {
-			atmel_port->use_dma_tx  = true;
-			atmel_port->use_pdc_tx  = false;
-		} else {
-			atmel_port->use_dma_tx  = false;
-			atmel_port->use_pdc_tx  = true;
-		}
+		atmel_port->use_dma_tx = of_property_present(np, "dmas");
+		atmel_port->use_pdc_tx = !atmel_port->use_dma_tx;
 	} else {
 		atmel_port->use_dma_tx  = false;
 		atmel_port->use_pdc_tx  = false;
-- 
2.45.2

