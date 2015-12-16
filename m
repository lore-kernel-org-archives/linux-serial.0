From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 01/11] tty: serial: 8250: Fix whitespace errors
Date: Wed, 16 Dec 2015 16:36:07 +0100
Message-ID: <1450280177-4460-2-git-send-email-anton.wuerfel@fau.de>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

This patch fixes whitespace errors reported by checkpatch to increase
readability. Main focus is on missing spaces after commas in
function headers and macros (like foo,bar edited to foo, bar).

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_accent.c        |  2 +-
 drivers/tty/serial/8250/8250_acorn.c         |  2 +-
 drivers/tty/serial/8250/8250_boca.c          |  2 +-
 drivers/tty/serial/8250/8250_core.c          |  1 +
 drivers/tty/serial/8250/8250_dw.c            |  6 +++
 drivers/tty/serial/8250/8250_exar_st16c554.c |  2 +-
 drivers/tty/serial/8250/8250_fourport.c      |  2 +-
 drivers/tty/serial/8250/8250_hp300.c         |  1 +
 drivers/tty/serial/8250/8250_hub6.c          |  2 +-
 drivers/tty/serial/8250/8250_pci.c           |  7 +++-
 drivers/tty/serial/8250/8250_port.c          |  3 ++
 drivers/tty/serial/8250/serial_cs.c          | 58 ++++++++++++++------=
--------
 12 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial=
