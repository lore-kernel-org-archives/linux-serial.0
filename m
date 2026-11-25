Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649501;
	b=skvMJNRCGDdDJXwYYuxGk7R0JSkpjlJcXqNGOfmPTqjU7SXHA7efrG5v+aCOJfFiktUi
	 mdXKSByzrmoqOYhqjuZ/UnfYliNSZLqrg4X8eGwfMgFsEyjfCle215QgTeN9q0z4si8a2
	 0Fd3/pqMGEBsyn/Znp2JIRr4NV+PbpVcJ/U9LtmmxyPr3mGfozgMP0WgDQDC8sPnnPfyP
	 AA4cP8n4UUiQsDbupu4zWKSaoLGMQdl90PsaNvTjoFqKzdKjfefPi4A4fjxA92iC12YER
	 A6gT/rFmpnjoB/hDlA7GLH2WaVdd6n+Y/3+hN3tCupEBUzs4iXGv3ftJY6apsWCOP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JKnAC/v/PE5Id4vZjvScRbgOEIeYezkg5HQc5ebkHqc=;
	b=tQPdIhnbtwuD3Em/YMQz5Wb1yIDGBkA6+K41wdJi/Dm62lPnCxMQcTocalWY9pPUwmab
	 2PfSS0fCykJg08uhyKH8CxcAF8aflIZYK0rbVxHLKQmhJoptvzOKkZnPqRndL4tdzjFBf
	 c+Enmt+C6cG55JCPuN8XEW1FJ6CWcEFqWn5t9KPzBbUFtxITywsz46D5xDerWjVZD6Hfi
	 cjd9CzDTypu91AjoNFQ1UTNiDtI5ZTgJyLLVk3AXejj7WpvC+ejFyEY+ff1op1mJcrQIT
	 1eC3EpcRiaoGuseIsAykmzP3/AmWDTTJmK3KkT7WFe2Jdvga6IfLQWAh/HD8e33W9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Uic/IL3O";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC1606A32A
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 23:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ABC1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uic/IL3O
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491846221ffso5492028f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649499; x=1796254299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKnAC/v/PE5Id4vZjvScRbgOEIeYezkg5HQc5ebkHqc=;
        b=Uic/IL3OYcJCF3ErHoq9kSyVfw0xGqQq4NuKPNIwtz/iisnqLAP3ebjNiV28ib1PKd
         Bt8MGWRBB2uNTXeWS6SPxuf7DHhqhaQ8hZZI+Kg/uuzkDC2UTDY6kX108rnGBf1Omiyx
         frhK5ZRCDQ64QeccyxSsIKs5GTFR1czynldvh1KTaKhtLG5k1DZCrSlBg6vAAD5XgaUG
         0bOGXc89zHMjs+T88OWCek/1k+AkleTCYELY3GY0KNcOnSCl+e5CuDsmBAhQ2DKY81th
         SKy3tfKICuqIbkSFODfgYs4B5gnpw/Jbpm07Ee9r/VpoazYXfXV5vF2AB4ohauK7nN5w
         029A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649499; x=1796254299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKnAC/v/PE5Id4vZjvScRbgOEIeYezkg5HQc5ebkHqc=;
        b=U2p8ihl5XB5eBRnkgCsvMqVgqXls14DqrwlzgAmvaSDilA5jMw3ulmy/YBayeft5q3
         g+o8ZOo7H8Irb4GO8rd28s61hAXzjK2cfNrxYauVnQuuQ9aRepF2bHxL7hnGIVOKdX/y
         oOSP1CDSNi8Tfg4fOx6+VWB8UzYcQ2OsYgHcar1d5Yd354EuXEiOyem9fIDQTSexgPnY
         YWrMtCSPiorL+hQhwifq+AKTfoiuTFUUtpdvS9JzXUGSz1EW/Sge/xjJnLtFJrHTQjbc
         t5xbzD8anvJmiQIvYhOJrfkrW+rwnO3VFqvHfILmTchpsLlwp/NLk/6ee/TjXwY87zxx
         U6Uw==
