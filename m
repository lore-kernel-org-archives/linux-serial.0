Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A8C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A224D6109E
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353912AbhJALvz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:51:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:28077 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354023AbhJALvz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 07:51:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="205565400"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="205565400"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="619039192"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:50:08 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWH3E-007Qn5-T2;
        Fri, 01 Oct 2021 14:50:04 +0300
Date:   Fri, 1 Oct 2021 14:50:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 2/3] serial: 8250: Add UART_CAP_NOTEMT on
 PORT_16550A_FSL64
Message-ID: <YVb17BPnJqZWhvXo@smile.fi.intel.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <20210204161158.643-3-etremblay@distech-controls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204161158.643-3-etremblay@distech-controls.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 04, 2021 at 11:11:57AM -0500, Eric Tremblay wrote:
> This port doesn't have an interrupt on TEMT available when using

s/This port/Port on Freescale ... (or what is that?)/

> the FIFO mode.

With amended commit message
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 00c2cb64e8a7..dd904f736c61 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -262,7 +262,7 @@ static const struct serial8250_config uart_config[] = {
>  		.tx_loadsz	= 63,
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>  				  UART_FCR7_64BYTE,
> -		.flags		= UART_CAP_FIFO,
> +		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
>  	},
>  	[PORT_RT2880] = {
>  		.name		= "Palmchip BK-3103",
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


