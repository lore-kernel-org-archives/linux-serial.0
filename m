Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B8AC48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321B5611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhFRGR2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhFRGR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 57E4921B51;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0/sPTdXkqy+3O70CwUG3/nPI/FpLgT1W1rjqdxAiPo=;
        b=ICEeLxj3DTRSoZhfbvjTs1ZFlYlCSRysZ3b20/YyPd6M+9I0E9XH1OU6ItVHh0S6M6ISB2
        Bq6lRsedFTOn++4+avBm3qZCfjGHo5L67G0MyT03VuL2V4YYcyrx6ww2p/3WjvEE1SJimR
        /FQmnLoNQSRXSpCgQh6wwWWOiqx6FRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0/sPTdXkqy+3O70CwUG3/nPI/FpLgT1W1rjqdxAiPo=;
        b=tEVWJ+ocnjQd3ZxLKtN9bsd+8rdwuZmeEkh0tJXxqvRegiV97W0tq+R8+IE4xBbLnRAZpS
        TwpLYo4YCD1n0rBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31197A3BC5;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/70] mxser: drop ISA support
Date:   Fri, 18 Jun 2021 08:14:07 +0200
Message-Id: <20210618061516.662-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

While mxser PCI cards are still around and produced (Moxa provided me
with two recently), ISA cards are obsolete for a long time. I haven't
seen anyone using the cards and the ISA code paths are barely tested.

Hence, remove ISA support from mxser driver so that we can clean the
driver up.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 .../driver-api/serial/moxa-smartio.rst        | 107 +-----
 drivers/tty/Kconfig                           |   2 +-
 drivers/tty/mxser.c                           | 348 +-----------------
 3 files changed, 17 insertions(+), 440 deletions(-)

diff --git a/Documentation/driver-api/serial/moxa-smartio.rst b/Documentation/driver-api/serial/moxa-smartio.rst
index 156100f17c3f..aedda2546242 100644
--- a/Documentation/driver-api/serial/moxa-smartio.rst
+++ b/Documentation/driver-api/serial/moxa-smartio.rst
@@ -37,8 +37,7 @@ Date: 01/21/2008
 	CP-102U, CP-102UL, CP-102UF
 	CP-132U-I, CP-132UL,
 	CP-132, CP-132I, CP132S, CP-132IS,
-	CI-132, CI-132I, CI-132IS,
-	(C102H, C102HI, C102HIS, C102P, CP-102, CP-102S)
+	(CP-102, CP-102S)
 
     - 4 ports multiport board
 	CP-104EL,
@@ -46,10 +45,7 @@ Date: 01/21/2008
 	CP-134U, CP-134U-I,
 	C104H/PCI, C104HS/PCI,
 	CP-114, CP-114I, CP-114S, CP-114IS, CP-114UL,
-	C104H, C104HS,
-	CI-104J, CI-104JS,
-	CI-134, CI-134I, CI-134IS,
-	(C114HI, CT-114I, C104P),
+	(C114HI, CT-114I),
 	POS-104UL,
 	CB-114,
 	CB-134I
@@ -58,8 +54,6 @@ Date: 01/21/2008
 	CP-118EL, CP-168EL,
 	CP-118U, CP-168U,
 	C168H/PCI,
-	C168H, C168HS,
-	(C168P),
 	CB-108
 
    This driver and installation procedure have been developed upon Linux Kernel
@@ -78,9 +72,6 @@ Date: 01/21/2008
 		 Monitor program to observe data count and line status signals.
     - msterm     A simple terminal program which is useful in testing serial
 	         ports.
-    - io-irq.exe
-		 Configuration program to setup ISA boards. Please note that
-                 this program can only be executed under DOS.
 
    All the drivers and utilities are published in form of source code under
    GNU General Public License in this version. Please refer to GNU General
@@ -112,17 +103,6 @@ Date: 01/21/2008
 3.1 Hardware installation
 =========================
 
