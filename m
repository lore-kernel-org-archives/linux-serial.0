From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] RFC: WIP: sc16is7xx.c
Date: Thu, 06 Mar 2014 22:26:46 -0800
Message-ID: <1394173606.16156.51.camel@joe-AO722>
References: <1394159746-1729-1-git-send-email-jon@ringle.org>
	 <20140307055231.GA32019@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140307055231.GA32019@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jon@ringle.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2014-03-06 at 21:52 -0800, Greg KH wrote:
> On Thu, Mar 06, 2014 at 09:35:46PM -0500, jon@ringle.org wrote:
> > From: Jon Ringle <jringle@gridpoint.com>
> >=20
> > I am requesting comments on this serial driver.
> > I am currently having some latency issues with it where I experienc=
e
> > packet loss at speed of 19200.
> >=20
> > I welcome any and all comments.
>=20
> The basic coding style problems make it hard to read to be able to he=
lp
> review it, sorry.
>=20
> Yes, brains have patterns, you want to follow the same patterns as
> others, it matters.

Here's a patternizing patch on top of this...

It's an extended version of what I sent Jon privately.

Mostly whitespace but some other neatening too.
Brace removals, tabifying, 80 column comments,
spelling typos, pr_<level>, c90 comments, etc.

I don't care that's it does a lot of things in
a single patch because this hasn't ever been
submitted before and I hope Jon rolls it into
his next submission.

---
 drivers/tty/serial/sc16is7xx.c | 485 +++++++++++++++++++++------------=
--------
 1 file changed, 253 insertions(+), 232 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
index 5daed84..045241e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1,28 +1,34 @@
 /*
- * The SC16IS740/750/760 is a slave I2C-bus/SPI interface to a single-=
channel high
- * performance UART. The SC16IS740/750/760=E2=80=99s internal register=
 set is backward-compatible
- * with the widely used and widely popular 16C450. The SC16IS740/750/7=
60 also provides
- * additional advanced features such as auto hardware and software flo=
w control, automatic
- * RS-485 support, and software reset.
- *
- * Copyright (C) 2014 GridPoint
+ * SC16IS740/750/760 tty serial driver - Copyright (C) 2014 GridPoint
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
+ * The SC16IS740/750/760 is a slave I2C-bus/SPI interface to a single-=
channel
+ * high performance UART. The SC16IS740/750/760=E2=80=99s internal reg=
ister set is
+ * backward-compatible with the widely used and widely popular 16C450.
+ *
+ * The SC16IS740/750/760 also provides additional advanced features su=
ch as
+ * auto hardware and software flow control, automatic RS-485 support, =
and
+ * software reset.
+ *
  * Notes:
+ *
  * The sc16is740 driver is used for the GPEC RS485 Half duplex communi=
cation.
- * In the EC1K board the sc16is740 RTS line is connected to the SN65HV=
D1780DR chip and which
- * is used to signal the RS485 diretion. When the RTS is low the RS485=
 direction is set to
- * output from the CPU.
- * To set the RS485 diretion we use the sc16is740 internal RS485 featu=
re where the chip drives
- * the RTS line when the data is written to the TX FIFO (see the spec =
note for the EFCR[4] bit
- * configuration).
  *
+ * In the EC1K board the sc16is740 RTS line is connected to a SN65HVD1=
780DR
+ * chip which is used to signal the RS485 direction.
+ * When RTS is low, the RS485 direction is set to output from the CPU.
+ *
+ * To set the RS485 direction we use the sc16is740 internal RS485 feat=
ure
+ * where the chip drives the RTS line when the data is written to the =
TX FIFO
+ * (see the spec note for the EFCR[4] bit configuration).
  */
=20
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
@@ -39,116 +45,139 @@
 #include <linux/tty_flip.h>
 #include <linux/wait.h>
=20
-#define DRV_VERSION 		"0.3"
-#define DRV_NAME            "sc16is7xx"
-#define DEV_NAME            "ttySC"
-#define SC16IS7XX_MAJOR 	204  /* Take place of the /dev/ttySC0 SCI ser=
ial port 0 */
-#define SC16IS7XX_MINOR  	8
+#define DRV_VERSION	"0.3"
+#define DRV_NAME	"sc16is7xx"
+#define DEV_NAME	"ttySC"
+
+#define SC16IS7XX_MAJOR	204	/* Take place of the /dev/ttySC0
+				 * SCI serial port 0
+				 */
+#define SC16IS7XX_MINOR	8
=20
 /*
  * Software Definitions
  */
 /* Commands sent from the uart callbacks to the work handler */
