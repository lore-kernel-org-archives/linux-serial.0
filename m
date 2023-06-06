Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B85C77B7A
	for <linux-serial@archiver.kernel.org>; Tue,  6 Jun 2023 13:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjFFNRX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238073AbjFFNRW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Jun 2023 09:17:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95858126;
        Tue,  6 Jun 2023 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686057441; x=1717593441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3unk0aogg1D3yycwO10ZC4P3s2sKT8wqZK+rZGr50jM=;
  b=NHLUPjz5C+HoKhtqYv6Qo+r2+SOdOQHms6AyqBAx6h3gaJLlRSPVaqer
   CjhKDyw0OykKL0CPkDme7BrvqKXThq3o/HqE+q43qFa/l2wGyA+4lMoaM
   di996zljx7GYy44GbHeSKxAwr1SnAtnNAb0hTj6kKZsMRgIszjl/khST+
   psYqetLJuERHa7uFefvbg3Zt4vRTjBLUXM213qWMJ387mYQICLCdnObsx
   T6mpQM5gsseHZ0Kxw8+U/b0PkqUBTcbN5qn+6OPGVSqV8wACWrH1TF75Y
   Qna5491zBb+BJ55JxxOTnxwSomDPwsj2+8V4PJZPKqvjiXbNgCN6qQyuR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336292255"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336292255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853426084"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853426084"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2023 06:17:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6WYo-001dc3-0l;
        Tue, 06 Jun 2023 16:17:18 +0300
Date:   Tue, 6 Jun 2023 16:17:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: core: don't kfree device managed data
Message-ID: <ZH8x3eNGB6DBg96L@smile.fi.intel.com>
References: <ZH7tsTmWY5b/4m+6@moroto>
 <20230606122843.GJ56720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606122843.GJ56720@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 06, 2023 at 03:28:43PM +0300, Tony Lindgren wrote:
> * Dan Carpenter <dan.carpenter@linaro.org> [230606 08:26]:
> > The put_device() function will call serial_base_ctrl_release() or
> > serial_base_port_release() so these kfrees() are a double free bug.
> > 
> > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Thanks for catching it:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Be careful, we can now get memory leaks :-)

-- 
With Best Regards,
Andy Shevchenko


