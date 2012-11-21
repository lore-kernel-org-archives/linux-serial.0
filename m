From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/8250 Add support for Commtech's Fastcom Async-335
 and Fastcom Async-PCIe cards
Date: Wed, 21 Nov 2012 15:27:41 +0000
Message-ID: <20121121152741.49be9fcc@pyramind.ukuu.org.uk>
References: <CAJp1Oe7syKV54oOisSO=DX+hBaZxugSqQoHXoCPmDVWUiT1dOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34535 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab2KUPW1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 10:22:27 -0500
In-Reply-To: <CAJp1Oe7syKV54oOisSO=DX+hBaZxugSqQoHXoCPmDVWUiT1dOQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>

> +	p = pci_ioremap_bar(priv->dev, 0);

This can in theory fail so should be checked.
> +
> +	port->port.flags |= UPF_EXAR_EFR;
> +
> +	/*
> +	 * Setup Multipurpose Input/Output pins.
> +	 */
> +	if (idx == 0) {
> +		switch (priv->dev->device) {
> +		case 0x04: /* PCI_DEVICE_ID_COMMTECH_4222PCI335 */
> +		case 0x02: /* PCI_DEVICE_ID_COMMTECH_4224PCI335 */
> +			writeb(0x78, p + 0x90); /* MPIOLVL[7:0] */
> +			writeb(0x00, p + 0x92); /* MPIOINV[7:0] */
> +			writeb(0x00, p + 0x93); /* MPIOSEL[7:0] */
> +			break;
> +		case 0x0a: /* PCI_DEVICE_ID_COMMTECH_2324PCI335 */
> +		case 0x0b: /* PCI_DEVICE_ID_COMMTECH_2328PCI335 */
> +			writeb(0x00, p + 0x90); /* MPIOLVL[7:0] */
> +			writeb(0xc0, p + 0x92); /* MPIOINV[7:0] */
> +			writeb(0xc0, p + 0x93); /* MPIOSEL[7:0] */
> +			break;
> +		}
> +		writeb(0x00, p + 0x8f); /* MPIOINT[7:0] */
> +		writeb(0x00, p + 0x91); /* MPIO3T[7:0] */
> +		writeb(0x00, p + 0x94); /* MPIOOD[7:0] */
> +	}
> +	writeb(0x00, p + UART_EXAR_8XMODE);
> +	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> +	writeb(32, p + UART_EXAR_TXTRG);
> +	writeb(32, p + UART_EXAR_RXTRG);
> +	iounmap(p);
> +
> +	return pci_default_setup(priv, board, port, idx);
> +}
> +
> +static int
>  pci_wch_ch353_setup(struct serial_private *priv,
>                      const struct pciserial_board *board,
>                      struct uart_8250_port *port, int idx)
> @@ -1246,6 +1288,13 @@ pci_wch_ch353_setup(struct serial_private *priv,
>  #define PCI_VENDOR_ID_AGESTAR		0x5372
>  #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
>  #define PCI_VENDOR_ID_ASIX		0x9710
> +#define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
> +#define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
> +#define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
> +#define PCI_DEVICE_ID_COMMTECH_2328PCI335 0x000b
> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
> +#define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
> +#define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021

Would be better if these defines were above where you use them commented
in the code...

Otherwise looks good.
