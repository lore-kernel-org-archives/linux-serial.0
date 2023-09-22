Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01466E6FE41
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjIVOsq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOsp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 10:48:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A79180
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695394119; x=1726930119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hvvZmS8LRnG2YAgEiQ2j+fvLQhg1O44wZDEt3KYv/vM=;
  b=M0RATJN1nB5XjZRFFkTguti4LcvfYb9tUzLtM7/RN9xBXDlpuk21rKFt
   YBKZhLUCu45847n3q+/c3h6LQpLkMPuNzpXYJHakKIOVV73ClWJiD6Mtq
   k7HaAYwYsOWBwfzMKxeCKBthMBxpd88W1/KzcJb2KkB0F8TT3GJd7Ruop
   BQcVBNUc3HQLrvrDCzUt3lveZjEW/01VcwSrFKy0D8fSBCkwqcEHJo/Xu
   nVWZ2YPROTFtbIyFPghBQl33Gt9VXhpz4rf2ZtWBD0i5/2DYFpJOWB1xG
   mE3ZXLHKzJNnesWufQ5yPT/24flj2W1TtPx+/WoKTev09gTlUDKC9Sqiu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="467140451"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467140451"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="921186742"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="921186742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:48:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qjhSM-0000000HDAa-17zl;
        Fri, 22 Sep 2023 17:48:34 +0300
Date:   Fri, 22 Sep 2023 17:48:33 +0300
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: Re: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZQ2pQS4q31t8aMBB@smile.fi.intel.com>
References: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
 <4c6c4e3212a929822ec6a8ba09691b465541f648.camel@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6c4e3212a929822ec6a8ba09691b465541f648.camel@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Bingo, you have threaded emails!

On Fri, Sep 22, 2023 at 02:22:11PM +0000, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
> the current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> Sealevel cards.

Btw, few ideas for further improvements / questions.

...

> +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		   struct uart_8250_port *port, int idx)
> +{
> +	int ret;
> +
> +	ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> +	if (ret)
> +		return ret;
> +
> +	port->port.rs485_config = sealevel_rs485_config;
> +
> +	return 0;
> +}

This actually can be embedded into original pci_xr17v35x_setup() as

	if (pdev->subsystem_vendor == PCI_VENDOR_ID_SEALEVEL)
		port->port.rs485_config = sealevel_rs485_config;

...

> +	SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),

This is kinda worries me. Original Exar card has12 port, why 16 is in use for this one?

> +	SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),

With the above suggestion this will be fixed automatically.

-- 
With Best Regards,
Andy Shevchenko


