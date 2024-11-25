Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C8190662
	for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528459; cv=none; b=HrM0QFiNKc4EmUOm5kmbxBUd+Ui8jjSSCZHvwMu9E/WXJ/4mg8mXKUAJDdtLocPsxrPAJrptTXXn/PO1bn+MKOs/vO33+YtayGL2b3lYASjRwcUQyHBs+d1Ik07kZoFcAMRbCG4U33QNcayNz6EKSAZZSnc+pnVdk0KzZfeEMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528459; c=relaxed/simple;
	bh=gHwhc9KOj+cZOKgz6vnfOwrkoWHADDCUrI4b85vHXZU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dAADppA5DDFLkkN6X863BWwACFWIik7W+ZlRqvxKxjGp039lF0JruUNcWqavSsUqvs5G3mNLlV+lo9dAGdiBp9iS/Sg5fvfK/Hzt3cRqcgFlVOOJkVDFUUlXxrrXWMUY3YUF9rDI4S2sEvuO6u8ful2d1zONwP3ZTqzEpl3G1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4IWOLWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4IWOLWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866ABC4CED1;
	Mon, 25 Nov 2024 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732528459;
	bh=gHwhc9KOj+cZOKgz6vnfOwrkoWHADDCUrI4b85vHXZU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=t4IWOLWWgh4j1l9W+hZlk3ItV7+jwKmJu3PaYU3d2haAuCgQ9x8D6/R2rt4Qdr+0v
	 z4oAdOR7ZfDn0yaeHW97odcyvmq8YfMxTAl9qETiqFgncwR8DANE0wR+v5E9qyA4gk
	 3Ff0x0d/Oj1ifmvEvYpFLIbKNYOaFrsKmEkE625Rw6tHsxPaj8l168aJ7wSY2GHFvq
	 jP5QHwQff8aQL+/wTyqofYX7L/g2bFd2der9qp7EaKqhjMGqpBwSg4wCnc1/dP0XN7
	 XIHqGC8LhVzmwYGqLEHZEjC7kHikZJpRXL2aSzgpsvVDtLgWNEBgC40dzL8U7HiyWJ
	 hMwBt19qInV8w==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D977120007F;
	Mon, 25 Nov 2024 04:54:17 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 04:54:17 -0500
X-ME-Sender: <xms:SUlEZxarIomWgDBfYUpFRPiACFv_RC-6ohnAC1XLVwwPVu4UFBYygQ>
    <xme:SUlEZ4a4tp2ubRUMlhs6MGQNT2rFmFbUBB8E3luBqRj0MvX16sEY7szqLRHNwpQHc
    Fbnt5W8a9_cOJyPZuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:SUlEZz9NfZcfSTk8fPD7GnnF8v0MgUhnKZPwIzhi1AThxqwh-41UFg>
    <xmx:SUlEZ_rptzDEQ8VbabBqcI9OXz9R1dYTHFsX6Iod1P3hZwGVYHXydQ>
    <xmx:SUlEZ8r_QLW8Nj-JXAKOtL_ZXQd84njCSjcJ0tnATm-u3f2mK9KeYQ>
    <xmx:SUlEZ1QBmw3rvoWngG0nuXJqH08fvqhQQHvrDXP5M9RzKAJGftLytA>
    <xmx:SUlEZ0qaPpJ7-Tpbpd0-Zwaapie9pYIN-M5p8GP7_rmEc2ureKVLd9XL>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51D622220071; Mon, 25 Nov 2024 04:54:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 10:53:46 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
In-Reply-To: <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 08:55, Andy Shevchenko wrote:
> On Fri, Nov 22, 2024 at 08:24:37PM +0100, Arnd Bergmann wrote:
>> On Fri, Nov 22, 2024, at 18:22, Guenter Roeck wrote:
>> 
>> This looks like a bug in drivers/tty/serial/8250/8250_platform.c
>> to me, not something the architectures did wrong. My impression
>> from __serial8250_isa_init_ports() is that this is supposed
>> to initialize exactly the ports in the old_serial_port[]
>> array, which is filled only on alpha, m68k and x86 but not
>> on the other ones.
>
>> Andy moved this code in ffd8e8bd26e9 ("serial: 8250: Extract
>> platform driver"), but I don't think this move by itself
>> changed anything.
>
> Yep. the idea was to purely split this code out of the core
> library parts. I was not intending any functional changes.

Ok.

> I believe it's a preexisted bug, but if you can point out to
> the breakage I made, please do it, so I would be able to fix
> ASAP.
>
>> serial8250_setup_port() is where it ends up using the
>> uninitialized serial8250_ports[index] contents. Since 
>> port->iotype is not set to anything here, it defaults to
>> '0', which happens to be UPIO_PORT.
>
> Btw, we have a new constant to tell the 8250 core that IO type is not set,
> but that one is not used here.

So I see serial8250_setup_port() setting "up->cur_iotype = 0xFF"
by first calling serial8250_init_port(), this is the "not
set" value you mean, right?.

Right after that it calls serial8250_set_defaults(),
which sets "up->cur_iotype = p->iotype;", which may or
may not be initialized here.

The possible calls chains I see leading up to
serial8250_setup_port() are:

serial8250_register_8250_port(): here we first initialize
  the iotype incorrectly, then set uart->port.iotype and
  call serial8250_set_defaults() again to fix it.

module_init(serial8250_init): relies on the first
  serial8250_set_defaults() for the ISA ports since they
  are always UPIO_PORT, but sets the other ones (pnp, acpi,
  platform_data) correctly.

early_serial_setup(): called only on non-ISA platforms,
  shouldn't need to call serial8250_isa_init_ports() at
  all.

console_initcall(univ8250_console_init): Not completely
  sure here, it seems this now only allows ports that
  are registered from one of the methods above

Can you have a look at the patch below? I think this
correctly removes the broken serial8250_set_defaults()
while also still adding it in the one case that relies
on the implied version.

This does however revert f4c23a140d80 ("serial: 8250:
fix null-ptr-deref in serial8250_start_tx()") and
might bring back the bug came from opening an
uninitialized uart. On the other hand, I don't see
why that doesn't also crash from accessing the invalid
I/O port on the same architectures.

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
index 66fd6d5d4835..d3c1668add58 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -94,6 +94,10 @@ static void __init __serial8250_isa_init_ports(void)
 		port->regshift = old_serial_port[i].iomem_reg_shift;
 
 		port->irqflags |= irqflag;
+
+		serial8250_set_defaults(port);
+
+		/* Allow Intel CE4100 and jailhouse to override defaults */
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
 	}

