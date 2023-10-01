Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF723E748E9
	for <linux-serial@archiver.kernel.org>; Sun,  1 Oct 2023 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjJAI4a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 1 Oct 2023 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAI43 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Oct 2023 04:56:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BCC6
        for <linux-serial@vger.kernel.org>; Sun,  1 Oct 2023 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696150587; x=1727686587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAdgoFlTSxhaxMus9TGJFKyzmG3dEdE5WDVlSPfsrXM=;
  b=mE4XVVeQZ+8fctbMj4r2fl/VUcZbjyPKEaXoh8oPbn9dnrkk7zbI0nl0
   PrHHMDFDkK59Ih6K1Ygs0MIDuFbXoCUPvVJXY14fKdPLej0KG5FFApNpN
   HbyLaHt8BCND8AwT7/RbldtXUFYOGhrv+7T2rm4lvdFwq7I6JK7maT/rb
   JNikeQjRwPgv2FwGoXxC3uPaodpiD9hWZIYQtUePzX9XgQL2jaUXkZ2e5
   uZ85/+cjhizDBu1HCHA9M3Xq4NqbhMCXov3tnGSEa2VSHqlrVlSBZ+qZ0
   MFIct57OZNofdqTXhDMbIH18+5IzNszWI8Lblg2B1998yvoH6gbjvcRCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="4081169"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="4081169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="924000599"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="924000599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:56:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenkoa@linux.intel.com>)
        id 1qmsFE-00000001rHa-2vGO;
        Sun, 01 Oct 2023 11:56:08 +0300
Date:   Sun, 1 Oct 2023 11:56:08 +0300
From:   Andy Shevchenko <andriy.shevchenkoa@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "eff.baldwin@sealevel.com" <eff.baldwin@sealevel.com>,
        James Olson <james.olson@sealevel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V9 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZRk0KL8XGOBIwg2F@smile.fi.intel.com>
References: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
 <4b8ad8ab6728742464c4e048fdeecb2b40522aef.camel@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8ad8ab6728742464c4e048fdeecb2b40522aef.camel@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 29, 2023 at 05:40:55PM +0000, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
> the current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> Sealevel cards.

Looks good, thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenkoa@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


