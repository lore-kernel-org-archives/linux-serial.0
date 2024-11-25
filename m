Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8F194C77
	for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532799; cv=none; b=hPc/ns+i4NUqLc8MHHMmOagfWoZlF5nffngh9Zkf9xoDDuKhHFc98xTpQ2j9n6LwhKnaVCcLC4lO+rFGdToPwEOnSwJJnCYtW33LtSk4j5iOVHgbVXVJAbKDOKON6h318PtkkNtAqO/eMlOr4NuLa6nXhNpMHqyUfUDg59Imzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532799; c=relaxed/simple;
	bh=IUu7ElnEKRhylBYLNIvGx+7F6jbYVwpoxJaickF20/Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bq5GTnIMJKXflmWx1Wj96dAundkqNMvj85JTPG1Ko3bV9OT+fqx9IGEhPXuFBqraTCTrRuhljePcJ17ZQpqvljrUohSDhZ7GjCbPiGAiI2iZ0yD9yPVDWBhcq3J5Ryy+FgYMx2zf3kV1sAb/eOSE8Q4BlTNaSXsJbrLNSGIoQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWW6Akio; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWW6Akio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44836C4CECE;
	Mon, 25 Nov 2024 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732532798;
	bh=IUu7ElnEKRhylBYLNIvGx+7F6jbYVwpoxJaickF20/Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DWW6Akiox3vuPa2+Qh7G3rYFhAUr5KxbtY9/OwfSAZ7VXu9CduMt7mfF2PjpmwN3n
	 fh7e3Y8HnPqbNMMBBc0/QBplFjDclGBoA4ZIIdiwL2VCdFjx/pvcUt8Q1clKWqsXLM
	 tL8RQS+27fWfm4bl7xKCGVcOgSFVq91mf4rsqm/zDnr+A6v2+LbdV3Fe4pcrdphuFF
	 t4XOAtMbHpLoRaqvo7ihFoGbs/lVt+h/p4im6HBle4Z6uUlatnOoCEKgSN1Krp+gFG
	 DHvG+8HXALMg4A8otYr750kqB+EWygvwg6MS4WRn8NAsOd6v4cUZlCGg8lWVp1GyVR
	 Lzco1v+MvY0Rg==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4902C1200043;
	Mon, 25 Nov 2024 06:06:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 06:06:37 -0500
X-ME-Sender: <xms:PVpEZyZ6Fice8eRJ9xGHb_rYQjeg9clz744uXlUn7haHlm0dXNgxqw>
    <xme:PVpEZ1ZCTq3dU6W5AaaEdP0fcXT3iam1cS75P-TU9z6ScWGNDxWJoLsacotNBZJrA
    zEjVQbDt2SAdnRqkJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephigrnhhghihinhhglhhirghngheshhhurgifvghirdgtohhmpd
    hrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhlvgeslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghn
    khhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvh
    hinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PVpEZ8_ak8z6AJG8vkacyS3MJZUwpOA2O3wRhUEp9ZLpfWu_euGM7w>
    <xmx:PVpEZ0qQQW-HhDGLBRP3s45DrWbc6UsbLRyhoiQP_P0grTHcTY9J5g>
    <xmx:PVpEZ9qvCLPjz-ZCQXC5eDS2m43nT8k5qzhX6d3Fb0bM6OQuHhZXQw>
    <xmx:PVpEZyRYj7LXrVQJizwpHs43l5MtQ3VPXUcM0k6E5R9XtIDvb6qWJA>
    <xmx:PVpEZ9pwBrz1FHUu76jZd-9gd0PPyBH6su2j-7m9IJWlpLjR0lGbD3oz>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 137602220071; Mon, 25 Nov 2024 06:06:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 12:06:16 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
In-Reply-To: <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 11:33, Andy Shevchenko wrote:
> On Mon, Nov 25, 2024 at 10:53:46AM +0100, Arnd Bergmann wrote:
>> 
>> This does however revert f4c23a140d80 ("serial: 8250:
>> fix null-ptr-deref in serial8250_start_tx()") and
>> might bring back the bug came from opening an
>> uninitialized uart. On the other hand, I don't see
>> why that doesn't also crash from accessing the invalid
>> I/O port on the same architectures.
>
> AFAICS it does only partial revert, so I don't see how your patch
> may break that.

I think it's a complete revert, it's just not entirely obvious
since serial8250_setup_port() got split out by 9d86719f8769
("serial: 8250: Allow using ports higher than
SERIAL_8250_RUNTIME_UARTS") and the original callsite got
moved by your ffd8e8bd26e9 ("serial: 8250: Extract platform
driver").

What I suspect is going on with the f4c23a140d80 commit
is the same bug I mentioned earlier in this thread, where
__serial8250_isa_init_ports() just always registers
'nr_uarts' (CONFIG_SERIAL_8250_RUNTIME_UARTS) ports,
unlike any other serial driver.

This used to be required before 9d86719f8769 ("serial:
8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS"),
but I don't see why this is still a thing now, other than
for using setserial on i486-class PCs with nonstandard ISA
ports.

On non-x86 machines, it only ever seems to create extra
ports that are likely to crash the system if opened, either
because they lack proper serial_in/serial_out callbacks,
or because the default UPIO_PORT callbacks end up poking
unmapped memory.

Do you see any reason why we can't just do the version below?

        Arnd

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..5b72309611cb 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -358,8 +358,6 @@ struct uart_8250_port *serial8250_setup_port(int index)
 
 	up->ops = &univ8250_driver_ops;
 
-	serial8250_set_defaults(up);
-
 	return up;
 }
 
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 66fd6d5d4835..7675536b6396 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -33,8 +33,6 @@
 unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 unsigned int skip_txen_test;
 
-unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
-
 #include <asm/serial.h>
 
 /*
@@ -50,6 +48,8 @@ static const struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
+unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;
+
 serial8250_isa_config_fn serial8250_isa_config;
 void serial8250_set_isa_configurator(serial8250_isa_config_fn v)
 {
@@ -65,9 +65,9 @@ static void __init __serial8250_isa_init_ports(void)
 		nr_uarts = UART_NR;
 
 	/*
-	 * Set up initial ISA ports based on nr_uart module param, or else
-	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
-	 * need to increase nr_uarts when setting up the initial ISA ports.
+	 * Set up initial ISA ports based on nr_uart module param. Note that 
+	 * we do not need to increase nr_uarts when setting up the initial
+	 * ISA ports.
 	 */
 	for (i = 0; i < nr_uarts; i++)
 		serial8250_setup_port(i);
@@ -94,6 +94,10 @@ static void __init __serial8250_isa_init_ports(void)
 		port->regshift = old_serial_port[i].iomem_reg_shift;
 
 		port->irqflags |= irqflag;
+
+		serial8250_set_defaults(up);
+
+		/* Allow Intel CE4100 and jailhouse to override defaults */
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
 	}
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5b1cc009b977..3bf27cecf82e 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -198,17 +198,6 @@ config SERIAL_8250_NR_UARTS
 	  PCI enumeration and any ports that may be added at run-time
 	  via hot-plug, or any ISA multi-port serial cards.
 
-config SERIAL_8250_RUNTIME_UARTS
-	int "Number of 8250/16550 serial ports to register at runtime"
-	depends on SERIAL_8250
-	range 0 SERIAL_8250_NR_UARTS
-	default "4"
-	help
-	  Set this to the maximum number of serial ports you want
-	  the kernel to register at boot time.  This can be overridden
-	  with the module parameter "nr_uarts", or boot-time parameter
-	  8250.nr_uarts
-
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
