Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21804C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Feb 2022 12:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiBOM1X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:27:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiBOM1W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Feb 2022 07:27:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505E107814;
        Tue, 15 Feb 2022 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644928032; x=1676464032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsmaD5+AgiHG60FBubaPKIete3sPIwcvPaX8bd0Dk/s=;
  b=bWrHxuG4ByYvDfQggf/SBYn15vKCesmq4gavMURV4xmSfeZKFN/uC6ws
   qRRVhgxiGGXFSUL/2KHDUzg7w8idIqQA/KykPFHuvet2V89ay7ZBfUnDY
   lVD/t9LYiBngQYi+EmQ2OxS52ukH43PZpDE98iNE4/sxdMivQUuspP1xS
   0eK81yQWSvO8czC8ITK35moXiZ7nAH1Yy5P+Fq6UVKJDjE+jr3QguWUFe
   zfzd/1zQtDNcAgqhp03Tf8xFU70xqCqX8KKOMCmyENW6QVCwqKx9ROo8s
   3EPIOGjnFeohtexWf9e1Cx0InvGhEuZ0S4Vtf5Zq3IV5RduauXWklRGpk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230303594"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230303594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:27:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="587670373"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:27:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJwuO-004uq2-Ie;
        Tue, 15 Feb 2022 14:26:16 +0200
Date:   Tue, 15 Feb 2022 14:26:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_lpss: Balance reference count for
 PCI DMA device
Message-ID: <Ygub6JhhAqEtz5zj@smile.fi.intel.com>
References: <20220215102859.69123-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215102859.69123-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 15, 2022 at 12:28:59PM +0200, Andy Shevchenko wrote:
> The pci_get_slot() increases its reference count, the caller
> must decrement the reference count by calling pci_dev_put().

This needs a v2 as Jiri pointed out.

-- 
With Best Regards,
Andy Shevchenko


