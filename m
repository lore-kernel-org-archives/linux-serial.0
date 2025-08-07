Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A43237173;
	Thu,  7 Aug 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567609; cv=none; b=UM1BPZ5YdfViMFgqkdk60kJ/OBJpQ0mPFnxzyNAJvgPZpZWshptokdkggNvfpU9M68fDdqRWAgkxAB0f8JiHGeszUx7Iej9zc7No94wXMTHsWCAJ8Or6vP5kYhFJvYkv72o8UU53mR1e2Hqb7alLJiAhL/7b8YVdpQNrwpYXSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567609; c=relaxed/simple;
	bh=raVP6jzxD8zZ6p32e92Fcnv4BYL7lhEBRGyciV9Xnhw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jtq2/QWtXP98GrDHp2q0o+lfoU8b19hFiGi7j7X5wFJzCtAl3ixjIs8xKHDYsJ4/hOvdwOlIbn+KCasLyCA2cdDFvHdHLLqNV4JWO2eTewyU0gj+929nlj/89y25rCpXP/T0c8ah/RfiyZ06aMIjdiKHtM2ZlMTfNQ5Fs224lCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RAx5L6l6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnxmZrZ7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RAx5L6l6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnxmZrZ7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C84C14001BD;
	Thu,  7 Aug 2025 07:53:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 07:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754567603;
	 x=1754654003; bh=y4jR1b23izKJTNlU5nUUGBsipjy9tpfKgofE30JFEJE=; b=
	RAx5L6l6JB+Cxpk0hbG3SEWMpkSR1BEpfqvfgD+OKQ0OnDu3tJjxS07s2ahMs5mh
	wqx1wRjRNER11G7Rch2W/qc9kqqB9uwBYjgCH/K0S7O0pm16tJ4uBpzVX519rejz
	sh7bw+3FN4YiBhTIcGa/A/e/IzxStW0d/7njUB1i5QJga116QRUBNifZ86iprOCp
	i3iPPAHCtHb6QhS0Jox8i8qcMSMMzpRKO2uE/4fDXYEIjTavJ56S0tR0qEmYhS68
	/qSbmiv/2VvBtzeF0BvTW5DUuyZ5PxEIIvQPXKipm/3M9UeQ7Rc1YH2phkNoY4K3
	3QBtEaesupES/oMxjEcXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754567603; x=
	1754654003; bh=y4jR1b23izKJTNlU5nUUGBsipjy9tpfKgofE30JFEJE=; b=B
	nxmZrZ7XHgiI2CTgnc1od3waL8yW9bU1kUcDVhhBTMw5CUiz5uD+qx2Z0BKkgj7Z
	prkC52Y/OCOv3DX8xqDz8o3+1iHz566lFXRhf2OU9wVb+CsCpyLlv942A/PIlBJR
	3382mwTsy0JgkOHaWrlpBH8dtkDPYnnQLtmC1Vgv0b5px3YpAZF54sdnqK8uKdmE
	66Zl2Kdg54TjdDkuEsX7WjJESQxLYSEO1lhVNgLNccKhM0SiDqZrceT8XadjZoYb
	m72K5tEvXwvYI5VGopTLDHUbqX29IncMdtK8S2iwJuk4X+YRvyOaSG7Xb8fIvpB7
	0Ow0QNVse/8MSNJHVIuiw==
X-ME-Sender: <xms:spOUaPlAqxU-k2aMPEkEjfmkFW_QsaQBFr77MkzBRgax4xKaoRnCCQ>
    <xme:spOUaC18zDGo9-8_rifpIu1kJTSSt9j3GQXAqojKC2HwXnTtZjZqMwpELCj1VjTlu
    7StRORI9JANwV73lEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdeuheehieefkeetledtteegvdduveekveehtdfffffgtdevudffffekffelhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhorhhtrdguvghvpdhpohhrthdrph
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghr
    nhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgt
    ohhmpdhrtghpthhtoheprggsihhnrghshhhsihhnghhhlhgrlhhothhrrgesghhmrghilh
    drtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepshhunhhilhhvlhesvhgvnhhtrghnrghmihgtrhhordgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:spOUaDEqmx8zcjQPYTLmQWW2mwFuIDE0lleBBcs-q14XXufYCL4mhQ>
    <xmx:spOUaNPRQsdnSDfzNkAqkzUMzGrddmG3e2s3QzNbuP_69Sk91EoGZA>
    <xmx:spOUaE6eB1amRwXzacbAvaABKkaKwLdeZxboreh3lHo3IJiMcA4-lQ>
    <xmx:spOUaAir4I6OeqEjhlT4U66L_AcVASzevTXRVjg5PWFK6V__5YzDfw>
    <xmx:s5OUaDPDH-tEknXj0IT71Hu19cgcvsy7t1rBvJPtMC7yObJ_RyoORILv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B486700065; Thu,  7 Aug 2025 07:53:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1663be770c67d725
Date: Thu, 07 Aug 2025 13:52:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Slaby" <jirislaby@kernel.org>,
 "Abinash Singh" <abinashsinghlalotra@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <a6640a90-a1bb-4d71-b324-e27e98d73996@app.fastmail.com>
In-Reply-To: <22204a4a-9c10-4aca-8159-a0e69c74cb34@kernel.org>
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
 <f765eae4-f83e-4c25-9697-2705afd7b9b8@app.fastmail.com>
 <b9f715c0-082f-46a3-b332-d5f6bf53ad71@kernel.org>
 <22204a4a-9c10-4aca-8159-a0e69c74cb34@kernel.org>
Subject: Re: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in
 serial8250_probe_acpi()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 7, 2025, at 08:43, Jiri Slaby wrote:
> On 07. 08. 25, 7:25, Jiri Slaby wrote:
>> On 06. 08. 25, 9:01, Arnd Bergmann wrote:
>>> Note how serial8250_register_8250_port() ands up just copying
>>> individual members of the passed uart_8250_port structure into
>>> the global array of the same type, so one way of addressing
>>> this would be to use a structure for initialization that only
>>> contains a subset of the uart_8250_port members and can still
>>> be allocated on the stack, or possibly be constant.
>> 
>> Yes:
>> https://lore.kernel.org/all/ 
>> f84c2ee3-77b4-41c4-8517-26dfb44a2276@kernel.org/
>
> As a PoC, these members from uart_8250_port are really used in 
> serial8250_register_8250_port():

Nice, that does look helpful!

I was thinking about looking for the same members the other
way, seeing which fields are getting initialized by the various
callers, as I expect that by now we have gained a couple of
read-only or write-only members that we don't really need to
pass any more.

I the diff below I have removed all assignments to the local
uart_8250_port structures that get passed into
serial8250_register_8250_port() for reference, but I have
not yet cross-checked them against the members you found.

     Arnd

diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index 11272d605ecd..aabf4ea8c63c 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -470,11 +470,6 @@ static int register_serial_portandirq(unsigned int port, int irq)
 
 	memset(&uart, 0, sizeof(uart));
 	
-	uart.port.uartclk =  1843200;
-	uart.port.iobase = port;
-	uart.port.irq = irq;
-	uart.port.iotype = UPIO_PORT;
-	uart.port.flags =  UPF_SHARE_IRQ;
 	return serial8250_register_8250_port(&uart);
 }
 
