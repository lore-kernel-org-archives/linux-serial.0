From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v8 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Wed, 9 Oct 2019 20:17:14 -0700
Message-ID: <20191009201714.19296e3f@cakuba.netronome.com>
References: <20191009101713.12238-1-tbogendoerfer@suse.de>
        <20191009101713.12238-4-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009101713.12238-4-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed,  9 Oct 2019 12:17:10 +0200, Thomas Bogendoerfer wrote:
> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

> +static int ip27_baseio6g_setup(struct ioc3_priv_data *ipd)
> +{
> +	int ret, io_irq;
> +
> +	io_irq = ioc3_map_irq(ipd->pdev, PCI_SLOT(ipd->pdev->devfn) + 2);
> +	ret = ioc3_irq_domain_setup(ipd, io_irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_eth_setup(ipd, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_serial_setup(ipd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_m48t35_setup(ipd);
> +	if (ret)
> +		return ret;
> +
> +	return ioc3_kbd_setup(ipd);
> +}
> +
> +static int ip27_mio_setup(struct ioc3_priv_data *ipd)
> +{
> +	int ret;
> +
> +	ret = ioc3_irq_domain_setup(ipd, ipd->pdev->irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_serial_setup(ipd);
> +	if (ret)
> +		return ret;
> +
> +	return ioc3_kbd_setup(ipd);
> +}
> +
> +static int ip29_sysboard_setup(struct ioc3_priv_data *ipd)
> +{
> +	int ret, io_irq;
> +
> +	io_irq = ioc3_map_irq(ipd->pdev, PCI_SLOT(ipd->pdev->devfn) + 1);
> +	ret = ioc3_irq_domain_setup(ipd, io_irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_eth_setup(ipd, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_serial_setup(ipd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_m48t35_setup(ipd);
> +	if (ret)
> +		return ret;
> +
> +	return ioc3_kbd_setup(ipd);
> +}
> +
> +static int ioc3_menet_setup(struct ioc3_priv_data *ipd)
> +{
> +	int ret, io_irq;
> +
> +	io_irq = ioc3_map_irq(ipd->pdev, PCI_SLOT(ipd->pdev->devfn) + 4);
> +	ret = ioc3_irq_domain_setup(ipd, io_irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_eth_setup(ipd, false);
> +	if (ret)
> +		return ret;
> +
> +	return ioc3_serial_setup(ipd);
> +}
> +
> +static int ioc3_menet4_setup(struct ioc3_priv_data *ipd)
> +{
> +	return ioc3_eth_setup(ipd, false);
> +}
> +
> +static int ioc3_cad_duo_setup(struct ioc3_priv_data *ipd)
> +{
> +	int ret;
> +
> +	ret = ioc3_irq_domain_setup(ipd, ipd->pdev->irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = ioc3_eth_setup(ipd, true);
> +	if (ret)
> +		return ret;
> +
> +	return ioc3_kbd_setup(ipd);
> +}

None of these setup calls have a "cleanup" or un-setup call. Is this
really okay? I know nothing about MFD, but does mfd_add_devices() not
require a remove for example?  Doesn't the IRQ handling need cleanup?

> +/* Helper macro for filling ioc3_info array */
> +#define IOC3_SID(_name, _sid, _setup) \
> +	{								   \
> +		.name = _name,						   \
> +		.sid = (PCI_VENDOR_ID_SGI << 16) | IOC3_SUBSYS_ ## _sid,   \
> +		.setup = _setup,					   \
> +	}
> +
> +static struct {
> +	const char *name;
> +	u32 sid;
> +	int (*setup)(struct ioc3_priv_data *ipd);
> +} ioc3_infos[] = {
> +	IOC3_SID("IP27 BaseIO6G", IP27_BASEIO6G, &ip27_baseio6g_setup),
> +	IOC3_SID("IP27 MIO", IP27_MIO, &ip27_mio_setup),
> +	IOC3_SID("IP27 BaseIO", IP27_BASEIO, &ip27_baseio_setup),
> +	IOC3_SID("IP29 System Board", IP29_SYSBOARD, &ip29_sysboard_setup),
> +	IOC3_SID("MENET", MENET, &ioc3_menet_setup),
> +	IOC3_SID("MENET4", MENET4, &ioc3_menet4_setup)
> +};
> +#undef IOC3_SID
> +
> +static int ioc3_setup(struct ioc3_priv_data *ipd)
> +{
> +	u32 sid;
> +	int i;
> +
> +	/* Clear IRQs */
> +	writel(~0, &ipd->regs->sio_iec);
> +	writel(~0, &ipd->regs->sio_ir);
> +	writel(0, &ipd->regs->eth.eier);
> +	writel(~0, &ipd->regs->eth.eisr);
> +
> +	/* Read subsystem vendor id and subsystem id */
> +	pci_read_config_dword(ipd->pdev, PCI_SUBSYSTEM_VENDOR_ID, &sid);
> +
> +	for (i = 0; i < ARRAY_SIZE(ioc3_infos); i++)
> +		if (sid == ioc3_infos[i].sid) {
> +			pr_info("ioc3: %s\n", ioc3_infos[i].name);
> +			return ioc3_infos[i].setup(ipd);
> +		}
> +
> +	/* Treat everything not identified by PCI subid as CAD DUO */
> +	pr_info("ioc3: CAD DUO\n");
> +	return ioc3_cad_duo_setup(ipd);
> +}
> +
> +static int ioc3_mfd_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *pci_id)
> +{
> +	struct ioc3_priv_data *ipd;
> +	struct ioc3 __iomem *regs;
> +	int ret;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, IOC3_LATENCY);
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_warn(&pdev->dev,
> +			 "Failed to set 64-bit DMA mask, trying 32-bit\n");
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't set DMA mask, aborting\n");
> +			return ret;

So failing here we don't care about disabling the pci deivce..

> +		}
> +	}
> +
> +	/* Set up per-IOC3 data */
> +	ipd = devm_kzalloc(&pdev->dev, sizeof(struct ioc3_priv_data),
> +			   GFP_KERNEL);
> +	if (!ipd) {
> +		ret = -ENOMEM;
> +		goto out_disable_device;

..but here we do?

> +	}
> +	ipd->pdev = pdev;
> +
> +	/*
> +	 * Map all IOC3 registers.  These are shared between subdevices
> +	 * so the main IOC3 module manages them.
> +	 */
> +	regs = pci_ioremap_bar(pdev, 0);

This doesn't seem unmapped on error paths, nor remove?

> +	if (!regs) {
> +		dev_warn(&pdev->dev, "ioc3: Unable to remap PCI BAR for %s.\n",
> +			 pci_name(pdev));
> +		ret = -ENOMEM;
> +		goto out_disable_device;
> +	}
> +	ipd->regs = regs;
> +
> +	/* Track PCI-device specific data */
> +	pci_set_drvdata(pdev, ipd);
> +
> +	ret = ioc3_setup(ipd);
> +	if (ret)
> +		goto out_disable_device;
> +
> +	return 0;
> +
> +out_disable_device:
> +	pci_disable_device(pdev);
> +	return ret;
> +}
> +
> +static void ioc3_mfd_remove(struct pci_dev *pdev)
> +{
> +	struct ioc3_priv_data *ipd;
> +
> +	ipd = pci_get_drvdata(pdev);
> +
> +	/* Clear and disable all IRQs */
> +	writel(~0, &ipd->regs->sio_iec);
> +	writel(~0, &ipd->regs->sio_ir);
> +
> +	/* Release resources */
> +	if (ipd->domain) {
> +		irq_domain_remove(ipd->domain);
> +		free_irq(ipd->domain_irq, (void *)ipd);
> +	}
> +	pci_disable_device(pdev);
> +}
> +
> +static struct pci_device_id ioc3_mfd_id_table[] = {
> +	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
> +	{ 0, },
> +};
> +MODULE_DEVICE_TABLE(pci, ioc3_mfd_id_table);
> +
> +static struct pci_driver ioc3_mfd_driver = {
> +	.name = "IOC3",
> +	.id_table = ioc3_mfd_id_table,
> +	.probe = ioc3_mfd_probe,
> +	.remove = ioc3_mfd_remove,
> +};
> +
> +module_pci_driver(ioc3_mfd_driver);
> +
> +MODULE_AUTHOR("Thomas Bogendoerfer <tbogendoerfer@suse.de>");
> +MODULE_DESCRIPTION("SGI IOC3 MFD driver");
> +MODULE_LICENSE("GPL v2");
