From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add support for a no-name 4 ports multiserial card
Date: Fri, 6 Jun 2008 11:14:00 +0100
Message-ID: <20080606111400.1eefc4fd@core>
References: <1212736393-6837-1-git-send-email-catab@embedromix.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50806 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753580AbYFFK3w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jun 2008 06:29:52 -0400
In-Reply-To: <1212736393-6837-1-git-send-email-catab@embedromix.ro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Catalin(ux) M BOIE" <catab@embedromix.ro>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

On Fri,  6 Jun 2008 10:13:13 +0300
"Catalin(ux) M BOIE" <catab@embedromix.ro> wrote:

> It is a no-name PCI card. I found no reference to a producer so I
> used the fake name "PDR".

We don't really want to get fake names into pci_ids. I'd rather


>  		.vendor		= PCI_VENDOR_ID_PLX,
> +		.device		= PCI_DEVICE_ID_PLX_9050,
> +		.subvendor	= PCI_VENDOR_ID_PLX,
> +		.subdevice	= PCI_SUBDEVICE_ID_PDR,

Either the hex or a local and obviously unknown name like ID_UNKNOWN_1


> +	pbn_plx_pdr,

_unknown1

>  	pbn_oxsemi,
>  	pbn_intel_i960,
>  	pbn_sgi_ioc3,
> @@ -1186,6 +1196,13 @@ static struct pciserial_board pci_boards[] __devinitdata = {
>  		.base_baud	= 115200,
>  		.uart_offset	= 8,
>  	},
> +	/* PDR */
> +	[pbn_plx_pdr] = {

Ditto

> +	/* PDR */

Ditto

> +	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
> +		PCI_VENDOR_ID_PLX,
> +		PCI_SUBDEVICE_ID_PDR, 0, 0,

Ditto


> +#define PCI_SUBDEVICE_ID_PDR		0x1584
> +

And not in here at all.

Alan
