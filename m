Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D963DE6FE3D
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 14:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjIVOrH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIVOrG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 10:47:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C24C6
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695394020; x=1726930020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAES/reZXK7URPeKnkoNlXC416jCeja2odrtUsYzEAo=;
  b=meCFlP1ZHifm9d5Feg2b+mfoPZE4JviTSwFugT4uAwsCV6LHiOcCd8pd
   m7LGFRre2EXMv3Gpy9+yPSC410z72G64XHTf5E3IWWxm/IByJs8fyI8OE
   wEg76cfMyXCMz+ueox5zB6B7lR0f5pIwThZBd6hhayRjK9mO5Bf/h7Sre
   4Rn74CjBI/ncc/5PVMxvPwY2oOTT0d7gXE0adRrE4fDa6Dq9K6aiPRvlK
   ywJVxmMhL8s9S4vdLlJizh7N58cpM65m1W+QoXE4YT9Bj9RFMug7JWzmA
   gbzXrqUUNIk3nCoY6HGq+AzPz1rfbBaiLGGTXT+oCdU6cUJ6OM8vrU3+x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383590222"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383590222"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="750868742"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750868742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:46:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qjhQk-0000000HD8x-24jh;
        Fri, 22 Sep 2023 17:46:54 +0300
Date:   Fri, 22 Sep 2023 17:46:54 +0300
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: Re: [PATCH V8 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <ZQ2o3uIVTqDOgtwo@smile.fi.intel.com>
References: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 22, 2023 at 02:20:23PM +0000, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Hardware ID of Sealevel 7xxxC cards changed prior to release.
> This has rendered 14ee78d5932a redundant.

> Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

Aside:
This line basically is not needed (and misses period) as below does
the equivalent.

> This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

-- 
With Best Regards,
Andy Shevchenko


