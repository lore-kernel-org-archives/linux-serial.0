Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC846E7109A
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIUQ4f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIUQ4a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E07BCF
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315380; x=1726851380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ln6E8ET7YxoeQkoNw8Yb9eOoSkQhL/2RvjVpAOQWuGc=;
  b=IIMLOwS9+t6Vi9xQ3YWsOwjrf94jAJB35g/7JQPi3gdsPNsg06J+aFNn
   RxJgsELYJx5+CHYKff+SZ1XLNEYcAbLkfWZS3IAAL3tK08uEMesXuo3qQ
   9XTydtRwwZQf6QgK6XucMfXKP16NUfs2ViQBkM2oD6a4wofO5nKAkJxCm
   ZDvcaN1svQrtVxQyLKAMuN2Ecicfslifo/TcnHtSTU/T5C0SmExvzaH7e
   j5u5GFduE6TRJVrysTeDLCLszJrQ18SGDyGDsAVfK8NYqCcpm/loF3hti
   0OsPKsds59L7QF/8caWXR/Aej0AfD5dNUeA3v7rPWf43bkYWwxs4EHBDf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360735934"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360735934"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920694212"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920694212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:07:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjHWR-0000000GsAQ-2GmB;
        Thu, 21 Sep 2023 14:07:03 +0300
Date:   Thu, 21 Sep 2023 14:07:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V7 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <ZQwj1xLhCApa9tc6@smile.fi.intel.com>
References: <74f33e00-f8bf-5d82-3978-726fb78fca3f@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f33e00-f8bf-5d82-3978-726fb78fca3f@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 20, 2023 at 02:31:08PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Hardware ID of Sealevel 7xxxC cards changed prior to release.
> This has rendered 14ee78d5932a redundant.
> 
> Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> 
> This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


