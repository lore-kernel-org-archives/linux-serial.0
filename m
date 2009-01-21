From: Krzysztof Gantzke <k.gantzke@meilhaus.de>
Subject: [Fwd: Re: Support for Meilhaus serial boards - patch (kernel 2.6.28)]
Date: Wed, 21 Jan 2009 16:10:04 +0100
Message-ID: <49773ACC.6030009@meilhaus.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040800090603020706030401"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.meilhaus.com ([195.30.252.147]:56543 "EHLO
	mail.meilhaus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbZAUPKK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jan 2009 10:10:10 -0500
Received: from mail.meilhaus.com (localhost [127.0.0.1])
	by mail.meilhaus.com (Postfix) with ESMTP id A6E9CE8412C
	for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2009 16:10:04 +0100 (CET)
Received: from [192.168.20.36] (p5B0D1CDC.dip0.t-ipconnect.de [91.13.28.220])
	(Authenticated sender: k.gantzke@meilhaus.de)
	by mail.meilhaus.com (Postfix) with ESMTP id 7F68FE8412B
	for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2009 16:10:04 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------040800090603020706030401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Linux-serial team

You are right about this IOCTL.

I agree that this should be solved in general.
We are using XR17D158, OX16D954 and XR16L788 chips.
I'm preparing patch that will enable auto mode (for RS485) on all of them.

In the meantime, could you accept patch without IOCTL? This will add
support for Meilhaus' boards (RS422 and RS485/422 in manual mode).

Best regards,
Krzysztof Gantzke

