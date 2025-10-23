Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C52C21C3
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232378; cv=none; b=hvRZFba+iuI6IOThtMOtuMhXlBNhVNABMoKGtXNLTSPwC+TkkX5GSlR6ZNrhJfBDM2Ww5qVUqnMB9ivDaYWEMw/3anTugrGAj6AKfPK4KNNx2mbT6fFsTN/bN3saqtUENVj4CU7gcOvc2cpHDf/n81u9EK5gtnsvTEHAPf49/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232378; c=relaxed/simple;
	bh=HMDinnSAGy7VN4P2zN25ugWN5tcVYjctCdfF6z9szFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apBSrTbORMCXxBiwLIYjSOBIamuJLcObIvAiPbiocqaeZj4gbDntJSjLftBvgYe5PHkBD8E3lA7/WrwIBlK5VT3A/EEL73q4L8LDvgsHcFuStvH0PryytfwxROQ33ReuWdwO0MzWG7RtXINzPr3knvCrsRZIwmcAgdQfjnA/g3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=HtX8wsrF; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="HtX8wsrF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yUMWBw0gIF3UCrPgiooIfCI63DNrcrDyPYGYM/WMVXM=; b=HtX8wsrFsKSwFcC3RMH/NgoaBI
	0etU0vjZVFyQ8rD5OoNI/kjVdmvvDAmT6aY2YC8MeSrH4zvuIJ0Ca1Yf2e7aZKiOj0oIBeAVMNXiT
	YcrrLSoZ5XqoIGRQ2SbZBP0SUklYeggK2E0R2PsarIzJnkvPK4By+Y89/ZK1LfV9yS/Y=;
Received: from 188-22-5-236.adsl.highway.telekom.at ([188.22.5.236] helo=hornet.engleder.at)
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vBwzZ-000000005xV-2hyX;
	Thu, 23 Oct 2025 17:12:45 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lukas@wunner.de,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v4 1/2] serial: Keep rs485 settings for devices without firmware node
Date: Thu, 23 Oct 2025 17:12:28 +0200
Message-Id: <20251023151229.11774-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251023151229.11774-1-gerhard@engleder-embedded.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
retrieves rs485 properties for 8250 drivers. These properties are read
from the firmware node of the device within uart_get_rs485_mode(). If the
firmware node does not exist, then the rs485 flags are still reset. Thus,
8250 driver cannot set rs485 flags to enable a defined rs485 mode during
driver loading. This is no problem so far, as no 8250 driver sets the
rs485 flags.

The default rs485 mode can also be set by firmware nodes. But for some
devices a firmware node does not exist. E.g., for a PCIe based serial
interface on x86 no device tree is available and the ACPI information of
the BIOS often cannot by modified. In this case it shall be possible,
that a driver works out of the box by setting a reasonable default rs485
mode.

If no firmware node exists, then it should be possible for the driver to
set a reasonable default rs485 mode. Therefore, reset rs485 flags only
if a firmware node exists.

Signed-off-by: Gerhard Engleder <eg@keba.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/serial_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4757293ece8c..70cac77cac61 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3536,6 +3536,14 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return 0;
 
+	/*
+	 * Retrieve properties only if a firmware node exists. If no firmware
+	 * node exists, then don't touch rs485 config and keep initial rs485
+	 * properties set by driver.
+	 */
+	if (!dev_fwnode(dev))
+		return 0;
+
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
 	if (!ret) {
-- 
2.39.5

