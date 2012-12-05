From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] The correct device id for this card is 0x0022.
Date: Wed, 5 Dec 2012 21:38:12 +0000
Message-ID: <20121205213812.42c61b2e@pyramind.ukuu.org.uk>
References: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
	<1354740983-4352-2-git-send-email-matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54022 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2LEVcy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 16:32:54 -0500
In-Reply-To: <1354740983-4352-2-git-send-email-matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts_old@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

On Wed,  5 Dec 2012 14:56:22 -0600
Matt Schulte <matts_old@commtech-fastcom.com> wrote:

> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> ---
> Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c 
> 
>  drivers/tty/serial/8250/8250_pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index bf2f1a0..777832c 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1301,7 +1301,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
>  #define PCI_VENDOR_ID_AGESTAR		0x5372
>  #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
>  #define PCI_VENDOR_ID_ASIX		0x9710
> -#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
>  #define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
>  #define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021

Can you keep them in order 8)

