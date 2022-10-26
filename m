Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85508C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 11:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiJZLcT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiJZLbz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 07:31:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CF7297F
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666783901; x=1698319901;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jrGSLtx40ZyLtY9pGZKpZNNPujlNpZihob9wPbsNhDU=;
  b=ZBWNiHJjeqp04BjPcrWp3AibNpAcKTUvZktZ6z7C5hQWCKJyfKkeMHKP
   esfk3FJVrvkaoA9zue65lij2AhH5SqtVquUAqIo2CL4yrWETMcPEMVc6A
   2tgsual1U/CU4gNCCj70khw72ojHG6G3tXa2JT7UvVoS5v2eiJ8ENzhoD
   GdS5NvS/B71uvXmlddQBUf6lhfxhq52W3ccvWnYNB7msZE+C6mFAGzxOy
   M3Rqfa7azGI5JJjwY9Wu+KA/WxRKBL0LtCQQJZyBoqab4uTJbMhYiDWRO
   tbXjobZKWF/7Jy7EUCAngCPLAK9fORexmt5NcEdksrSt0KuNuMzobtMHd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305535693"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="305535693"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:31:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="626753074"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="626753074"
Received: from sgohier-mobl.ger.corp.intel.com ([10.252.54.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:31:38 -0700
Date:   Wed, 26 Oct 2022 14:31:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <20221025073944.102437-3-martin@geanix.com>
Message-ID: <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-3-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1785117009-1666783900=:9482"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1785117009-1666783900=:9482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Oct 2022, Martin Hundebøll wrote:

> Skip registration of the platform device used for built-in ports, if no
> such ports are configured/created.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>

For patches 1-3:

Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Please include these tags into the next version of your submission.
Thank you.

-- 
 i.

> ---
> 
> Change since v1:
>  * call serial8250_pnp_init() also when nr_uarts is zero
> 
> Change since v2:
>  * invert condition to initialize built-in ports (as suggested by Ilpo)
> 
>  drivers/tty/serial/8250/8250_core.c | 30 +++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index ba48431ec6e2..a8fbc2325244 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1186,22 +1186,26 @@ static int __init serial8250_init(void)
>  	if (ret)
>  		goto unreg_uart_drv;
>  
> -	serial8250_isa_devs = platform_device_alloc("serial8250",
> -						    PLAT8250_DEV_LEGACY);
> -	if (!serial8250_isa_devs) {
> -		ret = -ENOMEM;
> -		goto unreg_pnp;
> +	if (nr_uarts) {
> +		serial8250_isa_devs = platform_device_alloc("serial8250",
> +							    PLAT8250_DEV_LEGACY);
> +		if (!serial8250_isa_devs) {
> +			ret = -ENOMEM;
> +			goto unreg_pnp;
> +		}
> +
> +		ret = platform_device_add(serial8250_isa_devs);
> +		if (ret)
> +			goto put_dev;
> +
> +		serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
>  	}
>  
> -	ret = platform_device_add(serial8250_isa_devs);
> -	if (ret)
> -		goto put_dev;
> -
> -	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
> -
>  	ret = platform_driver_register(&serial8250_isa_driver);
>  	if (ret == 0)
>  		goto out;
> +	if (!nr_uarts)
> +		goto unreg_pnp;
>  
>  	platform_device_del(serial8250_isa_devs);
>  put_dev:
> @@ -1230,7 +1234,9 @@ static void __exit serial8250_exit(void)
>  	serial8250_isa_devs = NULL;
>  
>  	platform_driver_unregister(&serial8250_isa_driver);
> -	platform_device_unregister(isa_dev);
> +
> +	if (nr_uarts)
> +		platform_device_unregister(isa_dev);
>  
>  	serial8250_pnp_exit();
>  
> 

--8323329-1785117009-1666783900=:9482--