/8250/8250_accent.c
index 34b51c6..c480729 100644
--- a/drivers/tty/serial/8250/8250_accent.c
+++ b/drivers/tty/serial/8250/8250_accent.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
+#define PORT(_base, _irq)				\
 	{						\
 		.iobase		=3D _base,		\
 		.irq		=3D _irq,			\
diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/=
8250/8250_acorn.c
index 549aa07..402dfdd 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -70,7 +70,7 @@ serial_card_probe(struct expansion_card *ec, const st=
ruct ecard_id *id)
 	uart.port.regshift	=3D 2;
 	uart.port.dev	=3D &ec->dev;
=20
-	for (i =3D 0; i < info->num_ports; i ++) {
+	for (i =3D 0; i < info->num_ports; i++) {
 		uart.port.membase =3D info->vaddr + type->offset[i];
 		uart.port.mapbase =3D bus_addr + type->offset[i];
=20
diff --git a/drivers/tty/serial/8250/8250_boca.c b/drivers/tty/serial/8=
250/8250_boca.c
index d125dc1..e42a5b5 100644
--- a/drivers/tty/serial/8250/8250_boca.c
+++ b/drivers/tty/serial/8250/8250_boca.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
+#define PORT(_base, _irq)				\
 	{						\
 		.iobase		=3D _base,		\
 		.irq		=3D _irq,			\
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 3912646..89a20c9 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -756,6 +756,7 @@ void serial8250_suspend_port(int line)
 	if (!console_suspend_enabled && uart_console(port) &&
 	    port->type !=3D PORT_8250) {
 		unsigned char canary =3D 0xa5;
+
 		serial_out(up, UART_SCR, canary);
 		if (serial_in(up, UART_SCR) =3D=3D canary)
 			up->canary =3D canary;
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
index a5d319e..0f67355 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -102,8 +102,10 @@ static void dw8250_serial_out(struct uart_port *p,=
 int offset, int value)
 	/* Make sure LCR write wasn't ignored */
 	if (offset =3D=3D UART_LCR) {
 		int tries =3D 1000;
+
 		while (tries--) {
 			unsigned int lcr =3D p->serial_in(p, UART_LCR);
+
 			if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
@@ -143,8 +145,10 @@ static void dw8250_serial_outq(struct uart_port *p=
, int offset, int value)
 	/* Make sure LCR write wasn't ignored */
 	if (offset =3D=3D UART_LCR) {
 		int tries =3D 1000;
+
 		while (tries--) {
 			unsigned int lcr =3D p->serial_in(p, UART_LCR);
+
 			if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
@@ -166,8 +170,10 @@ static void dw8250_serial_out32(struct uart_port *=
p, int offset, int value)
 	/* Make sure LCR write wasn't ignored */
 	if (offset =3D=3D UART_LCR) {
 		int tries =3D 1000;
+
 		while (tries--) {
 			unsigned int lcr =3D p->serial_in(p, UART_LCR);
+
 			if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
diff --git a/drivers/tty/serial/8250/8250_exar_st16c554.c b/drivers/tty=
/serial/8250/8250_exar_st16c554.c
index bf53aab..999f2d3 100644
--- a/drivers/tty/serial/8250/8250_exar_st16c554.c
+++ b/drivers/tty/serial/8250/8250_exar_st16c554.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)				\
+#define PORT(_base, _irq)				\
 	{						\
 		.iobase		=3D _base,		\
 		.irq		=3D _irq,			\
diff --git a/drivers/tty/serial/8250/8250_fourport.c b/drivers/tty/seri=
al/8250/8250_fourport.c
index be15826..9a04a8a 100644
--- a/drivers/tty/serial/8250/8250_fourport.c
+++ b/drivers/tty/serial/8250/8250_fourport.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define PORT(_base,_irq)						\
+#define PORT(_base, _irq)						\
 	{								\
 		.iobase		=3D _base,				\
 		.irq		=3D _irq,					\
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/=
8250/8250_hp300.c
index 2891958..38d8cb2 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -125,6 +125,7 @@ int __init hp300_setup_serial_console(void)
 	} else {
 #ifdef CONFIG_HPDCA
 		unsigned long pa =3D dio_scodetophysaddr(scode);
+
 		if (!pa)
 			return 0;
=20
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8=
250/8250_hub6.c
index a5c778e..27124e2 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
=20
-#define HUB6(card,port)							\
+#define HUB6(card, port)						\
 	{								\
 		.iobase		=3D 0x302,				\
 		.irq		=3D 3,					\
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index 4097f3f..ed99fdf 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -113,6 +113,7 @@ static int addidata_apci7800_setup(struct serial_pr=
ivate *priv,
 				struct uart_8250_port *port, int idx)
 {
 	unsigned int bar =3D 0, offset =3D board->first_offset;
+
 	bar =3D FL_GET_BASE(board->flags);
=20
 	if (idx < 2) {
@@ -1115,6 +1116,7 @@ static struct quatech_feature quatech_cards[] =3D=
 {
 static int pci_quatech_amcc(u16 devid)
 {
 	struct quatech_feature *qf =3D &quatech_cards[0];
+
 	while (qf->devid) {
 		if (qf->devid =3D=3D devid)
 			return qf->amcc;
@@ -1200,6 +1202,7 @@ static int pci_quatech_test(struct uart_8250_port=
 *port)
 {
 	u8 reg;
 	u8 qopr =3D pci_quatech_rqopr(port);
+
 	pci_quatech_wqopr(port, qopr & QPCR_TEST_FOR1);
 	reg =3D pci_quatech_rqopr(port) & 0xC0;
 	if (reg !=3D QPCR_TEST_GET1)
@@ -1284,8 +1287,10 @@ static int pci_quatech_init(struct pci_dev *dev)
 {
 	if (pci_quatech_amcc(dev->device)) {
 		unsigned long base =3D pci_resource_start(dev, 0);
+
 		if (base) {
 			u32 tmp;
+
 			outl(inl(base + 0x38) | 0x00002000, base + 0x38);
 			tmp =3D inl(base + 0x3c);
 			outl(tmp | 0x01000000, base + 0x3c);
@@ -4502,7 +4507,7 @@ static struct pci_device_id serial_pci_tbl[] =3D =
{
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_921600 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI958,
-		PCI_ANY_ID , PCI_ANY_ID, 0, 0,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_8_1152000 },
=20
 	/*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 52d82d2..ae8f993 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1327,6 +1327,7 @@ static void serial8250_start_tx(struct uart_port =
*port)
=20
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr;
+
 			lsr =3D serial_in(up, UART_LSR);
 			up->lsr_saved_flags |=3D lsr & LSR_SAVE_FLAGS;
 			if (lsr & UART_LSR_THRE)
@@ -1734,8 +1735,10 @@ static void wait_for_xmitr(struct uart_8250_port=
 *up, int bits)
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
 		unsigned int tmout;
+
 		for (tmout =3D 1000000; tmout; tmout--) {
 			unsigned int msr =3D serial_in(up, UART_MSR);
+
 			up->msr_saved_flags |=3D msr & MSR_SAVE_FLAGS;
 			if (msr & UART_MSR_CTS)
 				break;
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8=
250/serial_cs.c
index 4d180c9..f5270ba 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -257,7 +257,7 @@ static const struct serial_quirk quirks[] =3D {
 };
=20
=20
-static int serial_config(struct pcmcia_device * link);
+static int serial_config(struct pcmcia_device *link);
=20
=20
 static void serial_remove(struct pcmcia_device *link)
@@ -309,7 +309,7 @@ static int serial_probe(struct pcmcia_device *link)
 	dev_dbg(&link->dev, "serial_attach()\n");
=20
 	/* Create new serial device */
-	info =3D kzalloc(sizeof (*info), GFP_KERNEL);
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	info->p_dev =3D link;
@@ -339,7 +339,7 @@ static void serial_detach(struct pcmcia_device *lin=
k)
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
=20
-static int setup_serial(struct pcmcia_device *handle, struct serial_in=
fo * info,
+static int setup_serial(struct pcmcia_device *handle, struct serial_in=
fo *info,
 			unsigned int iobase, int irq)
 {
 	struct uart_8250_port uart;
@@ -600,7 +600,7 @@ static int serial_check_for_multi(struct pcmcia_dev=
ice *p_dev,  void *priv_data)
 }
=20
=20
-static int serial_config(struct pcmcia_device * link)
+static int serial_config(struct pcmcia_device *link)
 {
 	struct serial_info *info =3D link->priv;
 	int i;
@@ -701,7 +701,7 @@ static const struct pcmcia_device_id serial_ids[] =3D=
 {
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "LINKSYS", "PCMLM336", 0xf7cb0b07, 0x7=
a821b58),
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "MEGAHERTZ", "XJEM1144/CCEM1144", 0xf5=
10db04, 0x52d21e1e),
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "MICRO RESEARCH", "COMBO-L/M-336", 0xb=
2ced065, 0x3ced0555),
-	PCMCIA_PFC_DEVICE_PROD_ID12(1, "NEC", "PK-UG-J001" ,0x18df0ba0 ,0x831=
b1064),
+	PCMCIA_PFC_DEVICE_PROD_ID12(1, "NEC", "PK-UG-J001", 0x18df0ba0, 0x831=
b1064),
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "Ositech", "Trumpcard:Jack of Diamonds=
 Modem+Ethernet", 0xc2f80cd, 0x656947b9),
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "Ositech", "Trumpcard:Jack of Hearts M=
odem+Ethernet", 0xc2f80cd, 0xdc9ba5ed),
 	PCMCIA_PFC_DEVICE_PROD_ID12(1, "PCMCIAs", "ComboCard", 0xdcfe12d3, 0x=
cd8906cc),
@@ -797,30 +797,30 @@ static const struct pcmcia_device_id serial_ids[]=
 =3D {
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96=
913a85, 0x8fbe92ae, 0x0877b627, "cis/COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "cis/RS-COM-2P.ci=
s"),
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "cis/GLOBETROTTER.cis"),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CA=
RD: SL100  1.00.",0x19ca78af,0xf964f42b),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CA=
RD: SL100",0x19ca78af,0x71d98e83),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CA=
RD: SL232  1.00.",0x19ca78af,0x69fb7490),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CA=
RD: SL232",0x19ca78af,0xb6bc0235),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CA=
RD: CF232",0x63f2e0bd,0xb9e175d3),
-	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CA=
RD: CF232-5",0x63f2e0bd,0xfce33442),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232",0x3beb8cf2,0x171e=
7190),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232-5",0x3beb8cf2,0x20=
da4262),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF428",0x3beb8cf2,0xea5d=
d57d),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF500",0x3beb8cf2,0xd772=
55fa),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: IC232",0x3beb8cf2,0x6a70=
9903),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: SL232",0x3beb8cf2,0x1843=
0676),
-	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: XL232",0x3beb8cf2,0x6f93=
3767),
-	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,=
0x16dc1ba7),
-	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,=
0x19816c41),
-	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,=
0x64112029),
-	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,=
0x1cce7ac4),
-	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x=
3beb8cf2,0xdb9e58bc),
-	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,=
0x16dc1ba7),
-	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,=
0x19816c41),
-	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,=
0x64112029),
-	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,=
0x1cce7ac4),
-	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,=
0x1cce7ac4),
-	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,=
0x1cce7ac4),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL C=
ARD: SL100  1.00.", 0x19ca78af, 0xf964f42b),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL C=
ARD: SL100", 0x19ca78af, 0x71d98e83),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL C=
ARD: SL232  1.00.", 0x19ca78af, 0x69fb7490),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL C=
ARD: SL232", 0x19ca78af, 0xb6bc0235),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.", "SERIAL C=
ARD: CF232", 0x63f2e0bd, 0xb9e175d3),
+	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.", "SERIAL C=
ARD: CF232-5", 0x63f2e0bd, 0xfce33442),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: CF232", 0x3beb8cf2, 0x1=
71e7190),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: CF232-5", 0x3beb8cf2, 0=
x20da4262),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: CF428", 0x3beb8cf2, 0xe=
a5dd57d),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: CF500", 0x3beb8cf2, 0xd=
77255fa),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: IC232", 0x3beb8cf2, 0x6=
a709903),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: SL232", 0x3beb8cf2, 0x1=
8430676),
+	PCMCIA_DEVICE_PROD_ID12("Elan", "Serial Port: XL232", 0x3beb8cf2, 0x6=
f933767),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0, "Elan", "Serial Port: CF332", 0x3beb8c=
f2, 0x16dc1ba7),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0, "Elan", "Serial Port: SL332", 0x3beb8c=
f2, 0x19816c41),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0, "Elan", "Serial Port: SL385", 0x3beb8c=
f2, 0x64112029),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0, "Elan", "Serial Port: SL432", 0x3beb8c=
f2, 0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(0, "Elan", "Serial+Parallel Port: SP230",=
 0x3beb8cf2, 0xdb9e58bc),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1, "Elan", "Serial Port: CF332", 0x3beb8c=
f2, 0x16dc1ba7),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1, "Elan", "Serial Port: SL332", 0x3beb8c=
f2, 0x19816c41),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1, "Elan", "Serial Port: SL385", 0x3beb8c=
f2, 0x64112029),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1, "Elan", "Serial Port: SL432", 0x3beb8c=
f2, 0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(2, "Elan", "Serial Port: SL432", 0x3beb8c=
f2, 0x1cce7ac4),
+	PCMCIA_MFC_DEVICE_PROD_ID12(3, "Elan", "Serial Port: SL432", 0x3beb8c=
f2, 0x1cce7ac4),
 	PCMCIA_DEVICE_MANF_CARD(0x0279, 0x950b),
 	/* too generic */
 	/* PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0160, 0x0002), */
--=20
1.9.1
