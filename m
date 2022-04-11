Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8FC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 10:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiDKK6Q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiDKK6P (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 06:58:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF263B2A8
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649674561; x=1681210561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3XS+zMt/2GJSDWFAnh7v6Du9fAG72B3xZKxzLdCY/Gc=;
  b=ep2OT0YKbv/N2dMkuRN00svO+dgl7lirTquRLQXzR3kpNrO37RpUkJhM
   aI03hpWox/Xtp7U7p4JvQEEl7IxEW4LErKQhAvEuEh0GkQZpEUzDGrsLP
   8tLtJb65ScqJRn3oJx+QBefCJ049lsJwFkujr5EOWVt6va9KoscBgskDQ
   Xy/MRS718KLL9WCsu1TKue2l+ePfG24bmfCqfUdTymbMpf0vz57onsX7+
   8D4lbLx+/VDs58RhhiKh7XKqyu99BdAmc0SkklfpF9EnaHPL4cmD8Ivgd
   rXs1Se1KHXwls4DpPLAVm3wvT6DVtoYZHh8SFZdDY0Vz7lgtcn6VxRWO6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243971679"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="243971679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:56:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525479515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:55:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndrec-001BZ7-6Q;
        Mon, 11 Apr 2022 13:52:18 +0300
Date:   Mon, 11 Apr 2022 13:52:17 +0300
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
Message-ID: <YlQIYatkKoeLekFJ@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411083321.9131-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 11:33:10AM +0300, Ilpo Järvinen wrote:
> Struct uart_port currently stores FIFO timeout. Having character
> timing information readily available is useful. Even serial core
> itself determines char_time from port->timeout using inverse
> calculation.
> 
> Store frame_time directly into uart_port. Character time is stored
> in nanoseconds to have reasonable precision with high rates.
> To avoid overflow, 64-bit math is necessary.
> 
> It might be possible to determine timeout from frame_time by
> multiplying it with fifosize as needed but only part of the
> users seem to be protected by a lock. Thus, this patch does
> not pursue storing only frame_time in uart_port.

...

> -	char_time = (port->timeout - HZ/50) / port->fifosize;
> -	char_time = char_time / 5;
> -	if (char_time == 0)
> -		char_time = 1;
> +	char_time = max(nsecs_to_jiffies(port->frame_time / 5), 1UL);
> +
>  	if (timeout && timeout < char_time)
>  		char_time = timeout;

Seems it can be packed to something like

	char_time = min_not_zero(nsecs_to_jiffies(port->frame_time / 5), timeout);

?

-- 
With Best Regards,
Andy Shevchenko


