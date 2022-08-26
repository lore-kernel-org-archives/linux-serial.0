Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D157FECAAA3
	for <linux-serial@archiver.kernel.org>; Fri, 26 Aug 2022 14:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiHZOwO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Aug 2022 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiHZOwN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Aug 2022 10:52:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4AD8B1A;
        Fri, 26 Aug 2022 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661525532; x=1693061532;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=o4zl2/94nYD0TeHRyR/L7P8QHLcI6dL7OhrMf0XiAEo=;
  b=lm3BBaP+x0Jk7JKRNxmEiCDaqB+kGdMRh5cTVWN1JeuUkb1IgOifwqjy
   Rmr7XouJhHOgsGRSNtCP9Y7h98kV+QVL3AKxXq9saG9so25v5n61pd+OW
   q7aLhM/1RNFXOJIozAeGipxtgsQnHsnB4+LrrB6L6vFgR+LJLqu7ds08k
   X1fxg6uwnjSAvb2QRT7GtWQ8EfR4SNyYaJYDEUlPyo0b6kNC1/UhPCc83
   2XUZQYxve8/GPQXbrw23szBO1R7d8M6HiQRq9dDRZtz3AYys16mdcshlW
   qJTXKJHL6jAL9ZwKAynjnFuKM2A8mnJeMuElj4ADKXCzRZjUaGTf+f3OS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295794367"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295794367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:52:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671490027"
Received: from syeghiay-mobl.ger.corp.intel.com ([10.252.41.100])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:52:09 -0700
Date:   Fri, 26 Aug 2022 17:52:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
cc:     linux-serial <linux-serial@vger.kernel.org>, git@amd.com,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux@armlinux.org.uk, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] serial: pl011: Add reg-io-width parameters
In-Reply-To: <20220826120559.2122-3-shubhrajyoti.datta@amd.com>
Message-ID: <5ee24dad-e5b4-206f-7ebc-d9a2d4b572@linux.intel.com>
References: <20220826120559.2122-1-shubhrajyoti.datta@amd.com> <20220826120559.2122-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-353544485-1661525329=:1606"
Content-ID: <f8af40c7-d22-15ba-7c9-da7747968451@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-353544485-1661525329=:1606
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <38586ab-17b-a2d3-308e-c51b82855c7a@linux.intel.com>

On Fri, 26 Aug 2022, Shubhrajyoti Datta wrote:

> Some of the implementations can read only 32 bits because of
> the interface limitations of the port they are connected to.
> Add a parameter reg-io-width for supporting such platforms.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
> v4:
> No change
> 
>  drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 15f0e4d88c5a..033bf8699540 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2777,6 +2777,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	struct uart_amba_port *uap;
>  	struct vendor_data *vendor = id->data;
>  	int portnr, ret;
> +	u32 val;
>  
>  	portnr = pl011_find_free_port();
>  	if (portnr < 0)
> @@ -2801,6 +2802,21 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	uap->port.rs485_supported = pl011_rs485_supported;
>  	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
>  
> +	if (device_property_read_u32(&dev->dev, "reg-io-width", &val) == 0) {
> +		switch (val) {
> +		case 1:
> +			uap->port.iotype = UPIO_MEM;
> +			break;
> +		case 4:
> +			uap->port.iotype = UPIO_MEM32;
> +			break;
> +		default:
> +			dev_warn(&dev->dev, "unsupported reg-io-width (%d)\n",
> +				 val);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
>  	if (ret)
>  		return ret;


--8323329-353544485-1661525329=:1606--