-#define SC16IS7XX_CMND_STOP_RX       (0) /* Disable the RX interrupt *=
/
-#define SC16IS7XX_CMND_START_TX      (1) /* Enable  the TX holding reg=
ister empty interrupt */
-#define SC16IS7XX_CMND_STOP_TX       (2) /* Disable the TX holding reg=
ister empty interrupt */
-#define SC16IS7XX_CMND_NEW_TERMIOS   (3) /* Apply new termios configur=
ation */
-#define SC16IS7XX_CMND_BREAK_CTRL    (4)
-#define SC16IS7XX_CMND_TX_RX         (5)
-
-#define SC16IS7XX_CLEAR_FIFO_ON_TX   /* If defined controller will cle=
ar tx fifo before it transmits chars */
+#define SC16IS7XX_CMND_STOP_RX		(0) /* Disable the RX interrupt */
+#define SC16IS7XX_CMND_START_TX		(1) /* Enable  the TX holding registe=
r
+					     * empty interrupt
+					     */
+#define SC16IS7XX_CMND_STOP_TX		(2) /* Disable the TX holding register
+					     * empty interrupt
+					     */
+#define SC16IS7XX_CMND_NEW_TERMIOS	(3) /* Apply termios configuration =
*/
+#define SC16IS7XX_CMND_BREAK_CTRL	(4)
+#define SC16IS7XX_CMND_TX_RX		(5)
+
+#define SC16IS7XX_CLEAR_FIFO_ON_TX   /* If defined controller will cle=
ar
+				      * tx fifo before it transmits chars
+				      */
=20
 /*
  * SC16IS7XX Hardware Definitions
  */
-#define DA850_RS485_INT_PIN  GPIO_TO_PIN(0,4)
+#define DA850_RS485_INT_PIN	GPIO_TO_PIN(0, 4)
=20
-#define SC16IS7XX_CLK          		7372800 /* crystal clock connected to=
 the SC16IS7XX chip */
-#define SC16IS7XX_DEFAULT_BAUDRATE     19200
+#define SC16IS7XX_CLK		7372800 /* crystal clock connected
+					 * to the SC16IS7XX chip
+					 */
+#define SC16IS7XX_DEFAULT_BAUDRATE	19200
=20
 /* General registers set */
-#define SC16IS7XX_TCR 0x06
-#define SC16IS7XX_TLR 0x07
-#define SC16IS7XX_TXLVL  0x08
-#define SC16IS7XX_RXLVL  0x09
-#define SC16IS7XX_EFCR   0x0F
+#define SC16IS7XX_TCR		0x06
+#define SC16IS7XX_TLR		0x07
+#define SC16IS7XX_TXLVL		0x08
+#define SC16IS7XX_RXLVL		0x09
+#define SC16IS7XX_EFCR		0x0F
=20
 /* LCR / MCR configurations */
-#define UART_LCR_8N1	UART_LCR_WLEN8
+#define UART_LCR_8N1		UART_LCR_WLEN8
=20
-#define SC16IS7XX_LCRVAL UART_LCR_8N1           /* 8 data, 1 stop, no =
parity */
-#define SC16IS7XX_MCRVAL (UART_MCR_DTR|UART_MCR_RTS) /* clock divisor =
=3D 1,UART mode,lpback disabled,RTS/DTR are set,TCR/TLR disabled */
+#define SC16IS7XX_LCRVAL	UART_LCR_8N1	/* 8 data, 1 stop, no parity */
+#define SC16IS7XX_MCRVAL	(UART_MCR_DTR | UART_MCR_RTS)
+						/* clock divisor =3D 1,
+						 * UART mode,
+						 * loopback disabled,
+						 * RTS/DTR are set,
+						 * TCR/TLR disabled
+						 */
=20
 /* SC16IS7XX Internal register address translation */
-#define REG_TO_I2C_ADDR(reg) (((reg) & 0x0f) << 3)
-
-#define SC16IS7XX_FIFO_SIZE 	  64  /* Rx fifo size */
+#define REG_TO_I2C_ADDR(reg)	(((reg) & 0x0f) << 3)
=20
-#define SC16IS7XX_LOAD_SIZE       64  /* Tx fifo size */
+#define SC16IS7XX_FIFO_SIZE	64	/* Rx fifo size */
+#define SC16IS7XX_LOAD_SIZE	64	/* Tx fifo size */
=20
 struct uart_sc16is7xx_port {
 	struct uart_port port;
=20
 	/* private to the driver */
-	struct i2c_client* client; /* I2C client handle */
+	struct i2c_client *client;	/* I2C client handle */
=20
-	int tx_empty;		/* last TX empty bit */
+	int tx_empty;			/* last TX empty bit */
=20
-	unsigned long command;  /* Command to the work executed from the work=
queue */
+	unsigned long command;		/* Command to the work executed
+					 * from the workqueue
+					 */
=20
-	struct ktermios* termios_new;
-	struct ktermios* termios_old;
+	struct ktermios *termios_new;
+	struct ktermios *termios_old;
=20
 	int break_state;
=20
-	char ier; /* cache Interrupt Enable Register to manage the interrupt =
from the work */
+	char ier;	/* cache Interrupt Enable Register to
+			 * manage the interrupt from the work
+			 */
 	char lcr;
-	char fcr; /* cache the FIFO control register to hold write only value=
s of that register */
+	char fcr;	/* cache the FIFO control register to
+			 * hold write only values of that register
+			 */
=20
 	spinlock_t lock;
=20
 	/* set to 1 to make the workhandler exit as soon as possible */
-	int  force_end_work;
+	int force_end_work;
 };
