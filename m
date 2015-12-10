From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Thu, 10 Dec 2015 12:33:38 +0200
Message-ID: <20151210103338.GE4884@kuha.fi.intel.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1445158908-9610-1-git-send-email-noamc@ezchip.com>
 <20151209131939.GA14285@kuha.fi.intel.com>
 <DB5PR02MB1141B69C5E327950511F4590D6E90@DB5PR02MB1141.eurprd02.prod.outlook.com>
 <20151210093104.GD4884@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151210093104.GD4884@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>
List-Id: linux-serial@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 11:31:04AM +0200, Heikki Krogerus wrote:
> Hi Noam,
> 
> On Thu, Dec 10, 2015 at 07:26:42AM +0000, Noam Camus wrote:
> > >From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com] 
> > >Sent: Wednesday, December 09, 2015 3:20 PM
> > 
> > 
> > >> @@ -171,7 +174,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
> > >>  			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
> > >>  				return;
> > >>  			dw8250_force_idle(p);
> > >> -			writel(value, p->membase + (UART_LCR << p->regshift));
> > >> +			d->serial_out(value,
> > >> +				      p->membase + (UART_LCR << p->regshift));
> > >>  		}
> > 
> > >.. The way I see it, this is the only place where you would really need the
> > >new private serial_in/out hooks, so why not just check the >iotype here and
> > >based on that use writeb/writel/iowrite32be or what ever ..
> > 
> > In previous versions (V2) Greg dis-liked using iotype here this is why I added
> > the private serial_in/serial_out
> 
> I couldn't find that comment in the thread? All he said in his
> comment for this was that you should use real if condition instead of
> the ternary operator you had there (condition ? true : false).
> 
> Why would it not be acceptable? If it would really not be acceptable
> (which I don't believe) then you should simply duplicate the lcr
> checking to dw8250_seria_out32be like it is done now in
> dw8250_serial_out and dw8250_serial_out32, but there still is no need
> for the private serial_in/out hooks.
> 
> I'm attaching a diff that I think would work as a good starting point
> for you.

Now actually attaching the diff :).

-- 
heikki

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dw8250_check_lcr.diff"

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a5d319e..b2ea0c2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -95,25 +95,39 @@ static void dw8250_force_idle(struct uart_port *p)
 	(void)p->serial_in(p, UART_RX);
 }
 
+static void dw8250_check_lcr(struct uart_port *p, int value)
+{
+	void __iomem *offset = p->membase + (UART_LCR << p->regshift);
+	int tries = 1000;
+
+	while (tries--) {
+		unsigned int lcr = p->serial_in(p, UART_LCR);
+
+		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+			return;
+
+		dw8250_force_idle(p);
+
+		if (p->iotype == UPIO_MEM32)
+			writel(value, offset);
+		else
+			writeb(value, offset);
+	}
+	/*
+	 * FIXME: this deadlocks if port->lock is already held
+	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
+	 */
+}
+
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
+	struct dw8250_data *d = p->private_data;
+
 	writeb(value, p->membase + (offset << p->regshift));
 
 	/* Make sure LCR write wasn't ignored */
-	if (offset == UART_LCR) {
-		int tries = 1000;
-		while (tries--) {
-			unsigned int lcr = p->serial_in(p, UART_LCR);
-			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-				return;
-			dw8250_force_idle(p);
-			writeb(value, p->membase + (UART_LCR << p->regshift));
-		}
-		/*
-		 * FIXME: this deadlocks if port->lock is already held
-		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-		 */
-	}
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
 }
 
 static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
@@ -161,23 +175,13 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
+	struct dw8250_data *d = p->private_data;
+
 	writel(value, p->membase + (offset << p->regshift));
 
 	/* Make sure LCR write wasn't ignored */
-	if (offset == UART_LCR) {
-		int tries = 1000;
-		while (tries--) {
-			unsigned int lcr = p->serial_in(p, UART_LCR);
-			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-				return;
-			dw8250_force_idle(p);
-			writel(value, p->membase + (UART_LCR << p->regshift));
-		}
-		/*
-		 * FIXME: this deadlocks if port->lock is already held
-		 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
-		 */
-	}
+	if (offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_check_lcr(p, value);
 }
 
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
@@ -463,10 +467,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
-	if (data->uart_16550_compatible) {
-		p->serial_out = NULL;
+	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
-	}
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);

--y0ulUmNC+osPPQO6--
