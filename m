From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 1/2] serial_core: add pci uart early console support
Date: Fri, 15 May 2015 11:27:40 +0100
Message-ID: <20150515112740.3f9d8c28@lxorguk.ukuu.org.uk>
References: <20150515043435.GB100883@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150515043435.GB100883@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> +/* x86 uses "earlyprintk=xxx", so we keep the compatibility here */
> +#ifdef CONFIG_X86
> +early_param("earlyprintk", param_setup_earlycon);
> +#else
>  early_param("earlycon", param_setup_earlycon);
> +#endif

Is there any reason for not just allowing both ? That way you don't need
an ifdef and the same command line (either) works everywhere ?

>  
>  int __init of_setup_earlycon(unsigned long addr,
>  			     int (*setup)(struct earlycon_device *, const char *))
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 0b7bb12..221143c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -34,10 +34,16 @@
>  #include <linux/serial_core.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/pci_regs.h>
>  
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
>  
> +/* Only x86 has early pci access APIs */
> +#if defined(CONFIG_PCI) && defined(CONFIG_X86)
> +#include <asm/pci-direct.h>
> +#endif

We should probably make that a define or Kconfig value so that any other
port wanting early PCI console can add the needed direct functions
without the defines here getting longer and longer

It would then be a single

#if defined(CONFIG_EARLY_PCI)

that could be put anywhere


> +static int parse_pci_options(char *options, unsigned long *phys)
> +{
> +	u8 bus, dev, func;

...

> +failed:
> +	pr_err("Invalid earlycon pci parameters\n");
> +	return -EINVAL;
> +}

#else
static int parse_pci_options(char *options, unsigned long *phys)
{
	pr_err("earlycon pci not available\n");
	return -EINVAL;
}
> +#endif
> +


The all the ifdef mess below goes away

Alan
