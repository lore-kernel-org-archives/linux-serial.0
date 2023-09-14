Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A203EEAA65
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjINTCo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjINTCj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 15:02:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428221FF1
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694718155; x=1726254155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=55AaLupJQAquoFHWGb35ftqYXpaW4EDTVkAhS8IyTlI=;
  b=jzkqAgQ0EmDA3R/pBYTqZQ9ZU1oZI27KjKymkC0oVsLHMCXUv5AEYD9L
   W2Upegk6t2Iea0WfYpOmRTROfl+U1O76JoM68zAzFHsKI2dXO1jD/Zis+
   TMtPO8oSAMG0CPEoJi1HM2Par8cr+fzdC9ce4qI1Vez/7qNJcmbtpghtu
   ks0agG2vNsEME7h0ydDGyFdF684a0j+AZ13J1jclwTfeS/c8Rj2p+kCPO
   LMMp2AladShqTNBHnSHe5dV8lt9h855fxlJ7ZqCesokzB6SNaDHEoJrb0
   6Wxjwp7iEgmxY/Njrj40tri9XPC+fxDKi6MQNtAovum2H963SIbYzNtmh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359307076"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359307076"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834853525"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834853525"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:02:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qgrbf-00000008qJg-0OlY;
        Thu, 14 Sep 2023 22:02:27 +0300
Date:   Thu, 14 Sep 2023 22:02:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZQNYwq6H4XlP/WON@smile.fi.intel.com>
References: <24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 08:32:40AM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but the current implementation of 8250_exar uses RTS for the auto-RS485-Enable mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on Sealevel cards.

Something went wrong with line wrapping, in the commit messages we usually ise
~72 characters long lines.

Same issue appears in the previous patch.

...

> +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		   struct uart_8250_port *port, int idx)
> +{

> +	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> +
> +	if (ret)
> +		return ret;

Hmm... Seems I need to elaborate the idea behind changing above to

	int ret;

	ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
	if (ret)
		return ret;

With the long-term maintenance the additional code may appear in between
ret assignment and check. While it looks simple and impossible to happen,
with time we might end up in the situation like (hypothetical case):

	int ret = foo();
	... *baz;
	...
	baz = bar();
	ret = PTR_ERR_OR_ZERO();
	if (ret)
		...
	...
	if (ret) // original one from your patch

That's why splitting is better than keeping it in definition block for this
kind of variable.

> +	port->port.rs485_config = sealevel_rs485_config;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