-   There are two types of buses, ISA and PCI, for Smartio/Industio
-   family multiport board.
-
-ISA board
----------
-
-   You'll have to configure CAP address, I/O address, Interrupt Vector
-   as well as IRQ before installing this driver. Please refer to hardware
-   installation procedure in User's Manual before proceed any further.
-   Please make sure the JP1 is open after the ISA board is set properly.
-
 PCI/UPCI board
 --------------
 
@@ -194,16 +174,6 @@ Device naming when more than 2 boards installed
    Under Kernel 2.6 and upper, the cum Device is Obsolete. So use ttyM*
    device instead.
 
-Board sequence
---------------
-
-   This driver will activate ISA boards according to the parameter set
-   in the driver. After all specified ISA board activated, PCI board
-   will be installed in the system automatically driven.
-   Therefore the board number is sorted by the CAP address of ISA boards.
-   For PCI boards, their sequence will be after ISA boards and C168H/PCI
-   has higher priority than C104H/PCI boards.
-
 3.4 Module driver configuration
 ===============================
 
@@ -274,12 +244,10 @@ Board sequence
 
    ::
 
-	 # modprobe mxser <argument>
+	 # modprobe mxser
 
    will activate the module driver. You may run "lsmod" to check
-   if "mxser" is activated. If the MOXA board is ISA board, the
-   <argument> is needed. Please refer to section "3.4.5" for more
-   information.
+   if "mxser" is activated.
 
 ------------- Load MOXA driver on boot --------------------
 
@@ -296,13 +264,6 @@ Board sequence
    achieved by rc file. We offer one "rc.mxser" file to simplify
    the procedure under "moxa/mxser/driver".
 
-   But if you use ISA board, please modify the "modprobe ..." command
-   to add the argument (see "3.4.5" section). After modifying the
-   rc.mxser, please try to execute "/moxa/mxser/driver/rc.mxser"
-   manually to make sure the modification is ok. If any error
-   encountered, please try to modify again. If the modification is
-   completed, follow the below step.
-
    Run following command for setting rc files::
 
 	 # cd /moxa/mxser/driver
@@ -316,21 +277,6 @@ Board sequence
 
    Reboot and check if moxa.o activated by "lsmod" command.
 
-3.4.5. specify CAP address
---------------------------
-
-   If you'd like to drive Smartio/Industio ISA boards in the system,
-   you'll have to add parameter to specify CAP address of given
-   board while activating "mxser.o". The format for parameters are
-   as follows.::
-
-	   modprobe mxser ioaddr=0x???,0x???,0x???,0x???
-				  |  |  |    |
-				  |  |  |    +- 4th ISA board
-				  |  |  +------ 3rd ISA board
-				  |  +------------ 2nd ISA board
-				  +-------------------1st ISA board
-
 3.5 Static driver configuration for Linux kernel 2.4.x and 2.6.x
 ================================================================
 
@@ -357,35 +303,7 @@ Board sequence
 	  # cd /usr/src/linux/drivers/char
 	  # ln -s /moxa/mxser/driver/mxser.c mxser.c
 
-3.5.3 Add CAP address list for ISA boards.
-------------------------------------------
-
-    For PCI boards user, please skip this step.
-
-    In module mode, the CAP address for ISA board is given by
-    parameter. In static driver configuration, you'll have to
-    assign it within driver's source code. If you will not
-    install any ISA boards, you may skip to next portion.
-    The instructions to modify driver source code are as
-    below.
-
-    a. run::
-
-	# cd /moxa/mxser/driver
-	# vi mxser.c
-
-    b. Find the array mxserBoardCAP[] as below::
-
-	  static int mxserBoardCAP[] = {0x00, 0x00, 0x00, 0x00};
-
-    c. Change the address within this array using vi. For
-       example, to driver 2 ISA boards with CAP address
-       0x280 and 0x180 as 1st and 2nd board. Just to change
-       the source code as follows::
-
-	  static int mxserBoardCAP[] = {0x280, 0x180, 0x00, 0x00};
-
-3.5.4 Setup kernel configuration
+3.5.3 Setup kernel configuration
 --------------------------------
 
     Configure the kernel::
