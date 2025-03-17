Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6B21ABD6;
	Mon, 17 Mar 2025 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194880; cv=none; b=GTh6EXs+Ufbdkk+wUcJElfeCZ2yR5wLRIa8lamWFYIcECbv8eG9RZNoYVKF4ncrwMSQWo3lvwsYnH3Zbg2XzH3KRk9hqj0dFNghkSaboMjsO3o6uNXlLYcwzSRA/ihvNqjnYRflw0+y1KnARNfAWK7YXX2qAKyTvJ7GzRzdAZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194880; c=relaxed/simple;
	bh=EwWownPK13neyE4WZdGUG3DsFNRwckPSUyx1cbKZcNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8A2VcYEipJyPidES5u8kS2UIJ+yNEfgkDXoLKlcGecZf7j75gdJmfM4OVFKNC5HkII9hSbBS6Nye01wRDXukIjz8nFX5Nk9vSyKPcxKU2ssbjp6GaxukC6Zx/mzOeGA77lJK+Vf/AxCs7Q1vfaxA86zWnY2qCF/ubOfEhTkiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw7n3n+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw7n3n+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7733C4CEE3;
	Mon, 17 Mar 2025 07:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194880;
	bh=EwWownPK13neyE4WZdGUG3DsFNRwckPSUyx1cbKZcNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw7n3n+cCnLfOKyYoAmFsjPHr+fiVUJ4Sg28VVRE+umaV/MfDShNftA2cJMDfrqju
	 J+XRUW8WIx6KbEZEp7q5R9bgARnFiXv0B+CixbULBHoHLPypvN+06SvBGoPURlXB4M
	 F6hvimzMk8pWMBCaIx18XAqlTvcjjHu9Wxj/GHamo//e2jeEmdW/fQqQNbQQWx5f3Z
	 +S6fBZnnOOPIQTwZbnU6cv8uHmPNmGoR9WOiof3FscIEEVVaOA/AzZY6dl85yp9hmD
	 IqQzxspKvtDhZFJSJRREnzbQlUQtZmbMeweCxk+j+dq41Pn+p4ajhyVc5oigBu9R3N
	 2Nwp0wQe07AOA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 19/31] tty: moxa: drop ISA support
Date: Mon, 17 Mar 2025 08:00:34 +0100
Message-ID: <20250317070046.24386-20-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I doubt anyone actually uses this driver (unlike mxser.c and serial
moxa driven devices). Even less there is anyone with a moxa ISA card.
The newer mxser dropped the support for ISA in 2021. Let this moxa
follow now.

Good diet.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/Kconfig |   2 +-
 drivers/tty/moxa.c  | 100 +++-----------------------------------------
 2 files changed, 6 insertions(+), 96 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..0f3f55372c11 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -210,7 +210,7 @@ config SERIAL_NONSTANDARD
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	depends on SERIAL_NONSTANDARD && PCI
 	select FW_LOADER
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 2b75ca12cbc9..a753afcb53b5 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -355,33 +355,21 @@
 #define MAX_PORTS_PER_BOARD	32	/* Don't change this value */
 #define MAX_PORTS		(MAX_BOARDS * MAX_PORTS_PER_BOARD)
 
-#define MOXA_IS_320(brd) ((brd)->boardType == MOXA_BOARD_C320_ISA || \
-		(brd)->boardType == MOXA_BOARD_C320_PCI)
-
-/*
- *    Define the Moxa PCI vendor and device IDs.
- */
-#define MOXA_BUS_TYPE_ISA	0
-#define MOXA_BUS_TYPE_PCI	1
+#define MOXA_IS_320(brd)	((brd)->boardType == MOXA_BOARD_C320_PCI)
 
 enum {
 	MOXA_BOARD_C218_PCI = 1,
-	MOXA_BOARD_C218_ISA,
 	MOXA_BOARD_C320_PCI,
-	MOXA_BOARD_C320_ISA,
 	MOXA_BOARD_CP204J,
 };
 
 static char *moxa_brdname[] =
 {
 	"C218 Turbo PCI series",
-	"C218 Turbo ISA series",
 	"C320 Turbo PCI series",
-	"C320 Turbo ISA series",
 	"CP-204J series",
 };
 
