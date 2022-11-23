Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360EAC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbiKWJUn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiKWJUX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 04:20:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D78183A7
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669195221; x=1700731221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gP3caYkJNACSZYpPgEu2ygG1JNldK16vSiAkTmFhNUc=;
  b=Ip8Nyf/VGt/TnfPgC29DhmiGvzvlsXHYPrhrCJT0qzHrA7jybZ3eu8Ck
   xP5BvkQK0VQ/oEnaFE68fTZIAjj+fzagjibQ7XUnRliHCsndXO1iZDDG9
   27sBrUbXIPHCUybyOzeywgnzRILXQDZ2QVfVF5vD0RqJUVNyX/SMboQIP
   cWIwjNLNS5KeLGIP00W4cKJ0kVirRHPiKJPu/F0tuuN5oFsRh4wptBHRY
   XRgH4iE7+L8LQ4sFa8AoqxlPeRvEafHyheBqsXsIosirjE0Ap8FiZKHbG
   y6AXeAjkUQBQRbzwDv2WeZYd93gwUqL6yvvtk26dl/J7ifM7cLwto1UmW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311652294"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311652294"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 01:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784170843"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="784170843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 01:20:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oxlvV-00GDpF-2j;
        Wed, 23 Nov 2022 11:20:17 +0200
Date:   Wed, 23 Nov 2022 11:20:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH] serial: pch: Fix PCI device refcount leak in
 pch_request_dma()
Message-ID: <Y33l0fCTTOc//S3s@smile.fi.intel.com>
References: <20221122114559.27692-1-wangxiongfeng2@huawei.com>
 <Y30c66gA+bOXGebH@smile.fi.intel.com>
 <6b2013af-45cf-5a2d-a84e-5c6fa23911da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2013af-45cf-5a2d-a84e-5c6fa23911da@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 23, 2022 at 10:41:08AM +0800, Xiongfeng Wang wrote:
> On 2022/11/23 3:03, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 07:45:59PM +0800, Xiongfeng Wang wrote:
> >> As comment of pci_get_slot() says, it returns a pci_device with its
> >> refcount increased. The caller must decrement the reference count by
> >> calling pci_dev_put().
> > 
> >> Since 'dma_dev' is only used to filter the channel in filter(), we can
> >> call pci_dev_put() before exiting from pch_request_dma(). Add the
> >> missing pci_dev_put() for the normal and error path.
> > 
> > No, we can't do that. How is it supposed to work if DMA device disappears in
> > the middle?
> 
> When the DMA device is registered into the system, its refcount is increased.
> dma_request_channel() will increase the refcount for 'dma_chan'. So I think this
> can gurantee the DMA device not removed in the middle.

It might be the case in this particular driver but not in general, i.e. when
driver drops and request channels on demand, like with SPI case. By doing this
way you prevent (possible) modifications to serial core to use DMA on demand.

That's why I recommend to switch to more robust way of solving this.

-- 
With Best Regards,
Andy Shevchenko


