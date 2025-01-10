Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B514A08E;
	Fri, 10 Jan 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494287; cv=none; b=F17zIPe3GBfEJYV3dRQhILfcqPlhw1c+/ll96vlHXuLNt7Vho75XIsptQ6hGw7Iu+kSaIZ9ZWUiobq4/hr4hbBzd+nPZgCHaeAb/3eaR3pLob+h+xTSZ6tJP1pKqWQheTL3fxS89jzMoGH+/576xYNK8GX1iMKP/lf2Kw932pSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494287; c=relaxed/simple;
	bh=Ar2rp2BY4xgYjEiaPKVkvF+xIeDRJqYb/u9PQ6wwuE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSx0RND9Fn5u6nH8fO8U2ZRH4PSuBP8+te0IEMO7ka1ytvYcs96Dp+JOE7jQbDOMjvVBaoCXaGfnRrRJqlhp78mlOL9GqkEUfxf73jri5uWvfqaq1ebrA71VvXoc9QoIbvuEW0zMccdN/xjqy1GULSDnPj+v26p38hLDSr483rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=culnParI; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="culnParI"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id E7DC59400101;
	Fri, 10 Jan 2025 08:31:23 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MOQdy3tHCIUP; Fri, 10 Jan 2025 08:31:23 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id BB6269400109;
	Fri, 10 Jan 2025 08:31:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com BB6269400109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736494283; bh=+5/EtE2IxqaBXW5nnyFfet9W6SYj7yFRk2JQ1bUVH10=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=culnParIG8MvHv2Ck5QqEKAw5t3pyrVpewPlw9KJeoVKd5HtNwRKRBiPivzLKMKn2
	 y78CJCuCCFxHztUlKbpqL15LFWe/nLGDbBlKqZtX2gkXOXosMm/D/rDS3CaFoXN+Sq
	 eVl5aXa54G4UP9UZmUdpGb1rTd6NdaFFiq5qkwM9unrxqqkqb0XROue3Kayf3Jn9Os
	 X5Rj6LJUXfTuxXiOCEsLuuVRwLFsggfULIzdpI+i9Go3HeehdbR7yhS6DTkDNrtsND
	 TUBqDTYpsU5fq0J4wTtWfqaPzFTjHNAAk0PrsNXYAopt7bxIlGBVJAJDP+J0EUsoXX
	 ATVMGM1eoZe5w==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jZYGOCdA_J5D; Fri, 10 Jan 2025 08:31:23 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 619ED9400101;
	Fri, 10 Jan 2025 08:31:23 +0100 (CET)
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
Subject: [PATCH v5 2/2] serial: sc16is7xx: Add polling mode if no IRQ pin is available
Date: Fri, 10 Jan 2025 08:31:04 +0100
Message-ID: <20250110073104.1029633-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110073104.1029633-1-andre.werner@systec-electronic.com>
References: <20250110073104.1029633-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fall back to polling mode if no interrupt is configured because there
is no possibility to connect the interrupt pin.
If "interrupts" property is missing in devicetree the driver
uses a delayed worker to pull the state of interrupt status registers.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
V2:
- Change warning for polling mode to debug log entry
- Correct typo: Resuse -> Reuse
- Format define with missing tabs for SC16IS7XX_POLL_PERIOD
- Format struct declaration sc16is7xx_one_config with missing tabs for po=
lling and shutdown
- Adapt dtbinding with new polling feature
V3:
- Use suffix with units and drop a comment SC16IS7XX_POLL_PERIOD_MS. Sorr=
y for that miss.
- Make Kernel lowercase.
V4:
- Reword commit messages for better understanding.
- Remove 'shutdown' property for canceling delayed worker.
- Rename worker function: sc16is7xx_transmission_poll -> sc16is7xx_poll_p=
roc
- Unify argument for worker functions: kthread_work *work -> kthread_work=
 *ws
V5:
- Replace of_property check with IRQ number check to set polling
  property. This will add support for usage without device tree
  definitions. Thanks for that advice.
- Add blank line es requested.
---
 drivers/tty/serial/sc16is7xx.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
index a3093e09309f..7b51cdc274fd 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -314,6 +314,7 @@
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_GPIOS_PER_BANK	4
=20
+#define SC16IS7XX_POLL_PERIOD_MS	10
 #define SC16IS7XX_RECONF_MD		BIT(0)
 #define SC16IS7XX_RECONF_IER		BIT(1)
 #define SC16IS7XX_RECONF_RS485		BIT(2)
@@ -348,6 +349,8 @@ struct sc16is7xx_port {
 	u8				mctrl_mask;
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
+	struct kthread_delayed_work	poll_work;
+	bool				polling;
 	struct sc16is7xx_one		p[];
 };
=20
@@ -861,6 +864,18 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_=
id)
 	return IRQ_HANDLED;
 }
=20
+static void sc16is7xx_poll_proc(struct kthread_work *ws)
+{
+	struct sc16is7xx_port *s =3D container_of(ws, struct sc16is7xx_port, po=
ll_work.work);
+
+	/* Reuse standard IRQ handler. Interrupt ID is unused in this context. =
*/
+	sc16is7xx_irq(0, s);
+
+	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
+	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
+}
+
 static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port =3D &(to_sc16is7xx_one(ws, tx_work)->port);
@@ -1149,6 +1164,7 @@ static int sc16is7xx_config_rs485(struct uart_port =
*port, struct ktermios *termi
 static int sc16is7xx_startup(struct uart_port *port)
 {
 	struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+	struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 	unsigned int val;
 	unsigned long flags;
=20
@@ -1211,6 +1227,10 @@ static int sc16is7xx_startup(struct uart_port *por=
t)
 	sc16is7xx_enable_ms(port);
 	uart_port_unlock_irqrestore(port, flags);
=20
+	if (s->polling)
+		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
+
 	return 0;
 }
=20
@@ -1232,6 +1252,9 @@ static void sc16is7xx_shutdown(struct uart_port *po=
rt)
=20
 	sc16is7xx_power(port, 0);
=20
+	if (s->polling)
+		kthread_cancel_delayed_work_sync(&s->poll_work);
+
 	kthread_flush_worker(&s->kworker);
 }
=20
@@ -1538,6 +1561,11 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
=20
+	s->polling =3D !!irq;
+	if (s->polling)
+		dev_dbg(dev,
+			"No interrupt pin definition, falling back to polling mode\n");
+
 	s->clk =3D devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
@@ -1665,6 +1693,12 @@ int sc16is7xx_probe(struct device *dev, const stru=
ct sc16is7xx_devtype *devtype,
 		goto out_ports;
 #endif
=20
+	if (s->polling) {
+		/* Initialize kernel thread for polling */
+		kthread_init_delayed_work(&s->poll_work, sc16is7xx_poll_proc);
+		return 0;
+	}
+
 	/*
 	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
 	 * If that succeeds, we can allow sharing the interrupt as well.
@@ -1724,6 +1758,9 @@ void sc16is7xx_remove(struct device *dev)
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
=20
+	if (s->polling)
+		kthread_cancel_delayed_work_sync(&s->poll_work);
+
 	kthread_flush_worker(&s->kworker);
 	kthread_stop(s->kworker_task);
=20
--=20
2.47.1

