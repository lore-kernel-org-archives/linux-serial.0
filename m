Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFE305074
	for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472123; cv=none; b=CGeuB25wH+St0Zx3gRlLvHMAzABS+CWf91Ipw8P285jyC65gsHTNu5mgiOlkmRXHW4Zfl0JDlE+/3o6GqN2yqcrduA/LroBwioKGLDxmjFpZYY0EAm4G9EgMgX3ulz3Eu9uN1aD2v1yUiGLhtLJcCwn3h4hJqRGUZL4DN5dXduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472123; c=relaxed/simple;
	bh=uV/hadbRnLetidt2wjJJsmJNjTzplK6vK7rpOT1LSLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTFPK0gTJVFB0ZdDvlHS35YVsJ81+Sh/wZNYvCWWEfPHEaK/QKbEhpINgEs2xGa9mTsLO1zKTGx2m8CfRUzuOIPqTpXpxsSMdWzUp4L4WixJR8Basz77Qp7FM1NGW85UUBYaGL+HqLkc+K64rSNLMyZfqotZcK1b9+utfP4DOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=e5D5Uoyp; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="e5D5Uoyp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=82E5A0LX1Pcz4kbvYzstEkQyikSHbuUOjDNdYtFO/F8=; b=e5D5UoypVqP2yr99SVWV6i3adx
	WOSmQRNJPwiPhxALOQ7pNHjlHeFBGKj/pWKBPDbLnsO3KYM1Sriff4UYoKCTto3X25W7/7XxqoRbn
	YQVzeIN1vx3IziCljIIX1JrgkJ12omg2ezTVF0k3hE/TXJDwvIe+o1LYVgfbAkbhpboU=;
Received: from 93-82-65-102.adsl.highway.telekom.at ([93.82.65.102] helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v8kUa-000000008Dg-2Ni4;
	Tue, 14 Oct 2025 21:15:29 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/2] serial: Keep rs485 settings for devices without firmware node
Date: Tue, 14 Oct 2025 21:15:14 +0200
Message-Id: <20251014191515.75888-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251014191515.75888-1-gerhard@engleder-embedded.com>
References: <20251014191515.75888-1-gerhard@engleder-embedded.com>
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
from the firmware node of the device. If the firmware node does not
exist, then the rs485 flags are still reset. Thus, 8250 driver cannot
set rs485 flags to enable a defined rs485 mode during driver loading.
This is no problem so far, as no 8250 driver sets the rs485 flags.

If no firmware node exist, then it should be possible for the driver to
set a reasonable default rs485 mode. Therefore, reset rs485 flags only
if a firmware node exists.

Signed-off-by: Gerhard Engleder <eg@keba.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/tty/serial/serial_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4757293ece8c..366101f85048 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3533,7 +3533,13 @@ int uart_get_rs485_mode(struct uart_port *port)
 	u32 rs485_delay[2];
 	int ret;
 
-	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
+	/*
+	 * Retrieve properties only if rs485 is supported and if a firmware node
+	 * exist. If no firmware node exist, then don't touch rs485 config and
+	 * keep initial rs485 properties set by driver.
+	 */
+	if (!(port->rs485_supported.flags & SER_RS485_ENABLED) ||
+	    !dev_fwnode(dev))
 		return 0;
 
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
-- 
2.39.5

