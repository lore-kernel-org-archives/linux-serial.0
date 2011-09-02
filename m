From: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>
Subject: [PATCH] serial: Support the EFR-register of XR1715x uarts.
Date: Fri,  2 Sep 2011 22:52:24 +0200
Message-ID: <1314996744-2878-1-git-send-email-sgh@sgh.dk>
References: <20110902132838.5481f302@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:45043 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755787Ab1IBVCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Sep 2011 17:02:00 -0400
Received: from 5634f1b4.rev.stofanet.dk ([86.52.241.180] helo=asrock)
	by mx01.stofanet.dk (envelope-from
	<sgh@sgh.dk>)
	with esmtp id 1Qzaj1-0007wN-2O
	for linux-serial@vger.kernel.org; Fri, 02 Sep 2011 22:52:31 +0200
In-Reply-To: <20110902132838.5481f302@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>

The EFR (Enhenced-Features-Register) is located at a different offset
than the other devices supporting UART_CAP_EFR. This change add a speci=
al
setup quick to set UPF_EXAR_EFR on the port. UPF_EXAR_EFR is then used =
to
the port type to PORT_XR17D15X since it is for sure a XR17D15X uart.

Signed-off-by: S=C3=B8ren Holm <sgh@sgh.dk>
---
 drivers/tty/serial/8250.c     |   20 +++++++++++++++++++-
 drivers/tty/serial/8250_pci.c |   33 +++++++++++++++++++++++++++++++++
 include/linux/serial_core.h   |    4 +++-
 include/linux/serial_reg.h    |    1 +
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 7f50999..7572666 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -309,6 +309,13 @@ static const struct serial8250_config uart_config[=
] =3D {
 				  UART_FCR_T_TRIG_01,
 		.flags		=3D UART_CAP_FIFO | UART_CAP_RTOIE,
 	},
+	[PORT_XR17D15X] =3D {
+		.name		=3D "XR17D15X",
+		.fifo_size	=3D 64,
+		.tx_loadsz	=3D 64,
+		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		=3D UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR,
+	},
 };
=20
 #if defined(CONFIG_MIPS_ALCHEMY)
@@ -1120,6 +1127,14 @@ static void autoconfig_16550a(struct uart_8250_p=
ort *up)
 	serial_outp(up, UART_IER, iersave);
=20
 	/*
+	 * Exar uarts have EFR in a weird location
+	 */
+	if (up->port.flags & UPF_EXAR_EFR) {
+		up->port.type =3D PORT_XR17D15X;
+		up->capabilities |=3D UART_CAP_AFE | UART_CAP_EFR;
+	}
+
+	/*
 	 * We distinguish between 16550A and U6 16550A by counting
 	 * how many bytes are in the FIFO.
 	 */
@@ -2458,7 +2473,10 @@ serial8250_do_set_termios(struct uart_port *port=
, struct ktermios *termios,
 			efr |=3D UART_EFR_CTS;
=20
 		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_outp(up, UART_EFR, efr);
+		if (up->port.flags & UPF_EXAR_EFR)
+			serial_outp(up, UART_XR_EFR, efr);
+		else
+			serial_outp(up, UART_EFR, efr);
 	}
=20
 #ifdef CONFIG_ARCH_OMAP
diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pc=
i.c
index 3abeca2..52247da 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -1101,6 +1101,15 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #endif
 }
=20
+static int
+pci_xr17c154_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_port *port, int idx)
+{
+	port->flags |=3D UPF_EXAR_EFR;
+	return pci_default_setup(priv, board, port, idx);
+}
+
 /* This should be in linux/pci_ids.h */
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
@@ -1506,6 +1515,30 @@ static struct pci_serial_quirk pci_serial_quirks=
[] __refdata =3D {
 		.setup		=3D pci_timedia_setup,
 	},
 	/*
+	 * Exar cards
+	 */
+	{
+		.vendor =3D PCI_VENDOR_ID_EXAR,
+		.device =3D PCI_DEVICE_ID_EXAR_XR17C152,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.setup		=3D pci_xr17c154_setup,
+	},
+	{
+		.vendor =3D PCI_VENDOR_ID_EXAR,
+		.device =3D PCI_DEVICE_ID_EXAR_XR17C154,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.setup		=3D pci_xr17c154_setup,
+	},
+	{
+		.vendor =3D PCI_VENDOR_ID_EXAR,
+		.device =3D PCI_DEVICE_ID_EXAR_XR17C158,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.setup		=3D pci_xr17c154_setup,
+	},
+	/*
 	 * Xircom cards
 	 */
 	{
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a5c3114..01aa96b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -46,7 +46,8 @@
 #define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
 #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
-#define PORT_MAX_8250	20	/* max port ID */
+#define PORT_XR17D15X	21	/* Exar XR17D15x UART */
+#define PORT_MAX_8250	21	/* max port ID */
=20
 /*
  * ARM specific type numbers.  These are not currently guaranteed
@@ -350,6 +351,7 @@ struct uart_port {
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
+#define UPF_EXAR_EFR		((__force upf_t) (1 << 25))
 /* The exact UART type is known and should not be probed.  */
 #define UPF_FIXED_TYPE		((__force upf_t) (1 << 27))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index c75bda3..8ce70d7 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -152,6 +152,7 @@
  * LCR=3D0xBF (or DLAB=3D1 for 16C660)
  */
 #define UART_EFR	2	/* I/O: Extended Features Register */
+#define UART_XR_EFR	9	/* I/O: Extended Features Register (XR17D15x) */
 #define UART_EFR_CTS		0x80 /* CTS flow control */
 #define UART_EFR_RTS		0x40 /* RTS flow control */
 #define UART_EFR_SCD		0x20 /* Special character detect */
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
