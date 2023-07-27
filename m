Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF23AC41513
	for <linux-serial@archiver.kernel.org>; Thu, 27 Jul 2023 11:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjG0L7o (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Jul 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG0L7n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jul 2023 07:59:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4519272A;
        Thu, 27 Jul 2023 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690459181; x=1721995181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9x/3Iz0t+xmxLOMyXL1Szthxpy6vP9JjfSM6KDQKSkM=;
  b=mXOEaQ0KjNVWEZIBZ+jD25iZ9qvbdc8LHQRC54iwL05YuH8WYTCJUc6T
   ppiDp1WULWQkxaevn8Cr7j3ZHdTABsfjAum0qUmnO7Tv8NW7eACQ30CK9
   7HoIMH+sSlrSvAv+JDftSHaRbxGdL7QuWKb3zWW3MKEH42KQh2F0ExAey
   m2AdpK6wKERUZX6p9mBpxtpRfATSzgfS8dprdjqwgVH/zHx/yFUL0aWOF
   pbgPmwzKbxVJygZZoFqvfLCaB73AzuxcBys2leEXhykB84NL4wSbzjfP2
   TttwCYpQQE2/DcsSpRRqTETYNfmZu0T5IIAeuNEwyb1GAH9/bHuTYwc4/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365747397"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="365747397"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 04:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="762143831"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="762143831"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2023 04:59:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOzeb-002nER-1U;
        Thu, 27 Jul 2023 14:59:37 +0300
Date:   Thu, 27 Jul 2023 14:59:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Replace strncmp()+strlen() with
 plain strcmp()
Message-ID: <ZMJcKc49Z69ZhfGk@smile.fi.intel.com>
References: <20230727090507.81962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727090507.81962-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 27, 2023 at 12:05:07PM +0300, Andy Shevchenko wrote:
> There is no sense to call strlen() ahead of strncmp().
> The same effect can be achieved by calling strcmp() directly.
> Replace strncmp()+strlen() with plain strcmp().

It seems I will have more against serial core, perhaps it makes sense to unite
them in a single series.

-- 
With Best Regards,
Andy Shevchenko


