From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH v4 1/2] serial_core: add pci uart early console support
Date: Thu, 28 May 2015 10:54:52 -0700
Message-ID: <20150528175452.GA139550@worksta>
References: <20150522160659.GA108447@worksta>
 <5564A982.9050600@hurleysoftware.com>
 <20150527231426.GA105692@worksta>
 <55665F81.1050301@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55665F81.1050301@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 27, 2015 at 08:21:21PM -0400, Peter Hurley wrote:
> I meant that the patch hunk below should be moved to patch
> 2/2, and the purpose of patch 2/2 should be to replace x86-specific
> earlyprintk=pciserial with arch-independent earlyprintk=pciserial.
> 
> There are 2 reasons for my suggestion:
> 1) Changes to x86 earlyprintk should get acks from the x86 maintainers.
>    Borislav Petkov <bp@suse.de> is particularly involved in the
>    'early' earlyprintk proposal. Patch 2/2 should cc them and the
>    author of the original earlyprintk=pciserial patch.
> 2) Changes to x86 earlyprintk may be rejected.
> 
> 
> > +/* x86 uses "earlyprintk=xxx", so we keep the compatibility here */
> > +#ifdef CONFIG_X86
> > +static int __init param_setup_earlycon_x86(char *buf)
> > +{
> > +	return param_setup_earlycon(buf);
> > +}
> > +early_param("earlyprintk", param_setup_earlycon_x86);
> > +#endif
> > +
Ok now I got it.


> >> FYI, there is a proposal to evaluate "earlyprintk=" earlier than
> >> parse_early_params(), which this would break.
> >>
> >> https://lkml.org/lkml/2015/5/18/127
> > No, it wouldn't. The proposal only moves earlyprintk=serial(legacy 0x3f8).
> > If you look into arch/x86/kernel/early_printk.c, you'll find many other
> > options other than serial, e.g. vga, dbgp, xen, efi, pciserial, etc.
> > uart8250(previously pciserial) is one of these "others".
> 
> I see; so when re-evaluating earlyprintk= for earlycon, there is no danger 
> of corrupting the device state for earlyprintk?
No, because uart8250 is a unknown value to earlyprintk= in
arch/x86/kernel/early_prink.c, so it simply returns from there.
 
> However, the namespace will now be shared so that is an important change
> that maintainers and future earlycon/earlyprintk authors need to know.
Yes, I'll cc more x86 people.

 
> > Then scripts/checkpatch.pl should be updated to avoid this kind of "misguiding".
> > Also the kstrto* API descriptions should be updated...
> 
> I know; I've already made that point to Joe.
> 
> >> The code above is exactly what is wrong with the kstrto* api.
> > Can you elaborate a little bit? Thanks.
> 
> I don't mean there is anything wrong with _your_ code, per se.
> Rather that it should not be necessary to write 14 lines of code, use temp
> storage and visit the entire string three times simply to parse a string
> into a number. IOW, the kstrto* API usefulness is limited, which is why
> simple_strto* is _not_ obsolete.
> 
>  
> >>> +	if (!early_pci_allowed()) {
> >>> +		pr_err("earlycon pci not available(early pci not allowed)\n");
> >>
> >> Error message is redundant.
> > "early pci not allowed" is the reason of "earlycon pci not available".
> 
> Only one or the other is necessary. For example,
> 
> 	"earlycon: early pci not allowed\n"
Will do.


> 
> 
> >>> +	/*
> >>> +	 * On these platforms class code in pci config is broken,
> >>               ^^^^^^^^^^^^^^^
> >> which platforms?
> > On platforms where this code will run on.
> > Do you prefer something like:
> > On platforms with early pci serial class code in pci config is broken,
> 
> This statement doesn't make sense to me: the original earlyprintk=pciserial
> implementation read the class code register, so it worked then.
> 
> Why not now?
Indeed on real silicon the class code is broken.
I would say it might be an accident that those class code related codes
were checked in...


> >>>   *	@options: ptr for <options> field; NULL if not present (out)
> >>>   *
> >>>   *	Decodes earlycon kernel command line parameters of the form
> >>> - *	   earlycon=<name>,io|mmio|mmio32,<addr>,<options>
> >>> + *	   earlycon=<name>,io|mmio|mmio32|pci|pci32,<addr>,<options>
> >>
> >> Document the pci/pci32 format separately because
> >> 	earlycon=uart8250,pci32,<addr>,<options> is not a valid form.
> > Why it's not a valid form? It follows the existed syntax like this:
> > earlycon=uart8250,<io type>,<addr>,<options>
> 
> Well, isn't <addr> being retrieved from BAR0? Why would you specify
> the <addr> on the command line?
> 
> But I see now that's where the 'bus:device.function' goes.
> I think if I was confused, others will be too. Further, in the context
> of this code 'addr' is a variable to which the command line parameter
> comment identifies, whereas 'bus:device.function' does not follow
> the same convention.
I think it's confusing because pci is special - we can say B:D.F is PCI
address(bus address), but address from BAR is also pci address(IO or
Memory address). How about we undertand the <address> from the comment
is bus address? So for mmio, it's 32bit(or 64bit) physical address, for
pci it's B:D.F.

Thanks,
Bin
