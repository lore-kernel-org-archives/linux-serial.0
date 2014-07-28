From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/3] PCI: export pci_get_dma_device() helper to other
 users
Date: Mon, 28 Jul 2014 12:26:35 +0300
Message-ID: <1406539595.8530.20.camel@smile.fi.intel.com>
References: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1406307516.1011.21.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406307516.1011.21.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2014-07-25 at 10:58 -0600, Alex Williamson wrote:
> On Fri, 2014-07-25 at 16:31 +0300, Andy Shevchenko wrote:
> > Some chipsets use the function 0 for DMA on other functions of a
> > multifunctional device. One of the example is Intel EG20T PCH. This is also
> > applicable to Lynxpoint PCH when LPSS devices are switched to PCI mode.
> > 
> > This patch exports a useful helper to get a device of the DMA. This device is
> > needed to request a DMA channel from a proper controller.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/pci/quirks.c | 2 +-
> >  include/linux/pci.h  | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 80c2d01..8352e5b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3517,7 +3517,7 @@ static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
> >  	if (!PCI_FUNC(dev->devfn))
> >  		return pci_dev_get(dev);
> >  
> > -	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > +	return pci_get_dma_device(dev);
> >  }
> >  
> >  static const struct pci_dev_dma_source {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 61978a4..86caab7 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1575,6 +1575,15 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
> >  static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
> >  #endif
> >  
> > +/*
> > + * Some chipsets use the function 0 for DMA on other functions of a
> > + * multifunctional device.
> > + */
> > +static inline struct pci_dev *pci_get_dma_device(struct pci_dev *dev)
> > +{
> > +	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > +}
> > +
> >  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
> >  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
> >  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> 
> You've created a very generic function for a very specific problem.  I
> can't just call this on any random device and expect it to work
> correctly.

Right.

>   What about all the other device which use function 1 for
> their DMA alias.

Hmm... I would like to understand what the difference between DMA alias
and the case when we have MFD where function 0 is real DMA controller
which serves the other devices in that block is?

Another (probably minor) question, why do you still have
pci_get_dma_source() function in quirks.c?

>   We've just added infrastructure in PCI to support DMA
> aliases, see pci_for_each_dma_alias().  Please use this instead.  Quirks
> can be added to set the dma_alias_devfn and
> PCI_DEV_FLAGS_DMA_ALIAS_DEVFN to indicate that it's valid.  Thanks,

Do you mean I have to list all devices that, for example, are listed in
the spi-topcliff-pch.c?


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