=20
-static inline unsigned char sc16is7xx_read_reg(struct uart_sc16is7xx_p=
ort* up, unsigned char reg)
+static inline unsigned char sc16is7xx_read_reg(struct uart_sc16is7xx_p=
ort *up,
+					       unsigned char reg)
 {
 	int rc;
 	u8 val =3D 0;
-
 	u8 sc_reg =3D REG_TO_I2C_ADDR(reg);
=20
 	rc =3D i2c_master_send(up->client, &sc_reg, 1);
-	if(rc < 0)
-	{
-		dev_err(&up->client->dev,"%s I2C error writing the i2c client rc =3D=
 %d\n",__FUNCTION__, rc);
+	if (rc < 0) {
+		dev_err(&up->client->dev,
+			"%s I2C error writing the i2c client rc =3D %d\n",
+			__func__, rc);
 		goto out;
 	}
=20
 	rc =3D i2c_master_recv(up->client, &val, 1);
-	if(rc < 0)
-	{
-		dev_err(&up->client->dev,"%s I2C error reading from the i2c client r=
c =3D %d\n",__FUNCTION__, rc);
-	}
+	if (rc < 0)
+		dev_err(&up->client->dev,
+			"%s I2C error reading from the i2c client rc =3D %d\n",
+			__func__, rc);
=20
 out:
 	return val;
 }
=20
-static inline void sc16is7xx_write_reg(struct uart_sc16is7xx_port *up,=
 unsigned char reg, unsigned char value)
+static inline void sc16is7xx_write_reg(struct uart_sc16is7xx_port *up,
+				       unsigned char reg, unsigned char value)
 {
 	int rc;
-
 	u8 msg[2];
=20
 	msg[0] =3D REG_TO_I2C_ADDR(reg);
 	msg[1] =3D value;
=20
 	rc =3D i2c_master_send(up->client, msg, 2);
-	if(rc < 0)
-	{
-		dev_err(&up->client->dev,"%s I2C error writing the i2c client rc =3D=
 %d\n",__FUNCTION__, rc);
-	}
+	if (rc < 0)
+		dev_err(&up->client->dev,
+			"%s I2C error writing the i2c client rc =3D %d\n",
+			__func__, rc);
 }
=20
 static void sc16is7xx_enable_irq(struct uart_sc16is7xx_port *up, int m=
ask)
@@ -163,45 +192,54 @@ static void sc16is7xx_disable_irq(struct uart_sc1=
6is7xx_port *up, int mask)
 	sc16is7xx_write_reg(up, UART_IER, up->ier);
 }
=20
-
-static void sc16is7xx_set_baudrate(struct uart_sc16is7xx_port* up, int=
 baudrate)
+static void sc16is7xx_set_baudrate(struct uart_sc16is7xx_port *up, int=
 baudrate)
 {
 	u8 lcr, ier;
 	u32 divisor;
=20
 	ier =3D sc16is7xx_read_reg(up, UART_IER);
 	lcr =3D sc16is7xx_read_reg(up, UART_LCR);
-	sc16is7xx_write_reg(up, UART_IER, 0x00); // Disable interrupts
=20
-	sc16is7xx_write_reg(up, SC16IS7XX_EFCR, 0x06 ); // Disable TX/RX
+	/* Disable interrupts */
+	sc16is7xx_write_reg(up, UART_IER, 0x00);
+
+	/* Disable TX/RX */
+	sc16is7xx_write_reg(up, SC16IS7XX_EFCR, 0x06);
=20
-	sc16is7xx_write_reg(up, UART_LCR, UART_LCR_CONF_MODE_B);   // Open th=
e LCR divisors for configuration
+	/* Open the LCR divisors for configuration */
+	sc16is7xx_write_reg(up, UART_LCR, UART_LCR_CONF_MODE_B);
=20
-	sc16is7xx_write_reg(up, UART_EFR, 0x10);   // Enable enhanced feature=
s and internal clock divider
+	/* Enable enhanced features and internal clock divider */
+	sc16is7xx_write_reg(up, UART_EFR, 0x10);
=20
-	sc16is7xx_write_reg(up, UART_MCR, UART_MCR_CLKSEL|4);  // Set the inp=
ut clock divisor to 1
+	/* Set the input clock divisor to 1 */
+	sc16is7xx_write_reg(up, UART_MCR, UART_MCR_CLKSEL|4);
=20
 	/* Get the baudrate divisor from the upper port layer */
 	divisor =3D uart_get_divisor(&up->port, baudrate);
=20
-	sc16is7xx_write_reg(up, UART_DLL, divisor & 0xff );      // Write the=
 new divisor
+	/* Write the new divisor */
+	sc16is7xx_write_reg(up, UART_DLL, divisor & 0xff);
 	sc16is7xx_write_reg(up, UART_DLM, (divisor >> 8) & 0xff);
=20
-	sc16is7xx_write_reg(up, UART_LCR, lcr);   // Put LCR back to the norm=
al mode
+	/* Put LCR back to the normal mode */
+	sc16is7xx_write_reg(up, UART_LCR, lcr);
=20
 	sc16is7xx_write_reg(up, SC16IS7XX_TLR, 0x0f);
+
+	/* Enable the FIFOs */
 	up->fcr =3D UART_FCR_ENABLE_FIFO;
-	sc16is7xx_write_reg(up, UART_FCR, up->fcr);   // Enable the FIFOs
+	sc16is7xx_write_reg(up, UART_FCR, up->fcr);
=20
-	sc16is7xx_write_reg(up, SC16IS7XX_EFCR, 0x10); // Enable the Rx and T=
x and  control the RTS (RS485_DIR) line
+	/* Enable the Rx and Tx and  control the RTS (RS485_DIR) line */
+	sc16is7xx_write_reg(up, SC16IS7XX_EFCR, 0x10);
=20
-	sc16is7xx_write_reg(up, UART_IER, ier); // Restore the interrupts con=
figuration
+	/* Restore the interrupts configuration */
+	sc16is7xx_write_reg(up, UART_IER, ier);
 }
=20
-/*
- * The function actually delivers the Tx characters to the HW
- */
-static void sc16is7xx_transmit_chars(struct uart_sc16is7xx_port* up)
+/* deliver the Tx characters to the HW */
+static void sc16is7xx_transmit_chars(struct uart_sc16is7xx_port *up)
 {
 	struct circ_buf *xmit =3D &up->port.state->xmit;
 	int count;
@@ -215,6 +253,7 @@ static void sc16is7xx_transmit_chars(struct uart_sc=
16is7xx_port* up)
 		up->port.x_char =3D 0;
 		return;
 	}
+
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
 		up->ier &=3D ~UART_IER_THRI;
 		return;
@@ -235,15 +274,13 @@ static void sc16is7xx_transmit_chars(struct uart_=
sc16is7xx_port* up)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
=20
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit))
 		up->ier &=3D ~UART_IER_THRI;
-	}
 }
