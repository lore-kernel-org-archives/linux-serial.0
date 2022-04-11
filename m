Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38884C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 11:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbiDKLEY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiDKLCf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 07:02:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E924504A
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649674814; x=1681210814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jYgo/pskezyKWbM20xhS/s9H18em5qzPlsxzrjkorgc=;
  b=eF1gKpBfmkz/LqCoHitxyYNHD5Vg1UhjiCoYsvQuPmjIhDKY8IITSCgs
   B34XCXaxDQHU/tWQgvsYaZo7E5YnooWZ0oxZ5txv3cOylNKOHlcWieFGQ
   boe8B96dbAwPjUI4IkeXwR5LA4g+0v416BWfBp9OxAsG7lfwyAAkZMImu
   vhaXsWcEuthMhklAtRhuE27pJOCDqHGg/93MXHIcLWUodhILKWiu2ftvi
   Hlo2RKaAlYl+EbN4BH7rxssiCX6V/Vs81MMLq1GekkqoOcnfwgOgheVqo
   9a6JA5XOsmxLJ7/fZXuu7H1KQZiZzvSXyGVYGDc6Y5zqRzKYfmcJege81
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261832371"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261832371"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:00:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="644040267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:00:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndria-001BcR-FW;
        Mon, 11 Apr 2022 13:56:24 +0300
Date:   Mon, 11 Apr 2022 13:56:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 01/12] serial: Store character timing information to
 uart_port
Message-ID: <YlQJWHVTMeN2YsPA@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-2-ilpo.jarvinen@linux.intel.com>
 <YlQIYatkKoeLekFJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlQIYatkKoeLekFJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 01:52:18PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 11, 2022 at 11:33:10AM +0300, Ilpo Järvinen wrote:
> > Struct uart_port currently stores FIFO timeout. Having character
> > timing information readily available is useful. Even serial core
> > itself determines char_time from port->timeout using inverse
> > calculation.
> > 
> > Store frame_time directly into uart_port. Character time is stored
> > in nanoseconds to have reasonable precision with high rates.
> > To avoid overflow, 64-bit math is necessary.
> > 
> > It might be possible to determine timeout from frame_time by
> > multiplying it with fifosize as needed but only part of the
> > users seem to be protected by a lock. Thus, this patch does
> > not pursue storing only frame_time in uart_port.

...

> > -	char_time = (port->timeout - HZ/50) / port->fifosize;
> > -	char_time = char_time / 5;
> > -	if (char_time == 0)
> > -		char_time = 1;
> > +	char_time = max(nsecs_to_jiffies(port->frame_time / 5), 1UL);
> > +
> >  	if (timeout && timeout < char_time)
> >  		char_time = timeout;
> 
> Seems it can be packed to something like
> 
> 	char_time = min_not_zero(nsecs_to_jiffies(port->frame_time / 5), timeout);
> 
> ?

Actually:

	char_time = min_not_zero(timeout, nsecs_to_jiffies(port->frame_time / 5));

Ah, either way it would still miss the case when both == 0. So, we need
something like minmax3_not_zero, where 1UL is implied argument. Probably
a suggesting for the future, since here it doesn't make much sense to
introduce.

-- 
With Best Regards,
Andy Shevchenko


