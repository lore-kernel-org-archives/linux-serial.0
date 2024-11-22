Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDB16EBEC;
	Fri, 22 Nov 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732316045; cv=none; b=kT/hEdAkAIZaKLR0/8D6rPI3fYeefj2cY5kbDqQTVIQVcR5HTyu2Lpb0ACe+yeWIbaJF5Pkh0K5AS955xg6Ae1WpQE79TMhHQAlwv1ipFaUsil5CbVAFHbJ3Ho48MDY4kEuKMDpJ2VA+N3Sbb+uhUQPbW1me4nm6piunHX5dQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732316045; c=relaxed/simple;
	bh=7cl79AxGHXbS/CI6KOpEnUB0/ltJq38rzwVVv1fM2Gg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NYfo/1atdm9U2tPmaVicUfw4ToELPOg1bHpKs3O37iiWM3Tnk0ubMgMcrFy3aKLfMkVdiDo0rN3ryfo/EBNpLGWJIiFF2g3ZajFID7Zo/EYaZMWmx1hN88geV/X1J+AfpNe8DkWL3H5pUodVIzm5rz2jgIqSva60KB9jccMZPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0W+zO+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0W+zO+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DB3C4CED3;
	Fri, 22 Nov 2024 22:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732316045;
	bh=7cl79AxGHXbS/CI6KOpEnUB0/ltJq38rzwVVv1fM2Gg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Z0W+zO+6rMvddB33Xt2z2A6oIXuJgxQWqOoPIvjgOLJCy9/huUJZJrpIWNAwrxjmC
	 IHaQ9RN0MEveQepxiGVpT6c9bBUWS8J1GvJtpV9t7S7mVGd+iBqvGYBVavuSzjRKe7
	 VD6m0fDqLUaCRWNIQ78pdKCi9VxNvD9Lj9G9aWdwT96rPsgdW/cN/oUvmmD4TewT7j
	 t4JH5Nu3stEvEI2wMQmdPTidCbdrXh1ge/gUO/msXnLQzE9FhktZuWUu4zzGVo2tTp
	 djREy/qE1Tm8rZjq11rx+1EzSW3HGzAfjDY2c1naGfUWEihWQ+ydS7A+zt4FCBc+Go
	 kD2ucJWIRW0pA==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 794AC1200073;
	Fri, 22 Nov 2024 17:54:03 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 22 Nov 2024 17:54:03 -0500
X-ME-Sender: <xms:iwtBZyXX3_p_hOteZ2JZiU4hTRUfvL4ypK08HmfcOzL_85nCAC3pPg>
    <xme:iwtBZ-n0q6AyjuVDkmm2kaZU3BoCSvzysWOJxiwwg8cf-ksBv-cSt870qvh7_mmUK
    IlLXmXbEt8RU7uxJPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgedtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehhtggrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepshgthhhnvghllhgv
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthh
    gvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehilhhpohdrjhgr
    rhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugies
    rhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iwtBZ2b1bLOdIkr3lyPxRKxsxYRDBABmV0l2JUe8JcxOOlL1TtoMjw>
    <xmx:iwtBZ5WMyTzBHk3pVy0UverBHNUF-5SZ5FpOYTkWdTdUtxxvcNr_ZQ>
    <xmx:iwtBZ8l9vgHv-PUIgTJK9WkJ9xqF0476bLKbXiKwhv6bGGqF_T2ioQ>
    <xmx:iwtBZ-fAUKepLl9PN0O5IYe2wkqEIq-QT_bfEMiOcsiYUZDUkHIxrg>
    <xmx:iwtBZ-E9Q2Qk7NdW4R3GdtuN67GVnu3FQuSXylDJpImNGGecWKJqDI-G>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49F7A2220072; Fri, 22 Nov 2024 17:54:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 23:51:38 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Message-Id: <eb1c5d4b-0662-41dd-826c-d3c3cf78de2b@app.fastmail.com>