@@ -398,7 +316,7 @@ Board sequence
     SmartIO support] driver with "[*]" for built-in (not "[M]"), then
     select [Exit] to exit this program.
 
-3.5.5 Rebuild kernel
+3.5.4 Rebuild kernel
 --------------------
 
     The following are for Linux kernel rebuilding, for your
@@ -426,14 +344,14 @@ Board sequence
           directory /usr/src/linux.
 
 
-3.5.6 Make tty device and special file
+3.5.5 Make tty device and special file
 --------------------------------------
 
     ::
        # cd /moxa/mxser/driver
        # ./msmknod
 
-3.5.7 Make utility
+3.5.6 Make utility
 ------------------
 
     ::
@@ -441,7 +359,7 @@ Board sequence
 	  # cd /moxa/mxser/utility
 	  # make clean; make install
 
-3.5.8 Reboot
+3.5.7 Reboot
 ------------
 
 
@@ -591,13 +509,6 @@ msterm - Terminal Emulation
    Each port within the same multiport board shares the same IRQ. Please set
    one IRQ (IRQ doesn't equal to zero) for one Moxa board.
 
-   Error msg:
-	      No interrupt vector be set for Moxa ISA board(CAP=xxx).
-
-   Solution:
-   Moxa ISA board needs an interrupt vector.Please refer to user's manual
-   "Hardware Installation" chapter to set interrupt vector.
-
    Error msg:
               Couldn't install MOXA Smartio/Industio family driver!
 
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index f6a7fd6d3bb6..476c11278235 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -204,7 +204,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
+	depends on SERIAL_NONSTANDARD && PCI
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index a74e6146a748..3a00f180f54a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -70,18 +70,8 @@
 #define PCI_DEVICE_ID_CB134I	0x1341
 #define PCI_DEVICE_ID_CP138U	0x1380
 
-
-#define C168_ASIC_ID    1
-#define C104_ASIC_ID    2
-#define C102_ASIC_ID	0xB
-#define CI132_ASIC_ID	4
-#define CI134_ASIC_ID	3
-#define CI104J_ASIC_ID  5
-
 #define MXSER_HIGHBAUD	1
-#define MXSER_HAS2	2
 
-/* This is only for PCI */
 static const struct {
 	int type;
 	int tx_fifo;
@@ -105,14 +95,14 @@ struct mxser_cardinfo {
 };
 
 static const struct mxser_cardinfo mxser_cards[] = {
-/* 0*/	{ "C168 series",	8, },
-	{ "C104 series",	4, },
-	{ "CI-104J series",	4, },
+/* 0*/	{ },
+	{ },
+	{ },
 	{ "C168H/PCI series",	8, },
 	{ "C104H/PCI series",	4, },
-/* 5*/	{ "C102 series",	4, MXSER_HAS2 },	/* C102-ISA */
-	{ "CI-132 series",	4, MXSER_HAS2 },
-	{ "CI-134 series",	4, },
+/* 5*/	{ },
+	{ },
+	{ },
 	{ "CP-132 series",	2, },
 	{ "CP-114 series",	4, },
 /*10*/	{ "CT-114 series",	4, },
@@ -172,15 +162,12 @@ static const struct pci_device_id mxser_pcibrds[] = {
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
 
-static unsigned long ioaddr[MXSER_BOARDS];
 static int ttymajor = MXSERMAJOR;
 
 /* Variables for insmod */
 
 MODULE_AUTHOR("Casper Yang");
 MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver");
-module_param_hw_array(ioaddr, ulong, ioport, NULL, 0);
-MODULE_PARM_DESC(ioaddr, "ISA io addresses to look for a moxa board");
 module_param(ttymajor, int, 0);
 MODULE_LICENSE("GPL");
 
@@ -300,7 +287,6 @@ static void mxser_enable_must_enchance_mode(unsigned long baseio)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-#ifdef	CONFIG_PCI
 static void mxser_disable_must_enchance_mode(unsigned long baseio)
 {
 	u8 oldlcr;
@@ -315,7 +301,6 @@ static void mxser_disable_must_enchance_mode(unsigned long baseio)
 	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
 }
-#endif
 
 static void mxser_set_must_xon1_value(unsigned long baseio, u8 value)
 {
@@ -387,7 +372,6 @@ static void mxser_set_must_enum_value(unsigned long baseio, u8 value)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-#ifdef CONFIG_PCI
 static void mxser_get_must_hardware_id(unsigned long baseio, u8 *pId)
 {
 	u8 oldlcr;
@@ -404,7 +388,6 @@ static void mxser_get_must_hardware_id(unsigned long baseio, u8 *pId)
 	*pId = inb(baseio + MOXA_MUST_HWID_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
 }
-#endif
 
 static void SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(unsigned long baseio)
 {
@@ -483,7 +466,6 @@ static void mxser_disable_must_rx_software_flow_control(unsigned long baseio)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-#ifdef CONFIG_PCI
 static int CheckIsMoxaMust(unsigned long io)
 {
 	u8 oldmcr, hwid;
@@ -506,7 +488,6 @@ static int CheckIsMoxaMust(unsigned long io)
 	}
 	return MOXA_OTHER_UART;
 }
-#endif
 
 static void process_txrx_fifo(struct mxser_port *info)
 {
@@ -1398,109 +1379,6 @@ static int mxser_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int __init mxser_program_mode(int port)
-{
-	int id, i, j, n;
-
-	outb(0, port);
-	outb(0, port);
-	outb(0, port);
-	(void)inb(port);
-	(void)inb(port);
-	outb(0, port);
-	(void)inb(port);
-
-	id = inb(port + 1) & 0x1F;
-	if ((id != C168_ASIC_ID) &&
-			(id != C104_ASIC_ID) &&
-			(id != C102_ASIC_ID) &&
-			(id != CI132_ASIC_ID) &&
-			(id != CI134_ASIC_ID) &&
-			(id != CI104J_ASIC_ID))
-		return -1;
-	for (i = 0, j = 0; i < 4; i++) {
-		n = inb(port + 2);
-		if (n == 'M') {
-			j = 1;
-		} else if ((j == 1) && (n == 1)) {
-			j = 2;
-			break;
-		} else
-			j = 0;
-	}
-	if (j != 2)
-		id = -2;
-	return id;
-}
-
-static void __init mxser_normal_mode(int port)
-{
-	int i, n;
-
-	outb(0xA5, port + 1);
-	outb(0x80, port + 3);
-	outb(12, port + 0);	/* 9600 bps */
-	outb(0, port + 1);
-	outb(0x03, port + 3);	/* 8 data bits */
-	outb(0x13, port + 4);	/* loop back mode */
-	for (i = 0; i < 16; i++) {
-		n = inb(port + 5);
-		if ((n & 0x61) == 0x60)
-			break;
-		if ((n & 1) == 1)
-			(void)inb(port);
-	}
-	outb(0x00, port + 4);
-}
-
-#define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
-#define CHIP_DO 	0x02	/* Serial Data Output in Eprom */
-#define CHIP_CS 	0x04	/* Serial Chip Select in Eprom */
-#define CHIP_DI 	0x08	/* Serial Data Input  in Eprom */
-#define EN_CCMD 	0x000	/* Chip's command register     */
-#define EN0_RSARLO	0x008	/* Remote start address reg 0  */
-#define EN0_RSARHI	0x009	/* Remote start address reg 1  */
-#define EN0_RCNTLO	0x00A	/* Remote byte count reg WR    */
-#define EN0_RCNTHI	0x00B	/* Remote byte count reg WR    */
-#define EN0_DCFG	0x00E	/* Data configuration reg WR   */
-#define EN0_PORT	0x010	/* Rcv missed frame error counter RD */
-#define ENC_PAGE0	0x000	/* Select page 0 of chip registers   */
-#define ENC_PAGE3	0x0C0	/* Select page 3 of chip registers   */
-static int __init mxser_read_register(int port, unsigned short *regs)
-{
-	int i, k, value, id;
-	unsigned int j;
-
-	id = mxser_program_mode(port);
-	if (id < 0)
-		return id;
-	for (i = 0; i < 14; i++) {
-		k = (i & 0x3F) | 0x180;
-		for (j = 0x100; j > 0; j >>= 1) {
-			outb(CHIP_CS, port);
-			if (k & j) {
-				outb(CHIP_CS | CHIP_DO, port);
-				outb(CHIP_CS | CHIP_DO | CHIP_SK, port);	/* A? bit of read */
-			} else {
-				outb(CHIP_CS, port);
-				outb(CHIP_CS | CHIP_SK, port);	/* A? bit of read */
-			}
-		}
-		(void)inb(port);
-		value = 0;
-		for (k = 0, j = 0x8000; k < 16; k++, j >>= 1) {
-			outb(CHIP_CS, port);
-			outb(CHIP_CS | CHIP_SK, port);
-			if (inb(port) & CHIP_DI)
-				value |= j;
-		}
-		regs[i] = value;
-		outb(0, port);
-	}
-	mxser_normal_mode(port);
-	return id;
-}
-
 static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 {
 	struct mxser_port *ip;
@@ -2346,37 +2224,6 @@ static const struct tty_port_operations mxser_port_ops = {
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
 
-static bool allow_overlapping_vector;
-module_param(allow_overlapping_vector, bool, S_IRUGO);
-MODULE_PARM_DESC(allow_overlapping_vector, "whether we allow ISA cards to be configured such that vector overlabs IO ports (default=no)");
-
-static bool mxser_overlapping_vector(struct mxser_board *brd)
-{
-	return allow_overlapping_vector &&
-		brd->vector >= brd->ports[0].ioaddr &&
-		brd->vector < brd->ports[0].ioaddr + 8 * brd->info->nports;
-}
-
-static int mxser_request_vector(struct mxser_board *brd)
-{
-	if (mxser_overlapping_vector(brd))
-		return 0;
-	return request_region(brd->vector, 1, "mxser(vector)") ? 0 : -EIO;
-}
-
-static void mxser_release_vector(struct mxser_board *brd)
-{
-	if (mxser_overlapping_vector(brd))
-		return;
-	release_region(brd->vector, 1);
-}
-
-static void mxser_release_ISA_res(struct mxser_board *brd)
-{
-	release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
-	mxser_release_vector(brd);
-}
-
 static int mxser_initbrd(struct mxser_board *brd)
 {
 	struct mxser_port *info;
@@ -2439,125 +2286,9 @@ static void mxser_board_remove(struct mxser_board *brd)
 	free_irq(brd->irq, brd);
 }
 
-static int __init mxser_get_ISA_conf(int cap, struct mxser_board *brd)
-{
-	int id, i, bits, ret;
-	unsigned short regs[16], irq;
-	unsigned char scratch, scratch2;
-
-	brd->chip_flag = MOXA_OTHER_UART;
-
-	id = mxser_read_register(cap, regs);
-	switch (id) {
-	case C168_ASIC_ID:
-		brd->info = &mxser_cards[0];
-		break;
-	case C104_ASIC_ID:
-		brd->info = &mxser_cards[1];
-		break;
-	case CI104J_ASIC_ID:
-		brd->info = &mxser_cards[2];
-		break;
-	case C102_ASIC_ID:
-		brd->info = &mxser_cards[5];
-		break;
-	case CI132_ASIC_ID:
-		brd->info = &mxser_cards[6];
-		break;
-	case CI134_ASIC_ID:
-		brd->info = &mxser_cards[7];
-		break;
-	default:
-		return 0;
-	}
-
-	irq = 0;
-	/* some ISA cards have 2 ports, but we want to see them as 4-port (why?)
-	   Flag-hack checks if configuration should be read as 2-port here. */
-	if (brd->info->nports == 2 || (brd->info->flags & MXSER_HAS2)) {
-		irq = regs[9] & 0xF000;
-		irq = irq | (irq >> 4);
-		if (irq != (regs[9] & 0xFF00))
-			goto err_irqconflict;
-	} else if (brd->info->nports == 4) {
-		irq = regs[9] & 0xF000;
-		irq = irq | (irq >> 4);
-		irq = irq | (irq >> 8);
-		if (irq != regs[9])
-			goto err_irqconflict;
-	} else if (brd->info->nports == 8) {
-		irq = regs[9] & 0xF000;
-		irq = irq | (irq >> 4);
-		irq = irq | (irq >> 8);
-		if ((irq != regs[9]) || (irq != regs[10]))
-			goto err_irqconflict;
-	}
-
-	if (!irq) {
-		printk(KERN_ERR "mxser: interrupt number unset\n");
-		return -EIO;
-	}
-	brd->irq = ((int)(irq & 0xF000) >> 12);
-	for (i = 0; i < 8; i++)
-		brd->ports[i].ioaddr = (int) regs[i + 1] & 0xFFF8;
-	if ((regs[12] & 0x80) == 0) {
-		printk(KERN_ERR "mxser: invalid interrupt vector\n");
-		return -EIO;
-	}
-	brd->vector = (int)regs[11];	/* interrupt vector */
-	if (id == 1)
-		brd->vector_mask = 0x00FF;
-	else
-		brd->vector_mask = 0x000F;
-	for (i = 7, bits = 0x0100; i >= 0; i--, bits <<= 1) {
-		if (regs[12] & bits) {
-			brd->ports[i].baud_base = 921600;
-			brd->ports[i].max_baud = 921600;
-		} else {
-			brd->ports[i].baud_base = 115200;
-			brd->ports[i].max_baud = 115200;
-		}
-	}
-	scratch2 = inb(cap + UART_LCR) & (~UART_LCR_DLAB);
-	outb(scratch2 | UART_LCR_DLAB, cap + UART_LCR);
-	outb(0, cap + UART_EFR);	/* EFR is the same as FCR */
-	outb(scratch2, cap + UART_LCR);
-	outb(UART_FCR_ENABLE_FIFO, cap + UART_FCR);
-	scratch = inb(cap + UART_IIR);
-
-	if (scratch & 0xC0)
-		brd->uart_type = PORT_16550A;
-	else
-		brd->uart_type = PORT_16450;
-	if (!request_region(brd->ports[0].ioaddr, 8 * brd->info->nports,
-			"mxser(IO)")) {
-		printk(KERN_ERR "mxser: can't request ports I/O region: "
-				"0x%.8lx-0x%.8lx\n",
-				brd->ports[0].ioaddr, brd->ports[0].ioaddr +
-				8 * brd->info->nports - 1);
-		return -EIO;
-	}
-
-	ret = mxser_request_vector(brd);
-	if (ret) {
-		release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
-		printk(KERN_ERR "mxser: can't request interrupt vector region: "
-				"0x%.8lx-0x%.8lx\n",
-				brd->ports[0].ioaddr, brd->ports[0].ioaddr +
-				8 * brd->info->nports - 1);
-		return ret;
-	}
-	return brd->info->nports;
-
-err_irqconflict:
-	printk(KERN_ERR "mxser: invalid interrupt number\n");
-	return -EIO;
-}
-
 static int mxser_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
-#ifdef CONFIG_PCI
 	struct mxser_board *brd;
 	unsigned int i, j;
 	unsigned long ioaddress;
@@ -2673,14 +2404,10 @@ static int mxser_probe(struct pci_dev *pdev,
 	pci_disable_device(pdev);
 err:
 	return retval;
-#else
-	return -ENODEV;
-#endif
 }
 
 static void mxser_remove(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PCI
 	struct mxser_board *brd = pci_get_drvdata(pdev);
 
 	mxser_board_remove(brd);
@@ -2689,7 +2416,6 @@ static void mxser_remove(struct pci_dev *pdev)
 	pci_release_region(pdev, 3);
 	pci_disable_device(pdev);
 	brd->info = NULL;
-#endif
 }
 
 static struct pci_driver mxser_driver = {
@@ -2701,9 +2427,6 @@ static struct pci_driver mxser_driver = {
 
 static int __init mxser_module_init(void)
 {
-	struct mxser_board *brd;
-	struct device *tty_dev;
-	unsigned int b, i, m;
 	int retval;
 
 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
@@ -2731,57 +2454,10 @@ static int __init mxser_module_init(void)
 		goto err_put;
 	}
 
-	/* Start finding ISA boards here */
-	for (m = 0, b = 0; b < MXSER_BOARDS; b++) {
-		if (!ioaddr[b])
-			continue;
-
-		brd = &mxser_boards[m];
-		retval = mxser_get_ISA_conf(ioaddr[b], brd);
-		if (retval <= 0) {
-			brd->info = NULL;
-			continue;
-		}
-
-		printk(KERN_INFO "mxser: found MOXA %s board (CAP=0x%lx)\n",
-				brd->info->name, ioaddr[b]);
-
-		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd) < 0) {
-			mxser_release_ISA_res(brd);
-			brd->info = NULL;
-			continue;
-		}
-
-		brd->idx = m * MXSER_PORTS_PER_BOARD;
-		for (i = 0; i < brd->info->nports; i++) {
-			tty_dev = tty_port_register_device(&brd->ports[i].port,
-					mxvar_sdriver, brd->idx + i, NULL);
-			if (IS_ERR(tty_dev)) {
-				for (; i > 0; i--)
-					tty_unregister_device(mxvar_sdriver,
-						brd->idx + i - 1);
-				for (i = 0; i < brd->info->nports; i++)
-					tty_port_destroy(&brd->ports[i].port);
-				free_irq(brd->irq, brd);
-				mxser_release_ISA_res(brd);
-				brd->info = NULL;
-				break;
-			}
-		}
-		if (brd->info == NULL)
-			continue;
-
-		m++;
-	}
-
 	retval = pci_register_driver(&mxser_driver);
 	if (retval) {
 		printk(KERN_ERR "mxser: can't register pci driver\n");
-		if (!m) {
-			retval = -ENODEV;
-			goto err_unr;
-		} /* else: we have some ISA cards under control */
+		goto err_unr;
 	}
 
 	return 0;
@@ -2794,19 +2470,9 @@ static int __init mxser_module_init(void)
 
 static void __exit mxser_module_exit(void)
 {
-	unsigned int i;
-
 	pci_unregister_driver(&mxser_driver);
-
-	for (i = 0; i < MXSER_BOARDS; i++) /* ISA remains */
-		if (mxser_boards[i].info != NULL)
-			mxser_board_remove(&mxser_boards[i]);
 	tty_unregister_driver(mxvar_sdriver);
 	put_tty_driver(mxvar_sdriver);
-
-	for (i = 0; i < MXSER_BOARDS; i++)
-		if (mxser_boards[i].info != NULL)
-			mxser_release_ISA_res(&mxser_boards[i]);
 }
 
 module_init(mxser_module_init);
-- 
2.32.0

