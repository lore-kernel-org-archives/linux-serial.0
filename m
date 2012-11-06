From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Tue, 6 Nov 2012 09:45:35 +0000
Message-ID: <20121106094535.17daa290@pyramind.ukuu.org.uk>
References: <1352193872.4332.44.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40928 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KFJk2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Nov 2012 04:40:28 -0500
In-Reply-To: <1352193872.4332.44.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>, chao.bi@intel.com, chuansheng.liu@intel.com

>  	dev_warn(&ifx_dev->spi_dev->dev, "*** SPI Timeout ***");
> +	saved_ifx_dev->hangup_reasons |= HU_TIMEOUT;
>  	ifx_spi_ttyhangup(ifx_dev);

This one should be using ifx_dev->hangup_reasons |=

this part of the code is clean for multiple devices so the ifx_dev
pointer should be used (it will always be the same as saved_ifx_dev
currently so it's just a tidy up)


> +/**
> + * reset_modem - modem reset command function
> + * @val: a reference to the string where the modem reset query is given
> + * @kp: an unused reference to the kernel parameter
> + */
> +
> +static int reset_modem(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned long reset_request;
> +	int err = 0;
> +
> +	u16 addr = V1P35CNT_W;
> +	u8 data, def_value;
> +
> +	if (kstrtoul(val, 10, &reset_request) < 0)
> +		return -EINVAL;
> +
> +	if (!saved_ifx_dev) {
> +		dev_dbg(&saved_ifx_dev->spi_dev->dev,
> +				"%s is called before probe\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(&saved_ifx_dev->spi_dev->dev,
> +					"%s requested !\n", __func__);
> +
> +	if (test_and_set_bit(MR_START, &saved_ifx_dev->mdm_reset_state))
> +		goto out;

This case returns 0 - rather than an error like -EBUSY - is that
intentional ?

Otherwise

Acked-by: Alan Cox <alan@linux.intel.com>

and the two points noted can be fixed up with a later patch IMHO.
