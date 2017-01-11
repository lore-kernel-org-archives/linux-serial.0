From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 18/18] serial: sh-sci: Compute the regshift value for SCI ports
Date: Wed, 11 Jan 2017 16:43:40 +0200
Message-ID: <20170111144340.29074-19-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

SCI instances found in SH SoCs have different spacing between registers
depending on the SoC. The platform data contains a regshift field that
tells the driver by how many bits to shift the register offset to
compute its address. We can compute the regshift value automatically
based on the memory resource size, there's no need to pass the value
through platform data.

Fix the sh7750 SCI and sh7760 SIM port memory resources length to ensure
proper computation of the regshift value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |  1 -
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |  3 +--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c | 10 ++++++++--
 drivers/tty/serial/sh-sci.c           |  8 +++++++-
 include/linux/serial_sci.h            |  1 -
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 592cd9ab30c4..59a88611df55 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -111,7 +111,6 @@ static struct platform_device rtc_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
-	.regshift	= 1,
 };
 
 static struct resource scif0_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index d98a55416306..57d30689204d 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -39,11 +39,10 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port sci_platform_data = {
 	.type		= PORT_SCI,
-	.regshift	= 2,
 };
 
 static struct resource sci_resources[] = {
-	DEFINE_RES_MEM(0xffe00000, 0x100),
+	DEFINE_RES_MEM(0xffe00000, 0x20),
 	DEFINE_RES_IRQ(evt2irq(0x4e0)),
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 0c0cdfc69dcc..e51fe1734e13 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -200,12 +200,18 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
+	/*
+	 * This is actually a SIM card module serial port, based on an SCI with
+	 * additional registers. The sh-sci driver doesn't support the SIM port
+	 * type, declare it as a SCI. Don't declare the additional registers in
+	 * the memory resource or the driver will compute an incorrect regshift
+	 * value.
+	 */
 	.type		= PORT_SCI,
-	.regshift	= 2,
 };
 
 static struct resource scif3_resources[] = {
-	DEFINE_RES_MEM(0xfe480000, 0x100),
+	DEFINE_RES_MEM(0xfe480000, 0x10),
 	DEFINE_RES_IRQ(evt2irq(0xc00)),
 	DEFINE_RES_IRQ(evt2irq(0xc20)),
 	DEFINE_RES_IRQ(evt2irq(0xc40)),
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7906255b097c..fbffe89b493f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2572,9 +2572,15 @@ static int sci_init_single(struct platform_device *dev,
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
-	port->regshift		= p->regshift;
 	port->fifosize		= sci_port->params->fifosize;
 
+	if (port->type == PORT_SCI) {
+		if (sci_port->reg_size >= 0x20)
+			port->regshift = 2;
+		else
+			port->regshift = 1;
+	}
+
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
 	 * for the multi-IRQ ports, which is where we are primarily
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index f9a4526f4ec5..e598eaef3962 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -56,7 +56,6 @@ struct plat_sci_port {
 	/*
 	 * Platform overrides if necessary, defaults otherwise.
 	 */
-	unsigned char	regshift;
 	unsigned char	regtype;
 
 	struct plat_sci_port_ops	*ops;
-- 
Regards,

Laurent Pinchart

