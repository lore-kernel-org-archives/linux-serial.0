From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Thu, 14 Feb 2019 11:08:23 +0100
Message-ID: <56da4c16-2f47-0033-fe60-ad49ccd0758d@gmail.com>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>, Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>
List-Id: linux-serial@vger.kernel.org



On 18/01/2019 04:10, Long Cheng wrote:
> In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> the performance, can enable the function.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/dma/mediatek/Kconfig          |   11 +
>  drivers/dma/mediatek/Makefile         |    1 +
>  drivers/dma/mediatek/mtk-uart-apdma.c |  669 +++++++++++++++++++++++++++++++++
>  3 files changed, 681 insertions(+)
>  create mode 100644 drivers/dma/mediatek/mtk-uart-apdma.c
> 
[...]
> +
> +static int mtk_uart_apdma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct mtk_uart_apdmadev *mtkd;
> +	struct resource *res;
> +	struct mtk_chan *c;
> +	int bit_mask = 32, rc;
> +	unsigned int i;
> +
> +	mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
> +	if (!mtkd)
> +		return -ENOMEM;
> +
> +	mtkd->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mtkd->clk)) {
> +		dev_err(&pdev->dev, "No clock specified\n");
> +		rc = PTR_ERR(mtkd->clk);
> +		return rc;
> +	}
> +
> +	if (of_property_read_bool(np, "dma-33bits"))
> +		mtkd->support_33bits = true;

dma-33bits not defined in the binding description.

> +
> +	if (mtkd->support_33bits)
> +		bit_mask = 33;
> +
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(bit_mask));
> +	if (rc)
> +		return rc;
> +
> +	dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
> +	mtkd->ddev.device_alloc_chan_resources =
> +				mtk_uart_apdma_alloc_chan_resources;
> +	mtkd->ddev.device_free_chan_resources =
> +				mtk_uart_apdma_free_chan_resources;
> +	mtkd->ddev.device_tx_status = mtk_uart_apdma_tx_status;
> +	mtkd->ddev.device_issue_pending = mtk_uart_apdma_issue_pending;
> +	mtkd->ddev.device_prep_slave_sg = mtk_uart_apdma_prep_slave_sg;
> +	mtkd->ddev.device_config = mtk_uart_apdma_slave_config;
> +	mtkd->ddev.device_pause = mtk_uart_apdma_device_pause;
> +	mtkd->ddev.device_terminate_all = mtk_uart_apdma_terminate_all;
> +	mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	mtkd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	mtkd->ddev.dev = &pdev->dev;
> +	INIT_LIST_HEAD(&mtkd->ddev.channels);
> +
> +	mtkd->dma_requests = MTK_UART_APDMA_NR_VCHANS;

Do this if dma-requests property is not present.

> +	if (of_property_read_u32(np, "dma-requests", &mtkd->dma_requests)) {

It's quite obvious what this does, but IMHO it should be reflected in the binding.

Regards,
Matthias

> +		dev_info(&pdev->dev,
> +			 "Using %u as missing dma-requests property\n",
> +			 MTK_UART_APDMA_NR_VCHANS);
> +	}
> +
> +	mtkd->dma_irq = devm_kcalloc(&pdev->dev, mtkd->dma_requests,
> +				 sizeof(*mtkd->dma_irq), GFP_KERNEL);
> +	if (!mtkd->dma_irq)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mtkd->dma_requests; i++) {
> +		c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
> +		if (!c) {
> +			rc = -ENODEV;
> +			goto err_no_dma;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res) {
> +			rc = -ENODEV;
> +			goto err_no_dma;
> +		}
> +
> +		c->base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(c->base)) {
> +			rc = PTR_ERR(c->base);
> +			goto err_no_dma;
> +		}
> +		c->requested = false;
> +		c->vc.desc_free = mtk_uart_apdma_desc_free;
> +		vchan_init(&c->vc, &mtkd->ddev);
> +
> +		mtkd->dma_irq[i] = platform_get_irq(pdev, i);
> +		if ((int)mtkd->dma_irq[i] < 0) {
> +			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
> +			rc = -EINVAL;
> +			goto err_no_dma;
> +		}
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +
> +	rc = dma_async_device_register(&mtkd->ddev);
> +	if (rc)
> +		goto rpm_disable;
> +
> +	platform_set_drvdata(pdev, mtkd);
> +
> +	/* Device-tree DMA controller registration */
> +	rc = of_dma_controller_register(np, of_dma_xlate_by_chan_id, mtkd);
> +	if (rc)
> +		goto dma_remove;
> +
> +	return rc;
> +
> +dma_remove:
> +	dma_async_device_unregister(&mtkd->ddev);
> +rpm_disable:
> +	pm_runtime_disable(&pdev->dev);
> +err_no_dma:
> +	mtk_uart_apdma_free(mtkd);
> +	return rc;
> +}
> +
> +static int mtk_uart_apdma_remove(struct platform_device *pdev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = platform_get_drvdata(pdev);
> +
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	dma_async_device_unregister(&mtkd->ddev);
> +	mtk_uart_apdma_free(mtkd);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_uart_apdma_suspend(struct device *dev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev))
> +		clk_disable_unprepare(mtkd->clk);
> +
> +	return 0;
> +}
> +
> +static int mtk_uart_apdma_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = clk_prepare_enable(mtkd->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_PM
> +static int mtk_uart_apdma_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(mtkd->clk);
> +
> +	return 0;
> +}
> +
> +static int mtk_uart_apdma_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	ret = clk_prepare_enable(mtkd->clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops mtk_uart_apdma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mtk_uart_apdma_suspend, mtk_uart_apdma_resume)
> +	SET_RUNTIME_PM_OPS(mtk_uart_apdma_runtime_suspend,
> +			   mtk_uart_apdma_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mtk_uart_apdma_driver = {
> +	.probe	= mtk_uart_apdma_probe,
> +	.remove	= mtk_uart_apdma_remove,
> +	.driver = {
> +		.name		= KBUILD_MODNAME,
> +		.pm		= &mtk_uart_apdma_pm_ops,
> +		.of_match_table = of_match_ptr(mtk_uart_apdma_match),
> +	},
> +};
> +
> +module_platform_driver(mtk_uart_apdma_driver);
> +
> +MODULE_DESCRIPTION("MediaTek UART APDMA Controller Driver");
> +MODULE_AUTHOR("Long Cheng <long.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> +
> 