=20
-/*
- * The function actually receives the characters from the HW and trans=
fers them up to the TTY layer.
- */
-static inline void sc16is7xx_receive_chars(struct uart_sc16is7xx_port =
*up, int *status)
+/* receives characters from the HW and transfer themto the TTY layer *=
/
+static inline void sc16is7xx_receive_chars(struct uart_sc16is7xx_port =
*up,
+					   int *status)
 {
 	unsigned int ch, flag;
 	int chars =3D 0;
@@ -252,15 +289,13 @@ static inline void sc16is7xx_receive_chars(struct=
 uart_sc16is7xx_port *up, int *
 	dev_dbg(&up->client->dev, "%s\n", __func__);
=20
 	do {
-		if (likely(*status & UART_LSR_DR)) {
+		if (likely(*status & UART_LSR_DR))
 			ch =3D sc16is7xx_read_reg(up, UART_RX);
-		} else {
+		else
 			ch =3D 0xffff;
-		}
=20
-		if (*status & up->port.ignore_status_mask) {
+		if (*status & up->port.ignore_status_mask)
 			goto ignore_char;
-		}
=20
 		flag =3D TTY_NORMAL;
 		up->port.icount.rx++;
@@ -273,64 +308,56 @@ static inline void sc16is7xx_receive_chars(struct=
 uart_sc16is7xx_port *up, int *
 				*status &=3D ~(UART_LSR_FE | UART_LSR_PE);
 				up->port.icount.brk++;
 				/*
-				 * We do the SysRQ and SAK checking
-				 * here because otherwise the break
-				 * may get masked by ignore_status_mask
-				 * or read_status_mask.
+				 * We do the SysRQ and SAK checking here
+				 * because otherwise the break may get masked
+				 * by ignore_status_mask or read_status_mask
 				 */
-				if (uart_handle_break(&up->port)) {
+				if (uart_handle_break(&up->port))
 					goto ignore_char;
-				}
 			} else if (*status & UART_LSR_PE) {
 				up->port.icount.parity++;
 			} else if (*status & UART_LSR_FE) {
 				up->port.icount.frame++;
 			}
-			if (*status & UART_LSR_OE) {
+			if (*status & UART_LSR_OE)
 				up->port.icount.overrun++;
-			}
=20
-			/*
-			 * Mask off conditions which should be ignored.
-			 */
+			/* Mask off conditions which should be ignored */
 			*status &=3D up->port.read_status_mask;
=20
-			if (*status & UART_LSR_BI) {
+			if (*status & UART_LSR_BI)
 				flag =3D TTY_BREAK;
-			} else if (*status & UART_LSR_PE) {
+			else if (*status & UART_LSR_PE)
 				flag =3D TTY_PARITY;
-			} else if (*status & UART_LSR_FE) {
+			else if (*status & UART_LSR_FE)
 				flag =3D TTY_FRAME;
-			}
 		}
=20
-		if (unlikely(0xffff =3D=3D ch)) {
+		if (unlikely(0xffff =3D=3D ch))
 			goto ignore_char;
-		}
=20
-		if (uart_handle_sysrq_char(&up->port, ch)) {
+		if (uart_handle_sysrq_char(&up->port, ch))
 			goto ignore_char;
-		}
=20
 		uart_insert_char(&up->port, *status, UART_LSR_OE, ch, flag);
 		chars++;
=20
 ignore_char:
 		*status =3D sc16is7xx_read_reg(up, UART_LSR);
-	} while ((*status & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0)=
 && !up->force_end_work);
+	} while ((*status & (UART_LSR_DR | UART_LSR_BI)) &&
+		 (max_count-- > 0) && !up->force_end_work);
=20
-	dev_dbg(&up->client->dev, "%s RX:%d chars oe:%d\n", __func__, chars, =
up->port.icount.overrun);
+	dev_dbg(&up->client->dev, "%s RX:%d chars oe:%d\n",
+		__func__, chars, up->port.icount.overrun);
=20
-	if (chars > 0) {
+	if (chars > 0)
 		tty_flip_buffer_push(&(up->port.state->port));
-	}
 }
