Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9BC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 11:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiDKLSI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiDKLSH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 07:18:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBF1B7AF
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 04:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649675753; x=1681211753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=To9EcCOnmZcbiokMZIFLUZuRO1nQWEW2HvhdSU2gkKo=;
  b=h70rk8ffAIdrisH7De79SptuEnFV9NkMdEUb057JaTzDn5CSj27JOhOx
   2efk6MgKueIvrRGIJlD9HdYsEtLZ19VASfUyafZy+w9MbsFW9uobq9S6D
   GU857R9uoDmUt1tydGeP6hfTckLEjL19FOH2w0tJbPQNpUPNM4ADhO5gf
   s+TT4/qtPJ+bcDyjDMQRfK2g5r5OZDbyblHlIFM1ZY2UZBIMEXPo8wJJj
   OCdumY1Q3dYHKOzT5kLSbRaQfapdS435jqZQNL3JppnNDbVX66+hl+Toj
   nv46FaLSIrpuoQBzBeVm1bpNJcyBftmn6FL8qfPgc2ESlp29B711Jz5BN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="287098090"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="287098090"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:15:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="660005427"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:15:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndrxp-001Bqk-Sb;
        Mon, 11 Apr 2022 14:12:09 +0300
Date:   Mon, 11 Apr 2022 14:12:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 11/12] serial: 8250_lpss: Use 32-bit reads
Message-ID: <YlQNCYb/eUkgcugl@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-12-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411083321.9131-12-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 11:33:20AM +0300, Ilpo Järvinen wrote:
> Use 32-bit reads in order to not lose higher bits of DW
> UART regs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Maybe it needs an additional words that currently the driver doesn't
use anything from the upper bits, that's why it's not a fix.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 0f5af061e0b4..4ba43bef9933 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -330,7 +330,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	uart.port.irq = pci_irq_vector(pdev, 0);
>  	uart.port.private_data = &lpss->data;
>  	uart.port.type = PORT_16550A;
> -	uart.port.iotype = UPIO_MEM;
> +	uart.port.iotype = UPIO_MEM32;
>  	uart.port.regshift = 2;
>  	uart.port.uartclk = lpss->board->base_baud * 16;
>  	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


