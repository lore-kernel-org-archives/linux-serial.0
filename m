Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE16C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 11:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiDKLZN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiDKLZL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 07:25:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF084550A
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676178; x=1681212178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=08RKjpMMHV3KkyFUunxkaSF7HTKjtoAVmsGrjtmyMow=;
  b=IScd2exlnhPf0qvBC6cJCIaxh/I0mMXdassxD+bucw3ifkk/b0oHkH0H
   UnpEU5uzWZWUsr57oblnXAziYX1nXSyJpfX2vzsMzJadOAgfXN8Bdj83+
   ONJjPlPXWB9mECQrqZm9blv4KzUKmIYNlElJbXNdlZv40rAAorcjrVYFB
   xU80ooJW//RESH8r0oMQjawje+qIw9rbXJJyKVg+lHJSZogWXhIywQxXy
   2GWXhgOVKIMLkiKMksP9JsQaRMQGnoiXLqmJppnbn5AtiXqOBhiQPT1Zm
   C1Sr8XTBR7TV7Fvdmn5c+kGxUjLzowt4EJ1QzSjjWPRuuXZQHEZRdPa9t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261529555"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261529555"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:22:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="723929659"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:22:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nds4g-001BxB-Kb;
        Mon, 11 Apr 2022 14:19:14 +0300
Date:   Mon, 11 Apr 2022 14:19:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Raymond Tan <raymond.tan@intel.com>,
        Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Subject: Re: [PATCH v3 12/12] serial: 8250_dwlib: Support for 9th bit
 multipoint addressing
Message-ID: <YlQOsiJAsYYA45B7@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-13-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411083321.9131-13-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 11:33:21AM +0300, Ilpo Järvinen wrote:
> This change adds 9th bit multipoint addressing mode for DW UART using
> the new ioctls introduced in the previous change. 9th bit addressing
> can be used only when HW RS485 is available.
> 
> Updating RAR (receive address register) is bit tricky because
> busy indication is not be available when DW UART is strictly
> 16550 compatible, which is the case with the hardware I was
> testing with. RAR should not be updated while receive is in
> progress which is now achieved by deasserting RE and waiting
> for one frame (in case rx would be in progress, the driver
> seems to have no way of knowing it w/o busy indication).

...

> +static void dw8250_update_rar(struct uart_port *p, u32 addr)
> +{
> +	u32 re_en = dw8250_readl_ext(p, DW_UART_RE_EN);
> +
> +	/*
> +	 * RAR shouldn't be changed while receiving. Thus, de-assert RE_EN
> +	 * if asserted and wait.
> +	 */
> +	if (re_en)
> +		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
> +	dw8250_wait_re_deassert(p);
> +	dw8250_writel_ext(p, DW_UART_RAR, addr);
> +	if (re_en)
> +		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);

I would write it

	u32 re_en;

	/*
	 * RAR shouldn't be changed while receiving. Thus, de-assert RE_EN
	 * if asserted and wait.
	 */
	re_en = dw8250_readl_ext(p, DW_UART_RE_EN);
	if (re_en) {
		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
		dw8250_wait_re_deassert(p);
		dw8250_writel_ext(p, DW_UART_RAR, addr);
		dw8250_writel_ext(p, DW_UART_RE_EN, re_en);
	} else {
		dw8250_wait_re_deassert(p);
		dw8250_writel_ext(p, DW_UART_RAR, addr);
	}

or something similar with extracting these two lines into another function.

But it's up to you, it's just pure style thingy.

> +}

...

> +		dw8250_writel_ext(p, DW_UART_TAR, addr->addr & 0xff);

GENMASK() ?
Perhaps even a separate definition?

...

> +		addr->addr = dw8250_readl_ext(p, DW_UART_TAR) & 0xff;

Ditto.

...

> +			addr->addr = dw8250_readl_ext(p, DW_UART_RAR) & 0xff;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