diff --git a/drivers/misc/ibmasm/uart.c b/drivers/misc/ibmasm/uart.c
index 46f4c98c3c85..35ccf8aabedb 100644
--- a/drivers/misc/ibmasm/uart.c
+++ b/drivers/misc/ibmasm/uart.c
@@ -34,12 +34,6 @@ void ibmasm_register_uart(struct service_processor *sp)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.irq		= sp->irq;
-	uart.port.uartclk	= 3686400;
-	uart.port.flags		= UPF_SHARE_IRQ;
-	uart.port.iotype	= UPIO_MEM;
-	uart.port.membase	= iomem_base;
-	uart.port.dev		= sp->dev;
 
 	sp->serial_line = serial8250_register_8250_port(&uart);
 	if (sp->serial_line < 0) {
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d39073dc4072..f5947d5713c0 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2279,14 +2279,6 @@ ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
 	 * the serial port device claim and release the pci resource.
 	 */
 	memset(&uart, 0, sizeof(uart));
-	uart.port.dev = &pdev->dev;
-	uart.port.iotype = UPIO_MEM;
-	uart.port.regshift = 2;
-	uart.port.mapbase = pci_resource_start(pdev, 0) + r->offset;
-	uart.port.irq = pci_irq_vector(pdev, r->irq_vec);
-	uart.port.uartclk = 50000000;
-	uart.port.flags = UPF_FIXED_TYPE | UPF_IOREMAP | UPF_NO_THRE_TEST;
-	uart.port.type = PORT_16550A;
 
 	return serial8250_register_8250_port(&uart);
 }
diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index 758c4aa203ab..1d74aeb1462e 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -60,16 +60,8 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 	ecard_set_drvdata(ec, info);
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
-	uart.port.irq	= ec->irq;
-	uart.port.flags	= UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
-	uart.port.uartclk	= type->uartclk;
-	uart.port.iotype	= UPIO_MEM;
-	uart.port.regshift	= 2;
-	uart.port.dev	= &ec->dev;
 
 	for (i = 0; i < info->num_ports; i++) {
-		uart.port.membase = info->vaddr + type->offset[i];
-		uart.port.mapbase = bus_addr + type->offset[i];
 
 		info->ports[i] = serial8250_register_8250_port(&uart);
 	}
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..24cfd8fbec4e 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -438,25 +438,11 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	memset(&port, 0, sizeof(port));
-	port.port.private_data = vuart;
-	port.port.mapbase = res->start;
-	port.port.mapsize = resource_size(res);
-	port.port.startup = aspeed_vuart_startup;
-	port.port.shutdown = aspeed_vuart_shutdown;
-	port.port.throttle = aspeed_vuart_throttle;
-	port.port.unthrottle = aspeed_vuart_unthrottle;
-	port.port.status = UPSTAT_SYNC_FIFO;
-	port.port.dev = &pdev->dev;
-	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
-	port.port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE |
-			  UPF_NO_THRE_TEST;
-	port.bugs |= UART_BUG_TXRACE;
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
 		return rc;
 
-	rc = uart_read_port_properties(&port.port);
 	if (rc)
 		goto err_sysfs_remove;
 
@@ -468,21 +454,13 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 			goto err_sysfs_remove;
 		}
 
-		port.port.uartclk = clk_get_rate(vclk);
 	}
 
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &prop) == 0)
-		port.port.custom_divisor = port.port.uartclk / (16 * prop);
 
-	port.port.handle_irq = aspeed_vuart_handle_irq;
-	port.port.type = PORT_ASPEED_VUART;
-
-	if (port.port.fifosize)
-		port.capabilities = UART_CAP_FIFO;
 
 	if (of_property_read_bool(np, "auto-flow-control"))
-		port.capabilities |= UART_CAP_AFE;
 
 	rc = serial8250_register_8250_port(&port);
 	if (rc < 0)
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 0609582a62f7..824dbee0d67a 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -95,14 +95,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* initialize data */
-	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
-	up.port.dev = &pdev->dev;
-	up.port.type = PORT_16550;
-	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST | UPF_IOREMAP;
-	up.port.rs485_config = serial8250_em485_config;
-	up.port.rs485_supported = serial8250_em485_supported;
-	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
-	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
 
 	/* initialize cached copy with power-on reset value */
 	data->cntl = BCM2835_AUX_UART_CNTL_RXEN | BCM2835_AUX_UART_CNTL_TXEN;
@@ -121,8 +113,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	up.port.mapbase = res->start;
-	up.port.mapsize = resource_size(res);
 
 	bcm2835_swnode = device_get_match_data(&pdev->dev);
 	if (bcm2835_swnode) {
@@ -131,12 +121,9 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = uart_read_port_properties(&up.port);
 	if (ret)
 		goto rm_swnode;
 
-	up.port.regshift = 2;
-	up.port.fifosize = 8;
 
 	/* enable the clock as a last step */
 	ret = clk_prepare_enable(data->clk);
@@ -147,14 +134,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	uartclk = clk_get_rate(data->clk);
 	if (uartclk)
-		up.port.uartclk = uartclk;
 
 	/* the HW-clock divider for bcm2835aux is 8,
 	 * but 8250 expects a divider of 16,
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk *= 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 742004d63c6f..3b9504ec440f 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1025,20 +1025,11 @@ static int brcmuart_probe(struct platform_device *pdev)
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
 
 	memset(&up, 0, sizeof(up));
-	up.port.type = PORT_BCM7271;
-	up.port.dev = dev;
-	up.port.mapbase = mapbase;
-	up.port.membase = membase;
-	up.port.handle_irq = brcmuart_handle_irq;
-	up.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	up.port.private_data = priv;
 
 	ret = uart_read_port_properties(&up.port);
 	if (ret)
 		goto release_dma;
 
-	up.port.regshift = 2;
-	up.port.iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
 
 	/* See if a Baud clock has been specified */
 	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
@@ -1050,7 +1041,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
-		up.port.uartclk = priv->default_mux_rate;
 	} else {
 		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	}
@@ -1058,11 +1048,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 	/* setup HR timer */
 	hrtimer_setup(&priv->hrt, brcmuart_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
-	up.port.shutdown = brcmuart_shutdown;
-	up.port.startup = brcmuart_startup;
-	up.port.throttle = brcmuart_throttle;
-	up.port.unthrottle = brcmuart_unthrottle;
-	up.port.set_termios = brcmstb_set_termios;
 
 	if (priv->dma_enabled) {
 		priv->rx_size = RX_BUF_SIZE * RX_BUFS_COUNT;
diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
index f46cb8981cb1..cd5451cb8940 100644
--- a/drivers/tty/serial/8250/8250_dfl.c
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -60,23 +60,18 @@ static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port
 	if (ret)
 		return dev_err_probe(dev, ret, "missing CLK_FRQ param\n");
 
-	uart->port.uartclk = clk_freq;
-
 	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN, &fifo_len);
 	if (ret)
 		return dev_err_probe(dev, ret, "missing FIFO_LEN param\n");
 
 	switch (fifo_len) {
 	case 32:
-		uart->port.type = PORT_ALTR_16550_F32;
 		break;
 
 	case 64:
-		uart->port.type = PORT_ALTR_16550_F64;
 		break;
 
 	case 128:
-		uart->port.type = PORT_ALTR_16550_F128;
 		break;
 
 	default:
@@ -87,15 +82,12 @@ static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port
 	if (ret)
 		return dev_err_probe(dev, ret, "missing REG_LAYOUT param\n");
 
-	uart->port.regshift = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_SHIFT, reg_layout);
 	reg_width = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_WIDTH, reg_layout);
 	switch (reg_width) {
 	case 4:
-		uart->port.iotype = UPIO_MEM32;
 		break;
 
 	case 2:
-		uart->port.iotype = UPIO_MEM16;
 		break;
 
 	default:
@@ -113,17 +105,11 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
 	struct dfl_uart *dfluart;
 	int ret;
 
-	uart.port.flags = UPF_IOREMAP;
-	uart.port.mapbase = dfl_dev->mmio_res.start;
-	uart.port.mapsize = resource_size(&dfl_dev->mmio_res);
-	uart.port.dev = dev;
-
 	ret = dfl_uart_get_params(dfl_dev, &uart);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed uart feature walk\n");
 
 	if (dfl_dev->num_irqs == 1)
-		uart.port.irq = dfl_dev->irqs[0];
 
 	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
 	if (!dfluart)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..fa526dd3298b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -496,18 +496,12 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 
 #ifdef CONFIG_64BIT
 	if (quirks & DW_UART_QUIRK_OCTEON) {
-		p->serial_in = dw8250_serial_inq;
-		p->serial_out = dw8250_serial_outq;
-		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-		p->type = PORT_OCTEON;
 		data->skip_autocfg = true;
 	}
 #endif
 
 	if (quirks & DW_UART_QUIRK_ARMADA_38X)
-		p->serial_out = dw8250_serial_out38x;
 	if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
-		p->set_termios = dw8250_do_set_termios;
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC) {
 		data->data.dma.txconf.device_fc = 1;
 		data->data.dma.rxconf.device_fc = 1;
@@ -515,9 +509,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		data->data.dma.prepare_rx_dma = dw8250_prepare_rx_dma;
 	}
 	if (quirks & DW_UART_QUIRK_APMC0D08) {
-		p->iotype = UPIO_MEM32;
-		p->regshift = 2;
-		p->serial_in = dw8250_serial_in32;
 		data->uart_16550_compatible = true;
 	}
 }
