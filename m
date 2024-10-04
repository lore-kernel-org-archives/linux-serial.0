Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5711DC19D
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046159; cv=none; b=VcfZFMZ1UxnBvAfsBagWHrGy5o+L6iEMX63qMnAKJeXPju+Pdx1cTPdYcTGDNnpBBCtv+vYnb5aQQoqGcC6QnfzIq2Z7FPj4XiPXzi9tEow8QMdmUqo/pg0F55dhr5K3qfj4I3r5bq9IBXXcr9ReyjK8fuCsVscSvOBo/shkSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046159; c=relaxed/simple;
	bh=RVDjOu/smcCTAlb8O/VamzlNR+7aD1rrKn/d0WU7JK4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bIJnu0X7JIDvPoB/NXXs8viX/Z7u5osQq2oadyNJwrQSUCKcoep6AnYK9EmpoRyKcKxe7zZ2dKkKDld/kkr9gZJjBXC2mLCjmukYxQ/sdlhZlXYw7Fy7tVsyu3+2SXBs84pZ0gaWauUG1u9822DkNust1v/otq4e9eMXQ4GkhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2VyvV1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2VyvV1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE4C4DDE0;
	Fri,  4 Oct 2024 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046159;
	bh=RVDjOu/smcCTAlb8O/VamzlNR+7aD1rrKn/d0WU7JK4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H2VyvV1MRNor7SCotV72ZFQAkcGwgPjW9hi25wGxt8Ptjs6LZ8FGTO/gOSMwsgctl
	 LJuOLRQIPOLYpPx8rvxaF+gZEDMaiVvi1/jOFAPd2Hr94AuwM73GcSYrk8d8wCZXSK
	 ZT6E4ceR6WgKct6xje6oBoojIbfcvindlY270bHmwZizBG/8bSbSM9D98FTAwZIoCv
	 st8NGbBW/7N6105UjHZPfp2rEaAz978K75PoqMSyzCM9F2QtrcSBAcXTSh687F3Z2S
	 gOJNpSm4VQoJ5Y5feG03BS82neYJUAH3SvFbGW3srHJT5KwRM3bKxgD66ZO85TM8PX
	 B2E2x7I5+q3Bw==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BFB241200043;
	Fri,  4 Oct 2024 08:49:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 04 Oct 2024 08:49:17 -0400
X-ME-Sender: <xms:TeT_ZtirptZe69526iAi7zVEJOnvumZs350eqnLfH2gPpR7gxcesWw>
    <xme:TeT_ZiBXcSY7JMAEaq8tPXhz9w-7_7G8rHkQeOBIimfoJHWLA0M4sEhVV5U6TCKTt
    4cLELmgMu9Ey3QBs8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhl
    vgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrtghrohesohhrtggrmh
    drmhgvrdhukhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TeT_ZtEwaTvO8eiigRtCkJGX_y_dKigJGworNDQ01D537UB9OYQuvA>
    <xmx:TeT_ZiT7NFFLD70rtRHnZBSMP0GHyhn87DnoGAhP_NXuCVJvAgJiiQ>
    <xmx:TeT_ZqwKpSYm-rKIalu2K7DfdEgI9GpiRO_dQsNrwZmeR5MsuCOsAg>
    <xmx:TeT_Zo6vUjtFlKn_K0A9Rdc3qQ_wqI787-Izu7gNLsMAkVuBrqoPGw>
    <xmx:TeT_Zvzkc_lF7E7gLYLBkB576_oWdvxaS6sUsXwBMM31h68rdpytSSHl>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E51D2220071; Fri,  4 Oct 2024 08:49:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 12:48:56 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Message-Id: <eedc037b-8790-4269-8ed6-d641b9cbc4ad@app.fastmail.com>
In-Reply-To: <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
 <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
 <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
 <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com>
 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
 <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 4, 2024, at 10:09, Niklas Schnelle wrote:

