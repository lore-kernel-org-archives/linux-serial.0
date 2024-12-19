Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62D2206B1;
	Thu, 19 Dec 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598609; cv=none; b=AMX33rjG++JlT8aJujsY+jkn9hjsj4DxdhPuhQUKiA7dJVdocOQi7VOVFjr6x9LUko8T1yDuK+RYSFREH0SjHhRKCbXeomF6e0heVtFzBN619s15+w3c6kukhwkOMTEeMsU2eBp07eSpWHdg50kd094F9y7DniLS4luy+a4TiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598609; c=relaxed/simple;
	bh=3qX0PlxX/Bi6B6oCIzUVZwanJqmbkPARfeib8DqmQoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdCdBD6s7C23oWllCk3+GI8nwy7GKt2hRtDZcNo4Qa9JV8QK9cmv/FK+Wb9j0UlVNckL4GiFUcV9qlg60e4VHRdSD7Gkz8d57WxbWSGFYFO6IaVzuNGEGdB/wFQPmiXnaBHAgG8fPIEpLBCvCQkcq5hIoTNNqbtIpWtNWX/yk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=BJc802cZ; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="BJc802cZ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 8566994016B2;
	Thu, 19 Dec 2024 09:46:40 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LpPeq9G4SJgi; Thu, 19 Dec 2024 09:46:40 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 5FED994016B3;
	Thu, 19 Dec 2024 09:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 5FED994016B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1734598000; bh=vPL1a3op5VuHLSMViZIQN5Wr4BRq/ziCyRM7m1dbrPU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=BJc802cZMsKPSvBchrGGwe5gpylvYX9TgVjX3/90UlCe64vGprK1XsZtUzewrjOg9
	 P5tqsK10VDZsoXqNMHxVNf3u9pm52DVKaaktms1mODRa50PmElujUMbSxawyAia9F8
	 TVz5lvDo9rOVGALm0j8qmaESgbSI2BXWqDHF9pgaH7/nnounNlq1IinVjfX8LQ6+B8
	 DKlmKZLmVqsgGqLWzU2phir1Q0BmdCVXnR33hNuWgHipAmxWIvczGgDAIoqqUktTFE
	 /N8qAEmbD27vB0PFv+ICd68/Lq1JYPpDH0lQ+kKg79gOO7rzwcKjO7ErhISGMaQSMX
	 qyau6sgZ+RTFA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4ovNyPgVEC8X; Thu, 19 Dec 2024 09:46:40 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 1897C94016B2;
	Thu, 19 Dec 2024 09:46:40 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH] serial: sc16is7xx: Add polling feature if no IRQ usage possible
Date: Thu, 19 Dec 2024 09:46:38 +0100
Message-ID: <20241219084638.960253-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.47.1
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
This driver was tested on Linux 5.10. We had a custom board that was not
able to connect the interrupt port. Only I2C was available.
---
---
 drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
index a3093e09309f..31962fdca178 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -314,6 +314,7 @@
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_GPIOS_PER_BANK	4
=20
+#define SC16IS7XX_POLL_PERIOD 10 /*ms*/
 #define SC16IS7XX_RECONF_MD		BIT(0)
 #define SC16IS7XX_RECONF_IER		BIT(1)
 #define SC16IS7XX_RECONF_RS485		BIT(2)
@@ -348,6 +349,9 @@ struct sc16is7xx_port {
 	u8				mctrl_mask;
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
+	struct kthread_delayed_work	poll_work;
+	bool polling;
+	bool shutdown;
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
+	/* Resuse standard IRQ handler. Interrupt ID is unused in this context.=
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
+		dev_warn(dev,
+			 "No interrupt definition found. Falling back to polling mode.\n");
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

