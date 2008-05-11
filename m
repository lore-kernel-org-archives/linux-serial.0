From: Michal Simek <monstr@seznam.cz>
Subject: Uartlite driver
Date: Sun, 11 May 2008 16:01:12 +0200
Message-ID: <4826FC28.4090701@seznam.cz>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:63393 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108AbYEKOGx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 May 2008 10:06:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, John Williams <john.williams@petalogix.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Steph


Hi All,

I have started to use uartlite driver which is in Linus tree.
I look at history and differences between my ancient version and new one.
I found one "insensible" commit from Grant with ACK from Josh and John and one
revert of this.

This commit a15da8eff3627b8368db7f5dd260e5643213d918 (description below) is
trying to fix problem 32bit access to ulite registers. You change 8bit access to
32bit (and commit 077b50c29a7e8be5812d1156934ea837b712ca6) reverts changes back.

"Magic offset" is not magic it is normal - because there is normal big endian
mess where readb and writeb read first byte from big endian but uartlite
registers have are on the last byte -> this mean that magical offset +3.

goto next;

[POWERPC] Uartlite: Fix reg io to access documented register size
The Uartlite data sheet defines the registers as 32 bit wide.  This
patch changes the register access to use 32 bit transfers and eliminates
the magic +3 offset which is currently required to make the device
work.

[POWERPC] Uartlite: Revert register io access changes
Reverts commit a15da8eff3627b8368db7f5dd260e5643213d918
This driver is used by devices other than the xilinx opb-uartlite which
depend on bytewise access to the registers.  The change to 32 bit access
does not work on these devices.

next:

This changes has impact to registration of device (OF in driver and simple in
virtex_devices.c)
 599         return ulite_assign(&op->dev, id ? *id : -1, res.start+3, irq);

--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -28,7 +28,7 @@
        .num_resources = 2, \
        .resource = (struct resource[]) { \
                { \
                        .start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
                        .end = XPAR_UARTLITE_##num##_HIGHADDR, \
                        .flags = IORESOURCE_MEM, \
                }, \
556         return ulite_assign(&pdev->dev, pdev->id, res->start, res2->start);


The result of this mess is senseless output in kernel log
40100000.serial: ttyUL0 at MMIO 0x40100003 (irq = 3) is a uartlite

I think better solution will be remove our magic offset +3 and add it offset +3
to register with comment why this offset is. This changes will help us to clear
registration for non OF devices on Microblaze.

  49 #define ULITE_RX                (0x00 + 3)
  50 #define ULITE_TX                (0x04 + 3)
  51 #define ULITE_STATUS            (0x08 + 3)
  52 #define ULITE_CONTROL           (0x0c + 3)

Patch is below.

Regards,
Michal Simek



>From 7f151ef33344eff401e1e50fb85a77449768b62d Mon Sep 17 00:00:00 2001
From: Michal Simek <monstr@monstr.eu>
Date: Sun, 11 May 2008 15:26:16 +0200
Subject: [PATCH 1/1] Serial: Uartlite - moving register displacement to driver

Clearing registration driver with magic displacement +3
to register offset. For readb and writeb function is this better
way how to read/write proper position than registering whole
device drivers with magic offset +3.
Magic offset is only displacement from manual because uarlite
driver use last byte from 32bit register.
Byte reading/writing is neutral on little and big endian archs.

This patch clean senseless line in kernel log
40100000.serial: ttyUL0 at MMIO 0x40100003 (irq = 3) is a uartlite

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/ppc/syslib/virtex_devices.c |    2 +-
 drivers/serial/uartlite.c        |   11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 7322781..3ff1cbc 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -28,7 +28,7 @@
 	.num_resources = 2, \
 	.resource = (struct resource[]) { \
 		{ \
-			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
+			.start = XPAR_UARTLITE_##num##_BASEADDR, \
 			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
 			.flags = IORESOURCE_MEM, \
 		}, \
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index b51c242..d5c96e5 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -46,10 +46,10 @@ MODULE_DEVICE_TABLE(of, ulite_of_match);
  * http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
  */

-#define ULITE_RX		0x00
-#define ULITE_TX		0x04
-#define ULITE_STATUS		0x08
-#define ULITE_CONTROL		0x0c
+#define ULITE_RX		(0x00 + 3)
+#define ULITE_TX		(0x04 + 3)
+#define ULITE_STATUS		(0x08 + 3)
+#define ULITE_CONTROL		(0x0c + 3)

 #define ULITE_REGION		16

@@ -66,7 +66,6 @@ MODULE_DEVICE_TABLE(of, ulite_of_match);
 #define ULITE_CONTROL_RST_RX	0x02
 #define ULITE_CONTROL_IE	0x10

-
 static struct uart_port ulite_ports[ULITE_NR_UARTS];

 /* ---------------------------------------------------------------------
@@ -596,7 +595,7 @@ ulite_of_probe(struct of_device *op, const struct
of_device_id *match)

 	id = of_get_property(op->node, "port-number", NULL);

-	return ulite_assign(&op->dev, id ? *id : -1, res.start+3, irq);
+	return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
 }

 static int __devexit ulite_of_remove(struct of_device *op)
-- 
1.5.4.GIT