-#ifdef CONFIG_PCI
 static const struct pci_device_id moxa_pcibrds[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C218),
 		.driver_data = MOXA_BOARD_C218_PCI },
@@ -392,14 +380,12 @@ static const struct pci_device_id moxa_pcibrds[] = {
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, moxa_pcibrds);
-#endif /* CONFIG_PCI */
 
 struct moxa_port;
 
 static struct moxa_board_conf {
 	int boardType;
 	int numPorts;
-	int busType;
 
 	unsigned int ready;
 
@@ -459,9 +445,6 @@ static unsigned int moxaLowWaterChk;
 static DEFINE_MUTEX(moxa_openlock);
 static DEFINE_SPINLOCK(moxa_lock);
 
-static unsigned long baseaddr[MAX_BOARDS];
-static unsigned int type[MAX_BOARDS];
-static unsigned int numports[MAX_BOARDS];
 static struct tty_port moxa_service_port;
 
 MODULE_AUTHOR("William Chen");
@@ -471,13 +454,6 @@ MODULE_FIRMWARE("c218tunx.cod");
 MODULE_FIRMWARE("cp204unx.cod");
 MODULE_FIRMWARE("c320tunx.cod");
 
-module_param_array(type, uint, NULL, 0);
-MODULE_PARM_DESC(type, "card type: C218=2, C320=4");
-module_param_hw_array(baseaddr, ulong, ioport, NULL, 0);
-MODULE_PARM_DESC(baseaddr, "base address");
-module_param_array(numports, uint, NULL, 0);
-MODULE_PARM_DESC(numports, "numports (ignored for C218)");
-
 module_param(ttymajor, int, 0);
 
 /*
@@ -723,7 +699,6 @@ static DEFINE_TIMER(moxaTimer, moxa_poll);
 static int moxa_check_fw_model(struct moxa_board_conf *brd, u8 model)
 {
 	switch (brd->boardType) {
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 		if (model != 1)
 			goto err;
@@ -767,7 +742,6 @@ static int moxa_load_bios(struct moxa_board_conf *brd, const u8 *buf,
 	msleep(2000);
 
 	switch (brd->boardType) {
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 		tmp = readw(baseAddr + C218_key);
 		if (tmp != C218_KeyCode)
@@ -831,7 +805,6 @@ static int moxa_real_load_code(struct moxa_board_conf *brd, const void *ptr,
 
 	switch (brd->boardType) {
 	case MOXA_BOARD_CP204J:
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 		key = C218_key;
 		loadbuf = C218_LoadBuf;
@@ -896,15 +869,9 @@ static int moxa_real_load_code(struct moxa_board_conf *brd, const void *ptr,
 		return -EIO;
 
 	if (MOXA_IS_320(brd)) {
-		if (brd->busType == MOXA_BUS_TYPE_PCI) {	/* ASIC board */
-			writew(0x3800, baseAddr + TMS320_PORT1);
-			writew(0x3900, baseAddr + TMS320_PORT2);
-			writew(28499, baseAddr + TMS320_CLOCK);
-		} else {
-			writew(0x3200, baseAddr + TMS320_PORT1);
-			writew(0x3400, baseAddr + TMS320_PORT2);
-			writew(19999, baseAddr + TMS320_CLOCK);
-		}
+		writew(0x3800, baseAddr + TMS320_PORT1);
+		writew(0x3900, baseAddr + TMS320_PORT2);
+		writew(28499, baseAddr + TMS320_CLOCK);
 	}
 	writew(1, baseAddr + Disable_IRQ);
 	writew(0, baseAddr + Magic_no);
