From: Feng Tang <feng.tang@intel.com>
Subject: Re: pch_uart and pch_phub clock selection
Date: Mon, 20 Feb 2012 13:57:08 +0800
Message-ID: <20120220055708.GA4903@feng-i7>
References: <4F3DA617.5030805@linux.intel.com>
 <20120217072808.GA26800@feng-i7>
 <CANKRQnhfQyUrMWaXJVsjmL-yFnHa9WuR5LfTkqv=QmRGnC2aTw@mail.gmail.com>
 <4F3E9909.7010301@linux.intel.com>
 <CANKRQnihp+CO9yz3SfEL=kFO18SMUJnU_LdELViPsNmd-Ew8yw@mail.gmail.com>
 <20120220044322.GA4113@feng-i7>
 <CANKRQniP+OxrqhL=7eE1NpGf_umyA-GHLSYaiF+o-o=OT2iL_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20978 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab2BTF6O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Feb 2012 00:58:14 -0500
Content-Disposition: inline
In-Reply-To: <CANKRQniP+OxrqhL=7eE1NpGf_umyA-GHLSYaiF+o-o=OT2iL_w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Darren Hart <dvhart@linux.intel.com>, "lkml," <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Hi Tomoya,

On Mon, Feb 20, 2012 at 02:42:32PM +0900, Tomoya MORINAGA wrote:
> 2012=E5=B9=B42=E6=9C=8820=E6=97=A513:43 Feng Tang <feng.tang@intel.co=
m>:
> > Can we also set ML7213/7223's
> > default clk to 192MHz? 192MHz works fine on my ML7213 board. And us=
ing an
> > unified default clock rate for all EG20T compatible IOHs will save =
extra
> > effort of setting the uart clock.
> >
> Yes, you can also use 192MHz for both ML7213 and ML7223.
> In fact, we've already confirmed 192MHz works fine. (Windows driver).
> thanks,

Great! and glad to hear that. Could you update your patch which only to=
uches
the EG20T UART clock setting? like taking the register setting code out=
 of
the "switch/case" loop. something like:

---------------
diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 10fc478..299524c 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -55,7 +55,7 @@
 #define CLKCFG_CANCLK_MASK 0xFF000000
 #define CLKCFG_UART_MASK			0xFFFFFF
=20
-/* CM-iTC */
+/* 192MHz Clock configuration. USB_48MHz / 2 * 8 =3D 192 */
 #define CLKCFG_UART_48MHZ			(1 << 16)
 #define CLKCFG_BAUDDIV				(2 << 20)
 #define CLKCFG_PLL2VCO				(8 << 9)
@@ -714,9 +714,13 @@ static int __devinit pch_phub_probe(struct pci_dev=
 *pdev,
=20
 	chip->pdev =3D pdev; /* Save pci device struct */
=20
-	if (id->driver_data =3D=3D 1) { /* EG20T PCH */
-		const char *board_name;
+	pch_phub_read_modify_write_reg(chip,
+					(unsigned int)CLKCFG_REG_OFFSET,
+					CLKCFG_UART_48MHZ | CLKCFG_BAUDDIV |
+					CLKCFG_PLL2VCO | CLKCFG_UARTCLKSEL,
+					CLKCFG_UART_MASK);
=20
+	if (id->driver_data =3D=3D 1) { /* EG20T PCH */
 		retval =3D sysfs_create_file(&pdev->dev.kobj,
 					   &dev_attr_pch_mac.attr);
 		if (retval)
@@ -731,15 +735,6 @@ static int __devinit pch_phub_probe(struct pci_dev=
 *pdev,
 					       CLKCFG_CAN_50MHZ,
 					       CLKCFG_CANCLK_MASK);
=20
-		/* quirk for CM-iTC board */
-		board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
-		if (board_name && strstr(board_name, "CM-iTC"))
-			pch_phub_read_modify_write_reg(chip,
-						(unsigned int)CLKCFG_REG_OFFSET,
-						CLKCFG_UART_48MHZ | CLKCFG_BAUDDIV |
-						CLKCFG_PLL2VCO | CLKCFG_UARTCLKSEL,
-						CLKCFG_UART_MASK);
-
 		/* set the prefech value */
 		iowrite32(0x000affaa, chip->pch_phub_base_address + 0x14);
 		/* set the interrupt delay value */
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uar=
t.c
index 17ae657..b6ec42a 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -203,7 +203,7 @@ enum {
=20
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
=20
-#define DEFAULT_BAUD_RATE 1843200 /* 1.8432MHz */
+#define DEFAULT_UART_CLOCK 192000000 /* 192.0MHz */
=20
 struct pch_uart_buffer {
 	unsigned char *buf;
@@ -287,6 +287,7 @@ static struct pch_uart_driver_data drv_dat[] =3D {
 static struct eg20t_port *pch_uart_ports[PCH_UART_NR];
 #endif
 static unsigned int default_baud =3D 9600;
+static unsigned int clock_param =3D 0;
 static const int trigger_level_256[4] =3D { 1, 64, 128, 224 };
 static const int trigger_level_64[4] =3D { 1, 16, 32, 56 };
 static const int trigger_level_16[4] =3D { 1, 4, 8, 14 };
@@ -1507,7 +1508,7 @@ static int __init pch_console_setup(struct consol=
e *co, char *options)
 		return -ENODEV;
=20
 	/* setup uartclock */
-	port->uartclk =3D DEFAULT_BAUD_RATE;
+	port->uartclk =3D clock_param ? clock_param : DEFAULT_UART_CLOCK;
=20
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1553,7 +1554,6 @@ static struct eg20t_port *pch_uart_init_port(stru=
ct pci_dev *pdev,
 	int fifosize, base_baud;
 	int port_type;
 	struct pch_uart_driver_data *board;
-	const char *board_name;
=20
 	board =3D &drv_dat[id->driver_data];
 	port_type =3D board->port_type;
@@ -1566,12 +1566,10 @@ static struct eg20t_port *pch_uart_init_port(st=
ruct pci_dev *pdev,
 	if (!rxbuf)
 		goto init_port_free_txbuf;
=20
-	base_baud =3D DEFAULT_BAUD_RATE;
+	base_baud =3D DEFAULT_UART_CLOCK;
=20
-	/* quirk for CM-iTC board */
-	board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
-	if (board_name && strstr(board_name, "CM-iTC"))
-		base_baud =3D 192000000; /* 192.0MHz */
+	/* The module parameter overrides default. */
+	uart_clock =3D clock_param ? clock_param : uart_clock;
=20
 	switch (port_type) {
 	case PORT_UNKNOWN:
>=20
> ---
> ROHM Co., Ltd.
> tomoya
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
