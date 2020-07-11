Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A022BC433E1
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AAB2075F
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGKNzh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:55:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:37296 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKNzg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:55:36 -0400
IronPort-SDR: RxlwBMj8Ml3xVBojiloCN/klavHr/xv5vmt8hi4R872E4uu8TvL1w7+N+YoqA/dgdhCHlYzT9j
 G6VtWo/o+qkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="146439062"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="146439062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:55:36 -0700
IronPort-SDR: uC8ttAo1xEOsPMPi0O6p3/g5T2S3Ysi1cMb5cqvlzSfLMy7Bp0S/x3mjIcEsMMiwP3VGaFP7go
 3KKnY36TvX9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="306870014"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2020 06:55:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1juFyZ-001FLr-80; Sat, 11 Jul 2020 16:55:35 +0300
Date:   Sat, 11 Jul 2020 16:55:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] tty: serial: owl: Initialize lock before registering
 port
Message-ID: <20200711135535.GW3703480@smile.fi.intel.com>
References: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
 <20200529113419.GA1631227@kroah.com>
 <20200710120549.GA11293@BV030612LT>
 <20200710133542.GA2172832@kroah.com>
 <20200710155806.GA10457@BV030612LT>
 <20200710163022.GT3703480@smile.fi.intel.com>
 <20200711063041.GC2784728@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711063041.GC2784728@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 11, 2020 at 08:30:41AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 10, 2020 at 07:30:22PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2020 at 06:58:06PM +0300, Cristian Ciocaltea wrote:
> > > On Fri, Jul 10, 2020 at 03:35:42PM +0200, Greg Kroah-Hartman wrote:

...

> > > however I'm a bit confused now regarding the recommended approach since
> > > there is at least one more commit in the tty-linux tree that still 
> > > handles a similar issue in the driver specific code:
> > > f38278e9b810 ("serial: sh-sci: Initialize spinlock for uart console")
> > 
> > They now should be reverted.
> 
> Please send patches for that :)

Just sent.

-- 
With Best Regards,
Andy Shevchenko


