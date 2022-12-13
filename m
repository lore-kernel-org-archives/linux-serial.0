Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23096C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 13 Dec 2022 10:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiLMK1D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiLMK0m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Dec 2022 05:26:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BDF1CFDF
        for <linux-serial@vger.kernel.org>; Tue, 13 Dec 2022 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670927199; x=1702463199;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ah5SZVY2fxhzaYLbtqGp5de0N+/yQQjIpznbkipHIEk=;
  b=IeIP0EOI/O1eYnjeqldopcN5mwDZCMOdi5vQXdu4d6DReSgkwD+I7Fxj
   ISYTsLG3CDRl2kedCulzWy5EWSfJsb1EJdPmwqYdB6jMUC8AsryRXXE1b
   sKAjPTiK0bvJG8dC7NECGT3Zeu8ONWDZJmFgTlOiRjkqXELPR+BwNTUAa
   BN/uQHV/fbyV2YjCEZMYgNBrjm/GbnlDWhDVnIg6VJylrCPZX8cnAgoM7
   ZArqNgkHmfzLowEZSB9SHdOqOlfQNKxaExAXpYdD6q9/GQ4atJ6OvK59q
   jBmM+n1/J+zP6ZamWo+9FcB7NypBOJoyHvRVJjTeg0It35iTaIH6TYhuB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404354164"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="404354164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:26:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="712023652"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="712023652"
Received: from myegin-mobl1.ger.corp.intel.com ([10.251.216.20])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:26:36 -0800
Date:   Tue, 13 Dec 2022 12:26:33 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Vineet Gupta <vgupta@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] serial: arc_uart: Drop empty platform remove function
In-Reply-To: <20221212212037.3773636-1-u.kleine-koenig@pengutronix.de>
Message-ID: <2260aed-5ad1-a67-13b9-17b3ad8b3377@linux.intel.com>
References: <20221212212037.3773636-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-159833375-1670927198=:1741"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-159833375-1670927198=:1741
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Dec 2022, Uwe Kleine-König wrote:

> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
>  drivers/tty/serial/arc_uart.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
> index 2a65ea2660e1..f1b6034addda 100644
> --- a/drivers/tty/serial/arc_uart.c
> +++ b/drivers/tty/serial/arc_uart.c
> @@ -632,12 +632,6 @@ static int arc_serial_probe(struct platform_device *pdev)
>  	return uart_add_one_port(&arc_uart_driver, &arc_uart_ports[dev_id].port);
>  }
>  
> -static int arc_serial_remove(struct platform_device *pdev)
> -{
> -	/* This will never be called */
> -	return 0;
> -}
> -
>  static const struct of_device_id arc_uart_dt_ids[] = {
>  	{ .compatible = "snps,arc-uart" },
>  	{ /* Sentinel */ }
> @@ -646,7 +640,6 @@ MODULE_DEVICE_TABLE(of, arc_uart_dt_ids);
>  
>  static struct platform_driver arc_platform_driver = {
>  	.probe = arc_serial_probe,
> -	.remove = arc_serial_remove,
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.of_match_table  = arc_uart_dt_ids,
> 

--8323329-159833375-1670927198=:1741--