In-Reply-To: <791f37f3-2b93-47f1-b0a3-46825c09f222@roeck-us.net>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <791f37f3-2b93-47f1-b0a3-46825c09f222@roeck-us.net>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 22, 2024, at 21:44, Guenter Roeck wrote:
> On 11/22/24 11:24, Arnd Bergmann wrote:
>> 
>> serial8250_setup_port() is where it ends up using the
>> uninitialized serial8250_ports[index] contents. Since
>> port->iotype is not set to anything here, it defaults to
>> '0', which happens to be UPIO_PORT.
>> 
>> The reason it doesn't immediately crash and burn is that
>> this is still only setting up the structures for later
>> use, but I assume that trying to use console=ttyS0, or
>> opening /dev/ttyS0 on the uninitialized port would
>> then cause an oops.
>> 
>
> All four affected platforms use ttyS0, only it is mmio based,
> not io port based.

Right, so I think the problem is really the 8250_platform.c
file trying to handle all possible cases on x86 (acpi,
isapnp, legacy isa) that may define the same UARTs, but
also trying to handle non-legacy ports with their own
special cases on other architectures.

The patch below is a first idea of how we can skip the
legacy ISA case on architectures that don't define those.
If this works, we can try to come up with a better way of
doing that. Ideally all the pre-DT boardfile machines that
define their own "serial8250" platform_device (with platform_data)
should use a different identifier the x86-legacy case that
uses the platform_device (without platform_data). Similarly,
I think the riscv special ACPI port needs its own trivial
driver without all the ISA magic.

      Arnd

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 66fd6d5d4835..610b31517734 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -101,7 +101,8 @@ static void __init __serial8250_isa_init_ports(void)
 
 void __init serial8250_isa_init_ports(void)
 {
-	DO_ONCE(__serial8250_isa_init_ports);
+	if (ARRAY_SIZE(old_serial_port))
+		DO_ONCE(__serial8250_isa_init_ports);
 }
 
 /*
@@ -283,7 +284,7 @@ static const struct acpi_device_id acpi_platform_serial_table[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
 
-static struct platform_driver serial8250_isa_driver = {
+static struct platform_driver serial8250_platform_driver = {
 	.probe		= serial8250_probe,
 	.remove		= serial8250_remove,
 	.suspend	= serial8250_suspend,
@@ -300,7 +301,7 @@ static struct platform_driver serial8250_isa_driver = {
  */
 struct platform_device *serial8250_isa_devs;
 
-static int __init serial8250_init(void)
+static int __init serial8250_isa_init(void)
 {
 	int ret;
 
@@ -337,11 +338,8 @@ static int __init serial8250_init(void)
 
 	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
 
-	ret = platform_driver_register(&serial8250_isa_driver);
-	if (ret == 0)
-		goto out;
+	return 0;
 
-	platform_device_del(serial8250_isa_devs);
 put_dev:
 	platform_device_put(serial8250_isa_devs);
 unreg_pnp:
@@ -355,6 +353,17 @@ static int __init serial8250_init(void)
 out:
 	return ret;
 }
+
+static int __init serial8250_init(void)
+{
+	if (ARRAY_SIZE(old_serial_port)) {
+		int ret = serial8250_isa_init();
+		if (ret)
+			return ret;
+	}
+
+	return platform_driver_register(&serial8250_platform_driver);
+}
 module_init(serial8250_init);
 
 static void __exit serial8250_exit(void)
@@ -368,7 +377,11 @@ static void __exit serial8250_exit(void)
 	 */
 	serial8250_isa_devs = NULL;
 
-	platform_driver_unregister(&serial8250_isa_driver);
+	platform_driver_unregister(&serial8250_platform_driver);
+
+	if (!ARRAY_SIZE(old_serial_port))
+		return;
+
 	platform_device_unregister(isa_dev);
 
 	serial8250_pnp_exit();
