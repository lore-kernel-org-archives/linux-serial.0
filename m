Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A383CD37B0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjIRIeO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbjIRIeB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 04:34:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79C11F
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695026025; x=1726562025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AJop6ANx+5r8U0chpRLoGhnJAY034+hGFCIbsQDlLrI=;
  b=bkgFlljw+U25TwXPrWpmRjVk37hEh4cK87quZvAN3MKiKaEXjoGH/osN
   gbjCA6j5Zlh0jkJrFWSTaSIsMmLXCv1ApPdYbmBxwbI/zoCMLZVR62aLd
   HnFTkLD28+lXAxERL034Tjhqy/aPEYjROMpjdj4GCl2FzEvjT5FMnRkiL
   lm9iMVbpT6OElRVw8z+B3EpI/ahoiuZzaN5pF7jVgFGKDjasdTZRJHcLK
   VLkZPUXCSG8k2NdG67s4gIRKdLx9kQ7oui6uLEXO/L21XrBWf2Z00Ppd/
   PBBAIyaBBgZLtmN4qKapDxDJCa6AM8ZoTJdDmyjMxSrciMb7h/S5pxhPF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364640370"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364640370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860975806"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="860975806"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:33:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qi9hM-0000000Gh9i-0ZDv;
        Mon, 18 Sep 2023 11:33:40 +0300
Date:   Mon, 18 Sep 2023 11:33:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <ZQgLY7WAkc20KleJ@smile.fi.intel.com>
References: <515ad583-5692-d4e0-6fee-cd242dd422b1@foxvalley.net>
 <80762c3a-2192-5384-8960-6b1cb54cab94@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80762c3a-2192-5384-8960-6b1cb54cab94@foxvalley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 15, 2023 at 06:04:17PM -0600, Dan Raymond wrote:
> I took Andy Shevchenko's suggestion and added port I/O tracing in
> a similar manner as the memory-mapped I/O tracing enabled with
> CONFIG_TRACE_MMIO_ACCESS.  I'll be submitting another patch for
> that shortly.  It works well and it provides another way to trace
> UART register accesses.  For most purposes it is probably superior to
> the method used in this patch because it leverages the existing kernel
> tracing framework.
> 
> However, this patch might still be useful for debugging issues that
> are sensitive to timing because it uses less CPU resources.  It also
> uses less memory so a larger trace can be collected.  I did some more
> timing analysis and tried to minimize the impact of cache misses by
> reading the MSR register 100 times in a loop.  I added this test to
> serial8250_do_get_mctrl() and ran 'cat /proc/tty/driver/serial' to
> exercise the test.  Here are the results (trace overhead is measured
> in CPU cycles at 1GHz):
> 
> overhead   method
> --------   ------------------------------------------
>        0   serial_debugfs disabled
>      158   serial_debugfs enabled without pipe reader
>      367   serial_debugfs enabled with pipe reader
> 
>        2   portio_tracefs disabled
>      461   portio_tracefs enabled but filtered
>      713   portio_tracefs enabled and collected
> 
> I made a few changes to v4 of this patch to support pipe semantics
> similar to how /sys/kernel/tracing/trace_pipe works.  You can now get
> unlimited trace depth by piping the trace buffer to disk as follows:
> 
> cat /sys/kernel/debug/ttyS1/trace_pipe > trace.txt &
> 
> The 'cat' process will run in the background and it will terminate
> when tracing is disabled.  This doesn't come for free, however.  The
> wake_up() call adds a fair amount of overhead when a pipe reader is
> present as you can see in the measurements above.

Thanks!

In my opinion this work is good to have published, but still doesn't warrant
to be part of the Linux kernel with the other method being worked.

Let's hear others' opinions, though...

-- 
With Best Regards,
Andy Shevchenko