=20
-static void
-sc16is7xx_set_termios_work(struct uart_sc16is7xx_port *up)
+static void sc16is7xx_set_termios_work(struct uart_sc16is7xx_port *up)
 {
-	struct ktermios* termios =3D up->termios_new;
-	struct ktermios* old =3D up->termios_old;
+	struct ktermios *termios =3D up->termios_new;
+	struct ktermios *old =3D up->termios_old;
 	unsigned long flags;
 	unsigned char cval;
 	unsigned int baud;
@@ -347,8 +374,8 @@ sc16is7xx_set_termios_work(struct uart_sc16is7xx_po=
rt *up)
 	case CS7:
 		cval =3D UART_LCR_WLEN7;
 		break;
-	default:
 	case CS8:
+	default:
 		cval =3D UART_LCR_WLEN8;
 		break;
 	}
@@ -362,29 +389,22 @@ sc16is7xx_set_termios_work(struct uart_sc16is7xx_=
port *up)
=20
 	sc16is7xx_write_reg(up, UART_LCR, cval);
=20
-	/*
-	 * Ask the core to calculate the divisor for us.
-	 */
+	/* Ask the core to calculate the divisor for us */
 	baud =3D uart_get_baud_rate(&up->port, termios, old, 9600, 115200);
 	sc16is7xx_set_baudrate(up, baud);
=20
-	up->port.state->port.low_latency =3D 1; // Low latency since we Tx fr=
om the work queue
+	/* Low latency since we Tx from the work queue */
+	up->port.state->port.low_latency =3D 1;
=20
-	/*
-	 * Update the per-port timeout.
-	 */
+	/* Update the per-port timeout */
 	uart_update_timeout(&up->port, termios->c_cflag, baud);
=20
-	/*
-	 * ignore all characters if CREAD is not set
-	 */
+	/* ignore all characters if CREAD is not set */
 	if ((termios->c_cflag & CREAD) =3D=3D 0)
 		up->port.ignore_status_mask |=3D UART_LSR_DR;
=20
-	if(tty_termios_baud_rate(termios))
-	{
-		tty_termios_encode_baud_rate(termios,baud,baud);
-	}
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
=20
 	spin_unlock_irqrestore(&up->lock, flags);
 }
@@ -395,53 +415,59 @@ static void sc16is7xx_work(struct uart_sc16is7xx_=
port *up)
=20
 	up->ier =3D sc16is7xx_read_reg(up, UART_IER);
=20
-	/* We cannot handle the interrupts while in the work queue so we disa=
ble the RX interrupt.
-	 * It is ok because of during the reception of the characters we chec=
k the status of the
+	/*
+	 * We cannot handle the interrupts while in the work queue so we
+	 * disable the RX interrupt.  It is ok because of during the
+	 * reception of the characters we check the status of the
 	 * interrupt register and process all incoming packets
 	 */
 	sc16is7xx_write_reg(up, UART_IER, 0x00);
