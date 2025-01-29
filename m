Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E91E25FF;
	Wed, 29 Jan 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169554; cv=none; b=i4KwO+Fc7e9DUkRdCEDb8gzSG0xezoDTWL8Pf5kolAKrquF3CjfJ0WzTDEMOOUKxavSPX6e41Xo1jF4DaOoyoXZ4h/P0StdVGWl848bK46JqnnhhDN7pCbJ8g9rOxyJ9qMXO9h0G3J4PP78qMFVCahYCU3X8Uj9smIqJhBwuIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169554; c=relaxed/simple;
	bh=NEZcXEKcNfK0D22Bwje0WD2wbRhNaJxAFpSiFUDyiFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+Xi3wWM3SBA4AIsUBodhRbVjjV08ucT6SqObUd0rnb51zwc/9Fh6zU1q6gF5JsP8Hm1OhZIpvq4Xmvgh8mFeR8H4StcVjt7TP4oDRgjyYT7WurQV6GStN0INbeyOU+cDGspSCWx7PTej2FxJqz3wVwQJLa2mOlbTqDj78kBfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: g9b1VeC9QeqO89iBSK4eHA==
X-CSE-MsgGUID: pz/FqopDTDC2N5YY+9oKmQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2025 01:52:32 +0900
Received: from wvbox.administration.lan (unknown [10.226.92.145])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A633402E096;
	Thu, 30 Jan 2025 01:52:29 +0900 (JST)
From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 10/14] serial: sh-sci: Introduced sci_of_data
Date: Wed, 29 Jan 2025 16:37:46 +0000
Message-ID: <20250129165122.2980-11-thierry.bultel.yh@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129165122.2980-1-thierry.bultel.yh@bp.renesas.com>
References: <20250129165122.2980-1-thierry.bultel.yh@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim here is to provide an easier support to more different SCI
controllers, like the RZ/T2H one.

The existing .data field of_sci_match is changed to a structure containing
all what that can be statically initialized, and avoid a call to
'sci_probe_regmap', in both 'sci_init_single', and 'early_console_setup'.

'sci_probe_regmap' is now assumed to be called in the only case where the
device description is from a board file instead of a dts.

In this way, there is no need to patch 'sci_probe_regmap' for adding new
SCI type, and also, the specific sci_port_params for a new SCI type can be
provided by an external file.

Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c        | 64 +++++++++++++++++++-----------
 drivers/tty/serial/sh-sci_common.h |  3 +-
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1b83a246c7ed..c58c0793c521 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2968,9 +2968,7 @@ static int sci_init_single(struct platform_device *dev,
 	int ret;
 
 	sci_port->cfg	= p;
-	sci_port->ops	= &sci_port_ops;
 
-	port->ops	= &sci_uart_ops;
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SH_SCI_CONSOLE);
@@ -3010,7 +3008,16 @@ static int sci_init_single(struct platform_device *dev,
 		for (i = 1; i < ARRAY_SIZE(sci_port->irqs); i++)
 			sci_port->irqs[i] = sci_port->irqs[0];
 
-	sci_port->params = sci_probe_regmap(p);
+	/*
+	 * sci_port->params params can be NULL when using a board file instead
+	 * of a dts.
+	 */
+	if (sci_port->params == NULL) {
+		sci_port->params = sci_probe_regmap(p);
+		if (unlikely(sci_port->params == NULL))
+			return -EINVAL;
+	}
+
 	if (unlikely(sci_port->params == NULL))
 		return -EINVAL;
 
@@ -3266,9 +3273,14 @@ static void sci_remove(struct platform_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 }
 
-#define SCI_OF_DATA(type, regtype)	(void *)((type) << 16 | (regtype))
-#define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
-#define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
+#define SCI_OF_DATA(_type, _regtype) (\
+&(struct sci_of_data) {\
+	.type = (_type), \
+	.regtype = (_regtype),\
+	.ops = &sci_port_ops,\
+	.uart_ops = &sci_uart_ops,\
+	.params = &sci_port_params[_regtype],\
+})
 
 static const struct of_device_id of_sci_match[] __maybe_unused = {
 	/* SoC-specific types */
@@ -3336,7 +3348,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	struct reset_control *rstc;
 	struct plat_sci_port *p;
 	struct sci_port *sp;
-	const void *data;
+	const struct sci_of_data *data;
 	int id, ret;
 
 	if (!IS_ENABLED(CONFIG_OF) || !np)
@@ -3382,8 +3394,12 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	sp = &sci_ports[id];
 	*dev_id = id;
 
-	p->type = SCI_OF_TYPE(data);
-	p->regtype = SCI_OF_REGTYPE(data);
+	p->type = data->type;
+	p->regtype = data->regtype;
+
+	sp->ops = data->ops;
+	sp->port.ops = data->uart_ops;
+	sp->params = data->params;
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
@@ -3562,19 +3578,23 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 static struct plat_sci_port port_cfg __initdata;
 
 int __init early_console_setup(struct earlycon_device *device,
-				      int type)
+			       const struct sci_of_data *data)
 {
 	const struct sci_common_regs *regs;
 
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->port.type = type;
+	device->port.type = data->type;
 	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
-	port_cfg.type = type;
+
+	port_cfg.type = data->type;
+	port_cfg.regtype = data->regtype;
+
 	sci_ports[0].cfg = &port_cfg;
-	sci_ports[0].ops = &sci_port_ops;
-	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_ports[0].params = data->params;
+	sci_ports[0].ops = data->ops;
+	sci_ports[0].port.ops = data->uart_ops;
 	regs = sci_ports[0].params->common_regs;
 
 	port_cfg.scscr = sci_ports[0].ops->read_reg(&sci_ports[0].port, regs->control);
@@ -3588,41 +3608,39 @@ int __init early_console_setup(struct earlycon_device *device,
 static int __init sci_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCI);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCI, SCIx_SCI_REGTYPE));
 }
 static int __init scif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIF);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE));
 }
 static int __init rzscifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	port_cfg.regtype = SCIx_RZ_SCIFA_REGTYPE;
-	return early_console_setup(device, PORT_SCIF);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE));
 }
 
 static int __init rzv2hscif_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
-	port_cfg.regtype = SCIx_RZV2H_SCIF_REGTYPE;
-	return early_console_setup(device, PORT_SCIF);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCIF, SCIx_RZV2H_SCIF_REGTYPE));
 }
 
 static int __init scifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIFA);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCIFA, SCIx_SCIFA_REGTYPE));
 }
 static int __init scifb_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIFB);
+	return early_console_setup(device, SCI_OF_DATA(PORT_SCIFB, SCIx_SCIFB_REGTYPE));
 }
 static int __init hscif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_HSCIF);
+	return early_console_setup(device, SCI_OF_DATA(PORT_HSCIF, SCIx_HSCIF_REGTYPE));
 }
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
diff --git a/drivers/tty/serial/sh-sci_common.h b/drivers/tty/serial/sh-sci_common.h
index cbfacdc1a836..f75c185079dd 100644
--- a/drivers/tty/serial/sh-sci_common.h
+++ b/drivers/tty/serial/sh-sci_common.h
@@ -172,7 +172,8 @@ extern void sci_flush_buffer(struct uart_port *port);
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-extern int __init early_console_setup(struct earlycon_device *device, int);
+extern int __init early_console_setup(struct earlycon_device *device,
+				      const struct sci_of_data *data);
 #endif
 
 #endif /* __SH_SCI_COMMON_H__ */
-- 
2.43.0