Laurent Pinchart wrote:
> On Monday 19 January 2009 16:10:32 Krzysztof Gantzke wrote:
>
>> Dear Linux-serial team
>> Meilhaus (PCI ID: 0x1402) ME90xx, ME91xx and ME93xx support added.
>> The are RS232 and RS422/485 PCI serial boards.
>> This patch was tested on x86 and x86_64 machines.
>>
>> Could you added this to main tree, please.
>>
>
> NAK. You should not add an ioctl to revert to RS232 mode but check
> serial_rs485.flags in TIOCSRS485. Enable RS485 when SER_RS485_ENABLED
is set,
> disable it otherwise.
>
> You should also probably base your patch to 8250.c on top of Matthias
Fuchs'
> patch ('[PATCH V3] serial: Add ioctl to enable auto rs485 mode with
some Exar
> UARTs').
>
> Best regards,
>
>


-- 
Krzysztof Gantzke

Meilhaus Electronic GmbH
Fischerstr. 2
D-82178 Puchheim


--------------040800090603020706030401
Content-Type: text/x-patch;
 name="me9x00-2.0.3-2.6.28-without_IOCTL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="me9x00-2.0.3-2.6.28-without_IOCTL.patch"

diff -U 10 -b -w -B -E -p -r -x '.*' -- linux-2.6.28-me9x00/drivers/serial//8250_pci.c linux-2.6.28/drivers/serial//8250_pci.c
--- home/work/linux-sources/linux-2.6.28-me9x00/drivers/serial//8250_pci.c	2008-12-25 00:26:37.000000000 +0100
+++ usr/src/linux-2.6.28/drivers/serial//8250_pci.c	2009-01-07 15:05:02.000000000 +0100
@@ -123,20 +123,79 @@ static int addidata_apci7800_setup(struc
 		offset += ((idx - 4) * board->uart_offset);
 	} else if (idx >= 6) {
 		bar += 3;
 		offset += ((idx - 6) * board->uart_offset);
 	}
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /*
+ * Meilhaus Electronic GmbH.
+ * The ME9100 and ME9300 boards use the PLX PCI chip, which requires
+ * the interrupts to be enabled on the chip before we can use it.
+ * In addition the ME9100 boards with 8 ports use a mixture of
+ * PCI bar and register offsets.
+ */
+static int __devinit pci_me9x00_init(struct pci_dev *dev)
+{
+	u32 irq_config;
+	u32 plx_base = pci_resource_start(dev, 1);
+
+	if(!plx_base)
+		return -ENODEV;
+
+	if((dev->device == 0x9108) || (dev->device == 0x9158) || (dev->device == 0x930B))
+		irq_config = 0x5B;
+	else if((dev->device == 0x9104) || (dev->device == 0x9154))
+		irq_config = 0x43;
+	else
+		return -ENODEV;
+
+	/*
+	 * Enable interrupts
+	 */
+	outl(irq_config, plx_base + 0x4C);
+	return 0;
+}
+
+static int
+pci_me9x00_setup(struct serial_private *priv, struct pciserial_board *board,
+		  struct uart_port *port, int idx)
+{
+	unsigned int bar, offset = board->first_offset;
+
+	bar = FL_GET_BASE(board->flags);
+	if(idx >= 4) {
+		bar++;
+		offset += (idx - 4) * board->uart_offset;
+	} else
+		offset += idx * board->uart_offset;
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
+static void __devexit pci_me9x00_exit(struct pci_dev *dev)
+{
+	u32 plx_base = pci_resource_start(dev, 1);
+
+	if(!plx_base)
+		return;
+
+	/*
+	 * Disable interrupts
+	 */
+	outl(0x0, plx_base + 0x4C);
+	return;
+}
+
+/*
  * AFAVLAB uses a different mixture of BARs and offsets
  * Not that ugly ;) -- HW
  */
 static int
 afavlab_setup(struct serial_private *priv, struct pciserial_board *board,
 	      struct uart_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
 
 	bar = FL_GET_BASE(board->flags);
@@ -470,20 +529,95 @@ static int pci_siig_setup(struct serial_
 
 	if (idx > 3) {
 		bar = 4;
 		offset = (idx - 4) * 8;
 	}
 
 	return setup_port(priv, port, bar, offset, 0);
 }
 
 /*
+ * Meilhaus Electronic GmbH.
+ * ME9000 series has an explosion of boards, and to avoid the PCI table from
+ * growing *huge*, we use this function to collapse the 88 entries
+ * in the PCI table into one, for sanity's and compactness's sake.
+ */
+static unsigned short me9000_one_port[] = {
+	0x9000, 0x9001,
+	0x9080, 0x9081, 0
+};
+
+static unsigned short me9000_two_port[] = {
+	0x9090, 0x9091, 0x9092,
+	0x9010, 0x9011, 0x9012, 0
+};
+
+static unsigned short me9000_three_port[] = {
+	0x9020, 0x9021, 0x9022, 0x9023,
+       	0x90A0, 0x90A1, 0x90A2, 0x90A3, 0
+};
+
+static unsigned short me9000_four_port[] = {
+	0x9030, 0x9031, 0x9032, 0x9033, 0x9034,
+	0x90B0, 0x90B1, 0x90B2, 0x90B3, 0x90B4, 0
+};
+
+static unsigned short me9000_five_port[] = {
+	0x9040, 0x9041, 0x9042, 0x9043, 0x9044, 0x9045,
+	0x90C0, 0x90C1, 0x90C2, 0x90C3, 0x90C4, 0x90C5, 0
+};
+
+static unsigned short me9000_six_port[] = {
+	0x9050, 0x9051, 0x9052, 0x9053, 0x9054, 0x9055, 0x9056,
+	0x90D0, 0x90D1, 0x90D2, 0x90D3, 0x90D4, 0x90D5, 0x90D6, 0
+};
+
+static unsigned short me9000_seven_port[] = {
+	0x9060, 0x9061, 0x9062, 0x9063, 0x9064, 0x9065, 0x9066, 0x9067,
+	0x90E0, 0x90E1, 0x90E2, 0x90E3, 0x90E4, 0x90E5, 0x90E6, 0x90E7, 0
+};
+
+static unsigned short me9000_eight_port[] = {
+	0x9070, 0x9071, 0x9072, 0x9073, 0x9074, 0x9075, 0x9076, 0x9077, 0x9078,
+	0x90F0, 0x90F1, 0x90F2, 0x90F3, 0x90F4, 0x90F5, 0x90F6, 0x90F7, 0x90F8, 0
+};
+
+static struct me9000_struct {
+	int num;
+	unsigned short *ids;
+} me9000_data[] = {
+	{ 1, me9000_one_port },
+	{ 2, me9000_two_port },
+	{ 3, me9000_three_port },
+	{ 4, me9000_four_port },
+	{ 5, me9000_five_port },
+	{ 6, me9000_six_port },
+	{ 7, me9000_seven_port },
+	{ 8, me9000_eight_port },
+	{ 0, 0 }
+};
+
+static int __devinit pci_me9000_init(struct pci_dev *dev)
+{
+	unsigned short *ids;
+	int i, j;
+
+	for (i = 0; me9000_data[i].num; i++) {
+		ids = me9000_data[i].ids;
+		for (j = 0; ids[j]; j++)
+			if (dev->device == ids[j])
+				return me9000_data[i].num;
+	}
+	return 0;
+}
+
+/*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
  * in the PCI table into one, for sanity's and compactness's sake.
  */
 static const unsigned short timedia_single_port[] = {
 	0x4025, 0x4027, 0x4028, 0x5025, 0x5027, 0
 };
 
 static const unsigned short timedia_dual_port[] = {
 	0x0002, 0x4036, 0x4037, 0x4038, 0x4078, 0x4079, 0x4085,
@@ -752,20 +886,21 @@ pci_default_setup(struct serial_private
 	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
 		(board->reg_shift + 3);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
 /* This should be in linux/pci_ids.h */
+#define PCI_VENDOR_ID_MEILHAUS		0x1402
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
 #define PCI_SUBDEVICE_ID_OCTPRO232	0x0108
 #define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
 #define PCI_SUBDEVICE_ID_POCTAL232	0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -773,20 +908,85 @@ pci_default_setup(struct serial_private
 /*
  * Master list of serial port init/setup/exit quirks.
  * This does not describe the general nature of the port.
  * (ie, baud base, number and location of ports, etc)
  *
  * This list is ordered alphabetically by vendor then device.
  * Specific entries must come before more generic entries.
  */
 static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	/*
+	 * Meilhaus Electronic GmbH ME9100 series boards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9108,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_me9x00_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9104,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9158,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_me9x00_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x9154,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	/*
+	 * Meilhaus Electronic GmbH ME9300 board
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= 0x930B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9x00_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_me9x00_exit),
+	},
+	/*
+	 * Meilhaus Electronic GmbH ME9000 series boards are
+	 * catched with this entry.
+	 * The init function detects the number of ports
+	 * available for the specific board.
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MEILHAUS,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_me9000_init,
+		.setup		= pci_default_setup,
+	},
+	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
 	{
 		.vendor         = PCI_VENDOR_ID_ADDIDATA_OLD,
 		.device         = PCI_DEVICE_ID_ADDIDATA_APCI7800,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = addidata_apci7800_setup,
 	},
 	/*
@@ -1156,20 +1356,22 @@ enum pci_board_num_t {
 	pbn_b2_bt_2_921600,
 	pbn_b2_bt_4_921600,
 
 	pbn_b3_2_115200,
 	pbn_b3_4_115200,
 	pbn_b3_8_115200,
 
 	/*
 	 * Board-specific versions.
 	 */
+	pbn_me9000,
+	pbn_me9300_16,
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_exsys_4055,
 	pbn_plx_romulus,
 	pbn_oxsemi,
 	pbn_oxsemi_1_4000000,
 	pbn_oxsemi_2_4000000,
 	pbn_oxsemi_4_4000000,
 	pbn_oxsemi_8_4000000,
@@ -1579,20 +1781,35 @@ static struct pciserial_board pci_boards
 		.num_ports	= 8,
 		.base_baud	= 115200,
 		.uart_offset	= 8,
 	},
 
 	/*
 	 * Entries following this are board-specific.
 	 */
 
 	/*
+	 * Meilhaus Electronic GmbH
+	 */
+	[pbn_me9000] = {
+		.flags		= FL_BASE0,
+		.base_baud	= 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_me9300_16] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 16,
+		.base_baud	= 921600,
+		.uart_offset	= 0x8,
+	},
+
+	/*
 	 * Panacom - IOMEM
 	 */
 	[pbn_panacom] = {
 		.flags		= FL_BASE2,
 		.num_ports	= 2,
 		.base_baud	= 921600,
 		.uart_offset	= 0x400,
 		.reg_shift	= 7,
 	},
 	[pbn_panacom2] = {
@@ -2125,20 +2342,43 @@ static int pciserial_resume_one(struct p
 		/* FIXME: We cannot simply error out here */
 		if (err)
 			printk(KERN_ERR "pciserial: Unable to re-enable ports, trying to continue.\n");
 		pciserial_resume_ports(priv);
 	}
 	return 0;
 }
 #endif
 
 static struct pci_device_id serial_pci_tbl[] = {
+	/* Meilhaus ME-9300 board */
+	{	PCI_VENDOR_ID_MEILHAUS, 0x930B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_me9300_16 },
+	/* Meilhaus ME-9100 boards */
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9108,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	   	pbn_b2_8_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9104,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9158,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_8_921600 },
+	{	PCI_VENDOR_ID_MEILHAUS, 0x9154,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_4_921600 },
+	/* Meilhaus ME-9000 boards */
+	{	PCI_VENDOR_ID_MEILHAUS, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_COMMUNICATION_SERIAL << 8,
+		0xffff00, pbn_me9000 },
+
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
 		pbn_b1_8_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232, 0, 0,
 		pbn_b1_4_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,


--------------040800090603020706030401--