@@ -540,28 +531,13 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
-	spin_lock_init(&p->lock);
-	p->pm		= dw8250_do_pm;
-	p->type		= PORT_8250;
-	p->flags	= UPF_FIXED_PORT;
-	p->dev		= dev;
-	p->set_ldisc	= dw8250_set_ldisc;
-	p->set_termios	= dw8250_set_termios;
-
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	p->private_data = &data->data;
-
-	p->mapbase = regs->start;
-	p->mapsize = resource_size(regs);
-
-	p->membase = devm_ioremap(dev, p->mapbase, p->mapsize);
 	if (!p->membase)
 		return -ENOMEM;
 
-	err = uart_read_port_properties(p);
 	/* no interrupt -> fall back to polling */
 	if (err == -ENXIO)
 		err = 0;
@@ -570,16 +546,10 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	switch (p->iotype) {
 	case UPIO_MEM:
-		p->serial_in = dw8250_serial_in;
-		p->serial_out = dw8250_serial_out;
 		break;
 	case UPIO_MEM32:
-		p->serial_in = dw8250_serial_in32;
-		p->serial_out = dw8250_serial_out32;
 		break;
 	case UPIO_MEM32BE:
-		p->serial_in = dw8250_serial_in32be;
-		p->serial_out = dw8250_serial_out32be;
 		break;
 	default:
 		return -ENODEV;
@@ -621,7 +591,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
 
 	if (data->clk)
-		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk)
@@ -662,7 +631,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (p->fifosize) {
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
 		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
-		up->dma = &data->data.dma;
 	}
 
 	data->data.line = serial8250_register_8250_port(up);
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index b055d89cfb39..71ee94d0545c 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -247,16 +247,8 @@ void dw8250_setup_port(struct uart_port *p)
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
-		p->rs485_config = dw8250_rs485_config;
-		up->lsr_save_mask = LSR_SAVE_FLAGS | DW_UART_LSR_ADDR_RCVD;
-		p->rs485_supported = dw8250_rs485_supported;
 	} else {
-		p->rs485_config = serial8250_em485_config;
-		p->rs485_supported = serial8250_em485_supported;
-		up->rs485_start_tx = serial8250_em485_start_tx;
-		up->rs485_stop_tx = serial8250_em485_stop_tx;
 	}
-	up->capabilities |= UART_CAP_NOTEMT;
 
 	/* Preserve value written by firmware or bootloader  */
 	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
@@ -266,8 +258,6 @@ void dw8250_setup_port(struct uart_port *p)
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-		p->get_divisor = dw8250_get_divisor;
-		p->set_divisor = dw8250_set_divisor;
 	}
 
 	reg = dw8250_readl_ext(p, DW_UART_UCV);
@@ -285,16 +275,12 @@ void dw8250_setup_port(struct uart_port *p)
 
 	/* Select the type based on FIFO */
 	if (reg & DW_UART_CPR_FIFO_MODE) {
-		p->type = PORT_16550A;
-		p->flags |= UPF_FIXED_TYPE;
-		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
-		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
-		up->capabilities |= UART_CAP_AFE;
+	;
 
 	if (reg & DW_UART_CPR_SIR_MODE)
-		up->capabilities |= UART_CAP_IRDA;
+	;
 }
 EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index e90c71494944..d8cba8ea8160 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -176,20 +176,6 @@ static int serial8250_em_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(sclk), "unable to get clock\n");
 
 	memset(&up, 0, sizeof(up));
-	up.port.mapbase = regs->start;
-	up.port.irq = irq;
-	up.port.type = PORT_16750;
-	up.port.flags = UPF_FIXED_PORT | UPF_IOREMAP | UPF_FIXED_TYPE;
-	up.port.dev = dev;
-	up.port.private_data = priv;
-
-	up.port.uartclk = clk_get_rate(sclk);
-
-	up.port.iotype = UPIO_MEM32;
-	up.port.serial_in = serial8250_em_serial_in;
-	up.port.serial_out = serial8250_em_serial_out;
-	up.dl_read = serial8250_em_serial_dl_read;
-	up.dl_write = serial8250_em_serial_dl_write;
 
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0)
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 04a0cbab02c2..f7772b2d844d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -516,19 +516,9 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	 */
 	status = readb(port->port.membase + UART_EXAR_DVID);
 	if (status == 0x82 || status == 0x84 || status == 0x88) {
-		port->port.type = PORT_XR17V35X;
-
-		port->port.get_divisor = xr17v35x_get_divisor;
-		port->port.set_divisor = xr17v35x_set_divisor;
-
-		port->port.startup = xr17v35x_startup;
 	} else {
-		port->port.type = PORT_XR17D15X;
 	}
 
-	port->port.pm = exar_pm;
-	port->port.shutdown = exar_shutdown;
-
 	return 0;
 }
 
@@ -541,8 +531,6 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	u8 __iomem *p;
 	int err;
 
-	port->port.uartclk = baud * 16;
-
 	err = default_setup(priv, pcidev, idx, offset, port);
 	if (err)
 		return err;
