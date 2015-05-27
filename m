From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v4 1/2] serial_core: add pci uart early console support
Date: Wed, 27 May 2015 16:14:26 -0700
Message-ID: <20150527231426.GA105692@worksta>
References: <20150522160659.GA108447@worksta>
 <5564A982.9050600@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5564A982.9050600@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Peter Hurley,
First of all, thank you for your reviewing.
Please see my answers below.

On Tue, May 26, 2015 at 01:12:34PM -0400, Peter Hurley wrote:
> Hi Bin,
> 
> Please don't drop lists (or other addressees) from patch revisions.
> 
> [ +cc linux-serial]
Will fix this.


> Please update Documentation/kernel-parameters.txt with pci-specific
> earlycon parameter formats.
Will do.

 
> Please move this hunk to patch 2/2.
It's already in 2/2. Or I'm not quite understanding?


> FYI, there is a proposal to evaluate "earlyprintk=" earlier than
> parse_early_params(), which this would break.
> 
> https://lkml.org/lkml/2015/5/18/127
No, it wouldn't. The proposal only moves earlyprintk=serial(legacy 0x3f8).
If you look into arch/x86/kernel/early_printk.c, you'll find many other
options other than serial, e.g. vga, dbgp, xen, efi, pciserial, etc.
uart8250(previously pciserial) is one of these "others".


> > +static int parse_bdf(char *options, char **endp, char delimiter, u8 *val)
> 
> If this function is only used from parse_pci_options(), please enclose it
> in #ifdef CONFIG_PCI_EARLY scope with parse_pci_options().
Yes, will fix it.


> 
> > +{
> > +	char str[4]; /* max 3 chars, plus a NULL terminator */
> > +	char *p = options;
> > +	int i = 0;
> > +
> > +	while (*p) {
> > +		if (i >= 4)
> > +			return -EINVAL;
> > +
> > +		if (*p == delimiter) {
> > +			str[i++] = 0;
> > +			if (endp)
> > +				*endp = p + 1;
> > +			return kstrtou8(str, 10, val); /* decimal, no hex */
> > +		}
> > +
> > +		str[i++] = *p++;
> > +	}
> 
> Is all this to avoid using simple_strtoul()?
> If yes, I'd rather you use simple_strtoul() like the rest of the console
> code and ignore the (misguided) advice that simple_strtoul() is obsolete.
Then scripts/checkpatch.pl should be updated to avoid this kind of "misguiding".
Also the kstrto* API descriptions should be updated...


> The code above is exactly what is wrong with the kstrto* api.
Can you elaborate a little bit? Thanks.


> > +	if (!early_pci_allowed()) {
> > +		pr_err("earlycon pci not available(early pci not allowed)\n");
> 
> Error message is redundant.
"early pci not allowed" is the reason of "earlycon pci not available".


> > +	/*
> > +	 * On these platforms class code in pci config is broken,
>               ^^^^^^^^^^^^^^^
> which platforms?
On platforms where this code will run on.
Do you prefer something like:
On platforms with early pci serial class code in pci config is broken,


> > +	pr_info("Use 8250 uart at PCI 0000:%02u:%02u.%01u as early console\n",
> > +							bus, dev, func);
> 
> I think one earlycon banner is sufficient; you could make this pr_debug()
> instead. Existing convention for earlycon messages is
> 
> 	"earlycon: ...."
Will use pr_debug().


> >   *	@options: ptr for <options> field; NULL if not present (out)
> >   *
> >   *	Decodes earlycon kernel command line parameters of the form
> > - *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
> > + *	   earlycon=<name>,io|mmio|mmio32|pci|pci32,<addr>,<options>
> 
> Document the pci/pci32 format separately because
> 	earlycon=uart8250,pci32,<addr>,<options> is not a valid form.
Why it's not a valid form? It follows the existed syntax like this:
earlycon=uart8250,<io type>,<addr>,<options>


> > @@ -1829,12 +1939,23 @@ uart_get_console(struct uart_port *ports, int nr, struct console *co)
> >  int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
> >  			char **options)
> >  {
> > +	int pci = 0, ret;
> > +	unsigned long phys;
> > +
> >  	if (strncmp(p, "mmio,", 5) == 0) {
> >  		*iotype = UPIO_MEM;
> >  		p += 5;
> >  	} else if (strncmp(p, "mmio32,", 7) == 0) {
> >  		*iotype = UPIO_MEM32;
> >  		p += 7;
> > +	} else if (strncmp(p, "pci,", 4) == 0) {
> > +		pci = 1;
> > +		p += 4;
> > +		ret = parse_pci_options(p, &phys);
> > +	} else if (strncmp(p, "pci32,", 6) == 0) {
> > +		pci = 2;
> > +		p += 6;
> > +		ret = parse_pci_options(p, &phys);
> >  	} else if (strncmp(p, "io,", 3) == 0) {
> >  		*iotype = UPIO_PORT;
> >  		p += 3;
> > @@ -1844,7 +1965,27 @@ int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
> >  		return -EINVAL;
> >  	}
> >  
> > -	*addr = simple_strtoul(p, NULL, 0);
> > +	if (pci) {
> > +		if (ret < 0) /* error */
> > +			return ret;
> > +
> > +		/*
> > +		 * Once PCI mem/io is read from PCI BAR, we can reuse
> > +		 * mmio/mmio32/io type to minimize code change.
> > +		 */
> > +		if (ret > 0) /* PCI io */
> > +			*iotype = UPIO_PORT;
> > +		else { /* ret = 0: PCI mem */
> > +			if (pci == 2)
> > +				*iotype = UPIO_MEM32;
> > +			else
> > +				*iotype = UPIO_MEM;
> > +		}
> > +
> > +		*addr = phys;
> > +	} else
> > +		*addr = simple_strtoul(p, NULL, 0);
> > +
> 
> I'd like to see this refactored without the logic steering locals.
> Like this:
> 
>  	if (strncmp(p, "mmio,", 5) == 0) {
>  		*iotype = UPIO_MEM;
>  		p += 5;
> +		*addr = simple_strtoul(p, NULL, 0);
>  	} else if (strncmp(p, "mmio32,", 7) == 0) {
>  		*iotype = UPIO_MEM32;
>  		p += 7;
> +		*addr = simple_strtoul(p, NULL, 0);
> +	} else if (strncmp(p, "pci,", 4) == 0) {
> +		pci = 1;
> +		p += 4;
> +		ret = parse_pci_options(p, addr);
> +		if (ret < 0)
> +			return ret;
> +		*iotype = (ret > 0) ? UPIO_PORT : UPIO_MEM;
> +	} else if (strncmp(p, "pci32,", 6) == 0) {
> +		pci = 2;
> +		p += 6;
> +		ret = parse_pci_options(p, addr);
> +		if (ret < 0)
> +			return ret;
> +		*iotype = (ret > 0) ? UPIO_PORT : UPIO_MEM32;
>  	} else if (strncmp(p, "io,", 3) == 0) {
>  		*iotype = UPIO_PORT;
>  		p += 3;
> +		*addr = simple_strtoul(p, NULL, 0);
> 
> 
> Regards,
> Peter Hurley
> 
> > -	*addr = simple_strtoul(p, NULL, 0);
> >  	p = strchr(p, ',');
> >  	if (p)
> >  		p++;
> > 
Ah, this is kind of coding style. But I agree with your suggestion. Will fix it.
