Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2167C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJTNBQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJTNBO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 09:01:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898A1A0FBB
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666270873; x=1697806873;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZV2JlxPyNW3ygjq9L80ZL+zVYk6YiEDONcJLz36Rk4Q=;
  b=FNBMGheTx8HbC2psUMqYS7tIh2Pv7CYSDdI5OolovjIYEOijAEDUeQVX
   4r1z3hkUXqUf2r18sPKTS00zsFYcDQL40a/wW3q3pHB06LBAyyrLyTdh1
   eyEwnoCnLGN3V5r3DvYG0IxzISYbaksZP4w+8ucXQUKuhs1XuuNi9C8HQ
   lJrSE+gCQQU/bf7YbsHlzr2rJrgfdRlcHPHoTytQVRhxdKs6mwCOC9CR3
   kGANWAZ6TIKN+L7Csxbv7ShQAOOY0OteMdQAh1JwFElzfmrEfDbpi5jWx
   jWP4fCYrE5yK7k+8ica/ItBO0/WMjHo0weD9SVVd+/yIo1xbWzlVh4Xn2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370910594"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="370910594"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:00:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="663028878"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="663028878"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:00:45 -0700
Date:   Thu, 20 Oct 2022 16:00:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <20221018133419.134110-3-martin@geanix.com>
Message-ID: <f2383fb1-9420-c35c-fef1-3c4cc9df368@linux.intel.com>
References: <20221018133419.134110-1-martin@geanix.com> <20221018133419.134110-3-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1511748881-1666270846=:1542"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1511748881-1666270846=:1542
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Oct 2022, Martin Hundebøll wrote:

> Skip registration of the platform device used for built-in ports, if no
> such ports are configured/created.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>

For the whole series:

Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> ---
> 
> Change since v1:
>  * call serial8250_pnp_init() also when nr_uarts is zero
> 
>  drivers/tty/serial/8250/8250_core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index ba48431ec6e2..f4a08fb74c31 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1186,6 +1186,14 @@ static int __init serial8250_init(void)
>  	if (ret)
>  		goto unreg_uart_drv;
>  
> +	if (nr_uarts == 0) {
> +		ret = platform_driver_register(&serial8250_isa_driver);
> +		if (ret)
> +			goto unreg_pnp;
> +
> +		goto out;
> +	}
> +

I'd reverse the condition:

	if (nr_uarts) {
		platform stuff
	}

	ret = platform_driver_register(&serial8250_isa_driver);
        if (ret == 0)
		goto out;
	if (!nr_uarts)
		goto unreg_pnp;

I believe the logic would be easier to follow if you do that.

-- 
 i.

>  	serial8250_isa_devs = platform_device_alloc("serial8250",
>  						    PLAT8250_DEV_LEGACY);
>  	if (!serial8250_isa_devs) {
> @@ -1230,7 +1238,9 @@ static void __exit serial8250_exit(void)
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

--8323329-1511748881-1666270846=:1542--
