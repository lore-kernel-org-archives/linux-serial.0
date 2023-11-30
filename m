Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kxrmXO2p"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6585196;
	Thu, 30 Nov 2023 06:07:36 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3482C40003;
	Thu, 30 Nov 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701353255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7vbdl0phWxmXqUNa5odOWDQ5PiPNBLg4EXYyhdyx1Q=;
	b=kxrmXO2pD/RvqeUbb1b13xx7xVNZXcsWd5lr4hZYIc3cFLhByFdzZeGk0W3c9kRZic0WxJ
	u3Lck3xl6q8x/O6QtGCnvKisWgZowEWNo5WjPvtUDuXv7hC5luoyjB1TYDC8xOgBQSWgnE
	fbkpHwZpVjWDibSRCA+L6Z+X6an5Rg9DgO9eGA1tGQEhIpxKOVu+z8nWrhcyEbf4He/QeF
	doiPogFV51DF3qbIDil3+aO5p1qZqCevLZpTtZBSo4NdYdTtbmUsZJPQFGCvpshavrmgOd
	q15d6k93uuPTJnnwo0+Dbwm7xkMiNzgbKDTPwtvQQXgO9SHzfsS3diEzhQkUtg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 30 Nov 2023 15:07:16 +0100
Subject: [PATCH v5 4/9] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-4-6566703a04b5@bootlin.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com

The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
simplify the logic. Those look scary to checkpatch because they contain
ifs without do-while loops.

Avoid the macros by creating small equivalent static functions; that
lets the compiler do its type checking & avoids checkpatch errors.

For the second instance __assign_bit is not usable because it deals with
unsigned long pointers whereas we have an unsigned int in
pl011_set_mctrl.

This addresses the following checkpatch warnings:

    $ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c

    ERROR: Macros starting with if should be enclosed by a do -
           while loop to avoid possible if/else logic defects

    CHECK: Macro argument 'uartbit' may be better as '(uartbit)' to
           avoid precedence issues

    ERROR: Macros starting with if should be enclosed by a do - while
           loop to avoid possible if/else logic defects

    CHECK: Macro argument 'tiocmbit' may be better as '(tiocmbit)' to
           avoid precedence issues

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7bd0b68ef92f..743dee75c68b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1589,6 +1589,12 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+}
+
 static unsigned int pl011_get_mctrl(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1596,18 +1602,22 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 	unsigned int result = 0;
 	unsigned int status = pl011_read(uap, REG_FR);
 
-#define TIOCMBIT(uartbit, tiocmbit)	\
-	if (status & uartbit)		\
-		result |= tiocmbit
+	pl011_maybe_set_bit(status & UART01x_FR_DCD, &result, TIOCM_CAR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_dsr, &result, TIOCM_DSR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_cts, &result, TIOCM_CTS);
+	pl011_maybe_set_bit(status & uap->vendor->fr_ri, &result, TIOCM_RNG);
 
-	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
-	TIOCMBIT(uap->vendor->fr_dsr, TIOCM_DSR);
-	TIOCMBIT(uap->vendor->fr_cts, TIOCM_CTS);
-	TIOCMBIT(uap->vendor->fr_ri, TIOCM_RNG);
-#undef TIOCMBIT
 	return result;
 }
 
+static void pl011_assign_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+	else
+		*ptr &= ~mask;
+}
+
 static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_amba_port *uap =
@@ -1616,23 +1626,16 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	cr = pl011_read(uap, REG_CR);
 
-#define	TIOCMBIT(tiocmbit, uartbit)		\
-	if (mctrl & tiocmbit)		\
-		cr |= uartbit;		\
-	else				\
-		cr &= ~uartbit
-
-	TIOCMBIT(TIOCM_RTS, UART011_CR_RTS);
-	TIOCMBIT(TIOCM_DTR, UART011_CR_DTR);
-	TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
-	TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
-	TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
+	pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTS);
+	pl011_assign_bit(mctrl & TIOCM_DTR, &cr, UART011_CR_DTR);
+	pl011_assign_bit(mctrl & TIOCM_OUT1, &cr, UART011_CR_OUT1);
+	pl011_assign_bit(mctrl & TIOCM_OUT2, &cr, UART011_CR_OUT2);
+	pl011_assign_bit(mctrl & TIOCM_LOOP, &cr, UART011_CR_LBE);
 
 	if (port->status & UPSTAT_AUTORTS) {
 		/* We need to disable auto-RTS if we want to turn RTS off */
-		TIOCMBIT(TIOCM_RTS, UART011_CR_RTSEN);
+		pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTSEN);
 	}
-#undef TIOCMBIT
 
 	pl011_write(cr, uap, REG_CR);
 }

-- 
2.43.0