@@ -828,17 +816,10 @@ static int cti_port_setup_common(struct exar8250 *priv,
 {
 	int ret;
 
-	port->port.port_id = idx;
-	port->port.uartclk = priv->osc_freq;
-
 	ret = serial8250_pci_setup_port(pcidev, port, 0, offset, 0);
 	if (ret)
 		return ret;
 
-	port->port.private_data = (void *)priv;
-	port->port.pm = exar_pm;
-	port->port.shutdown = exar_shutdown;
-
 	return 0;
 }
 
@@ -1062,7 +1043,6 @@ static int cti_port_setup_xr17c15x(struct exar8250 *priv,
 	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, pcidev, idx);
 
 	offset = idx * UART_EXAR_XR17C15X_PORT_OFFSET;
-	port->port.type = PORT_XR17D15X;
 
 	if (CTI_PORT_TYPE_RS485(port_type)) {
 		switch (pcidev->subsystem_device) {
@@ -1078,15 +1058,12 @@ static int cti_port_setup_xr17c15x(struct exar8250 *priv,
 		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
 		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
 		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
-			port->port.rs485_config = cti_rs485_config_mpio_tristate;
 			break;
 		// Otherwise auto or no power on 485 tri-state support
 		default:
-			port->port.rs485_config = generic_rs485_config;
 			break;
 		}
 
-		port->port.rs485_supported = generic_rs485_supported;
 	}
 
 	return cti_port_setup_common(priv, pcidev, idx, offset, port);
@@ -1481,9 +1458,6 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 		return rc;
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR | UPF_FIXED_TYPE | UPF_FIXED_PORT;
-	uart.port.irq = pci_irq_vector(pcidev, 0);
-	uart.port.dev = &pcidev->dev;
 
 	/* Clear interrupts */
 	exar_misc_clear(priv);
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 649ae5c8304d..234a25f561b5 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -129,22 +129,6 @@ static int fsl8250_acpi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&port8250.port.lock);
-
-	port8250.port.mapbase           = regs->start;
-	port8250.port.irq               = irq;
-	port8250.port.handle_irq        = fsl8250_handle_irq;
-	port8250.port.type              = PORT_16550A;
-	port8250.port.flags             = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
-						| UPF_FIXED_PORT | UPF_IOREMAP
-						| UPF_FIXED_TYPE;
-	port8250.port.dev               = dev;
-	port8250.port.mapsize           = resource_size(regs);
-	port8250.port.iotype            = UPIO_MEM;
-	port8250.port.irqflags          = IRQF_SHARED;
-
-	port8250.port.membase = devm_ioremap(dev,  port8250.port.mapbase,
-							port8250.port.mapsize);
 	if (!port8250.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 3012ea03d22c..5b9050a31ce8 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -249,15 +249,6 @@ static int __init hp300_8250_init(void)
 		base = (FRODO_BASE + FRODO_APCI_OFFSET(i));
 
 		/* Memory mapped I/O */
-		uart.port.iotype = UPIO_MEM;
-		uart.port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ
-				| UPF_BOOT_AUTOCONF;
-		/* XXX - no interrupt support yet */
-		uart.port.irq = 0;
-		uart.port.uartclk = HPAPCI_BAUD_BASE * 16;
-		uart.port.mapbase = base;
-		uart.port.membase = (char *)(base + DIO_VIRADDRBASE);
-		uart.port.regshift = 2;
 
 		line = serial8250_register_8250_port(&uart);
 
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 94542fc143c2..39d156ed38fc 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -252,25 +252,9 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	spin_lock_init(&uart.port.lock);
-	uart.port.type = PORT_16550A;
-	uart.port.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE;
-	uart.port.mapbase = regs->start;
-	uart.port.serial_out = ingenic_uart_serial_out;
-	uart.port.serial_in = ingenic_uart_serial_in;
-	uart.port.dev = &pdev->dev;
-	uart.tx_loadsz = cdata->tx_loadsz;
-	uart.capabilities = UART_CAP_FIFO | UART_CAP_RTOIE;
-
-	err = uart_read_port_properties(&uart.port);
 	if (err)
 		return err;
 
-	uart.port.regshift = 2;
-	uart.port.fifosize = cdata->fifosize;
-
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -295,7 +279,6 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not enable baud clock: %d\n", err);
 		goto out_disable_moduleclk;
 	}
-	uart.port.uartclk = clk_get_rate(data->clk_baud);
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0) {
diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
index 28e28076782b..51a9555307fa 100644
--- a/drivers/tty/serial/8250/8250_ioc3.c
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -57,16 +57,6 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
 
 	/* Register serial ports with 8250.c */
 	memset(&up, 0, sizeof(struct uart_8250_port));
-	up.port.iotype = UPIO_MEM;
-	up.port.uartclk = IOC3_UARTCLK;
-	up.port.type = PORT_16550A;
-	up.port.irq = irq;
-	up.port.flags = (UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ);
-	up.port.dev = &pdev->dev;
-	up.port.membase = membase;
-	up.port.mapbase = r->start;
-	up.port.serial_in = ioc3_serial_in;
-	up.port.serial_out = ioc3_serial_out;
 	line = serial8250_register_8250_port(&up);
 	if (line < 0)
 		return line;
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 6c0489c9c253..8670c40efaf5 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -102,8 +102,6 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	memset(&uart, 0, sizeof(uart));
 
-	uart.port.membase = devm_ioremap(&pdev->dev, res->start,
-					 resource_size(res));
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -138,28 +136,10 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	data->dma.rx_param = data;
 	data->dma.tx_param = data;
 
-	spin_lock_init(&uart.port.lock);
-	uart.port.dev = &pdev->dev;
-	uart.port.mapbase = res->start;
-	uart.port.type = PORT_16550A;
-	uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
-	uart.port.uartclk = clk_get_rate(data->clk_uart);
-	uart.port.private_data = data;
-	uart.port.rs485_config = lpc18xx_rs485_config;
-	uart.port.rs485_supported = lpc18xx_rs485_supported;
-	uart.port.serial_out = lpc18xx_uart_serial_out;
-
 	ret = uart_read_port_properties(&uart.port);
 	if (ret)
 		goto dis_uart_clk;
 
-	uart.port.iotype = UPIO_MEM32;
-	uart.port.regshift = 2;
-
-	uart.dma = &data->dma;
-	uart.dma->rxconf.src_maxburst = 1;
-	uart.dma->txconf.dst_maxburst = 1;
-
 	ret = serial8250_register_8250_port(&uart);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 776ec1ef29d6..0e3379f9008e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -299,8 +299,6 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 	dma->rx_param = rx_param;
 	dma->tx_param = tx_param;
 
-	port->dma = dma;
-
 out_configuration_only:
 	dma->rxconf.src_maxburst = lpss->dma_maxburst;
 	dma->txconf.dst_maxburst = lpss->dma_maxburst;
@@ -332,17 +330,6 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
-	uart.port.dev = &pdev->dev;
-	uart.port.irq = pci_irq_vector(pdev, 0);
-	uart.port.private_data = &lpss->data;
-	uart.port.type = PORT_16550A;
-	uart.port.iotype = UPIO_MEM32;
-	uart.port.regshift = 2;
-	uart.port.uartclk = lpss->board->base_baud * 16;
-	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	uart.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
-	uart.port.mapbase = pci_resource_start(pdev, 0);
-	uart.port.membase = pcim_iomap(pdev, 0, 0);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index f7111337d50f..cb173ef42afa 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -209,18 +209,6 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 
 	for (i = 0; i < data->num_ports; i++) {
 		memset(&uart, 0, sizeof(struct uart_8250_port));
-		spin_lock_init(&uart.port.lock);
-
-		uart.port.flags = UPF_SKIP_TEST |
-				  UPF_SHARE_IRQ |
-				  UPF_BOOT_AUTOCONF |
-				  UPF_IOREMAP;
-		uart.port.iotype = UPIO_MEM;
-		uart.port.uartclk = men_lookup_uartclk(mdev);
-		uart.port.irq = mcb_get_irq(mdev);
-		uart.port.mapbase = (unsigned long) mem->start
-					    + data->offset[i];
-		uart.port.dev = &mdev->dev;
 
 		/* ok, register the port */
 		res = serial8250_register_8250_port(&uart);
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec03863606e..d0765737f7f0 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -124,7 +124,6 @@ static int tng_setup(struct mid8250 *mid, struct uart_port *p)
 	mid->dma_index = index;
 	mid->dma_dev = pci_get_slot(pdev->bus, PCI_DEVFN(5, 0));
 
-	p->handle_irq = tng_handle_irq;
 	return 0;
 }
 
@@ -176,8 +175,6 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 	if (ret < 0)
 		return ret;
 
-	p->irq = pci_irq_vector(pdev, 0);
-
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = p->membase;
@@ -191,7 +188,6 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 
 	mid->dma_dev = pdev;
 
-	p->handle_irq = dnv_handle_irq;
 	return 0;
 }
 
