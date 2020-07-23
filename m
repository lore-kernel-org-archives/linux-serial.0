Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B336C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BE92086A
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 13:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGWNW6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:22:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:29787 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgGWNW5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 09:22:57 -0400
IronPort-SDR: J30BYzvvgLMENviJEZRXkbsq12x4R6rWRdVbvdXfVRHv1/lmyRKY3krnsXZT3QhY8unrd1TspF
 EvoyBgyoSZJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="212059114"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="212059114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 06:22:56 -0700
IronPort-SDR: 4GO0K6O/fAszS773o7NEpcOAj7DizHFTQKjcLN5fA0k2A2aTmjSdUbwuYtzJneptBZbbkmgh9t
 iHd3vWCNkkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="272294139"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 06:22:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jybBX-003e7x-Kb; Thu, 23 Jul 2020 16:22:55 +0300
Date:   Thu, 23 Jul 2020 16:22:55 +0300
From:   andriy.shevchenko@linux.intel.com
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] serial: add sparse context annotation
Message-ID: <20200723132255.GA869178@smile.fi.intel.com>
References: <20200723123327.5843-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723123327.5843-1-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 23, 2020 at 02:33:25PM +0200, Johan Hovold wrote:
> The Intel test robot reported a new sparse warning in pmac_zilog, which
> wasn't actually new.
> 
> Add sparse annotation to the two drivers that release and reacquire the
> port lock in their receive handlers to suppress these warnings.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Johan
> 
> Changes in v2:
>  - let's use the right context expression even if sparse doesn't seem to
>    care (add the missing ampersand)
> 
> 
> Johan Hovold (2):
>   serial: pmac_zilog: add sparse context annotation
>   serial: msm_serial: add sparse context annotation
> 
>  drivers/tty/serial/msm_serial.c | 2 ++
>  drivers/tty/serial/pmac_zilog.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


