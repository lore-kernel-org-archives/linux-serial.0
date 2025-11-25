Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC515326D5C
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083200; cv=none; b=RWv/J8GNP+Suk0h3q6zobK+q25CCxgMtikhPq1QyK0JTNxtLSvGEEkhppv4McQtMx76B72WpnHKruR75mDxqqhc6mEf+k+Rs6FhXqOQ5XCSrJ14F88EWE1yFbY40FALEx/cUZiJSd6hW0sXpjwo2EQTpshu94bf0Tl8W5Dhp+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083200; c=relaxed/simple;
	bh=Nh3Ty6TiX7FCEIz6ikF19spmIxiE8SBKU0CTyBwe/s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R992hKyXxfPtJ96VZoDRPaZimD3dQlEa2W6V/8K3O0IVlTjAR2Zk1QVUd4CWe4+HXPpb24L7ANJi69y+WjxUPUQdMQDVpa72sENnY+vzWgqENo5xp5Y+tFdfdSApxjUqkoVV4YtkN8XYn9bGLZ6QB0ki3lGhGdX7rn1tx7vbL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KITUXPaA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KITUXPaA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso35089485e9.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083197; x=1764687997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsvzpDdHuaCCHjJpYBsgV96uU86b6iPp7/i436ekO/M=;
        b=KITUXPaAPaNEjZuoZ9vUCvYuqHolUJJqjZI/47FnxXC+Ecl/tBc/RPSMEzm4eAVHKq
         jSWTfQ6kt8kMYIByk96Fb6b04yJsd3jvOq4aCCJnUMW/t2owUa3ubP4zcZMAtzS6l0pW
         ET9fvxoB6E+Jx4btB/otiTfhm9Q2TLK4gk7x/iZBv+yqXyquH+64H6uicpC8M9j6kYPA
         LmKlPdJXZXfT23ktaUtLtTqmC/Uq0zQg7sC+5XopPU1s4Y8WB9dX0aqeDJTxDzca7Qxj
         SuTAOHNkFx7L/dyxAB4sRx20a+xBE7bN7+o7z8uF5D7vUArfQQTNdcukuycMTq7s8vbE
         1F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083197; x=1764687997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LsvzpDdHuaCCHjJpYBsgV96uU86b6iPp7/i436ekO/M=;
        b=mdheBWjMfvXJid4IDVX04wrM9G0l9xKk+weVgpB628toh+bImqDj3iq7S5DGys0OD3
         jCH4ANuU7lUK1gQQljjhjLkv2InJoYANrHqO88lQ7PPGspzp+LH8GzMb/OMnaanNDY6t
         Ce5VsAqeFAFzpKvjSd9+wo1TwZi7dtZVGy09wC8qYPJloa+n8ZqCRisx1wLX/omWDok3
         5Pm503yhxh3WPyxECaKRgElyeqtGizPpVfP6Qxgb2nPetT9OHRcDmG8cjgyLdhTDnSgc
         yHr2hNOOWE54z02Qbkk4v++otYp39sQScOtANxx2Yi9M5yRmj9AgWoZ8VMVhZz6UCMXX
         SMnA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxmxreXvA7lUcDgztOA+ErUlr07KiBTvJRbdcFTYpvBZ09RYaeVs/cimveOO6iP2C/g8eDVIu9wpP82M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKuqP/Ee3xMBKJ9lwKVWcXOfeVS9RYS1hXaLpiYUmXkAUbivJ
	wHLtwtReKzCzTNW3WocFQ+Y4FUNYB7yDhMQZdV7hl9iVJTmRU9+7E09/
X-Gm-Gg: ASbGnctqYigMi7ziqF23HGQctXASD9TDIjzXvv598TbDppJWAcN0sR8smZiQRDdf91h
	JMdpD3fkBj6Sy2tzZCBD9PqNnOwXzlZpwcq5sin9fr7VLsZwYNTV5GODLWScw3Q/b9DgT2UuDkS
	LU1q987fezrXb6lU8f5uBgHno4xcKq2uo1S4oHvWqmNqlE5icIdUJLDNenEGYDw+B/uoxxPHuKM
	lZd/RvqNXXaevlswrNZJ3iCoVQuDteIxgEhZH1s3AaONhQrVbngWoTqZRWSrwrGWREkCa4ljTF7
	aj6aG/pThPX/50j+JFOrzTUGirxrP89NbC4xB3MB5tVa1u3t3stWqb5AT21pi9FT8nJWYoJ2W8O
	3W2Jc7dOdBxsPBYCEiYuRrgKbjw1rqDb6UsXwCwhmDsHFwQYm3NMAEbLfRXD2339c+zWZ1054yj
	upTgYLVfk32yci1eid+dWy92eQgbUiGe1SfwCgS38LGAIg3Ab6iNxgD0JyuKNPNFj23KJS2P27g
	Q==
X-Google-Smtp-Source: AGHT+IGQ2lrJjpd5A0Bi98GjwpO8U0bS/285r/RkgU2XPW9IQYDqpZ5dHzIRnpjdKjTjaKMviAxfTA==
X-Received: by 2002:a05:6000:2508:b0:42b:39ee:2855 with SMTP id ffacd0b85a97d-42cba6528a2mr21269154f8f.8.1764083196944;
        Tue, 25 Nov 2025 07:06:36 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 02/16] serial: sh-sci: Add sci_is_fifo_type()
Date: Tue, 25 Nov 2025 15:06:04 +0000
Message-ID: <20251125150632.299890-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add sci_is_fifo_type() helper for SCI operates in FIFO mode to
simplify the code in probe() and remove().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4:
 * New patch.
---
 drivers/tty/serial/sh-sci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 53edbf1d8963..56d6489b2a7c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3546,6 +3546,12 @@ static struct uart_driver sci_uart_driver = {
 	.cons		= SCI_CONSOLE,
 };
 
+static bool sci_is_fifo_type(u8 type)
+{
+	return (type == PORT_SCIFA || type == PORT_SCIFB ||
+		type == PORT_HSCIF || type == SCI_PORT_RSCI);
+}
+
 static void sci_remove(struct platform_device *dev)
 {
 	struct sci_port *s = platform_get_drvdata(dev);
@@ -3556,8 +3562,7 @@ static void sci_remove(struct platform_device *dev)
 
 	if (s->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
-	    type == SCI_PORT_RSCI)
+	if (sci_is_fifo_type(type))
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 }
 
@@ -3918,8 +3923,7 @@ static int sci_probe(struct platform_device *dev)
 		if (ret)
 			return ret;
 	}
-	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
-	    sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
+	if (sci_is_fifo_type(sp->type)) {
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			if (sp->port.fifosize > 1) {
-- 
2.43.0