@@ -955,7 +922,6 @@ static int moxa_load_code(struct moxa_board_conf *brd, const void *ptr,
 		return retval;
 
 	switch (brd->boardType) {
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 	case MOXA_BOARD_CP204J:
 		port = brd->ports;
@@ -1139,7 +1105,6 @@ static int moxa_init_board(struct moxa_board_conf *brd, struct device *dev)
 	}
 
 	switch (brd->boardType) {
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 		file = "c218tunx.cod";
 		break;
@@ -1225,7 +1190,6 @@ static void moxa_board_deinit(struct moxa_board_conf *brd)
 	kfree(brd->ports);
 }
 
-#ifdef CONFIG_PCI
 static int moxa_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
@@ -1268,7 +1232,6 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 
 	board->boardType = board_type;
 	switch (board_type) {
-	case MOXA_BOARD_C218_ISA:
 	case MOXA_BOARD_C218_PCI:
 		board->numPorts = 8;
 		break;
@@ -1280,7 +1243,6 @@ static int moxa_pci_probe(struct pci_dev *pdev,
 		board->numPorts = 0;
 		break;
 	}
-	board->busType = MOXA_BUS_TYPE_PCI;
 
 	retval = moxa_init_board(board, &pdev->dev);
 	if (retval)
@@ -1316,14 +1278,10 @@ static struct pci_driver moxa_pci_driver = {
 	.probe = moxa_pci_probe,
 	.remove = moxa_pci_remove
 };
-#endif /* CONFIG_PCI */
 
 static int __init moxa_init(void)
 {
-	unsigned int isabrds = 0;
 	int retval = 0;
-	struct moxa_board_conf *brd = moxa_boards;
-	unsigned int i;
 
 	tty_port_init(&moxa_service_port);
 
@@ -1352,64 +1310,16 @@ static int __init moxa_init(void)
 		return -1;
 	}
 
-	/* Find the boards defined from module args. */
-
-	for (i = 0; i < MAX_BOARDS; i++) {
-		if (!baseaddr[i])
-			break;
-		if (type[i] == MOXA_BOARD_C218_ISA ||
-				type[i] == MOXA_BOARD_C320_ISA) {
-			pr_debug("Moxa board %2d: %s board(baseAddr=%lx)\n",
-					isabrds + 1, moxa_brdname[type[i] - 1],
-					baseaddr[i]);
-			brd->boardType = type[i];
-			brd->numPorts = type[i] == MOXA_BOARD_C218_ISA ? 8 :
-					numports[i];
-			brd->busType = MOXA_BUS_TYPE_ISA;
-			brd->basemem = ioremap(baseaddr[i], 0x4000);
-			if (!brd->basemem) {
-				printk(KERN_ERR "MOXA: can't remap %lx\n",
-						baseaddr[i]);
-				continue;
-			}
-			if (moxa_init_board(brd, NULL)) {
-				iounmap(brd->basemem);
-				brd->basemem = NULL;
-				continue;
-			}
-
-			printk(KERN_INFO "MOXA isa board found at 0x%.8lx and "
-					"ready (%u ports, firmware loaded)\n",
-					baseaddr[i], brd->numPorts);
-
-			brd++;
-			isabrds++;
-		}
-	}
-
-#ifdef CONFIG_PCI
 	retval = pci_register_driver(&moxa_pci_driver);
-	if (retval) {
+	if (retval)
 		printk(KERN_ERR "Can't register MOXA pci driver!\n");
-		if (isabrds)
-			retval = 0;
-	}
-#endif
 
 	return retval;
 }
 
 static void __exit moxa_exit(void)
 {
-	unsigned int i;
-
-#ifdef CONFIG_PCI
 	pci_unregister_driver(&moxa_pci_driver);
-#endif
-
-	for (i = 0; i < MAX_BOARDS; i++) /* ISA boards */
-		if (moxa_boards[i].ready)
-			moxa_board_deinit(&moxa_boards[i]);
 
 	del_timer_sync(&moxaTimer);
 
-- 
2.49.0

