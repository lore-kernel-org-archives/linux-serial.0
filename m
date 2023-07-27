Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C07C0015E
	for <linux-serial@archiver.kernel.org>; Thu, 27 Jul 2023 11:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjG0L6f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Jul 2023 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG0L6e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jul 2023 07:58:34 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F4272A;
        Thu, 27 Jul 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690459113; x=1721995113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hY+8uYrnEMl08IuoLtWPq8No+6FuLjDj9Prajmo6FTE=;
  b=jStp7on7UQ6lEuhRc33J7BIleKv5UeqG43/zO29Z8UQweHssMl0zRjDz
   Kgm8Bp00YqJKk3CPZtx8W4jAKDXABaofcIDQTZRtkYhvZWDCUy3Yu3NAc
   gNm3FHWWsE7bbYrnQi7WB6QHcQ3Hs/8XajA1jS/PKuTHrRtt3sidEg/ow
   MMDFEIDEF3p23cWeE1DwzF7PliIBhVPYQzmxUzxnX9NVwlm/AwtQ8f5ru
   95qbsKBUbAOysXNKU+xukW/g96rn61zQYskDpPIHzazssy/vwxkz32+c+
   dwcNq5fr9RHTbTHfRCsErkFcevlhiYsWx+Iu+ZI2aD/F8e0GOBt+Ift6o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="353185759"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="353185759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 04:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="704158257"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="704158257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2023 04:58:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOzdW-002kmz-1k;
        Thu, 27 Jul 2023 14:58:30 +0300
Date:   Thu, 27 Jul 2023 14:58:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Simplify uart_get_rs485_mode()
Message-ID: <ZMJb5lT5BjtSiflM@smile.fi.intel.com>
References: <20230726122335.14187-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726122335.14187-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 26, 2023 at 03:23:35PM +0300, Andy Shevchenko wrote:
> Simplify uart_get_rs485_mode() by using temporary variable for
> the GPIO descriptor. With that, use proper type for the flags
> of the GPIO descriptor.

It seems I will have more against serial core, perhaps it makes sense to unite
them in a single series.

-- 
With Best Regards,
Andy Shevchenko


