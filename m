Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD93C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F51861406
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 08:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhD3Isq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 04:48:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:50001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhD3Isp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 04:48:45 -0400
IronPort-SDR: G6VQlE2r2RQTPIQMOu8jR7uvFv8mffOxNGb/0DYlQwJYvV4WD8T1ikJhQwA+wsKCUXortDHQH5
 FmI7Lujh+Olg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197277334"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="197277334"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 01:47:57 -0700
IronPort-SDR: E4U978OvIrbtLI5TvgbCzg4M84QuzHEO7iKss4BvoA192lIR+5j/oWBzpcBE3YgG9hPATxbUGH
 qc172zTlNkUg==
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="459270154"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 01:47:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lcOoS-008NCh-O0; Fri, 30 Apr 2021 11:47:52 +0300
Date:   Fri, 30 Apr 2021 11:47:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YIvEODgGIMMek6uG@smile.fi.intel.com>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIvDz7hEhwm66R8G@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 29, 2021 at 04:02:15PM +0300, Dan Carpenter wrote:
> > On Thu, Apr 29, 2021 at 02:08:45PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 29, 2021 at 10:19:22AM +0300, Dan Carpenter wrote:
> > > > This loop ends on -1 so the error message will never be printed.
> > > > 
> > > > Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > ...
> > > 
> > > >  			       poll_count--)
> > > >  				cpu_relax();
> > > >  
> > > > -			if (!poll_count)
> > > > +			if (poll_count == -1)
> > > 
> > > Why not to change poll_count-- to --poll_count?
> > >
> > 
> > Either one is fine.  I considered several different ways and wrote the
> > patch twice.  The downside of --poll_count is that it's an off by one
> > in that the author clearly intended to loop 25 times.  It doesn't really
> > matter if we only loop 24 but off by ones are aesthetically unpleasant.
> 
> I didn't get. If you use --poll_count you get exactly 25 times and moreover,
> you may convert variable to unsigned type.

It seems I missed in the first message to mention that it is in association
with using do {} while (); model, which is more clear for wait loops.

-- 
With Best Regards,
Andy Shevchenko


