Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE4CA0FE4
	for <linux-serial@archiver.kernel.org>; Fri,  1 Sep 2023 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbjIAQDV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbjIAQDU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Sep 2023 12:03:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC810EC
        for <linux-serial@vger.kernel.org>; Fri,  1 Sep 2023 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693584197; x=1725120197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opxFmr16MqAlpdrIPJZ4R0qrlu3Ke0ux3KSgkrUdGT8=;
  b=i7XaSOxLpKHTW0kIEsUXYsTg47wlSbli5UcmWhQExYGTvGCMpNuuIggJ
   7glAd6ERGzCwRRcU2cHMPaoyr2m4mIY4i7w/Ks3PnIB5GcTK4c7MJ1OP3
   j2DjsOXW/CtYsEyQRp7ZEv+T0RKzhYhdlUgzSxq7yvQMwsBHLXXwM7HtF
   9oBvLAK5VkgOZlxcrZFJdvd3iH77dr4/fSq5ewlXqAnFKSQhSJ11FR38p
   G2zV4XlGSkPAK4HZ1w+kGm+irF6mJ8Q0+4tG0+xTRs/3OppdVqY3zSOEf
   m2tt3ZWQlnuwgXTe1Z2V6hgV2kZ8y/KMbAo8g2I1pq2BJPRMwwmniMVS4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376180279"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="376180279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="716815624"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="716815624"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:03:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qc6bw-005iLT-13;
        Fri, 01 Sep 2023 19:03:04 +0300
Date:   Fri, 1 Sep 2023 19:03:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V3 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZPILOMkXJZed4ci6@smile.fi.intel.com>
References: <b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com>
 <ZPEflBvmd5R/kImw@smile.fi.intel.com>
 <a4d66170-82f3-5021-2991-3b67e6eb86d4@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d66170-82f3-5021-2991-3b67e6eb86d4@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 01, 2023 at 10:26:01AM -0400, Matthew Howell wrote:
> On Thu, 31 Aug 2023, Andy Shevchenko wrote:
> > On Thu, Aug 31, 2023 at 03:48:08PM -0400, Matthew Howell wrote:

...

> > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > 
> > Seems you haven't seen / ignored my comments. Please, read my previous reply.
> 
> You said !!() is redundant and I have removed !!(). Previous feedback also
> suggested that is_rs485 is not needed, but I had reverted both changes as 
> I initially thought it was the cause of a breakage. However, further testing 
> found the breakage was unrelated to this patch series. Therefore, I 
> attempted to address both suggestions by removing is_rs485 and !!() in 
> this submission.
> 
> I did not ignore your comments and I do not appreciate these insenuations. 

> I have made changes based on every one of your comments in the previous 
> submission, I just did not always address the comment in exactly you 
> suggested.
> 
> Please, clarify how this fails to address your comments and I will be 
> happy to correct it in the next submission.

I believe there is a misunderstanding in what I meant.
My previous comment was to change

	if (is_...) {
		...
	}
	return 0;

to

	if (!is_...)
		return 0;
	...
	return 0;

which is missing here. But as you said the entire "if" is redundant, so drop it.

> > > +    }

-- 
With Best Regards,
Andy Shevchenko


