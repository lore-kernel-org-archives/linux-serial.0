Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC346C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhKVMvn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:51:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:26794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhKVMvm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 07:51:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="258597079"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="258597079"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:48:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="456626505"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:48:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mp8kI-009Qzu-2a;
        Mon, 22 Nov 2021 14:48:30 +0200
Date:   Mon, 22 Nov 2021 14:48:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
Message-ID: <YZuRnSaZz04KJIDk@smile.fi.intel.com>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZuRV8ipjcly26HB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZuRV8ipjcly26HB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 02:47:20PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
> > On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> > > Split Pericom driver to a separate module.
> > > While at it, re-enable high baud rates.
> > > 
> > > Jay, can you, please, test this on as many hardware as you have?
> 
> ...
> 
> > * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
> > stick.
> 
> Can't find an evidence that this is the case. Can you recheck this (reading
> flags back via sysfs or so)? So, for v2 I'll leave my approach.

Otherwise how the other drivers which are using that flag survive? If it's
indeed an issue, it should be fixed on generic level.

-- 
With Best Regards,
Andy Shevchenko


