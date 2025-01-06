Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C31BF58;
	Mon,  6 Jan 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153821; cv=none; b=fKI0Jq0C1mX5yL1t2eNW9Ak/jglwsFo2bMADYMrX/+mueEtbVn6s4vqPSg0v8UoZ2Co24iVYqeUg7xJxzjDJ69Jto+7GPzgp8hta6xthwhwL2ECnwnfc70/+e026kkP88VDdK/B3wcQEtwH1XQYrtghdks5U/YFpz433pe2I5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153821; c=relaxed/simple;
	bh=cKpf2ORv0kQoV99YNhzpYcKqV/wDBcgo9lNHipTmM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzshpRDYJ8Vgh7P7vVMxZe+9Wf/LJgjK8A3eLqMqLWvDJCsE1aJ8naJEpvCh9Qy+yu1M9piPlWNeMuhWFu8ZmxlgKRAYs86c3gr8ckjRA46CYTh/N9m49QEpjrvs8+oosHc15AqNoSW+YUcTTccjFmfykhnlNW1WZgofSd8TICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=PfMH/atc; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="PfMH/atc"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7BDA894016AD;
	Mon,  6 Jan 2025 09:50:56 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hKUDc7pI4xjm; Mon,  6 Jan 2025 09:50:56 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 56D1A94016B0;
	Mon,  6 Jan 2025 09:50:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 56D1A94016B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736153456; bh=vxb1rVCeUTokfbEKi9yjK8p2m0L76IHGFq60aPy8PmI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=PfMH/atcqdict55GGLq8WrpeSpgDMmEMQ2pvKjaxbCmBg5VFPPKKX/FmqRUTh9qXm
	 AqZME7YGMUDcozmcYwOiRDwTLpFt630sREUTgivYZ+XSkM1JDs7m8xFjnm054Tc66X
	 bjmyyDsv9DdwF7WodL1mKk2P9udonrWTDgx5NiSxIvaK6K3ElvXt8odKaDzWrN2Gcu
	 DySHh2zHzHw1QhIUvV2K0LE4DY+eEVtXKUpHkuPsuM8S+j6AuRfYznlY2/z1G1fLBs
	 Qc0xkwd3ohMzTWw3IjZ4HCo4KlwS6fQmtp6ESwRV8TFIDNu0VSZekIMIlo6mV3r+As
	 yRKYUXLskn8cA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TIY-CqYYayOm; Mon,  6 Jan 2025 09:50:56 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 0513294016AD;
	Mon,  6 Jan 2025 09:50:56 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2 2/2] serial: sc16is7xx: Add polling feature if no IRQ usage possible
Date: Mon,  6 Jan 2025 09:50:51 +0100
Message-ID: <20250106085051.50861-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106085051.50861-1-andre.werner@systec-electronic.com>
References: <20250106085051.50861-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fall back to polling mode if no interrupt is configured because not
possible. If "interrupts" property is missing in devicetree the driver
uses a delayed worker to pull state of interrupt status registers.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
V2:
- Change warning for polling mode to debug log entry
- Correct typo: Resuse -> Reuse
- Format define with missing tabs for SC16IS7XX_POLL_PERIOD
- Format struct declaration sc16is7xx_one_config with missing tabs for po=
lling and shutdown
- Adapt dtbinding with new polling feature
---
---
 drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
index a3093e09309f..cfe63fe8a729 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -314,6 +314,7 @@
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_GPIOS_PER_BANK	4
=20
+#define SC16IS7XX_POLL_PERIOD		10 /*ms*/
 #define SC16IS7XX_RECONF_MD		BIT(0)
 #define SC16IS7XX_RECONF_IER		BIT(1)
 #define SC16IS7XX_RECONF_RS485		BIT(2)
@@ -348,6 +349,9 @@ struct sc16is7xx_port {
 	u8				mctrl_mask;
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
+	struct kthread_delayed_work	poll_work;
+	bool				polling;
+	bool				shutdown;
 	struct sc16is7xx_one		p[];
 };
=20
@@ -861,6 +865,19 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_=
id)
 	return IRQ_HANDLED;
 }
=20
+static void sc16is7xx_transmission_poll(struct kthread_work *work)
+{
+	struct sc16is7xx_port *s =3D container_of(work, struct sc16is7xx_port, =
poll_work.work);
+
+	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. =
*/
+	sc16is7xx_irq(0, s);
+
+	/* setup delay based on SC16IS7XX_POLL_PERIOD */
+	if (!s->shutdown)
+		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
+}
+
 static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port =3D &(to_sc16is7xx_one(ws, tx_work)->port);
@@ -1149,6 +1166,7 @@ static int sc16is7xx_config_rs485(struct uart_port =
*port, struct ktermios *termi
 static int sc16is7xx_startup(struct uart_port *port)
 {
 	struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 	unsigned int val;
 	unsigned long flags;
=20
@@ -1210,6 +1228,11 @@ static int sc16is7xx_startup(struct uart_port *por=
t)
 	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_enable_ms(port);
 	uart_port_unlock_irqrestore(port, flags);
+	if (s->polling) {
+		s->shutdown =3D false;
+		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD));
+	}
=20
 	return 0;
 }
@@ -1232,6 +1255,10 @@ static void sc16is7xx_shutdown(struct uart_port *p=
ort)
=20
 	sc16is7xx_power(port, 0);
=20
+	if (s->polling) {
+		s->shutdown =3D true;
+		kthread_cancel_delayed_work_sync(&s->poll_work);
+	}
 	kthread_flush_worker(&s->kworker);
 }
=20
@@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
=20
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
+	s->polling =3D !device_property_present(dev, "interrupts");
=20
+	if (s->polling) {
+		dev_dbg(dev,
+			"No interrupt definition found. Falling back to polling mode.\n");
+		irq =3D 0;
+	}
 	s->clk =3D devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
@@ -1664,6 +1697,11 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
 	if (ret)
 		goto out_ports;
 #endif
+	if (s->polling) {
+		/* Initialize Kernel timer for polling */
+		kthread_init_delayed_work(&s->poll_work, sc16is7xx_transmission_poll);
+		return 0;
+	}
=20
 	/*
 	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
@@ -1724,6 +1762,8 @@ void sc16is7xx_remove(struct device *dev)
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
=20
+	if (s->polling)
+		kthread_cancel_delayed_work_sync(&s->poll_work);
 	kthread_flush_worker(&s->kworker);
 	kthread_stop(s->kworker_task);
=20
--=20
2.47.1

