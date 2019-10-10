From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v8 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Thu, 10 Oct 2019 15:29:49 +0200
Message-ID: <20191010152949.f5049c2728beffa38f07c924@suse.de>
References: <20191009101713.12238-1-tbogendoerfer@suse.de>
        <20191009101713.12238-4-tbogendoerfer@suse.de>
        <20191009201714.19296e3f@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191009201714.19296e3f@cakuba.netronome.com>
Sender: netdev-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 9 Oct 2019 20:17:14 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Wed,  9 Oct 2019 12:17:10 +0200, Thomas Bogendoerfer wrote:
> [...]
> > +static int ioc3_cad_duo_setup(struct ioc3_priv_data *ipd)
> > +{
> > +	int ret;
> > +
> > +	ret = ioc3_irq_domain_setup(ipd, ipd->pdev->irq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ioc3_eth_setup(ipd, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ioc3_kbd_setup(ipd);
> > +}
> 
> None of these setup calls have a "cleanup" or un-setup call. Is this
> really okay? I know nothing about MFD, but does mfd_add_devices() not
> require a remove for example? Doesn't the IRQ handling need cleanup?

good catch, I'll add that.

> > +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > +	if (ret) {
> > +		dev_warn(&pdev->dev,
> > +			 "Failed to set 64-bit DMA mask, trying 32-bit\n");
> > +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Can't set DMA mask, aborting\n");
> > +			return ret;
> 
> So failing here we don't care about disabling the pci deivce..

fixed in the next version.

> > +
> > +	/*
> > +	 * Map all IOC3 registers.  These are shared between subdevices
> > +	 * so the main IOC3 module manages them.
> > +	 */
> > +	regs = pci_ioremap_bar(pdev, 0);
> 
> This doesn't seem unmapped on error paths, nor remove?

will fix.

Thank you for the review.

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG München)
Geschäftsführer: Felix Imendörffer