=20
-	dev_dbg(&up->client->dev, "%s: start work  command:%04lx ier:0x%02x\n=
", __func__, up->command, (int)up->ier);
+	dev_dbg(&up->client->dev, "%s: start work - command:%04lx ier:0x%02x\=
n",
+		__func__, up->command, (int)up->ier);
=20
-	if(test_and_clear_bit(SC16IS7XX_CMND_NEW_TERMIOS, &up->command)) {
+	if (test_and_clear_bit(SC16IS7XX_CMND_NEW_TERMIOS, &up->command)) {
 		dev_dbg(&up->client->dev, "CMND_NEW_TERMIOS\n");
 		/* User requested the changes in the Terminal Configurations */
 		sc16is7xx_set_termios_work(up);
 	}
=20
-	if(test_and_clear_bit(SC16IS7XX_CMND_BREAK_CTRL, &up->command)) {
-		if (up->break_state =3D=3D -1) {
+	if (test_and_clear_bit(SC16IS7XX_CMND_BREAK_CTRL, &up->command)) {
+		if (up->break_state =3D=3D -1)
 			up->lcr |=3D UART_LCR_SBC;
-		} else {
+		else
 			up->lcr &=3D ~UART_LCR_SBC;
-		}
 		sc16is7xx_write_reg(up, UART_LCR, up->lcr);
 	}
=20
-	if(test_and_clear_bit(SC16IS7XX_CMND_START_TX, &up->command)) {
+	if (test_and_clear_bit(SC16IS7XX_CMND_START_TX, &up->command)) {
 		dev_dbg(&up->client->dev, "CMND_START_TX\n");
 		/* Enable the Tx holding register empty interrupt */
 		up->ier |=3D UART_IER_THRI;
=20
 #ifdef SC16IS7XX_CLEAR_FIFO_ON_TX
 		/* Clear Tx Fifo to remove the junk characters if any */
-		if(up->fcr & UART_FCR_ENABLE_FIFO) {
+		if (up->fcr & UART_FCR_ENABLE_FIFO) {
 			/* Fifo is enabled */
-			sc16is7xx_write_reg(up, UART_FCR, up->fcr & UART_FCR_CLEAR_XMIT);
+			sc16is7xx_write_reg(up, UART_FCR,
+					    up->fcr & UART_FCR_CLEAR_XMIT);
 			dev_dbg(&up->client->dev, "Clear FIFO\n");
 		}
 #endif
 	}
=20
-	if(test_and_clear_bit(SC16IS7XX_CMND_STOP_TX, &up->command)) {
+	if (test_and_clear_bit(SC16IS7XX_CMND_STOP_TX, &up->command)) {
 		dev_dbg(&up->client->dev, "CMND_STOP_TX\n");
 		/* Disable the Tx holding register interrupt  */
 		up->ier &=3D ~UART_IER_THRI;
 	}
=20
-	if(test_and_clear_bit(SC16IS7XX_CMND_STOP_RX, &up->command)) {
+	if (test_and_clear_bit(SC16IS7XX_CMND_STOP_RX, &up->command)) {
 		dev_dbg(&up->client->dev, "CMND_STOP_RX\n");
-		/* User requested to stop the RX interrupt so we clear the interrupt=
 enable register */
+		/*
+		 * User requested to stop the RX interrupt so we clear the
+		 * interrupt enable register
+		 */
 		up->ier &=3D ~UART_IER_RDI;
 	}
=20
@@ -449,35 +475,33 @@ static void sc16is7xx_work(struct uart_sc16is7xx_=
port *up)
 	lsr =3D sc16is7xx_read_reg(up, UART_LSR);
 	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (up->ier & UART_IER_RDI)) =
{
 		sc16is7xx_receive_chars(up, &lsr);
-		if (lsr & (UART_LSR_DR | UART_LSR_BI)) {
-			/* There is more to receive */
+		/* check if there is more to receive */
+		if (lsr & (UART_LSR_DR | UART_LSR_BI))
 			set_bit(SC16IS7XX_CMND_TX_RX, &up->command);
-		}
 	}
=20
-	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
 		sc16is7xx_transmit_chars(up);
-	}
=20
-	if(sc16is7xx_read_reg(up, UART_LSR) & UART_LSR_THRE)
-	{
-		dev_dbg(&up->client->dev, "%s: TX_EMPTY\n", __FUNCTION__);
+	if (sc16is7xx_read_reg(up, UART_LSR) & UART_LSR_THRE) {
+		dev_dbg(&up->client->dev, "%s: TX_EMPTY\n", __func__);
 		up->tx_empty =3D TIOCSER_TEMT;
-	}
-	else
-	{
-		dev_dbg(&up->client->dev, "%s: TX_NOT_EMPTY\n", __FUNCTION__);
-		up->tx_empty =3D 0; /* port is not ready to accept  the new TX chara=
cters */
+	} else {
+		/* port is not ready to accept the new TX characters */
+		dev_dbg(&up->client->dev, "%s: TX_NOT_EMPTY\n", __func__);
+		up->tx_empty =3D 0;
 	}
=20
-	dev_dbg(&up->client->dev, "%s: end work ier 0x%02X\n", __func__, (int=
)up->ier);
+	dev_dbg(&up->client->dev, "%s: end work - ier 0x%02X\n",
+		__func__, (int)up->ier);
=20
-	sc16is7xx_write_reg(up, UART_IER, up->ier); /* Restore the interrupts=
 */
+	/* Restore the interrupts */
+	sc16is7xx_write_reg(up, UART_IER, up->ier);
 }
=20
-static irqreturn_t sc16is7xx_ist(int irq, void* dev_id)
+static irqreturn_t sc16is7xx_ist(int irq, void *dev_id)
 {
-	struct uart_sc16is7xx_port* up =3D (struct uart_sc16is7xx_port *)dev_=
id;
+	struct uart_sc16is7xx_port *up =3D (struct uart_sc16is7xx_port *)dev_=
id;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&up->lock, flags);
@@ -491,18 +515,25 @@ static unsigned int sc16is7xx_tx_empty(struct uar=
t_port *port)
 {
 	struct uart_sc16is7xx_port *up =3D (struct uart_sc16is7xx_port *)port=
;
=20
-	dev_dbg(&up->client->dev, "%s:(%d)\n", __FUNCTION__, up->tx_empty);
+	dev_dbg(&up->client->dev, "%s:(%d)\n", __func__, up->tx_empty);
+
 	return up->tx_empty;
 }
=20
 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int m=
ctrl)
 {
-	/* Just a placeholder. We do not have modem control lines in our RS48=
5 port */
+	/*
+	 * Just a placeholder
+	 * We do not have modem control lines in our RS485 port
+	 */
 }
=20
 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
-	/* Just a placeholder. We do not have modem control lines in our RS48=
5 port */
+	/*
+	 * Just a placeholder
+	 * We do not have modem control lines in our RS485 port
+	 */
 	return TIOCM_CAR | TIOCM_RNG | TIOCM_DSR | TIOCM_CTS;
 }
=20
@@ -548,7 +579,7 @@ static void sc16is7xx_stop_tx(struct uart_port *por=
t)
 	spin_unlock_irqrestore(&up->lock, flags);
 }
=20
-static void sc16is7xxs_enable_ms(struct uart_port* port)
+static void sc16is7xxs_enable_ms(struct uart_port *port)
 {
 	/* Do nothing */
 }
@@ -560,7 +591,7 @@ static void sc16is7xx_break_ctl(struct uart_port *p=
ort, int break_state)
=20
 	spin_lock_irqsave(&up->lock, flags);
=20
-	dev_dbg(&up->client->dev, "%s:(%d)\n", __FUNCTION__, break_state);
+	dev_dbg(&up->client->dev, "%s:(%d)\n", __func__, break_state);
 	up->break_state =3D break_state;
 	set_bit(SC16IS7XX_CMND_BREAK_CTRL, &up->command);
 	sc16is7xx_work(up);
@@ -577,18 +608,15 @@ static void sc16is7xx_shutdown(struct uart_port *=
port)
=20
 	dev_dbg(&up->client->dev, "%s\n", __func__);
=20
-	/*
-	 * Disable interrupts from this port
-	 */
+	/* Disable interrupts from this port */
 	sc16is7xx_disable_irq(up, UART_IER_THRI | UART_IER_RDI);
=20
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	sc16is7xx_write_reg(up, UART_LCR, sc16is7xx_read_reg(up, UART_LCR) & =
~UART_LCR_SBC);
-	sc16is7xx_write_reg(up, UART_FCR, UART_FCR_ENABLE_FIFO |
-			    UART_FCR_CLEAR_RCVR |
-			    UART_FCR_CLEAR_XMIT);
+	/* Disable break condition and FIFOs */
+	sc16is7xx_write_reg(up, UART_LCR,
+			    sc16is7xx_read_reg(up, UART_LCR) & ~UART_LCR_SBC);
+	sc16is7xx_write_reg(up, UART_FCR,
+			    (UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+			     UART_FCR_CLEAR_XMIT));
 	sc16is7xx_write_reg(up, UART_FCR, 0);
=20
 	spin_unlock_irqrestore(&up->lock, flags);
@@ -610,37 +638,37 @@ static int sc16is7xx_startup(struct uart_port *po=
rt)
 	up->break_state =3D -1;
 	up->tx_empty =3D TIOCSER_TEMT;
=20
-	// Disable IRQs to configure
+	/* Disable IRQs to configure */
 	sc16is7xx_write_reg(up, UART_IER, 0);
=20
-	/*
-	 * Now, initialize the UART
-	 */
+	/* Now, initialize the UART */
 	sc16is7xx_write_reg(up, UART_LCR, UART_LCR_8N1);
=20
 	/*
-	 * Clear the FIFO buffers and disable them.
+	 * Clear the FIFO buffers and disable them
 	 * (they will be reenabled in set_termios())
 	 */
-	while(sc16is7xx_read_reg(up, UART_LSR) & (UART_LSR_DR | UART_LSR_BI))
-	{
-		/* Empty the RX holding register to prevent printing stale character=
s on the screen */
+	while (sc16is7xx_read_reg(up, UART_LSR) & (UART_LSR_DR | UART_LSR_BI)=
) {
+		/*
+		 * Empty the RX holding register to prevent printing
+		 * stale characters on the screen
+		 */
 		sc16is7xx_read_reg(up, UART_RX);
 	}
=20
-	/*
-	 * Finally, enable interrupts.
-	 */
+	/* Finally, enable interrupts */
 	sc16is7xx_enable_irq(up, UART_IER_RDI);
=20
 	spin_unlock_irqrestore(&up->lock, flags);
+
 	return 0;
 }
=20
-static void
-sc16is7xx_set_termios(struct uart_port* port, struct ktermios* termios=
, struct ktermios* old)
+static void sc16is7xx_set_termios(struct uart_port *port,
+				  struct ktermios *termios,
+				  struct ktermios *old)
 {
-	struct uart_sc16is7xx_port * up =3D (struct uart_sc16is7xx_port *)por=
t;
+	struct uart_sc16is7xx_port *up =3D (struct uart_sc16is7xx_port *)port=
;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&up->lock, flags);
@@ -678,15 +706,14 @@ static void sc16is7xx_config_port(struct uart_por=
t *port, int flags)
 		up->port.type =3D PORT_SC16IS7XX;
 }
=20
-static int sc16is7xx_verify_port(struct uart_port *port, struct serial=
_struct *ser)
+static int sc16is7xx_verify_port(struct uart_port *port,
+				 struct serial_struct *ser)
 {
-	int ret =3D -EINVAL;
-
 	if (ser->type =3D=3D PORT_UNKNOWN || ser->type =3D=3D PORT_SC16IS7XX)
-		ret =3D 0;
-	return ret;
-}
+		return 0;
=20
+	return -EINVAL;
+}
=20
 static struct uart_ops sc16is7xx_ops =3D {
 	.tx_empty	=3D sc16is7xx_tx_empty,
@@ -701,65 +728,61 @@ static struct uart_ops sc16is7xx_ops =3D {
 	.shutdown	=3D sc16is7xx_shutdown,
 	.set_termios	=3D sc16is7xx_set_termios,
 	.type		=3D sc16is7xx_type,
-	.release_port   =3D sc16is7xx_release_port,
-	.request_port   =3D sc16is7xx_request_port,
+	.release_port	=3D sc16is7xx_release_port,
+	.request_port	=3D sc16is7xx_request_port,
 	.config_port	=3D sc16is7xx_config_port,
 	.verify_port	=3D sc16is7xx_verify_port,
 };
=20
 static struct uart_driver sc16is7xx_uart_driver =3D {
 	.owner		=3D THIS_MODULE,
-	.driver_name =3D DRV_NAME,
-	.dev_name    =3D DEV_NAME,
-	.major       =3D SC16IS7XX_MAJOR,
-	.minor       =3D SC16IS7XX_MINOR,
-	.nr          =3D 1,
+	.driver_name	=3D DRV_NAME,
+	.dev_name	=3D DEV_NAME,
+	.major		=3D SC16IS7XX_MAJOR,
+	.minor		=3D SC16IS7XX_MINOR,
+	.nr		=3D 1,
 };
-static int uart_driver_registered =3D 0;
+
+static int uart_driver_registered;
=20
 static int sc16is7xx_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	int retval;
-	struct uart_sc16is7xx_port* up =3D NULL; /* user port */
+	struct uart_sc16is7xx_port *up =3D NULL; /* user port */
=20
 	if (!uart_driver_registered) {
 		retval =3D uart_register_driver(&sc16is7xx_uart_driver);
 		if (retval) {
-			printk(KERN_ERR "Couldn't register sc16is7xx uart driver\n");
+			pr_err("Couldn't register sc16is7xx uart driver\n");
 			return retval;
 		}
 		uart_driver_registered =3D 1;
 	}
=20
-	up =3D kzalloc(sizeof(struct uart_sc16is7xx_port), GFP_KERNEL);
-	if (!up) {
-		dev_warn(&client->dev,
-			 "kmalloc for sc16is7xx structure failed!\n");
+	up =3D kzalloc(sizeof(*up), GFP_KERNEL);
+	if (!up)
 		return -ENOMEM;
-	}
=20
 	/* First check if adaptor is OK and it supports our I2C functionality=
 */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
-	{
-		dev_err(&client->dev,"Can't find the sc16is7xx chip\n");
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "Can't find the sc16is7xx chip\n");
 		retval =3D -ENODEV;
 		goto exit;
 	}
