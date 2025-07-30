Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF2293462
	for <linux-serial@vger.kernel.org>; Wed, 30 Jul 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873441; cv=none; b=JkoEPtzt6q9/nK1MFOQcYls/NLVJ3TytQB/iZyb6ItiXCIwiS8vQGtykM0fmyLLMg5QZx9o6f0TkIBX0ScS02o2PhO6xUUkP8LDfaP16/OKshRoGQZGK82n2X3n0Iqu77Duk+fWIsN2IuxgyRct3h23JBE0s6ex8nC4KltUnrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873441; c=relaxed/simple;
	bh=szHfJZabhBzQOJCt7xJakEBSVeQuaISLuhGKPgme3UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl/wYJbh5cYVfmhFBCdE8QGBjoI3CkICgs2Fh8nA1Jrs24sZrK5Ql45TunftsI47/UKVkuI44XdZTZh+8Am4HdJfB07QQBigByxlYSxMAe+8Q6IDeSfOJrxyftZj8Xy+Zq69ef8U4tPgF9AflELJQKG8E39sLMePhhPcQCs/ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=hIrludL7; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="hIrludL7"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F05E5240101
	for <linux-serial@vger.kernel.org>; Wed, 30 Jul 2025 13:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753873430;
	bh=A8Tk31KLWXGEJE8kGQgr7GbyzbSIczErq5KW134DbNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=hIrludL71YOynUay6Y1461uhuCxgot24rOfIw0scNUOQh/d974/U3xbIoLda9pYQc
	 yHXrHGbGsE+KU/dgx0byg95/nCLlq/ZLScKjKf2/tuiU5smJIg65XQkwR9cqm3p7EJ
	 gX482UBcX8R//iXp9IuDbIVkc+nTfYn/UKNXx+yuwRM3P5+pRW2/cqi0R8aaAKyTF7
	 gnmWBimIrPpArt+Bg9RxoA4KHIUIADoySTF07+viWFKZRkErgbCwg0C5FoK88eBAeL
	 Ur8t9jOzeSVSyc0+Au1Z09/5mbsVpmW66CLOb3C4YBwqxBVAq9cLt/e0SgDMFDaK6K
	 lDajYWmBr6pIRX4RcrtBTqhpFf43YKZEDjBgB2kigXR+pCor3E1Eq3th6DFpC7Wzmw
	 QE0qzcdfd+b9rxWSZ3SAqBFSWEWtzqHcGv+2Vn7Fy0r/aCzUSgvmpfeSbGF5s64UYK
	 fM+t5OpDe7TOUXoapI8ZuJK6Y7HXnxD0mRxDzkviPmsaioIlDzO
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bsTq945Lfz9rxL;
	Wed, 30 Jul 2025 13:03:49 +0200 (CEST)
Date: Wed, 30 Jul 2025 11:03:50 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <20250730130348.082ad53d@posteo.net>
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

> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 04a0cbab02c2..5660bb897803 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  			 struct uart_8250_port *port)
> >  {
> >  	const struct exar8250_board *board = priv->board;
> > +	unsigned int bar = 0;
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

Hi Greg,

I will not provide a second version of this patch, because this is a bigger
problem involving 8250_exar, 8250_pci and 8250_pci1xxxx. With the changes from
kernel 6.10 to 6.11 the underlying pcim_* functions where changed. The
serial8250_pci_setup_port() does checks on pci_dev + BAR where resources were
already mapped via pcim_iomap(), pci_iomap() or even pci_ioremap_bar(). Not
sure if mixing this is a good idea after the kernel 6.11 changes.

serial8250_pci_setup_port() uses pcim_iomap() and pcim_iomap_table() for checking
these already mapped resources. But the pcim_iomap_table() is deprecated and
suggests to use pcim_iomap() function to aquire the pointer to the resources
while at the same time pcim_iomap() description states, don't use this function 
twice on the same BAR. I think the most sane approach would be to drop the
pcim_iomap() and pcim_iomap_table() checks from the serial8250_pci_setup_port()
function. But I can not fully test this, I only have access to some hardware
used by the 8250_exar driver. I also CC Andy and Parker, both worked on the
affected code.

greetings,
Wilken
