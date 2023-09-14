Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB2DEEAA65
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 19:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjINTES (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjINTER (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 15:04:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86010C7
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694718253; x=1726254253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sQJZZLhX+1K92a7aPb9+3iWGpstlab4RZLPavzOjIXI=;
  b=S6Chn9F1YQ5Trt86gn06KtvEX1vdyyqq48cgU30L02U1uyv3khh6B3A4
   5gcja7246ee9s3T+ztO6CvFzaTsEPQFgPDv3D//99pDYcu1Nz8ecH5AhU
   R6KkPb4+/iLnO1dRQZ6oQmoCaSLbqRCugpbh45S5DNFHasI3FN4SagJGj
   5x0ohTkaS3JqfQSgdURxXQ5bcKWHId1Ht8dza/lPjnvV2EU2zs7Hn4ikb
   52EJKinLNPOzjghjAq4j+FKdUDCtIT2BNvkmzHr+3qZuTAh4Rk7+XyVvh
   GlTmnjioOCNgAT0v7LCQZGI9P8BLgb/3gPAUSXHoIO+JbQD+0V79Sl+b/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381762704"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381762704"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779783412"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779783412"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:04:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qgrdH-00000008tmo-3zy6;
        Thu, 14 Sep 2023 22:04:07 +0300
Date:   Thu, 14 Sep 2023 22:04:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <ZQNZJwJoad0EkIYL@smile.fi.intel.com>
References: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 08:28:47AM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.

Too long line.

> Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> 
> This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> 
> Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
> Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>

The patch 1 and patch 2 have not been linked via email, so mail archives and
mail clients do not see this as a thread. I suggest to use `git send-email` for
patches. With --thread option (which I believe should be default) it chains
the mails it sends.

-- 
With Best Regards,
Andy Shevchenko