> I'm working on a new proposal for 8250 now. Basically I think we can
> put the warning/error in serial8250_pci_setup_port(). And then for
> those 8250_pci.c "sub drivers" that require I/O ports instead of just
> ifdeffing out their setup/init/exit we can define anything but setup to
> NULL and setup to pci_default_setup() such that the latter will find
> the I/O port BAR via FL_GET_BASE() and subsequently cause the error
> print in serial8250_pci_setup_port(). It's admittedly a bit odd but it
> also keeps the #ifdefs to just around the code that wouldn't compile.

Right, makes sense.

> One thing I'm not happy with yet is the handling around
> is_upf_fourport(port) in 8250_pci.c. With !HAS_IOPORT this is defined
> as false. With that it makes sure that inb_p()/outb_p() aren't called
> but I think this only works because the compiler usually drops the dead
> if clause. I think there were previous discussions around this but I
> think just like IS_ENABLED() checks this isn't quite correct.

Not sure what you mean, we rely on dead code elimination in all
kinds of places. The only bit to be aware of is that normal
'inline' functions may not get constant-folded all the time,
but anything that is either a macro or __always_inline does
work.

I just verified that the version below does what Maciej
suggested with IS_ENABLED() in 8250-pci, and this works fine.

       Arnd

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6709b6a5f301..784190824aad 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -928,6 +928,14 @@ static int pci_netmos_init(struct pci_dev *dev)
 	return num_serial;
 }
 
+static int serial_8250_need_ioport(struct pci_dev *dev)
+{
+	dev_warn(&dev->dev,
+		 "Serial port not supported because of missing I/O resource\n");
+
+	return -ENXIO;
+}
+
 /*
  * These chips are available with optionally one parallel port and up to
  * two serial ports. Unfortunately they all have the same product id.
@@ -964,6 +972,9 @@ static int pci_ite887x_init(struct pci_dev *dev)
 	struct resource *iobase = NULL;
 	u32 miscr, uartbar, ioport;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	/* search for the base-ioport */
 	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
 		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
@@ -1049,6 +1060,10 @@ static int pci_ite887x_init(struct pci_dev *dev)
 static void pci_ite887x_exit(struct pci_dev *dev)
 {
 	u32 ioport;
+
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		serial_8250_need_ioport(dev);
+
 	/* the ioport is bit 0-15 in POSIO0R */
 	pci_read_config_dword(dev, ITE_887x_POSIO0, &ioport);
 	ioport &= 0xffff;
@@ -1514,6 +1529,9 @@ static int pci_quatech_init(struct pci_dev *dev)
 	const struct pci_device_id *match;
 	bool amcc = false;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	match = pci_match_id(quatech_cards, dev);
 	if (match)
 		amcc = match->driver_data;
@@ -1538,6 +1556,9 @@ static int pci_quatech_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	/* Needed by pci_quatech calls below */
 	port->port.iobase = pci_resource_start(priv->dev, FL_GET_BASE(board->flags));
 	/* Set up the clocking */
@@ -1864,6 +1885,9 @@ static int kt_serial_setup(struct serial_private *priv,
 			   const struct pciserial_board *board,
 			   struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	port->port.flags |= UPF_BUG_THRE;
 	port->port.serial_in = kt_serial_in;
 	port->port.handle_break = kt_handle_break;
@@ -1918,6 +1942,8 @@ static int pci_wch_ch38x_init(struct pci_dev *dev)
 	int max_port;
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
 
 	switch (dev->device) {
 	case 0x3853: /* 8 ports */
@@ -1937,6 +1963,9 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 {
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		serial_8250_need_ioport(dev);
+
 	iobase = pci_resource_start(dev, 0);
 	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
 }
@@ -2052,6 +2081,9 @@ static int pci_moxa_init(struct pci_dev *dev)
 	unsigned int i, num_ports = moxa_get_nports(device);
 	u8 val, init_mode = MOXA_RS232;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_RS422;
 	}
@@ -2084,6 +2116,9 @@ pci_moxa_setup(struct serial_private *priv,
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
