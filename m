Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D0C77B6E
	for <linux-serial@archiver.kernel.org>; Fri, 14 Apr 2023 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjDNRHs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNRHr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Apr 2023 13:07:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAF12F;
        Fri, 14 Apr 2023 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681492066; x=1713028066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GBoNCViOEvk6woG7iq2pnj+UK5lo70w24v6Gu/PxKA0=;
  b=hl55Ouq+lFG1MGwxu7G3UOZNoV76W7pKLygPnyMiyaQ3YV/7pRZ0yZ53
   PE3swiFpVUefTSf/ctxOJjeEQ8p3g6xGepqiwaZvwN4FAq+MIVJSyh/tI
   x+kkMYOltTRc6Ym7fFG3fMO11ZYZ0YomlQ/IaTKjux1WoWdjELgcq1Zjk
   Z8bBMWWBRL4of++L0mb0nyWD2c7xoFEyTzuknODBSJx87RrKWtNcX1wdr
   2rQHqVCrK1NRdPoTOxih15Wx54WTJYlOs3FosxYZzDHzD+Bwx4ILgcJx2
   35PDSZ+1BXOwB+PJT7FYAp1sGAxrJGbJmKxAHLuDYsKxF33rknMb6XWXM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324142458"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="324142458"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="692496616"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="692496616"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2023 10:07:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pnMtj-00HDNV-0q;
        Fri, 14 Apr 2023 20:07:43 +0300
Date:   Fri, 14 Apr 2023 20:07:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250_exar: Use PCI_DEVICE_DATA macro directly
Message-ID: <ZDmIXoARLYXb8k9z@smile.fi.intel.com>
References: <20230413214421.6251-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413214421.6251-1-afd@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 13, 2023 at 04:44:20PM -0500, Andrew Davis wrote:
> The EXAR_DEVICE macro was converted to use PCI_DEVICE_DATA, having
> this macro at doesn't add much, remove it.

I'm not against this, but I have to point out that this patch brings
inconsistency into the table. Either convert all, or none, I think.

That's why the patch that converts EXAR_DEVICE() to use PCI_DEVICE_DATA()
had a little intrusion.


-- 
With Best Regards,
Andy Shevchenko


