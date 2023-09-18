Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5747C46CA1
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 08:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjIRIcG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbjIRIbl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 04:31:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5411B1
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695025875; x=1726561875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8NA8jtzr2FmbknA4LLZSgawAm0ougemGoRnJx18Yzk=;
  b=KYeJEVvjuAQae3cDAHtuz4WgiX23vgi8tFPv7oQ8Cn0qTVeJnFG1WdGS
   G7zJhIVFdvmp07LzJsSNKKoCpro9qpXkGGjUCmSjlvRq1LhTMlFMNslEa
   Z4grV4p+EE61baQjH0X6d8MHlqTnn5dkM5WaDwZVLGAlBdx1wAVYCM5Iv
   /ofECRfCmPK5j1ZujV1wpGY6m/Z+nJoBm6cMuSo3b1qzi0+g4uu/UHRGT
   M5sahwa8v1IqxfD7j2x2kx4wRREUjmRt/3CzTGUFI37Mbog3dH8HxPJJ6
   e8kLnMNrVAbimzVeT0iOL6KxNKWpuFnijaEOQzy0zKmOfnxKdgHNXeVoa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383420485"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383420485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="775052865"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775052865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:31:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qi9ex-0000000Gc7B-2KIC;
        Mon, 18 Sep 2023 11:31:11 +0300
Date:   Mon, 18 Sep 2023 11:31:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] tty/serial: port I/O tracing on x86
Message-ID: <ZQgKz/s+x1XJs3Xb@smile.fi.intel.com>
References: <ec734abb-6d3c-69ec-c3e5-cb21b8829264@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec734abb-6d3c-69ec-c3e5-cb21b8829264@foxvalley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 15, 2023 at 07:16:44PM -0600, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.

Thanks, I believe this should be done to all archs that support port I/O
(ppc?).

Codewise looks okay to me, thanks for doing that!

(Perhaps Suggested-by?)

-- 
With Best Regards,
Andy Shevchenko


