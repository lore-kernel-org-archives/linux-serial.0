Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D5C77B7A
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 14:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjFFOzj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjFFOyx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CE10CA;
        Tue,  6 Jun 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063287; x=1717599287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QtaV5Iu8s7V9dQfO9oleupwHmFU2xDZG9go1SNSm9fY=;
  b=aQyVwwegESQ9pnpxVwOmJEnEv1SZ35ByahSUV1QVRWZeGUwUQpQKsK/O
   pev0+Cf+gzxTXQAbpHuOGPPvoQqg2CWCQD8+LmxpqHQFZsFD/O7eZn41X
   VWBuUjKtg8clZq3zCSahwtvXXW4Q2SFl2fDYKbLHQctbxHLrkhPEUf05x
   ISMZksaNAfjW4TZkolIMBIqpJLRYi08+rVakvNR+j33oRwwt9a2eNa9AJ
   EZbl89ObZmxdYVOJI7J0Peh5wcw35OYVmtp7JS+udvyFStDQ++Mn9py4/
   Z4o48KMoOqha9x+zB7Tl/0E8MckzyjAahO7nq/qB9qIyKvyWppMA/QXMc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336322201"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336322201"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712235772"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="712235772"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2023 07:54:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y4O-001gKi-2j;
        Tue, 06 Jun 2023 17:54:00 +0300
Date:   Tue, 6 Jun 2023 17:54:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <ZH9IiAUeIf/pi+E1@smile.fi.intel.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
 <20230606133749.GK56720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606133749.GK56720@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:49PM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230606 13:16]:
> > On Tue, Jun 06, 2023 at 11:26:25AM +0300, Dan Carpenter wrote:
> > > The put_device() function will call serial_base_ctrl_release() or
> > > serial_base_port_release() so these kfrees() are a double free bug.

...

> > These labels are also called without device being even added.
> > So, this is not good enough as far as I can tell.
> 
> I guess you mean the possibe error returned from the call to
> serial_base_device_init()?
> 
> If serial_base_device_init() fails, we return error and end up doing
> the put_device().
> 
> We have serial_base_device_init() call device_initialize(), is that
> not enough for put_device()?

It's not. The error is returned when device release callback is not assigned
yet.

And also just noticed since we return deferred probe, the message there should
be ratelimited or given only _once().

-- 
With Best Regards,
Andy Shevchenko