@@ -281,7 +277,6 @@ static int mid8250_dma_setup(struct mid8250 *mid, struct uart_8250_port *port)
 	dma->rx_param = rx_param;
 	dma->tx_param = tx_param;
 
-	port->dma = dma;
 	return 0;
 }
 
@@ -303,17 +298,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
-	uart.port.dev = &pdev->dev;
-	uart.port.irq = pdev->irq;
-	uart.port.private_data = mid;
-	uart.port.type = PORT_16750;
-	uart.port.iotype = UPIO_MEM;
-	uart.port.uartclk = mid->board->base_baud * 16;
-	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	uart.port.set_termios = mid8250_set_termios;
-
-	uart.port.mapbase = pci_resource_start(pdev, mid->board->bar);
-	uart.port.membase = pcim_iomap(pdev, mid->board->bar, 0);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b44de2ed7413..c04c07c79a74 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -530,8 +530,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -549,22 +547,9 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	spin_lock_init(&uart.port.lock);
-	uart.port.mapbase = regs->start;
-	uart.port.irq = irq;
-	uart.port.pm = mtk8250_do_pm;
-	uart.port.type = PORT_16550;
-	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
-	uart.port.dev = &pdev->dev;
-	uart.port.iotype = UPIO_MEM32;
-	uart.port.regshift = 2;
-	uart.port.private_data = data;
-	uart.port.shutdown = mtk8250_shutdown;
-	uart.port.startup = mtk8250_startup;
-	uart.port.set_termios = mtk8250_set_termios;
-	uart.port.uartclk = clk_get_rate(data->uart_clk);
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (data->dma)
-		uart.dma = data->dma;
+	;
 #endif
 
 	/* Disable Rate Fix function */
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index cb5b42b3609c..4fa89a67d117 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -196,13 +196,10 @@ static const struct serial_rs485 ni16550_rs485_supported = {
 
 static void ni16550_rs485_setup(struct uart_port *port)
 {
-	port->rs485_config = ni16550_rs485_config;
-	port->rs485_supported = ni16550_rs485_supported;
 	/*
 	 * The hardware comes up by default in 2-wire auto mode and we
 	 * set the flags to represent that
 	 */
-	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
 }
 
 static int ni16550_port_startup(struct uart_port *port)
@@ -300,15 +297,9 @@ static int ni16550_probe(struct platform_device *pdev)
 		return ret;
 
 	/* early setup so that serial_in()/serial_out() work */
-	serial8250_set_defaults(uart);
 
 	info = device_get_match_data(dev);
 
-	uart->port.dev		= dev;
-	uart->port.flags	= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	uart->port.startup	= ni16550_port_startup;
-	uart->port.shutdown	= ni16550_port_shutdown;
-
 	/*
 	 * Hardware instantiation of FIFO sizes are held in registers.
 	 */
@@ -318,18 +309,12 @@ static int ni16550_probe(struct platform_device *pdev)
 	dev_dbg(dev, "NI 16550 has TX FIFO size %u, RX FIFO size %u\n",
 		txfifosz, rxfifosz);
 
-	uart->port.type		= PORT_16550A;
-	uart->port.fifosize	= txfifosz;
-	uart->tx_loadsz		= txfifosz;
-	uart->fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
-	uart->capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
 
 	/*
 	 * Declaration of the base clock frequency can come from one of:
 	 * - static declaration in this driver (for older ACPI IDs)
 	 * - a "clock-frequency" ACPI
 	 */
-	uart->port.uartclk = info->uartclk;
 
 	ret = uart_read_port_properties(&uart->port);
 	if (ret)
@@ -338,7 +323,7 @@ static int ni16550_probe(struct platform_device *pdev)
 	if (!uart->port.uartclk) {
 		data->clk = devm_clk_get_enabled(dev, NULL);
 		if (!IS_ERR(data->clk))
-			uart->port.uartclk = clk_get_rate(data->clk);
+			;
 	}
 
 	if (!uart->port.uartclk)
@@ -347,7 +332,6 @@ static int ni16550_probe(struct platform_device *pdev)
 	prescaler = info->prescaler;
 	device_property_read_u32(dev, "clock-prescaler", &prescaler);
 	if (prescaler) {
-		uart->port.set_mctrl = ni16550_set_mctrl;
 		ni16550_config_prescaler(uart, (u8)prescaler);
 	}
 
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d178b6c54ea1..ff518b374143 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -56,8 +56,6 @@ static unsigned int npcm_get_divisor(struct uart_port *port, unsigned int baud,
 
 static int npcm_setup(struct uart_port *port)
 {
-	port->get_divisor = npcm_get_divisor;
-	port->startup = npcm_startup;
 	return 0;
 }
 
@@ -106,16 +104,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_pmruntime;
 	}
 
-	port->dev = &ofdev->dev;
-	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	spin_lock_init(&port->lock);
-
 	if (resource_type(&resource) == IORESOURCE_IO) {
-		port->iobase = resource.start;
 	} else {
-		port->mapbase = resource.start;
-		port->mapsize = resource_size(&resource);
-		port->flags |= UPF_IOREMAP;
 	}
 
 	ret = uart_read_and_validate_port_properties(port);
@@ -140,15 +130,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		}
 
 		info->bus_clk = bus_clk;
-		port->uartclk = clk_get_rate(info->clk);
 	}
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &spd) == 0)
-		port->custom_divisor = port->uartclk / (16 * spd);
 
 	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
 	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
-		port->regshift = 2;
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
@@ -160,12 +147,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (ret)
 		goto err_pmruntime;
 
-	port->type = type;
-	port->rs485_config = serial8250_em485_config;
-	port->rs485_supported = serial8250_em485_supported;
-	up->rs485_start_tx = serial8250_em485_start_tx;
-	up->rs485_stop_tx = serial8250_em485_stop_tx;
-
 	switch (type) {
 	case PORT_RT2880:
 		ret = rt288x_setup(port);
@@ -184,8 +165,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
 	    (of_device_is_compatible(np, "fsl,ns16550") ||
 	     of_device_is_compatible(np, "fsl,16550-FIFO64"))) {
-		port->handle_irq = fsl8250_handle_irq;
-		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 	}
 
 	return 0;
@@ -226,22 +205,19 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	if (ret)
 		goto err_free;
 
-	if (port8250.port.fifosize)
-		port8250.capabilities = UART_CAP_FIFO;
-
 	/* Check for TX FIFO threshold & set tx_loadsz */
 	if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
 				  &tx_threshold) == 0) &&
 	    (tx_threshold < port8250.port.fifosize))
-		port8250.tx_loadsz = port8250.port.fifosize - tx_threshold;
+		;
 
 	if (of_property_read_bool(ofdev->dev.of_node, "auto-flow-control"))
-		port8250.capabilities |= UART_CAP_AFE;
+		;
 
 	if (of_property_read_u32(ofdev->dev.of_node,
 			"overrun-throttle-ms",
 			&port8250.overrun_backoff_time_ms) != 0)
