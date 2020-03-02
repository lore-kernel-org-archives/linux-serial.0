Return-Path: <SRS0=YLjw=4T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F3C3F2D1
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A8F2064A
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 13:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBNR2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:17:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:32155 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbgCBNR2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 08:17:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="243194211"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2020 05:17:25 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8kwp-0068er-C6; Mon, 02 Mar 2020 15:17:27 +0200
Date:   Mon, 2 Mar 2020 15:17:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Gorby <russ.gorby@intel.com>
Subject: Re: [PATCH] tty: serial: ifx6x60: Convert to GPIO descriptors
Message-ID: <20200302131727.GX1224808@smile.fi.intel.com>
References: <20200302101117.331005-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302101117.331005-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 02, 2020 at 11:11:17AM +0100, Linus Walleij wrote:
> This driver for the Intel MID never seems to have been properly
> integrated upstream: the platform data in <linux/spi/ifx_modem.h>
> is not used anywhere in the kernel and haven't been since it was
> merged into the kernel in 2010.
> 
> There might be out-of-tree users, so I don't want to delete the
> driver, but I will refactor it to use GPIO descriptors, which
> means that out-of-tree users will need to adapt.

At least if we are going to remove it in the future, we may later on to revive
with already correct approach.

> There are several examples in the kernel of how to provide the
> resources necessary for using GPIO descriptors to pass in the
> GPIO lines, for the MID platform in particular, it will suffice
> to inspect the code in files like:
> arch/x86/platform/intel-mid/device_libs/platform_bt.c
> 
> This refactoring transfers all GPIOs in the driver, including
> a hard-coded "PMU reset" in the driver to use GPIO descriptors
> instead.
> 
> The following named GPIO descriptors need to be supplied:
> - reset
> - power
> - mrdy
> - srdy
> - rst_out
> - pmu_reset

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Russ Gorby <russ.gorby@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/tty/serial/ifx6x60.c  | 170 ++++++++++++----------------------
>  drivers/tty/serial/ifx6x60.h  |  13 ++-
>  include/linux/spi/ifx_modem.h |   5 -
>  3 files changed, 65 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
> index 32a0ccef9339..7d16fe41932f 100644
> --- a/drivers/tty/serial/ifx6x60.c
> +++ b/drivers/tty/serial/ifx6x60.c
> @@ -39,7 +39,7 @@
>  #include <linux/fs.h>
>  #include <linux/ip.h>
>  #include <linux/dmapool.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/time.h>
>  #include <linux/wait.h>
> @@ -61,7 +61,6 @@
>  #define IFX_SPI_HEADER_F		(-2)
>  
>  #define PO_POST_DELAY		200
> -#define IFX_MDM_RST_PMU	4
>  
>  /* forward reference */
>  static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev);
> @@ -81,7 +80,7 @@ static struct notifier_block ifx_modem_reboot_notifier_block = {
>  
>  static int ifx_modem_power_off(struct ifx_spi_device *ifx_dev)
>  {
> -	gpio_set_value(IFX_MDM_RST_PMU, 1);
> +	gpiod_set_value(ifx_dev->gpio.pmu_reset, 1);
>  	msleep(PO_POST_DELAY);
>  
>  	return 0;
> @@ -107,7 +106,7 @@ static int ifx_modem_reboot_callback(struct notifier_block *nfb,
>   */
>  static inline void mrdy_set_high(struct ifx_spi_device *ifx)
>  {
> -	gpio_set_value(ifx->gpio.mrdy, 1);
> +	gpiod_set_value(ifx->gpio.mrdy, 1);
>  }
>  
>  /**
> @@ -117,7 +116,7 @@ static inline void mrdy_set_high(struct ifx_spi_device *ifx)
>   */
>  static inline void mrdy_set_low(struct ifx_spi_device *ifx)
>  {
> -	gpio_set_value(ifx->gpio.mrdy, 0);
> +	gpiod_set_value(ifx->gpio.mrdy, 0);
>  }
>  
>  /**
> @@ -244,7 +243,7 @@ static inline void swap_buf_32(unsigned char *buf, int len, void *end)
>   */
>  static void mrdy_assert(struct ifx_spi_device *ifx_dev)
>  {
> -	int val = gpio_get_value(ifx_dev->gpio.srdy);
> +	int val = gpiod_get_value(ifx_dev->gpio.srdy);
>  	if (!val) {
>  		if (!test_and_set_bit(IFX_SPI_STATE_TIMER_PENDING,
>  				      &ifx_dev->flags)) {
> @@ -691,7 +690,7 @@ static void ifx_spi_complete(void *ctx)
>  	clear_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &(ifx_dev->flags));
>  
>  	queue_length = kfifo_len(&ifx_dev->tx_fifo);
> -	srdy = gpio_get_value(ifx_dev->gpio.srdy);
> +	srdy = gpiod_get_value(ifx_dev->gpio.srdy);
>  	if (!srdy)
>  		ifx_spi_power_state_clear(ifx_dev, IFX_SPI_POWER_SRDY);
>  
> @@ -898,7 +897,7 @@ static irqreturn_t ifx_spi_srdy_interrupt(int irq, void *dev)
>  static irqreturn_t ifx_spi_reset_interrupt(int irq, void *dev)
>  {
>  	struct ifx_spi_device *ifx_dev = dev;
> -	int val = gpio_get_value(ifx_dev->gpio.reset_out);
> +	int val = gpiod_get_value(ifx_dev->gpio.reset_out);
>  	int solreset = test_bit(MR_START, &ifx_dev->mdm_reset_state);
>  
>  	if (val == 0) {
> @@ -954,14 +953,14 @@ static int ifx_spi_reset(struct ifx_spi_device *ifx_dev)
>  	 * to reset properly
>  	 */
>  	set_bit(MR_START, &ifx_dev->mdm_reset_state);
> -	gpio_set_value(ifx_dev->gpio.po, 0);
> -	gpio_set_value(ifx_dev->gpio.reset, 0);
> +	gpiod_set_value(ifx_dev->gpio.po, 0);
> +	gpiod_set_value(ifx_dev->gpio.reset, 0);
>  	msleep(25);
> -	gpio_set_value(ifx_dev->gpio.reset, 1);
> +	gpiod_set_value(ifx_dev->gpio.reset, 1);
>  	msleep(1);
> -	gpio_set_value(ifx_dev->gpio.po, 1);
> +	gpiod_set_value(ifx_dev->gpio.po, 1);
>  	msleep(1);
> -	gpio_set_value(ifx_dev->gpio.po, 0);
> +	gpiod_set_value(ifx_dev->gpio.po, 0);
>  	ret = wait_event_timeout(ifx_dev->mdm_reset_wait,
>  				 test_bit(MR_COMPLETE,
>  					  &ifx_dev->mdm_reset_state),
> @@ -1080,107 +1079,68 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
>  		goto error_ret;
>  	}
>  
> -	ifx_dev->gpio.reset = pl_data->rst_pmu;
> -	ifx_dev->gpio.po = pl_data->pwr_on;
> -	ifx_dev->gpio.mrdy = pl_data->mrdy;
> -	ifx_dev->gpio.srdy = pl_data->srdy;
> -	ifx_dev->gpio.reset_out = pl_data->rst_out;
> -
> -	dev_info(dev, "gpios %d, %d, %d, %d, %d",
> -		 ifx_dev->gpio.reset, ifx_dev->gpio.po, ifx_dev->gpio.mrdy,
> -		 ifx_dev->gpio.srdy, ifx_dev->gpio.reset_out);
> -
> -	/* Configure gpios */
> -	ret = gpio_request(ifx_dev->gpio.reset, "ifxModem");
> -	if (ret < 0) {
> -		dev_err(dev, "Unable to allocate GPIO%d (RESET)",
> -			ifx_dev->gpio.reset);
> +	ifx_dev->gpio.reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ifx_dev->gpio.reset)) {
> +		dev_err(dev, "could not obtain reset GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.reset);
>  		goto error_ret;
>  	}
> -	ret += gpio_direction_output(ifx_dev->gpio.reset, 0);
> -	ret += gpio_export(ifx_dev->gpio.reset, 1);
> -	if (ret) {
> -		dev_err(dev, "Unable to configure GPIO%d (RESET)",
> -			ifx_dev->gpio.reset);
> -		ret = -EBUSY;
> -		goto error_ret2;
> -	}
> -
> -	ret = gpio_request(ifx_dev->gpio.po, "ifxModem");
> -	ret += gpio_direction_output(ifx_dev->gpio.po, 0);
> -	ret += gpio_export(ifx_dev->gpio.po, 1);
> -	if (ret) {
> -		dev_err(dev, "Unable to configure GPIO%d (ON)",
> -			ifx_dev->gpio.po);
> -		ret = -EBUSY;
> -		goto error_ret3;
> -	}
> -
> -	ret = gpio_request(ifx_dev->gpio.mrdy, "ifxModem");
> -	if (ret < 0) {
> -		dev_err(dev, "Unable to allocate GPIO%d (MRDY)",
> -			ifx_dev->gpio.mrdy);
> -		goto error_ret3;
> -	}
> -	ret += gpio_export(ifx_dev->gpio.mrdy, 1);
> -	ret += gpio_direction_output(ifx_dev->gpio.mrdy, 0);
> -	if (ret) {
> -		dev_err(dev, "Unable to configure GPIO%d (MRDY)",
> -			ifx_dev->gpio.mrdy);
> -		ret = -EBUSY;
> -		goto error_ret4;
> +	gpiod_set_consumer_name(ifx_dev->gpio.reset, "ifxModem reset");
> +	ifx_dev->gpio.po = devm_gpiod_get(dev, "power", GPIOD_OUT_LOW);
> +	if (IS_ERR(ifx_dev->gpio.po)) {
> +		dev_err(dev, "could not obtain power GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.po);
> +		goto error_ret;
>  	}
> -
> -	ret = gpio_request(ifx_dev->gpio.srdy, "ifxModem");
> -	if (ret < 0) {
> -		dev_err(dev, "Unable to allocate GPIO%d (SRDY)",
> -			ifx_dev->gpio.srdy);
> -		ret = -EBUSY;
> -		goto error_ret4;
> +	gpiod_set_consumer_name(ifx_dev->gpio.po, "ifxModem power");
> +	ifx_dev->gpio.mrdy = devm_gpiod_get(dev, "mrdy", GPIOD_OUT_LOW);
> +	if (IS_ERR(ifx_dev->gpio.mrdy)) {
> +		dev_err(dev, "could not obtain mrdy GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.mrdy);
> +		goto error_ret;
>  	}
> -	ret += gpio_export(ifx_dev->gpio.srdy, 1);
> -	ret += gpio_direction_input(ifx_dev->gpio.srdy);
> -	if (ret) {
> -		dev_err(dev, "Unable to configure GPIO%d (SRDY)",
> -			ifx_dev->gpio.srdy);
> -		ret = -EBUSY;
> -		goto error_ret5;
> +	gpiod_set_consumer_name(ifx_dev->gpio.mrdy, "ifxModem mrdy");
> +	ifx_dev->gpio.srdy = devm_gpiod_get(dev, "srdy", GPIOD_IN);
> +	if (IS_ERR(ifx_dev->gpio.srdy)) {
> +		dev_err(dev, "could not obtain srdy GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.srdy);
> +		goto error_ret;
>  	}
> -
> -	ret = gpio_request(ifx_dev->gpio.reset_out, "ifxModem");
> -	if (ret < 0) {
> -		dev_err(dev, "Unable to allocate GPIO%d (RESET_OUT)",
> -			ifx_dev->gpio.reset_out);
> -		goto error_ret5;
> +	gpiod_set_consumer_name(ifx_dev->gpio.srdy, "ifxModem srdy");
> +	ifx_dev->gpio.reset_out = devm_gpiod_get(dev, "rst_out", GPIOD_IN);
> +	if (IS_ERR(ifx_dev->gpio.reset_out)) {
> +		dev_err(dev, "could not obtain rst_out GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.reset_out);
> +		goto error_ret;
>  	}
> -	ret += gpio_export(ifx_dev->gpio.reset_out, 1);
> -	ret += gpio_direction_input(ifx_dev->gpio.reset_out);
> -	if (ret) {
> -		dev_err(dev, "Unable to configure GPIO%d (RESET_OUT)",
> -			ifx_dev->gpio.reset_out);
> -		ret = -EBUSY;
> -		goto error_ret6;
> +	gpiod_set_consumer_name(ifx_dev->gpio.reset_out, "ifxModem reset out");
> +	ifx_dev->gpio.pmu_reset = devm_gpiod_get(dev, "pmu_reset", GPIOD_ASIS);
> +	if (IS_ERR(ifx_dev->gpio.pmu_reset)) {
> +		dev_err(dev, "could not obtain pmu_reset GPIO\n");
> +		ret = PTR_ERR(ifx_dev->gpio.pmu_reset);
> +		goto error_ret;
>  	}
> +	gpiod_set_consumer_name(ifx_dev->gpio.pmu_reset, "ifxModem PMU reset");
>  
> -	ret = request_irq(gpio_to_irq(ifx_dev->gpio.reset_out),
> +	ret = request_irq(gpiod_to_irq(ifx_dev->gpio.reset_out),
>  			  ifx_spi_reset_interrupt,
>  			  IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING, DRVNAME,
>  			  ifx_dev);
>  	if (ret) {
>  		dev_err(dev, "Unable to get irq %x\n",
> -			gpio_to_irq(ifx_dev->gpio.reset_out));
> -		goto error_ret6;
> +			gpiod_to_irq(ifx_dev->gpio.reset_out));
> +		goto error_ret;
>  	}
>  
>  	ret = ifx_spi_reset(ifx_dev);
>  
> -	ret = request_irq(gpio_to_irq(ifx_dev->gpio.srdy),
> +	ret = request_irq(gpiod_to_irq(ifx_dev->gpio.srdy),
>  			  ifx_spi_srdy_interrupt, IRQF_TRIGGER_RISING, DRVNAME,
>  			  ifx_dev);
>  	if (ret) {
>  		dev_err(dev, "Unable to get irq %x",
> -			gpio_to_irq(ifx_dev->gpio.srdy));
> -		goto error_ret7;
> +			gpiod_to_irq(ifx_dev->gpio.srdy));
> +		goto error_ret2;
>  	}
>  
>  	/* set pm runtime power state and register with power system */
> @@ -1191,7 +1151,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
>  	/* no outgoing tty open at this point, this just satisfies the
>  	 * modem's read and should reset communication properly
>  	 */
> -	srdy = gpio_get_value(ifx_dev->gpio.srdy);
> +	srdy = gpiod_get_value(ifx_dev->gpio.srdy);
>  
>  	if (srdy) {
>  		mrdy_assert(ifx_dev);
> @@ -1200,18 +1160,8 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
>  		mrdy_set_low(ifx_dev);
>  	return 0;
>  
> -error_ret7:
> -	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
> -error_ret6:
> -	gpio_free(ifx_dev->gpio.srdy);
> -error_ret5:
> -	gpio_free(ifx_dev->gpio.mrdy);
> -error_ret4:
> -	gpio_free(ifx_dev->gpio.reset);
> -error_ret3:
> -	gpio_free(ifx_dev->gpio.po);
>  error_ret2:
> -	gpio_free(ifx_dev->gpio.reset_out);
> +	free_irq(gpiod_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
>  error_ret:
>  	ifx_spi_free_device(ifx_dev);
>  	saved_ifx_dev = NULL;
> @@ -1235,14 +1185,8 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
>  	pm_runtime_disable(&spi->dev);
>  
>  	/* free irq */
> -	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
> -	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);
> -
> -	gpio_free(ifx_dev->gpio.srdy);
> -	gpio_free(ifx_dev->gpio.mrdy);
> -	gpio_free(ifx_dev->gpio.reset);
> -	gpio_free(ifx_dev->gpio.po);
> -	gpio_free(ifx_dev->gpio.reset_out);
> +	free_irq(gpiod_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
> +	free_irq(gpiod_to_irq(ifx_dev->gpio.srdy), ifx_dev);
>  
>  	/* free allocations */
>  	ifx_spi_free_device(ifx_dev);
> diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
> index c5a2514212ff..f37e356af553 100644
> --- a/drivers/tty/serial/ifx6x60.h
> +++ b/drivers/tty/serial/ifx6x60.h
> @@ -10,6 +10,8 @@
>  #ifndef _IFX6X60_H
>  #define _IFX6X60_H
>  
> +struct gpio_desc;
> +
>  #define DRVNAME				"ifx6x60"
>  #define TTYNAME				"ttyIFX"
>  
> @@ -94,11 +96,12 @@ struct ifx_spi_device {
>  
>  	struct {
>  		/* gpio lines */
> -		unsigned short srdy;		/* slave-ready gpio */
> -		unsigned short mrdy;		/* master-ready gpio */
> -		unsigned short reset;		/* modem-reset gpio */
> -		unsigned short po;		/* modem-on gpio */
> -		unsigned short reset_out;	/* modem-in-reset gpio */
> +		struct gpio_desc *srdy;		/* slave-ready gpio */
> +		struct gpio_desc *mrdy;		/* master-ready gpio */
> +		struct gpio_desc *reset;	/* modem-reset gpio */
> +		struct gpio_desc *po;		/* modem-on gpio */
> +		struct gpio_desc *reset_out;	/* modem-in-reset gpio */
> +		struct gpio_desc *pmu_reset;	/* PMU reset gpio */
>  		/* state/stats */
>  		int unack_srdy_int_nb;
>  	} gpio;
> diff --git a/include/linux/spi/ifx_modem.h b/include/linux/spi/ifx_modem.h
> index 694268c78d5d..6d19b09139d0 100644
> --- a/include/linux/spi/ifx_modem.h
> +++ b/include/linux/spi/ifx_modem.h
> @@ -3,12 +3,7 @@
>  #define LINUX_IFX_MODEM_H
>  
>  struct ifx_modem_platform_data {
> -	unsigned short rst_out;		/* modem reset out */
> -	unsigned short pwr_on;		/* power on */
> -	unsigned short rst_pmu;		/* reset modem */
>  	unsigned short tx_pwr;		/* modem power threshold */
> -	unsigned short srdy;		/* SRDY */
> -	unsigned short mrdy;		/* MRDY */
>  	unsigned char modem_type;	/* Modem type */
>  	unsigned long max_hz;		/* max SPI frequency */
>  	unsigned short use_dma:1;	/* spi protocol driver supplies
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


