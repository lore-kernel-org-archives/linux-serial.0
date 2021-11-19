Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5154C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C03C60E93
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 08:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhKSI0j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:26:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:65390 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhKSI0j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 03:26:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234616335"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234616335"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:23:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="673130433"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:23:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnzBB-008TOl-Dh;
        Fri, 19 Nov 2021 10:23:29 +0200
Date:   Fri, 19 Nov 2021 10:23:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
Message-ID: <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> > Split Pericom driver to a separate module.
> > While at it, re-enable high baud rates.
> > 
> > Jay, can you, please, test this on as many hardware as you have?
> > 
> > The series depends on the fix-series: https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u

> I have my current state here: https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c
> 
> * Change port type to UPIO_PORT
> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
> stick.

Thanks, I have updated my local tree with these changes.

> When I'm testing baud rates greater than baud_base I'm seeing strange things
> on the scope.

Can you confirm that there are no issues with the first (fixes) series?
I have slightly changed your set_divisor() refactoring, it may be that issue
is there.

> Maybe I'm just tired, and it's human error. I should be able
> to get back to it and get it done on Saturday.

Thank you.

-- 
With Best Regards,
Andy Shevchenko


