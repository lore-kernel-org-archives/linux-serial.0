Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0AFC433ED
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDC4613B1
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhD3OWz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:22:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:32458 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233643AbhD3OWm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 10:22:42 -0400
IronPort-SDR: MzVU4T/8RWyoNW85L4hsniUSbFeV8zTrJ5HeRTnpnd92VdhE2P+ZQtl0wmkJRJNelFv5vR/aRn
 fRPVX5PuwREQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="194100812"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="194100812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 07:21:29 -0700
IronPort-SDR: FNVo5blX8sd1q0Ytx0H2GN/SyMLUegL2xLEixJMX11Tl++cHnQu9pce4pwNLbIrdbbM2W2lMli
 ku+0YGOtl9mg==
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="459453558"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 07:21:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lcU1E-008R4w-Or; Fri, 30 Apr 2021 17:21:24 +0300
Date:   Fri, 30 Apr 2021 17:21:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YIwSZGE76f2ZJyyf@smile.fi.intel.com>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
 <20210430114106.GF1981@kadam>
 <YIv92DBnaVotWd9Y@smile.fi.intel.com>
 <20210430133329.GH1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430133329.GH1981@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 30, 2021 at 04:33:29PM +0300, Dan Carpenter wrote:
> On Fri, Apr 30, 2021 at 03:53:44PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 30, 2021 at 02:41:06PM +0300, Dan Carpenter wrote:
> > > On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:

...

> > > Why would I make it unsigned?  As a static analysis developer,
> > > pointlessly unsigned variables are one of the leading causes for the
> > > bugs I see.
> > > 
> > > There are times where a iterator counter needs to be unsigned long, or
> > > u64 but I have never seen a case where changing an iterator from
> > > "int i;" to "unsigned int i;" solves a real life kernel bug.  It only
> > > introduces bugs.
> > 
> > See my followup to that, I meant
> > 
> > unsigned int count;
> > 
> > do {
> > 	...
> > } while (--count);
> > 
> > It doesn't solve bug, but prevents the code be read incorrectly like what you
> > are fixing can be avoided with do {} while (); along with unsigned type.
> 
> Why would you use an unsigned int for this???

Why it should be signed? You clearly show the amount of iterations. Check for
null I guess even compact in the assembly in comparison to -1.

I do not see any point why it should be signed. For what purpose?

It's a *down* counter.

-- 
With Best Regards,
Andy Shevchenko


