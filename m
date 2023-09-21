Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9920E7D0A4
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjIUSRT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjIUSQt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E8C102
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318603; x=1726854603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+R56exwD+ChUXqBW102V0/QDHpIBqGnuk1g9wosJXk=;
  b=jK+kFC7tSd26BSrvoiaU6/MLvff2UvegU4HgEWkhr5TNakUwttEeN/dg
   E5VQBtRs8lFWPgNN0o1123ioIHooz0eYjcgLKDeMQX5fKAaHQR3nSvqlw
   2b+BErs7GyHFAsl/zYMyEetgV9rHCegtMh96dSLkQREK7TXvG/bnKw57k
   4t/eQ6PIvF+xjBbH6TROWOuPMrUffSbkAhDiTcIEiMzaWKqRATDT7dcFF
   fPXIP6A4EGAb9FGfMCFdHFR+JGlXntxVqESzuvz/nZsuS1E1E0KpYyoS3
   sjj/u+Q6SXhI2Gj15ibie2drdzxkVcsJ9cWNVgMvs2/briECU6baRO/k+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359871972"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="359871972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812597209"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="812597209"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:10:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjHa9-0000000GsDR-3r4x;
        Thu, 21 Sep 2023 14:10:53 +0300
Date:   Thu, 21 Sep 2023 14:10:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V7 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZQwkvSUM9ojfmuj3@smile.fi.intel.com>
References: <d44f91c4-4599-1911-5cfb-bfc3cde95a9b@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44f91c4-4599-1911-5cfb-bfc3cde95a9b@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 20, 2023 at 03:03:02PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
> the current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> Sealevel cards.

If you address the following couple of things, feel free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> Hopefully Alpine threads correctly this time

Nope.

...

> +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)

Misindented second line (missing one space?).

...

> +	ret = generic_rs485_config(port, termios, rs485);

> +

Unneeded blank line.

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


