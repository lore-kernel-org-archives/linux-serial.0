Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4249C43219
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiKVTDY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKVTDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 14:03:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E601758C
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669143791; x=1700679791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSUMinOlsUfKF3wEMHIbj2Kl9ms686CL0+PNOlu/SmM=;
  b=oECM6patRcqvGqjwL6kA54D9aSXR4pUhFv0B51GUBXmge8vPCHGq/HeX
   LxRB+ch/HJ4pgLCTiVC0SN4KYKIlFwGQRtUioxkNfTzwx3uKssEVB+4pt
   sHcAjxutrNib0HZMvUTyTRhauXRuVqDWtCCSnLz8C7jNHULzzbND1EmLw
   g6vBJYPt38JSs2S/tM34PXymMKevlIPhmIbkM12lR3XmTugCK9up8ubBg
   TfIjPhtkwfxXKY+zeU2YsHW+Xn8f2iErcWnTayONIhiH7x1L3SmxjR1C8
   Fa9YZVRRAp4BBf1gNyFhOuFllyx8wgovPM5TC2SZaM/zxOdsbdDWPBdm6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312592657"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="312592657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747464857"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="747464857"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 11:03:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oxYXz-00Fxz4-31;
        Tue, 22 Nov 2022 21:03:07 +0200
Date:   Tue, 22 Nov 2022 21:03:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH] serial: pch: Fix PCI device refcount leak in
 pch_request_dma()
Message-ID: <Y30c66gA+bOXGebH@smile.fi.intel.com>
References: <20221122114559.27692-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122114559.27692-1-wangxiongfeng2@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 22, 2022 at 07:45:59PM +0800, Xiongfeng Wang wrote:
> As comment of pci_get_slot() says, it returns a pci_device with its
> refcount increased. The caller must decrement the reference count by
> calling pci_dev_put().

> Since 'dma_dev' is only used to filter the channel in filter(), we can
> call pci_dev_put() before exiting from pch_request_dma(). Add the
> missing pci_dev_put() for the normal and error path.

No, we can't do that. How is it supposed to work if DMA device disappears in
the middle?

Look at how it's done in the

5318f70da7e8 serial: 8250_lpss: Balance reference count for PCI DMA device
67ec6dd0b257 serial: 8250_mid: Balance reference count for PCI DMA device

-- 
With Best Regards,
Andy Shevchenko


