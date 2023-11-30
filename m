Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BttBXVRJ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF081B3;
	Thu, 30 Nov 2023 06:07:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2B794000F;
	Thu, 30 Nov 2023 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701353257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpzdCa8ytD7X29uBioQ7jY/NXgh5rnjsDhzeyzSU0ro=;
	b=BttBXVRJVyDD4HnPCP4cuUeYUnJf3K/nK1fgXQ/ll1+s1Z4F7D1CTD37h/cFUlK9iAbYC3
	xhqNmUO63l6dxwKL/Pcy/RO5XL95xNWFwx8h6wDI1nH5Hygnw8Z2RLhJCVb04Az5tc2Emb
	K/WJ1mnap3oT4yR/ctGMZgFdjYWmKi0Q+Alx5tUbNipesOAIrR0npfLnTk6cGqNH9cxoYh
	3qdxSOUpVVfx+GEGoM1zrlhMoZmuyVVD/jPy8OwKlnaaRFdkWxPsIHTi74GuZ7sIo6uQIX
	P3l9JRf+uKhEHHcKBDiDkZovcUzfNmO659yoJ02vpT8j2pgzAJrCDs8d4JymdA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 30 Nov 2023 15:07:19 +0100
Subject: [PATCH v5 7/9] tty: serial: amba-pl011: fix miscellaneous
 checkpatch warnings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-7-6566703a04b5@bootlin.com>
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

Fix the following messages from checkpatch:

    $ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c

    ERROR: do not initialise statics to false
    WARNING: Possible unnecessary 'out of memory' message
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
             dev_info(dev, ... then pr_info(...  to
    CHECK: Prefer using the BIT macro

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3c657bac2359..d141af8f8a5f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -51,7 +51,7 @@
 #define AMBA_ISR_PASS_LIMIT	256
 
 #define UART_DR_ERROR		(UART011_DR_OE | UART011_DR_BE | UART011_DR_PE | UART011_DR_FE)
-#define UART_DUMMY_DR_RX	(1 << 16)
+#define UART_DUMMY_DR_RX	BIT(16)
 
 enum {
 	REG_DR,
@@ -1109,7 +1109,6 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	uap->dmatx.buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL | __GFP_DMA);
 	if (!uap->dmatx.buf) {
-		dev_err(uap->port.dev, "no memory for DMA TX buffer\n");
 		uap->port.fifosize = uap->fifosize;
 		return;
 	}
@@ -2528,7 +2527,7 @@ static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
 		cpu_relax();
 }
 
-static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
+static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
@@ -2547,7 +2546,7 @@ static void pl011_putc(struct uart_port *port, unsigned char c)
 		cpu_relax();
 }
 
-static void pl011_early_write(struct console *con, const char *s, unsigned n)
+static void pl011_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
@@ -2653,8 +2652,8 @@ static struct uart_driver amba_reg = {
 static int pl011_probe_dt_alias(int index, struct device *dev)
 {
 	struct device_node *np;
-	static bool seen_dev_with_alias = false;
-	static bool seen_dev_without_alias = false;
+	static bool seen_dev_with_alias;
+	static bool seen_dev_without_alias;
 	int ret = index;
 
 	if (!IS_ENABLED(CONFIG_OF))
@@ -2996,7 +2995,7 @@ static struct amba_driver pl011_driver = {
 
 static int __init pl011_init(void)
 {
-	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
+	pr_info("Serial: AMBA PL011 UART driver\n");
 
 	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
 		pr_warn("could not register SBSA UART platform driver\n");

-- 
2.43.0