-		port8250.overrun_backoff_time_ms = 0;
+		;
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6707f55bdbe7..c90681ce094a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1438,9 +1438,6 @@ static int omap8250_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	memset(&up, 0, sizeof(up));
-	up.port.dev = &pdev->dev;
-	up.port.mapbase = regs->start;
-	up.port.membase = membase;
 	/*
 	 * It claims to be 16C750 compatible however it is a little different.
 	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
@@ -1449,12 +1446,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	 * we don't need our own type since we don't use 8250's set_termios()
 	 * or pm callback.
 	 */
-	up.port.type = PORT_8250;
-	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW | UPF_HARD_FLOW;
-	up.port.private_data = priv;
-
-	up.tx_loadsz = 64;
-	up.capabilities = UART_CAP_FIFO;
 #ifdef CONFIG_PM
 	/*
 	 * Runtime PM is mostly transparent. However to do it right we need to a
@@ -1462,28 +1453,12 @@ static int omap8250_probe(struct platform_device *pdev)
 	 * PM is not enabled we don't add that flag and can spare that one extra
 	 * interrupt in the TX path.
 	 */
-	up.capabilities |= UART_CAP_RPM;
 #endif
-	up.port.set_termios = omap_8250_set_termios;
-	up.port.set_mctrl = omap8250_set_mctrl;
-	up.port.pm = omap_8250_pm;
-	up.port.startup = omap_8250_startup;
-	up.port.shutdown = omap_8250_shutdown;
-	up.port.throttle = omap_8250_throttle;
-	up.port.unthrottle = omap_8250_unthrottle;
-	up.port.rs485_config = omap8250_rs485_config;
 	/* same rs485_supported for software emulation and native RS485 */
-	up.port.rs485_supported = serial8250_em485_supported;
-	up.rs485_start_tx = serial8250_em485_start_tx;
-	up.rs485_stop_tx = serial8250_em485_stop_tx;
-	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-	ret = uart_read_port_properties(&up.port);
 	if (ret)
 		return ret;
 
-	up.port.regshift = OMAP_UART_REGSHIFT;
-	up.port.fifosize = 64;
 
 	if (!up.port.uartclk) {
 		struct clk *clk;
@@ -1493,20 +1468,17 @@ static int omap8250_probe(struct platform_device *pdev)
 			if (PTR_ERR(clk) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
 		} else {
-			up.port.uartclk = clk_get_rate(clk);
 		}
 	}
 
 	if (of_property_read_u32(np, "overrun-throttle-ms",
 				 &up.overrun_backoff_time_ms) != 0)
-		up.overrun_backoff_time_ms = 0;
 
 	pdata = of_device_get_match_data(&pdev->dev);
 	if (pdata)
 		priv->habit |= pdata->habit;
 
 	if (!up.port.uartclk) {
-		up.port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
 			 "No clock speed specified: using default: %d\n",
 			 DEFAULT_CLK_SPEED);
@@ -1543,7 +1515,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(&up, priv);
-	up.port.handle_irq = omap8250_no_handle_irq;
 	priv->rx_trigger = RX_TRIGGER;
 	priv->tx_trigger = TX_TRIGGER;
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -1580,7 +1551,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 #endif
 
