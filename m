Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87666C7EE24
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 14:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFFOzi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbjFFOzV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 10:55:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754791B5;
        Tue,  6 Jun 2023 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063320; x=1717599320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCS0dhRq4avYTEb+8MFcW2OSh/IWWzK38QSfl0joyDI=;
  b=NQMxzpX6SRKPIgWo9A7HlCouf5jTPOuD0q9+ROBcyupyZ/HYQUc7OGdQ
   DQlqdHBxxsSI0C6XQzzRSBICW+2uElevBjJACsR55Osee1KZLWrM7oScM
   7C6Y0zB9ijSuXMdxO7ex6G6L7ecxlMQUWAd59lmA77wUFExioBbICE2Ey
   a6kun1TeaoY0jHw6IqraZ/Clm2W+PmMmH/H9IJtGnk+3G3xGFLGzIYeEt
   GRe2/RYvjByM8Utc9gAnI7N+5XRKGULkp/G7NMWamn1iGw25+I5/vuEuk
   V4SS1XGqXXU1MPz6xSu7LlXxP6T6cehpwPt5cssxROayaOM18KORDEA5J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336322649"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336322649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774156120"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="774156120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 07:55:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y5d-001gM5-0i;
        Tue, 06 Jun 2023 17:55:17 +0300
Date:   Tue, 6 Jun 2023 17:55:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <ZH9I1DCyfa8tEzIz@smile.fi.intel.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
 <c1a2467b-7a30-4eaa-9206-3b47d3ae64e6@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a2467b-7a30-4eaa-9206-3b47d3ae64e6@kadam.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 06, 2023 at 04:51:13PM +0300, Dan Carpenter wrote:
> On Tue, Jun 06, 2023 at 04:16:48PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 06, 2023 at 11:26:25AM +0300, Dan Carpenter wrote:
> > > The put_device() function will call serial_base_ctrl_release() or
> > > serial_base_port_release() so these kfrees() are a double free bug.

...

> > These labels are also called without device being even added.
> > So, this is not good enough as far as I can tell.
> 
> put_device() matches with the device_initialize() in
> serial_base_device_init().  If we wanted to undo a device_add() the
> function is device_del().
> 
> I originally wrote this patch last week but only resent it now because
> of an issue with my mail set up.  I see that serial_base_device_init()
> has actually changed and there is an issue now where the -EPROBE_DEFER
> path leaks.
> 
> I think making callers handle -EPROBE_DEFER as a special case would be
> an ongoing source of bugs.  So really I'd prefer something like this:

I'm okay with the above, but it seems at the same time we need to limit the
messages:

	dev_err_once(port->dev, "uart_add_one_port() called before arch_initcall()?\n");


> regards,
> dan carpenter
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 9354af7c11af..15fa0576d362 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -50,17 +50,17 @@ static int serial_base_device_init(struct uart_port *port,
>  				   void (*release)(struct device *dev),
>  				   int id)
>  {
> -	if (!serial_base_initialized) {
> -		dev_err(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> -		return -EPROBE_DEFER;
> -	}
> -
>  	device_initialize(dev);
>  	dev->type = type;
>  	dev->parent = parent_dev;
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
>  
> +	if (!serial_base_initialized) {
> +		dev_err(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> +		return -EPROBE_DEFER;
> +	}
> +
>  	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
>  }
>  
> 

-- 
With Best Regards,
Andy Shevchenko


