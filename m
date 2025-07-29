Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F2213E66
	for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781550; cv=none; b=VDQWTjL/D/GXlZ3PIt9OvFzTHBwG/s1U+Mupwf6W8IW1k+FWJGLp8qZ1hYsk+tLC3Jw/KoC0VrvBGh80o1W5snslFukh3laz69XCKmONaFXWF6JzhB1MqewPm1QNoDG33GV5d8qAUBwufOf6un39eIFL83wXWkrB9dqScq4P/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781550; c=relaxed/simple;
	bh=W4M9f/pAgKW1v4aP63Rk+5y/35YhjNbCTzW68Tgcb60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQY34+P7hUCDRE/ltt7jzMzeb0IFqugae1qp/VJKKaTSw4DRMPnWbA4NLwJjnRPubVRi+F39EPIHzWl7qGE9BygV1DhTUzJhhj8rB2Kdtb37OwAvD9qpg5PK8eWkroxW40eyjR6P9cHdD5WrDdwzBGYMaUrUweT0roC2LY7JcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=BGK8Zo34; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="BGK8Zo34"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 88F8F240101
	for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 11:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753781545;
	bh=GOyucIi0Gnh1gFmksRXxoXhE6Uol44TKHp9akm/XXPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=BGK8Zo34u8K6QznvkLYzloCigsbs7VBdIs+GGfZy5kJn2zogdaqIyx9BC59Ahn97g
	 Iht5E9BTyqvuWa5SozuNXZq8UO7a0rjW/TyV6mDmywC93seRBVD7/oDs+QC055FAkM
	 lYh5WyMIBHuB8d1pDWtkKA3CrC861RhvhvbKCFw4aNFxHrrtLcvew/WNR8CjKoHtRJ
	 iI3Y9OlIwBTS8qz6pnByz4rNUHfYSVv6b/Nz8MJjVsG4Pnnk8/1fGNP425mTdoo0Fc
	 025gaa+OUICowqSg6pWd74KoIWlYUOun8QKChIkcdmo0Xu8hdQe9mVv0i9+pRLDUsI
	 SyMUCgm3f450pbJnVGzHsmSgO3BQ1eXUvYIywCm5KX0oF/1Ngp461ux98rvP8UU0dd
	 yje3vqoiZ+7XxiF5+gD1PB+Cp2XlBNkVvungA+B1wY3IAYrf/dNGhXEj2g8GDL5w4d
	 l8QqHy2Jv5cYyjSofvR/EDaUec4Uv2Iy1/lxVOJHmSpeLFtQQEH
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4brqr855MVz9rxK;
	Tue, 29 Jul 2025 11:32:24 +0200 (CEST)
Date: Tue, 29 Jul 2025 09:32:25 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <20250729113223.65d02539@posteo.net>
In-Reply-To: <2025072929-distant-hardener-0e75@gregkh>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
	<2025072929-distant-hardener-0e75@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 10:48:17 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 29, 2025 at 08:17:04AM +0000, Wilken Gottwalt wrote:
> > Fixes:
> 
> But no "Fixes:" tag in the commit?  No cc: stable added?

It is a long time I ago I did a fixes patch, argh. Hmm, it was a line like this
Fixes: 123456789012 ("bla: bla: aaaahhh"), right? I will fix that. Though, I'm
not sure if I should refer the pcim_iomap change here, or the change in the exar
drivers default_setup. The point is, the first change, the default_setup one was
fine until the later pcim_iomap change was done. The later change basically
affects hundrets of drivers, while the default_setup change is limited to the
8250 exar driver only. I will not touch pcim_iomap. What do you think about
this?