-	irq_set_status_flags(up.port.irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
diff --git a/drivers/tty/serial/8250/8250_parisc.c b/drivers/tty/serial/8250/8250_parisc.c
index 4ba05a98791c..e2cd4ed28758 100644
--- a/drivers/tty/serial/8250/8250_parisc.c
+++ b/drivers/tty/serial/8250/8250_parisc.c
@@ -50,19 +50,11 @@ static int __init serial_init_chip(struct parisc_device *dev)
 		address += 0x800;
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.iotype	= UPIO_MEM;
 	/* 7.272727MHz on Lasi.  Assumed the same for Dino, Wax and Timi. */
-	uart.port.uartclk	= (dev->id.sversion != 0xad) ?
-					7272727 : 1843200;
-	uart.port.mapbase	= address;
-	uart.port.membase	= ioremap(address, 16);
 	if (!uart.port.membase) {
 		dev_warn(&dev->dev, "Failed to map memory\n");
 		return -ENOMEM;
 	}
-	uart.port.irq	= dev->irq;
-	uart.port.flags	= UPF_BOOT_AUTOCONF;
-	uart.port.dev	= &dev->dev;
 
 	err = serial8250_register_8250_port(&uart);
 	if (err < 0) {
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..e614f7b4a2f5 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1542,9 +1542,7 @@ static int pci_quatech_setup(struct serial_private *priv,
 		return serial_8250_warn_need_ioport(priv->dev);
 
 	/* Needed by pci_quatech calls below */
-	port->port.iobase = pci_resource_start(priv->dev, FL_GET_BASE(board->flags));
 	/* Set up the clocking */
-	port->port.uartclk = pci_quatech_clock(port);
 	/* For now just warn about RS422 */
 	if (pci_quatech_rs422(port))
 		pci_warn(priv->dev, "software control of RS422 features not currently supported.\n");
@@ -1580,10 +1578,6 @@ ce4100_serial_setup(struct serial_private *priv,
 	int ret;
 
 	ret = setup_port(priv, port, idx, 0, board->reg_shift);
-	port->port.iotype = UPIO_MEM32;
-	port->port.type = PORT_XSCALE;
-	port->port.flags = (port->port.flags | UPF_FIXED_PORT | UPF_FIXED_TYPE);
-	port->port.regshift = 2;
 
 	return ret;
 }
@@ -1603,8 +1597,6 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 {
 	int ret = pci_default_setup(priv, board, port, idx);
 
-	port->port.type = PORT_BRCM_TRUMANAGE;
-	port->port.flags = (port->port.flags | UPF_FIXED_PORT | UPF_FIXED_TYPE);
 	return ret;
 }
 
@@ -1668,10 +1660,6 @@ static int pci_fintek_setup(struct serial_private *priv,
 
 	pci_dbg(pdev, "idx=%d iobase=0x%x", idx, iobase);
 
-	port->port.iotype = UPIO_PORT;
-	port->port.iobase = iobase;
-	port->port.rs485_config = pci_fintek_rs485_config;
-	port->port.rs485_supported = pci_fintek_rs485_supported;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
 	if (!data)
@@ -1679,7 +1667,6 @@ static int pci_fintek_setup(struct serial_private *priv,
 
 	/* preserve index in PCI configuration space */
 	*data = idx;
-	port->port.private_data = data;
 
 	return 0;
 }
@@ -1776,11 +1763,6 @@ static int pci_fintek_f815xxa_setup(struct serial_private *priv,
 	data->idx = idx;
 	spin_lock_init(&data->lock);
 
-	port->port.private_data = data;
-	port->port.iotype = UPIO_MEM;
-	port->port.flags |= UPF_IOREMAP;
-	port->port.mapbase = pci_resource_start(pdev, 0) + 8 * idx;
-	port->port.serial_out = f815xxa_mem_serial_out;
 
 	return 0;
 }
@@ -1826,7 +1808,6 @@ static int skip_tx_en_setup(struct serial_private *priv,
 			const struct pciserial_board *board,
 			struct uart_8250_port *port, int idx)
 {
-	port->port.quirks |= UPQ_NO_TXEN_TEST;
 	pci_dbg(priv->dev,
 		"serial8250: skipping TxEn test for device [%04x:%04x] subsystem [%04x:%04x]\n",
 		priv->dev->vendor, priv->dev->device,
@@ -1876,9 +1857,6 @@ static int kt_serial_setup(struct serial_private *priv,
 	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
 		return serial_8250_warn_need_ioport(priv->dev);
 
-	port->port.flags |= UPF_BUG_THRE;
-	port->port.serial_in = kt_serial_in;
-	port->port.handle_break = kt_handle_break;
 	return skip_tx_en_setup(priv, board, port, idx);
 }
 
@@ -1978,8 +1956,6 @@ pci_sunix_setup(struct serial_private *priv,
 	int bar;
 	int offset;
 
-	port->port.flags |= UPF_FIXED_TYPE;
-	port->port.type = PORT_SUNIX;
 
 	if (idx < 4) {
 		bar = 0;
@@ -4156,16 +4132,12 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	priv->quirk = quirk;
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
-	uart.port.uartclk = board->base_baud * 16;
 
 	if (board->flags & FL_NOIRQ) {
-		uart.port.irq = 0;
 	} else {
 		if (pci_match_id(pci_use_msi, dev)) {
 			pci_dbg(dev, "Using MSI(-X) interrupts\n");
 			pci_set_master(dev);
-			uart.port.flags &= ~UPF_SHARE_IRQ;
 			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 		} else {
 			pci_dbg(dev, "Using legacy interrupts\n");
@@ -4177,10 +4149,8 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 			goto err_deinit;
 		}
 
-		uart.port.irq = pci_irq_vector(dev, 0);
 	}
 
-	uart.port.dev = &dev->dev;
 
 	for (i = 0; i < nr_ports; i++) {
 		if (quirk->setup(priv, board, &uart, i))
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 4c149db84692..a9ef137ac03c 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -675,8 +675,6 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 {
 	int ret;
 
-	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
-	port->port.type = PORT_MCHP16550A;
 	/*
 	 * 8250 core considers prescaller value to be always 16.
 	 * The MCHP ports support downscaled mode and hence the
@@ -687,21 +685,14 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	 * The value itself is not really used anywhere except baud
 	 * rate calculations, so we can mangle it as we wish.
 	 */
-	port->port.uartclk = 64 * HZ_PER_MHZ;
-	port->port.set_termios = serial8250_do_set_termios;
-	port->port.get_divisor = pci1xxxx_get_divisor;
-	port->port.set_divisor = pci1xxxx_set_divisor;
-	port->port.rs485_config = pci1xxxx_rs485_config;
-	port->port.rs485_supported = pci1xxxx_rs485_supported;
-
 	/*
 	 * C0 and later revisions support Burst operation.
 	 * RTS workaround in mctrl is applicable only to B0.
 	 */
 	if (rev >= 0xC0)
-		port->port.handle_irq = pci1xxxx_handle_irq;
+		;
 	else if (rev == 0xB0)
-		port->port.set_mctrl = pci1xxxx_set_mctrl;
+		;
 
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
@@ -805,8 +796,6 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
-	uart.port.dev = dev;
 
 	if (num_vectors == max_vec_reqd)
 		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, priv->membase + UART_PCI_CTRL_REG);
@@ -817,9 +806,7 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 		port_idx = pci1xxxx_logical_to_physical_port_translate(subsys_dev, i);
 
 		if (num_vectors == max_vec_reqd)
-			uart.port.irq = pci_irq_vector(pdev, port_idx);
-		else
-			uart.port.irq = pci_irq_vector(pdev, 0);
+			;
 
 		rc = pci1xxxx_setup(pdev, &uart, port_idx, priv->dev_rev);
 		if (rc) {
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index d8d0ae0d7238..97f4e0c3ef70 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -31,17 +31,7 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
 			return -ENOMEM;
 
-		port->port.iotype = UPIO_MEM;
-		port->port.iobase = 0;
-		port->port.mapbase = pci_resource_start(dev, bar) + offset;
-		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
-		port->port.regshift = regshift;
 	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
-		port->port.iotype = UPIO_PORT;
-		port->port.iobase = pci_resource_start(dev, bar) + offset;
-		port->port.mapbase = 0;
-		port->port.membase = NULL;
-		port->port.regshift = 0;
 	} else {
 		return serial_8250_warn_need_ioport(dev);
 	}
diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index b8d5b7714a9d..fa3ef5505421 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -112,17 +112,9 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	memset(&uart, 0, sizeof(uart));
 
-	uart.port.dev = &pdev->dev;
-	uart.port.irq = pdev->irq;
-	uart.port.private_data = pericom;
-	uart.port.iotype = UPIO_PORT;
-	uart.port.uartclk = 921600 * 16;
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
-	uart.port.set_divisor = pericom_do_set_divisor;
 	for (i = 0; i < nr && i < maxnr; i++) {
 		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
 
-		uart.port.iobase = pci_resource_start(pdev, bar) + offset;
 
 		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 10f2a5214342..6afa4feeff88 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -32,24 +32,14 @@ static int serial8250_probe_acpi(struct platform_device *pdev)
 
 	switch (resource_type(regs)) {
 	case IORESOURCE_IO:
-		uart.port.iobase = regs->start;
 		break;
 	case IORESOURCE_MEM:
-		uart.port.mapbase = regs->start;
-		uart.port.mapsize = resource_size(regs);
-		uart.port.flags = UPF_IOREMAP;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* default clock frequency */
-	uart.port.uartclk = 1843200;
-	uart.port.type = PORT_16550A;
-	uart.port.dev = &pdev->dev;
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-
-	ret = uart_read_and_validate_port_properties(&uart.port);
 	/* no interrupt -> fall back to polling */
 	if (ret == -ENXIO)
 		ret = 0;
@@ -71,33 +61,6 @@ static int serial8250_probe_platform(struct platform_device *dev, struct plat_se
 	memset(&uart, 0, sizeof(uart));
 
 	for (i = 0; p && p->flags != 0; p++, i++) {
-		uart.port.iobase	= p->iobase;
-		uart.port.membase	= p->membase;
-		uart.port.irq		= p->irq;
-		uart.port.irqflags	= p->irqflags;
-		uart.port.uartclk	= p->uartclk;
-		uart.port.regshift	= p->regshift;
-		uart.port.iotype	= p->iotype;
-		uart.port.flags		= p->flags;
-		uart.port.mapbase	= p->mapbase;
-		uart.port.mapsize	= p->mapsize;
-		uart.port.hub6		= p->hub6;
-		uart.port.has_sysrq	= p->has_sysrq;
-		uart.port.private_data	= p->private_data;
-		uart.port.type		= p->type;
-		uart.bugs		= p->bugs;
-		uart.port.serial_in	= p->serial_in;
-		uart.port.serial_out	= p->serial_out;
-		uart.dl_read		= p->dl_read;
-		uart.dl_write		= p->dl_write;
-		uart.port.handle_irq	= p->handle_irq;
-		uart.port.handle_break	= p->handle_break;
-		uart.port.set_termios	= p->set_termios;
-		uart.port.set_ldisc	= p->set_ldisc;
-		uart.port.get_mctrl	= p->get_mctrl;
-		uart.port.pm		= p->pm;
-		uart.port.dev		= &dev->dev;
-		uart.port.irqflags	|= irqflag;
 		ret = serial8250_register_8250_port(&uart);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 67fbf147aad1..b45df4ad9ae8 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -446,21 +446,12 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 
 	memset(&uart, 0, sizeof(uart));
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
-		uart.port.iobase = pnp_port_start(dev, 2);
 	} else if (pnp_port_valid(dev, 0)) {
-		uart.port.iobase = pnp_port_start(dev, 0);
 	} else if (pnp_mem_valid(dev, 0)) {
-		uart.port.mapbase = pnp_mem_start(dev, 0);
-		uart.port.mapsize = pnp_mem_len(dev, 0);
-		uart.port.flags = UPF_IOREMAP;
 	} else
 		return -ENODEV;
 
-	uart.port.uartclk = 1843200;
-	uart.port.dev = &dev->dev;
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 
-	ret = uart_read_port_properties(&uart.port);
 	/* no interrupt -> fall back to polling */
 	if (ret == -ENXIO)
 		ret = 0;
@@ -468,8 +459,6 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		return ret;
 
 	if (flags & CIR_PORT) {
-		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
-		uart.port.type = PORT_8250_CIR;
 	}
 
 	dev_info(&dev->dev,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8f4359cf42eb..f569584172a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3212,11 +3212,11 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 		unsigned int type = up->port.type;
 
 		if (!up->port.fifosize)
-			up->port.fifosize = uart_config[type].fifo_size;
+			;
 		if (!up->tx_loadsz)
-			up->tx_loadsz = uart_config[type].tx_loadsz;
+			;
 		if (!up->capabilities)
-			up->capabilities = uart_config[type].flags;
+			;
 	}
 
 	set_io_from_upio(port);
@@ -3224,9 +3224,9 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 	/* default dma handlers */
 	if (up->dma) {
 		if (!up->dma->tx_dma)
-			up->dma->tx_dma = serial8250_tx_dma;
+			;
 		if (!up->dma->rx_dma)
-			up->dma->rx_dma = serial8250_rx_dma;
+			;
 	}
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 656974dce062..09d93954307e 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -110,23 +110,9 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	uart.port.type = PORT_XSCALE;
-	uart.port.mapbase = mmres->start;
-	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
-	uart.port.dev = &pdev->dev;
-	uart.port.uartclk = clk_get_rate(data->clk);
-	uart.port.pm = serial_pxa_pm;
-	uart.port.private_data = data;
-
-	ret = uart_read_port_properties(&uart.port);
 	if (ret)
 		return ret;
 
-	uart.port.iotype = UPIO_MEM32;
-	uart.port.regshift = 2;
-	uart.port.fifosize = 64;
-	uart.tx_loadsz = 32;
-	uart.dl_write = serial_pxa_dl_write;
 
 	ret = serial8250_register_8250_port(&uart);
 	if (ret < 0)
diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index bf28b8a9a710..9ab928c7bfcc 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -83,17 +83,6 @@ int rt288x_setup(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 
-	p->iotype = UPIO_AU;
-
-	p->serial_in = au_serial_in;
-	p->serial_out = au_serial_out;
-	up->dl_read = au_serial_dl_read;
-	up->dl_write = au_serial_dl_write;
-
-	p->mapsize = 0x100;
-
-	up->bugs |= UART_BUG_NOMSR;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt288x_setup);
diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index 2f3b0075763f..c55a76c2d370 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -57,29 +57,18 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	port = &port8250.port;
 	spin_lock_init(&port->lock);
 
-	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	port->type = PORT_TEGRA;
-	port->dev = &pdev->dev;
-	port->handle_break = tegra_uart_handle_break;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
-	port->membase = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
 	if (!port->membase)
 		return -ENOMEM;
 
-	port->mapbase = res->start;
-	port->mapsize = resource_size(res);
 
-	ret = uart_read_port_properties(port);
 	if (ret)
 		return ret;
 
-	port->iotype = UPIO_MEM32;
-	port->regshift = 2;
 
 	uart->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(uart->rst))
@@ -96,7 +85,6 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		port->uartclk = clk_get_rate(uart->clk);
 	}
 
 	ret = reset_control_deassert(uart->rst);
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index e3db60bf50c9..cf90f5c31e28 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -190,34 +190,15 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	up.port.uartclk = clk_get_rate(priv->clk);
 
-	spin_lock_init(&priv->atomic_write_lock);
 
-	up.port.dev = dev;
-	up.port.private_data = priv;
-	up.port.mapbase = regs->start;
-	up.port.mapsize = resource_size(regs);
-	up.port.membase = membase;
 
-	ret = uart_read_port_properties(&up.port);
 	if (ret)
 		return ret;
 
-	up.port.type = PORT_16550A;
-	up.port.iotype = UPIO_MEM32;
-	up.port.fifosize = 64;
-	up.port.regshift = UNIPHIER_UART_REGSHIFT;
-	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	up.capabilities = UART_CAP_FIFO;
 
 	if (of_property_read_bool(dev->of_node, "auto-flow-control"))
-		up.capabilities |= UART_CAP_AFE;
-
-	up.port.serial_in = uniphier_serial_in;
-	up.port.serial_out = uniphier_serial_out;
-	up.dl_read = uniphier_serial_dl_read;
-	up.dl_write = uniphier_serial_dl_write;
+		;
 
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 58e279ea7ee0..74b75f2e3195 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -101,7 +101,6 @@ struct serial_info {
  */
 static void quirk_setup_brainboxes_0104(struct pcmcia_device *link, struct uart_8250_port *uart)
 {
-	uart->port.uartclk = 14745600;
 }
 
 static int quirk_post_ibm(struct pcmcia_device *link)
@@ -350,13 +349,8 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
 	int line;
 
 	memset(&uart, 0, sizeof(uart));
-	uart.port.iobase = iobase;
-	uart.port.irq = irq;
-	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	uart.port.dev = &handle->dev;
 	if (buggy_uart)
-		uart.port.flags |= UPF_BUGGY_UART;
+		;
 
 	if (info->quirk && info->quirk->setup)
 		info->quirk->setup(handle, &uart);
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 2fc48cd63f6c..4d471d50f0f8 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -203,32 +203,24 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 	int ret;
 
 	/* Read optional UART functional clock frequency */
-	device_property_read_u32(dev, "clock-frequency", &port->uartclk);
 
 	/* Read the registers alignment (default: 8-bit) */
 	ret = device_property_read_u32(dev, "reg-shift", &value);
 	if (ret)
-		port->regshift = use_defaults ? 0 : port->regshift;
 	else
-		port->regshift = value;
 
 	/* Read the registers I/O access type (default: MMIO 8-bit) */
 	ret = device_property_read_u32(dev, "reg-io-width", &value);
 	if (ret) {
-		port->iotype = port->iobase ? UPIO_PORT : UPIO_MEM;
 	} else {
 		switch (value) {
 		case 1:
-			port->iotype = UPIO_MEM;
 			break;
 		case 2:
-			port->iotype = UPIO_MEM16;
 			break;
 		case 4:
-			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
 			break;
 		default:
-			port->iotype = UPIO_UNKNOWN;
 			break;
 		}
 	}
@@ -249,19 +241,13 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 		return -EINVAL;
 	}
 
-	port->mapbase += value;
-	port->mapsize -= value;
-
 	/* Read optional FIFO size */
-	device_property_read_u32(dev, "fifo-size", &port->fifosize);
 
 	if (device_property_read_bool(dev, "no-loopback-test"))
-		port->flags |= UPF_SKIP_TEST;
 
 	/* Get index of serial line, if found in DT aliases */
 	ret = of_alias_get_id(dev_of_node(dev), "serial");
 	if (ret >= 0)
-		port->line = ret;
 
 	if (dev_is_platform(dev))
 		ret = platform_get_irq(to_platform_device(dev), 0);
@@ -274,14 +260,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 	if (ret > 0)
-		port->irq = ret;
 	else if (use_defaults)
 		/* By default IRQ support is mandatory */
 		return ret;
 	else
-		port->irq = 0;
 
-	port->flags |= UPF_SHARE_IRQ;
 
 	return 0;
 }


