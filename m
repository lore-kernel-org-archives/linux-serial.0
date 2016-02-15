From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: 8250_pci: add MOXA Smartio MUE boards support
Date: Mon, 15 Feb 2016 09:23:36 +0100
Message-ID: <56C18B08.4060803@suse.cz>
References: <1455301730-24333-1-git-send-email-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455301730-24333-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>, adam.lee@canonical.com, soeren.grunewald@desy.de, anton.wuerfel@fau.de, phillip.raffeck@fau.de, hpeter@gmail.com, udknight@gmail.com, andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, Jan Beulich <JBeulich@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/12/2016, 07:28 PM, Mathieu OTHACEHE wrote:
> Add support for :
> 
> - CP-102E: 2 ports RS232 PCIE card
> - CP-102EL: 2 ports RS232 PCIE card
> - CP-132EL: 2 ports RS422/485 PCIE card
> - CP-114EL: 4 ports RS232/422/485 PCIE card
> - CP-104EL-A: 4 ports RS232 PCIE card
> - CP-168EL-A: 8 ports RS232 PCIE card
> - CP-118EL-A: 8 ports RS232/422/485 PCIE card
> - CP-118E-A: 8 ports RS422/485 PCIE card
> - CP-138E-A: 8 ports RS422/485 PCIE card
> - CP-134EL-A: 4 ports RS422/485 PCIE card
> - CP-116E-A (A): 8 ports RS232/422/485 PCIE card
> - CP-116E-A (B): 8 ports RS232/422/485 PCIE card
> 
> Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
> ---
> 
> Hi,
> 
> This patch add support for MOXA Smartio MUE boards to 8250 driver.
> I already submitted an independant driver based on the vendor one :
> 
> https://lkml.org/lkml/2016/2/1/720
> 
> But as Andy pointed out, it seems to be a better idea to add this support
> directly in 8250 driver.
> I was able to test this patch on a CP-168EL-A on PC.

Hi,

all this should be above ---. It warrants to be in the commit log.

> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
...
> @@ -5604,6 +5748,55 @@ static struct pci_device_id serial_pci_tbl[] = {
>  	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
>  	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12 },
>  
> +	/* MOXA Smartio MUE PCI serial cards */
> +	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
> +		PCI_ANY_ID, PCI_ANY_ID,
> +		0,
> +		0, pbn_moxa_CP102E },

Please use PCI_DEVICE as others above do.

thanks,
-- 
js
suse labs
