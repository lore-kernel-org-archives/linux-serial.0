Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39273C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A492070B
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgFJQVe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:21:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:33566 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgFJQVe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 12:21:34 -0400
IronPort-SDR: /hWSNAZ1V/Bb3e+3vSbp6HE23KMk2BwXjAzI6juFhwPi7sZgw3j+rsRzveFPj4odl3uMlH3Cew
 b8kHhisFLk/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 09:21:33 -0700
IronPort-SDR: zXc11fw1SDgbKQqg58p2/lhta0NhpdBi0rRZyZQOnfkheJ45W7DNcIACtkPWcrqK5Z7Gx+Hqje
 EdHx3hDjIiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="418796692"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2020 09:21:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jj3Tq-00CAuX-0e; Wed, 10 Jun 2020 19:21:34 +0300
Date:   Wed, 10 Jun 2020 19:21:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: core: fix up sysrq regressions
Message-ID: <20200610162134.GL2428291@smile.fi.intel.com>
References: <20200610152232.16925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610152232.16925-1-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 10, 2020 at 05:22:29PM +0200, Johan Hovold wrote:
> This series fixes a few regressions introduced by the recent sysrq
> rework that went into 5.6.
> 
> The fix for the unnecessary per-character overhead probably could have
> been marked for stable but I left that decision to the maintainers as it
> is a bit intrusive (although mostly shuffling code around).

I see a problem, thanks for pointing out!
The fix LGTM! FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Johan
> 
> Changes in v2
>  - inline uart_unlock_and_check_sysrq() along with the other helpers
>    (restoring the interrupt state in a helper was never an issue)
> 
> 
> Johan Hovold (3):
>   Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
>   serial: core: fix sysrq overhead regression
>   serial: core: drop redundant sysrq checks
> 
>  drivers/tty/serial/serial_core.c |  96 +----------------------------
>  include/linux/serial_core.h      | 102 +++++++++++++++++++++++++++++--
>  2 files changed, 100 insertions(+), 98 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


