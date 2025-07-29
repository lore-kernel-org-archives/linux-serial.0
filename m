Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A827A928
	for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777035; cv=none; b=qPKaxnSBImaCU03ZHloQTvATw8Sbe/AyvbMgm3Q/N/tdbRBa/dWvMWe/UwlCBkeK+qVb+rZqHR17IU6hVjvkpDjK8Kz/2+y6YY0kdm4y0/vSxMCdKfhvQ01onG8BbSnf/RnDI9W5ODyYntObwykuhcrkb9dkpCbQU74lyVeMF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777035; c=relaxed/simple;
	bh=s1cI9+7C2OYK16bCxJ+aP05wRZKrzMS8qNt6g/O1Esc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HDj8Xm3qS4b8YK90whOa+SPyfY/yO4VAt1fOkAvlow40CzCwsxe2VGGu06i8ZGlV62xJOc701fHLrGYEwULQiwlMlegTYSHnBNDEuk1ss7DJ+auJH/CNAi5f2ASWCXXscfSO5e6IGR3z3JXCczcgCvXVVxMcl+TlRmxjdN7HlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=djWFjSgT; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="djWFjSgT"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2854F240101
	for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 10:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753777025;
	bh=ZceV9lTb5x0zeijbqghaE+NKc2Tl2gM8GVa9ckfsj/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From;
	b=djWFjSgTrv8LcPjd/1XxhMTsTf9t+T0XXS8TYr6hYDjZtK5EQ06el+f/L29vSykBg
	 xb9yeDetgSi/SfbyWhUlAObq3yqy3nJuMZ0lGDSQAbtt+tHP7TtmNg0B0rhH4TZKku
	 UHTVhWsgauAH1xOEIAVESCIAO/vNZaSx0iohAmkFFbPpm+0tM8YkN6f/3alJKGbEbB
	 lz84i3cH4C07i1Miw56xI6zz08AAyNDE05zipG/I7wSqlelIQ+z5FEjCtxJP2BaAV7
	 CHHLaJTNprNVIA6ZoKX53D7Nw7uOCnLlOYRFX3+C9bh4m8gyshGF6KKJyqpkvXDDOj
	 7jjrNulVpPO6Uc6IqsS5wbox/PXq46jJXa7G3i3wH795Fv7Wn3Rpp3lkKQ8Tr9f5l/
	 VrsghlpmRob0x55ChMsSz6lE/15+7uxOGNWveCcTFdSnaDZA+KgVZHJVXddxppYq5L
	 qCSzFqhwEgUJkHrQZLZZTNjLlJQnjWWqYpTrkg/VHBYTrhWBeA0
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4brp9D2n43z6tvy;
	Tue, 29 Jul 2025 10:17:04 +0200 (CEST)
Date: Tue, 29 Jul 2025 08:17:04 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: serial: 8250: exar: fix kernel warning in default_setup
 function
Message-ID: <aIiDf31HzRBGuMN2@monster.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixes:

[    2.601213] WARNING: CPU: 3 PID: 1 at pcim_iomap.part.0+0xbc/0xc0
[    2.601224] Modules linked in:
[    2.601230] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.38-vanilla-standard #1
[    2.601237] Hardware name: Default string Default string/CXC-BT-JERO, BIOS S1.61.1.0# 09/17/2018
[    2.601241] RIP: 0010:pcim_iomap.part.0+0xbc/0xc0
[    2.601248] Code: 31 ed e8 07 a5 14 00 4c 89 e8 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc 45 31 ed 5b 41 5c 4c 89 e8 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b eb a0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
[    2.601253] RSP: 0000:ffffa7444001f830 EFLAGS: 00010286
[    2.601259] RAX: ffffa066c1321f28 RBX: 0000000000000000 RCX: ffffa066c1215330
[    2.601264] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffffa066c121532c
[    2.601268] RBP: ffffa7444001f850 R08: 0000000000000000 R09: 0000000000000286
[    2.601272] R10: 0000000000000000 R11: 000ffffffffff000 R12: ffffa066c1215000
[    2.601275] R13: ffffa744403b0000 R14: ffffa066c1310208 R15: ffffa066c12150c8
[    2.601279] FS:  0000000000000000(0000) GS:ffffa067d7d80000(0000) knlGS:0000000000000000
[    2.601284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.601288] CR2: 0000000000000000 CR3: 000000005f22a000 CR4: 00000000001006f0
[    2.601292] Call Trace:
[    2.601296]  <TASK>
[    2.601301]  pcim_iomap+0x1a/0x20
[    2.601308]  serial8250_pci_setup_port+0xea/0x190
[    2.601337]  default_setup.constprop.0+0x27/0x90
[    2.601347]  pci_xr17v35x_setup+0xd0/0x190
[    2.601355]  exar_pci_probe+0x297/0x400
[    2.601365]  ? __pfx_generic_rs485_config+0x10/0x10
[    2.601383]  local_pci_probe+0x4b/0xb0
[    2.601390]  pci_device_probe+0xc5/0x200
[    2.601397]  really_probe+0xe5/0x390
[    2.601405]  __driver_probe_device+0x7e/0x160
[    2.601412]  driver_probe_device+0x23/0xa0
[    2.601418]  __driver_attach+0xe4/0x1e0
[    2.601424]  ? __pfx___driver_attach+0x10/0x10
[    2.601431]  bus_for_each_dev+0x7d/0xd0
[    2.601438]  driver_attach+0x1e/0x30
[    2.601444]  bus_add_driver+0x114/0x240
[    2.601450]  driver_register+0x64/0x130
[    2.601457]  ? __pfx_exar_pci_driver_init+0x10/0x10
[    2.601466]  __pci_register_driver+0x61/0x70
[    2.601471]  exar_pci_driver_init+0x1e/0x30
[    2.601479]  do_one_initcall+0x49/0x310
[    2.601487]  kernel_init_freeable+0x1aa/0x2e0
[    2.601495]  ? __pfx_kernel_init+0x10/0x10
[    2.601503]  kernel_init+0x1a/0x1c0
[    2.601510]  ret_from_fork+0x3c/0x60
[    2.601516]  ? __pfx_kernel_init+0x10/0x10
[    2.601523]  ret_from_fork_asm+0x1a/0x30
[    2.601531]  </TASK>

From kernel 6.8 to 6.9 the default_setup function was changed to use the
more generic serial8250_pci_setup_port function to setup the serial
ports, but that results in this kernel warning.

The serial8250_pci_setup_port function internally relies on the
pcim_iomap function. The way this function works was changed from kernel
6.10 to 6.11 and now clearly states in the description "This SHOULD only
be used once per BAR". And this is the issue. Basically all the hardware
handled by the 8250_exar driver are multi-port cards, which have
multiple ports on one PCI bar. The serial8250_pci_setup_port/pcim_iomap
functions can not be used with that driver anymore. Reverting the code
back to the older pci_resource_start approach fixes this issue.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 drivers/tty/serial/8250/8250_exar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 04a0cbab02c2..5660bb897803 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 			 struct uart_8250_port *port)
 {
 	const struct exar8250_board *board = priv->board;
+	unsigned int bar = 0;
 	unsigned char status;
-	int err;
 
-	err = serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_shift);
-	if (err)
-		return err;
+	port->port.iotype = UPIO_MEM;
+	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
+	port->port.membase = priv->virt + offset;
+	port->port.regshift = board->reg_shift;
 
 	/*
 	 * XR17V35x UARTs have an extra divisor register, DLD that gets enabled
-- 
2.50.1

