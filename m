Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24911C54E4A
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087A0206F5
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 13:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgELNpp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 09:45:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:39457 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgELNpp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 09:45:45 -0400
IronPort-SDR: 7hfIgR/VxCykRPHOs5nz37L5p/f+tmMeWnLu9mN8YjPzq6cOO9iQZ5KVXz8JRAUByW8RxWXJlz
 pwoU3gM1WmsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 06:45:44 -0700
IronPort-SDR: ohkyRxZxQdQVj7nV6l0tz+Lz2FVkB/DEDnlI6O8maPTYmQYdZ9XlTIpJIiUJeowZMdS+MEEPtw
 AUL12X/rcSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="463549874"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2020 06:45:42 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYVE9-006DO3-K1; Tue, 12 May 2020 16:45:45 +0300
Date:   Tue, 12 May 2020 16:45:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250: Avoid error message on reprobe
Message-ID: <20200512134545.GZ185537@smile.fi.intel.com>
References: <cover.1589285873.git.lukas@wunner.de>
 <b4a072013ee1a1d13ee06b4325afb19bda57ca1b.1589285873.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a072013ee1a1d13ee06b4325afb19bda57ca1b.1589285873.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 12, 2020 at 02:40:01PM +0200, Lukas Wunner wrote:
> If the call to uart_add_one_port() in serial8250_register_8250_port()
> fails, a half-initialized entry in the serial_8250ports[] array is left
> behind.
> 
> A subsequent reprobe of the same serial port causes that entry to be
> reused.  Because uart->port.dev is set, uart_remove_one_port() is called
> for the half-initialized entry and bails out with an error message:
> 
> bcm2835-aux-uart 3f215040.serial: Removing wrong port: (null) != (ptrval)
> 
> The same happens on failure of mctrl_gpio_init() since commit
> 4a96895f74c9 ("tty/serial/8250: use mctrl_gpio helpers").
> 
> Fix by zeroing the uart->port.dev pointer in the probe error path.
> 
> The bug was introduced in v2.6.10 by historical commit befff6f5bf5f
> ("[SERIAL] Add new port registration/unregistration functions."):
> https://git.kernel.org/tglx/history/c/befff6f5bf5f
> 
> The commit added an unconditional call to uart_remove_one_port() in
> serial8250_register_port().  In v3.7, commit 835d844d1a28 ("8250_pnp:
> do pnp probe before legacy probe") made that call conditional on
> uart->port.dev which allows me to fix the issue by zeroing that pointer
> in the error path.  Thus, the present commit will fix the problem as far
> back as v3.7 whereas still older versions need to also cherry-pick
> 835d844d1a28.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.10
> Cc: stable@vger.kernel.org # v2.6.10: 835d844d1a28: 8250_pnp: do pnp probe before legacy
> ---
> Changes v1 -> v2:
> * Drop unnecessary "else" after "if ... goto" statement. (Andy)
> * Document applicability to older kernels in commit message. (Andy)
> * Add Fixes tag. (Andy)
> 
>  drivers/tty/serial/8250/8250_core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 45d9117cab68..9548d3f8fc8e 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1040,7 +1040,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  			gpios = mctrl_gpio_init(&uart->port, 0);
>  			if (IS_ERR(gpios)) {
>  				ret = PTR_ERR(gpios);
> -				goto out_unlock;
> +				goto err;
>  			} else {
>  				uart->gpios = gpios;
>  			}
> @@ -1089,8 +1089,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  			serial8250_apply_quirks(uart);
>  			ret = uart_add_one_port(&serial8250_reg,
>  						&uart->port);
> -			if (ret == 0)
> -				ret = uart->port.line;
> +			if (ret)
> +				goto err;
> +
> +			ret = uart->port.line;
>  		} else {
>  			dev_info(uart->port.dev,
>  				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> @@ -1112,10 +1114,14 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  		}
>  	}
>  
> -out_unlock:
>  	mutex_unlock(&serial_mutex);
>  
>  	return ret;
> +
> +err:
> +	uart->port.dev = NULL;
> +	mutex_unlock(&serial_mutex);
> +	return ret;
>  }
>  EXPORT_SYMBOL(serial8250_register_8250_port);
>  
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


