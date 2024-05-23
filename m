Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE55EC7;
	Thu, 23 May 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430287; cv=none; b=faMU8aNDhfMnAyfQjyuKiaiWDpjVI5bzLepqdyZZ9H/C2+FmUJIL5wMOpWIYvJRuCBbYAV1dfqcFgss0lq5KiiLOdyVrp0A48zpL/Ra6mKBmu2gfW/cPrwzbpA01j+iwwfCRkf7a19g7ldw1xf3PUrCSHXmr0xaONW2RpkWltU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430287; c=relaxed/simple;
	bh=TGRqQ/gBYwVifINfQhz4oRdkJ1y9DO83Qzc6NF7fdg8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mIBiFpNBOtJ5WIrDyoeBC6ZUo7a1UUyf/sMGJp9mhsEdc4PEv68fysHfCd1yZ9OoXvYVWTZdiC5e4pBtrubJSG9LOnE5GVc+vuHBI4T90IjYC/oVpofIA/shuKl1/kxARAxRmfTmNqFhpkmRcTHtckK7p0L0e9hnrilSeCy6zgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D2C2992009C; Thu, 23 May 2024 04:11:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C191192009B;
	Thu, 23 May 2024 03:11:16 +0100 (BST)
Date: Thu, 23 May 2024 03:11:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <20240405152924.252598-2-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com> <20240405152924.252598-2-schnelle@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Apr 2024, Niklas Schnelle wrote:

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 0d35c77fad9e..38ac5236d2ea 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -928,6 +928,7 @@ static int pci_netmos_init(struct pci_dev *dev)
>  	return num_serial;
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  /*
>   * These chips are available with optionally one parallel port and up to
>   * two serial ports. Unfortunately they all have the same product id.
[...]
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 47ff50763c04..54bf98869abf 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -136,7 +135,7 @@ config SERIAL_8250_PCILIB
>  
>  config SERIAL_8250_PCI
>  	tristate "8250/16550 PCI device support"
> -	depends on SERIAL_8250 && PCI
> +	depends on SERIAL_8250 && PCI && HAS_IOPORT
>  	select SERIAL_8250_PCILIB
>  	default SERIAL_8250
>  	help

 This is clearly wrong, there is PCIe 8250 serial hardware that does MMIO 
only, so the option has to stay possible to enable.  I have such hardware 
as shown in this log:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0001:01:00.0: enabling device (0140 -> 0142)
serial 0001:01:00.0: detected caps 00000700 should be 00000500
0001:01:00.0: ttyS0 at MMIO 0x600c080401000 (irq = 40, base_baud = 15625000) is a 16C950/954
serial 0001:01:00.0: detected caps 00000700 should be 00000500
0001:01:00.0: ttyS1 at MMIO 0x600c080401200 (irq = 40, base_baud = 15625000) is a 16C950/954

which is from a POWER9 system.  Which as you may know has no PCI port I/O 
support in hardware, so it is quite relevant here.  I'd like to keep this 
PCIe serial option functional with my system.

 Also your change itself modifies 8250_pci.c (cited above for reference), 
which would make no sense if SERIAL_8250_PCI was permanently disabled for 
!HAS_IOPORT.  Shall I take it than that the Kconfig change I question has 
been made merely by mistake?

  Maciej
