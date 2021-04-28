Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF532C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 28 Apr 2021 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C65761107
	for <linux-serial@archiver.kernel.org>; Wed, 28 Apr 2021 09:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhD1JHY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:07:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:11102 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhD1JHY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Apr 2021 05:07:24 -0400
IronPort-SDR: 19u9sQ86hIOPmi2kEqiARS3njuKpmpe/6FHNVt6lfeoc/c3K2WIT/RmCeb/Pt+xm4SHTjTkDh9
 aKchyNfIgMXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="194579810"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="194579810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:06:40 -0700
IronPort-SDR: oxydSdPDCRBsw6vd2p2BrdWc+V5eDRGhitUmmArfmGlX7dVE79M3toNcDmh1jKsk8EhCW2/07q
 Yq/wJuN0yNQw==
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="425532650"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 02:06:37 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lbg9T-007q1b-3m; Wed, 28 Apr 2021 12:06:35 +0300
Date:   Wed, 28 Apr 2021 12:06:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de,
        yangyingliang@huawei.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add an empty line and remove some
 useless {}
Message-ID: <YIklm6h4xvQlw5Wf@smile.fi.intel.com>
References: <14024ddeb2b3a8c5b0138b5ba5083f54d00164a9.1619594713.git.christophe.jaillet@wanadoo.fr>
 <257ffd691b4a062ad017333c9430d69da6dbd29a.1619594713.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257ffd691b4a062ad017333c9430d69da6dbd29a.1619594713.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 28, 2021 at 09:30:52AM +0200, Christophe JAILLET wrote:
> This fixes the following checkpatch.pl warnings:
>    WARNING: Missing a blank line after declarations
>    WARNING: braces {} are not necessary for any arm of this statement

If it makes somebody happier...
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/tty/serial/8250/8250_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 081b773a54c9..1082e76c4d37 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -321,9 +321,9 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
>  	 * hardware interrupt, we use a timer-based system.  The original
>  	 * driver used to do this with IRQ0.
>  	 */
> -	if (!port->irq) {
> +	if (!port->irq)
>  		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
> -	} else
> +	else
>  		retval = serial_link_irq_chain(up);
>  
>  	return retval;
> @@ -752,6 +752,7 @@ void serial8250_suspend_port(int line)
>  	if (!console_suspend_enabled && uart_console(port) &&
>  	    port->type != PORT_8250) {
>  		unsigned char canary = 0xa5;
> +
>  		serial_out(up, UART_SCR, canary);
>  		if (serial_in(up, UART_SCR) == canary)
>  			up->canary = canary;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