=20
-	dev_info(&client->dev,"chip found, driver version " DRV_VERSION "\n")=
;
+	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n"=
);
=20
 	/* Configure the GPIO IRQ line */
 	retval =3D gpio_request(DA850_RS485_INT_PIN, "SC16IS7xx INT");
-
-	if(retval)
-	{
-		dev_err(&client->dev,"Can't request gpio interrupt pin \n");
+	if (retval) {
+		dev_err(&client->dev, "Can't request gpio interrupt pin\n");
 		retval =3D -EIO;
 		goto exit;
 	}
=20
-	gpio_direction_input(DA850_RS485_INT_PIN); // Set GPIO IRQ pin to be =
input
+	/* Set GPIO IRQ pin to be input */
+	gpio_direction_input(DA850_RS485_INT_PIN);
=20
 	up->client =3D client;
=20
@@ -768,8 +791,8 @@ static int sc16is7xx_probe(struct i2c_client *clien=
t,
 	up->port.uartclk =3D SC16IS7XX_CLK;
 	up->port.fifosize =3D SC16IS7XX_FIFO_SIZE;
 	up->port.ops =3D &sc16is7xx_ops;
-	up->port.iotype   =3D UPIO_PORT;
-	up->port.flags    =3D UPF_FIXED_TYPE | UPF_FIXED_PORT;
+	up->port.iotype =3D UPIO_PORT;
+	up->port.flags =3D UPF_FIXED_TYPE | UPF_FIXED_PORT;
 	up->port.line =3D 0;
 	up->port.type =3D PORT_SC16IS7XX;
 	up->port.dev =3D &client->dev;
@@ -780,7 +803,7 @@ static int sc16is7xx_probe(struct i2c_client *clien=
t,
 			 "uart_add_one_port failed with error %d\n",
 			 retval);
=20
-	i2c_set_clientdata(client,up);
+	i2c_set_clientdata(client, up);
=20
 	/* Disable interrupts */
 	up->ier =3D 0;
@@ -790,7 +813,8 @@ static int sc16is7xx_probe(struct i2c_client *clien=
t,
 				      NULL, sc16is7xx_ist,
 				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				      DRV_NAME, up) < 0) {
-		dev_err(&up->client->dev, "cannot allocate irq %d\n", up->port.irq);
+		dev_err(&up->client->dev, "cannot allocate irq %d\n",
+			up->port.irq);
 		return -EBUSY;
 	}
=20
@@ -805,10 +829,8 @@ static int sc16is7xx_remove(struct i2c_client *cli=
ent)
 {
 	struct uart_sc16is7xx_port *up =3D i2c_get_clientdata(client);
=20
-	if(!uart_driver_registered)
-	{
+	if (!uart_driver_registered)
 		return 0;
-	}
=20
 	devm_free_irq(&client->dev, up->port.irq, up);
=20
@@ -816,7 +838,6 @@ static int sc16is7xx_remove(struct i2c_client *clie=
nt)
 	dev_dbg(&client->dev, "%s: removing port\n", __func__);
 	uart_remove_one_port(&sc16is7xx_uart_driver, &up->port);
 	kfree(up);
-	up =3D NULL;
=20
 	pr_debug("removing sc16is7xx driver\n");
 	uart_unregister_driver(&sc16is7xx_uart_driver);
@@ -827,7 +848,7 @@ static int sc16is7xx_remove(struct i2c_client *clie=
nt)
 }
=20
 static const struct i2c_device_id sc16is7xx_i2c_id[] =3D {
-	{ "sc16is7xx",0},
+	{ "sc16is7xx", 0},
 	{ }
 };
=20