X-Forwarded-Encrypted: i=1; AL+hErHPEKKywm11tFeD6rDceurh8yujXlH4tgdei/lu4oet9KNFdQo2OzxqbVIYLJ8hDaU3W+Pd+CXqr8rH23s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZQjnn9waHPQy9Wo+ar9StJaIGLM5hXznREEyNn/jG8/z9LTJ7
	9PeRsmRjSMYxrAYQ3U3q2R4rl1xteRztkuXDSLYjWukvS5DBlLRVucAW
X-Gm-Gg: AZFdTZf7NImhNZ69uhouzGX9ENdxj+dzBJ/6/yxHiB7eYhoNQemtbO5qfuuoTrnRlOP
	czQrgWAemmrkRdHoQP92v+emDjKJzlhzAJSjary9wlSGyXAUYy4j9bKdDsFuaYBwrieyjRxBSxe
	OKUUVP6M5pkonmnKxa6D7GWxrFUmwZWlHdNg9iJo0zR5y9NBCYZ+9JUWPtlLtsoWYEMxoGPXpfH
	OAz8WDZmBEdxB3obb2jufArteeMk4Y0j/jwKjC9ZMdmQIK+p99aGywI01ljG/aRCHz2lKSU4jga
	gFO82p4F6vvOXobgsgVXCzRpJatx20NYOT26w4loJ4OWdL23aBLxfGc/35F8Z06//YdvWpDUZam
	5NWAVpxyNvoIep92QXNu65LTPPsQZk6pmvyxuEiGtvRVKYq4MRyAyL3YTXhwmeN0vmvi92PmYoB
	Fn4OQo9rr2v/eXFCpXjtXa2epG4HcXD/xCJ/YWBlHWONKSdJD2Ac/1me80IzXim9bSCuCyBo44B
	A0Rg+yoh56PE9AG85ldL9T+etE1dJbL5SR/ftlhmddgvJsCAVCeJ+Ln6D9zHumR4OEzVImhvn4u
	kHoBTsfZ2BCyiWDq7I876PIfXJ4RsVnZPcPVZ9SEl0heej6P4A0jSKImWrFjrEzi++OMWisWV9y
	GxBZjgF7aPg==
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id ffacd0b85a97d-4af75776767mr27523078f8f.5.1795649499471;
        Wed, 25 Nov 2026 15:31:39 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm38590936f8f.8.2026.11.25.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:31:39 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH RFC 12/19] serial: esp32: Rearm TX interrupts when the FIFO is full
Date: Wed, 25 Nov 2026 23:30:13 +0000
Message-ID: <20261125233020.1380594-13-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When transmission starts with a full FIFO, the driver can leave
queued data waiting with the TX interrupt disabled. Rearm the
interrupt whenever there is data ready to send, including a pending
high-priority character.

Hold the port lock in the TX interrupt handler as required by
uart_port_tx_limited().

Tested on a Waveshare ESP32-P4-Module-DEV-KIT. Verified that serial
output completed during SDMMC reads.

AI assisted with driver development.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 304e1345518b..002d6fdbd875 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -354,14 +354,14 @@ static void esp32_uart_transmit_buffer(struct uart_port *port)
 	unsigned int pending;
 	u8 ch;
 
-	if (tx_fifo_used >= ESP32_UART_TX_FIFO_SIZE)
-		return;
-
+	tx_fifo_used = min_t(u32, tx_fifo_used, ESP32_UART_TX_FIFO_SIZE);
 	pending = uart_port_tx_limited(port, ch,
 				       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
 				       true, esp32_uart_put_char(port, ch),
 				       ({}));
-	if (pending) {
+
+	/* Rearm TX even if the FIFO had no room for queued data. */
+	if (port->x_char || (pending && !uart_tx_stopped(port))) {
 		u32 int_ena;
 
 		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
@@ -372,7 +372,11 @@ static void esp32_uart_transmit_buffer(struct uart_port *port)
 
 static void esp32_uart_txint(struct uart_port *port)
 {
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
 	esp32_uart_transmit_buffer(port);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static irqreturn_t esp32_uart_int(int irq, void *dev_id)
-- 
2.56.1

