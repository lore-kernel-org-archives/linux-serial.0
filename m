Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45864C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2020671
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgERPJT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 11:09:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:22819 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPJT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 11:09:19 -0400
IronPort-SDR: SacNUC89LB64lbXUN6yQgwOqlVcMSw2Mzlrk0fQ2nDRTihdHr8Rtny6LBvnLz+cUPjwx8ucMJj
 kZR67zZ2uRZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:09:19 -0700
IronPort-SDR: JV4KtZ9f2cCpPu9R8GwLJi+LB1C0o/3lquaOAl0+ha4d8Yw0ooZ6huVo1GYgXYbA+eAo8+2zMk
 KbgvNlP0rKuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="254465710"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2020 08:09:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jahOJ-007RzP-OT; Mon, 18 May 2020 18:09:19 +0300
Date:   Mon, 18 May 2020 18:09:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 1/5] serial: 8520_port: Fix function param
 documentation
Message-ID: <20200518150919.GF1634618@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215610.2131618-2-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 17, 2020 at 11:56:06PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The parameter is named p while the documentation talks about up.
> Fix the doc to be in line with the code.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 058bc104f7ca ("serial: 8250: Generalize rs485 software emulation")
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 9c0457e74d21..6975bd3ecb7d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1437,7 +1437,7 @@ static void serial8250_stop_rx(struct uart_port *port)
>  
>  /**
>   * serial8250_em485_stop_tx() - generic ->rs485_stop_tx() callback
> - * @up: uart 8250 port
> + * @p: uart 8250 port
>   *
>   * Generic callback usable by 8250 uart drivers to stop rs485 transmission.
>   */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


