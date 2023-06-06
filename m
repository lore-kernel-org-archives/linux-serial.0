Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46427C77B73
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 13:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjFFNQz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbjFFNQy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 09:16:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB9E4B;
        Tue,  6 Jun 2023 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686057413; x=1717593413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qbWk3lY5A9iY7v7/xEPdSPouenXcZRlXvFi3kvQASvM=;
  b=brfabcuUK7WrqChs9x2ZRPBBAk2Iz77CKiixLrn7/k1TaJAMpXUncPCj
   ZLu/L2qNQRGc6l/AxOYtS1ZWSJmSS2joWIf2dz0Kd2De2c/8ZlTgBMk2Y
   gZeU7jCLTjWzQautn6rTKqP8FjbA8maDS0w66EFDYfdEFJ72WFip1K9vq
   1mx9Z+Q9cTZ4v9NonKobIhFjRqcIFGKjJYAOV4x4OCalYpj6/JtCiaX2N
   H3ACHolk1tyI8DGVQuTVxuWPMop5YMOHzG/OQIIsbF30z9qPHXjxLSKDm
   U4PZcpO3RAydlPQu9gSWCAQ4wKaWOnGFdT1t/84RLBQVBlCfzDjmEpg5e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355520568"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="355520568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="833227321"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="833227321"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2023 06:16:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6WYL-001dbT-0f;
        Tue, 06 Jun 2023 16:16:49 +0300
Date:   Tue, 6 Jun 2023 16:16:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <ZH8xwKuI9WqRUu5H@smile.fi.intel.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH7tsTmWY5b/4m+6@moroto>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 06, 2023 at 11:26:25AM +0300, Dan Carpenter wrote:
> The put_device() function will call serial_base_ctrl_release() or
> serial_base_port_release() so these kfrees() are a double free bug.

...

These labels are also called without device being even added.
So, this is not good enough as far as I can tell.

-- 
With Best Regards,
Andy Shevchenko


