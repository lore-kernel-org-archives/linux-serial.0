Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D1C83F2F
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjHaSIk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjHaSIj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 14:08:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08FE61
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693505316; x=1725041316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9r040TYKcCnPh6EOgNd0EOhsOIj6avPIBRQWR+9C0E=;
  b=eK0kC5iuK8mQ+Rgd7tvdWsdPM5z7UwgctqJim2aHmTBShgYt4EV1iGwk
   py5OAb06HniqLkg/aWyRLEt1BUc4BYt6ffjS4o5yu+pjQ1qlLhF0lCov3
   qzlDYPaKcqhFiDjGkpJLcUAJ8YvE6qp6piaJgAZHGlPqDGnVYBY44JouR
   6ovjVRknnlbxT8xN3SFSAYzNXjuM6QVWx094XjPO2nmwe80x6/g8eQNIm
   JMLgq2x4+06yhRD9JlHuQt06oP4O+U1VvtMxZsny7ZxmdJjn+W0f6nme3
   1Eq9ufijF/w2oj7/lirMQ0YcSAV7EBpfu2JU0JHw9PJCdd+oJvk6YMKBX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407018294"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="407018294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="742808609"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="742808609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:08:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbm5o-005TAA-0R;
        Thu, 31 Aug 2023 21:08:32 +0300
Date:   Thu, 31 Aug 2023 21:08:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 24, 2023 at 02:59:01PM -0600, Dan Raymond wrote:
> Implement a UART register tracing facility using the debugfs.  This can be
> used as a "serial port sniffer" to monitor UART traffic and line settings
> with timestamps at microsecond granularity.  This can be useful for general
> serial port debugging or to debug the UART driver itself.

>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++

My gosh. Why trace points and trace events can't be used for that?

-- 
With Best Regards,
Andy Shevchenko


