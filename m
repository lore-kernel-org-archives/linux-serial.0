Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710DC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 11:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbiDKLGH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbiDKLGG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 07:06:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0B44776
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649675028; x=1681211028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hef0Rvs2pZW/Io/0Qnl4QBytmvr3De5paC/D4xr6NRs=;
  b=F879labq1paLhz+TdEPNR6IeZmkaMK9Sx8ymRlpWM0ba1HdHW5+DHrNK
   6aToJDctez/27TLGMteR14PGY/f2sbf+a7aPc8QazSFts6nzgZJimWoOX
   7py7L2mM/Bfmgx4pP9KRpo2HncOT8KwQkvWFw6M/+eJwPMVGyzqL9br8w
   6jst/cNwxCl1I+d0BbalLDPVJWQTaike6PB01avlj5mibs/Xd+BUhiJmw
   ydYTWhL59kIxZqrLbCLuIJMTWYBAyvJIEhuKOP6YVDgI/pZBwcYge1TBg
   BQJOKsPVLn+Hl2+MPSt85QxYSXzlECiuvMacQhrC16VfmJ2kPU9Odx7mG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261833034"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261833034"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="589837968"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:03:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndrm8-001BfU-Rx;
        Mon, 11 Apr 2022 14:00:04 +0300
Date:   Mon, 11 Apr 2022 14:00:04 +0300
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
Message-ID: <YlQKNF0OORYQtvaZ@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-2-ilpo.jarvinen@linux.intel.com>
 <YlQIYatkKoeLekFJ@smile.fi.intel.com>
 <YlQJWHVTMeN2YsPA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlQJWHVTMeN2YsPA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 01:56:24PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 11, 2022 at 01:52:18PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 11, 2022 at 11:33:10AM +0300, Ilpo Järvinen wrote:
> > > Struct uart_port currently stores FIFO timeout. Having character
> > > timing information readily available is useful. Even serial core
> > > itself determines char_time from port->timeout using inverse
> > > calculation.
> > > 
> > > Store frame_time directly into uart_port. Character time is stored
> > > in nanoseconds to have reasonable precision with high rates.
> > > To avoid overflow, 64-bit math is necessary.
> > > 
> > > It might be possible to determine timeout from frame_time by
> > > multiplying it with fifosize as needed but only part of the
> > > users seem to be protected by a lock. Thus, this patch does
> > > not pursue storing only frame_time in uart_port.
> 
> ...
> 
> > > -	char_time = (port->timeout - HZ/50) / port->fifosize;
> > > -	char_time = char_time / 5;
> > > -	if (char_time == 0)
> > > -		char_time = 1;
> > > +	char_time = max(nsecs_to_jiffies(port->frame_time / 5), 1UL);
> > > +
> > >  	if (timeout && timeout < char_time)
> > >  		char_time = timeout;
> > 
> > Seems it can be packed to something like
> > 
> > 	char_time = min_not_zero(nsecs_to_jiffies(port->frame_time / 5), timeout);
> > 
> > ?
> 
> Actually:
> 
> 	char_time = min_not_zero(timeout, nsecs_to_jiffies(port->frame_time / 5));
> 
> Ah, either way it would still miss the case when both == 0. So, we need
> something like minmax3_not_zero, where 1UL is implied argument. Probably
> a suggesting for the future, since here it doesn't make much sense to
> introduce.

In case somebody goes for it:

#define minmax_not_zero(x, y)	(min_not_zero(x, y) ?: 1)

-- 
With Best Regards,
Andy Shevchenko