> > 
> > [    2.601213] WARNING: CPU: 3 PID: 1 at pcim_iomap.part.0+0xbc/0xc0
> > [    2.601224] Modules linked in:
> > [    2.601230] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.38-vanilla-standard #1
> > [    2.601237] Hardware name: Default string Default string/CXC-BT-JERO, BIOS S1.61.1.0#
> > 09/17/2018 [    2.601241] RIP: 0010:pcim_iomap.part.0+0xbc/0xc0
> > [    2.601248] Code: 31 ed e8 07 a5 14 00 4c 89 e8 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc 45 31
> > ed 5b 41 5c 4c 89 e8 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b eb a0 90 90 90 90 90 90 90 90 90 90
> > 90 90 90 90 90 90 0f 1f [    2.601253] RSP: 0000:ffffa7444001f830 EFLAGS: 00010286 [
> > 2.601259] RAX: ffffa066c1321f28 RBX: 0000000000000000 RCX: ffffa066c1215330 [    2.601264] RDX:
> > 0000000000000001 RSI: 0000000000000286 RDI: ffffa066c121532c [    2.601268] RBP:
> > ffffa7444001f850 R08: 0000000000000000 R09: 0000000000000286 [    2.601272] R10:
> > 0000000000000000 R11: 000ffffffffff000 R12: ffffa066c1215000 [    2.601275] R13:
> > ffffa744403b0000 R14: ffffa066c1310208 R15: ffffa066c12150c8 [    2.601279] FS:
> > 0000000000000000(0000) GS:ffffa067d7d80000(0000) knlGS:0000000000000000 [    2.601284] CS:
> > 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [    2.601288] CR2: 0000000000000000 CR3:
> > 000000005f22a000 CR4: 00000000001006f0 [    2.601292] Call Trace:
> > [    2.601296]  <TASK>
> > [    2.601301]  pcim_iomap+0x1a/0x20
> > [    2.601308]  serial8250_pci_setup_port+0xea/0x190
> > [    2.601337]  default_setup.constprop.0+0x27/0x90
> > [    2.601347]  pci_xr17v35x_setup+0xd0/0x190
> > [    2.601355]  exar_pci_probe+0x297/0x400
> > [    2.601365]  ? __pfx_generic_rs485_config+0x10/0x10
> > [    2.601383]  local_pci_probe+0x4b/0xb0
> > [    2.601390]  pci_device_probe+0xc5/0x200
> > [    2.601397]  really_probe+0xe5/0x390
> > [    2.601405]  __driver_probe_device+0x7e/0x160
> > [    2.601412]  driver_probe_device+0x23/0xa0
> > [    2.601418]  __driver_attach+0xe4/0x1e0
> > [    2.601424]  ? __pfx___driver_attach+0x10/0x10
> > [    2.601431]  bus_for_each_dev+0x7d/0xd0
> > [    2.601438]  driver_attach+0x1e/0x30
> > [    2.601444]  bus_add_driver+0x114/0x240
> > [    2.601450]  driver_register+0x64/0x130
> > [    2.601457]  ? __pfx_exar_pci_driver_init+0x10/0x10
> > [    2.601466]  __pci_register_driver+0x61/0x70
> > [    2.601471]  exar_pci_driver_init+0x1e/0x30
> > [    2.601479]  do_one_initcall+0x49/0x310
> > [    2.601487]  kernel_init_freeable+0x1aa/0x2e0
> > [    2.601495]  ? __pfx_kernel_init+0x10/0x10
> > [    2.601503]  kernel_init+0x1a/0x1c0
> > [    2.601510]  ret_from_fork+0x3c/0x60
> > [    2.601516]  ? __pfx_kernel_init+0x10/0x10
> > [    2.601523]  ret_from_fork_asm+0x1a/0x30
> > [    2.601531]  </TASK>
> > 
> > >From kernel 6.8 to 6.9 the default_setup function was changed to use the
> > more generic serial8250_pci_setup_port function to setup the serial
> > ports, but that results in this kernel warning.
> > 
> > The serial8250_pci_setup_port function internally relies on the
> > pcim_iomap function. The way this function works was changed from kernel
> > 6.10 to 6.11 and now clearly states in the description "This SHOULD only
> > be used once per BAR". And this is the issue. Basically all the hardware
> > handled by the 8250_exar driver are multi-port cards, which have
> > multiple ports on one PCI bar. The serial8250_pci_setup_port/pcim_iomap
> > functions can not be used with that driver anymore. Reverting the code
> > back to the older pci_resource_start approach fixes this issue.
> 
> These two paragraphs should be above the warning splat.

Yeah, I wasn't sure about this. Will fix this.

> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 04a0cbab02c2..5660bb897803 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  			 struct uart_8250_port *port)
> >  {
> >  	const struct exar8250_board *board = priv->board;
> > +	unsigned int bar = 0;
> 
> Why is this needed?

It was the original code, I just reverted it. The idea was to go back to code,
which was there for several kernel generations and worked flawlessly. But yes,
that can be optimized. I can change this.
 
> >  	unsigned char status;
> > -	int err;
> >  
> > -	err = serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_shift);
> > -	if (err)
> > -		return err;
> > +	port->port.iotype = UPIO_MEM;
> > +	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> > +	port->port.membase = priv->virt + offset;
> > +	port->port.regshift = board->reg_shift;
> 
> And so now serial8250_pci_setup_port() is never called?  Are you sure
> that's ok?

Not by this exar driver, but other serial port drivers (8250_pci1xxxx, 8250_pci)
use it, just like it was before the change in kernel 6.9.

> thanks,
> 
> greg k-h

Thanks for the feedback.

greetings,
Wilken

