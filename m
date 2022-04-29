Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E341C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 07:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355093AbiD2HXQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355098AbiD2HXP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 03:23:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D4BF958
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651216798; x=1682752798;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IPZ6T+T0q2WCVpS2dpjPbUGQ2Nv5r5LYHg6nnqSmcWI=;
  b=YCEIX0t8wRN9HcPa7RyTo4C5N2r0zJ65KQEkPA6/8I8LodlBir6HzZD3
   KlX6YF7ZRZ4QVofufJeXfXhsC17bDmvnB+Y4dDylVm+nzueEGgJ5YLFHN
   1h5KEkQ1ChHzR9R/pRvLylqBubneuOQfD+Xx8uAuW1cZZPoaLRpAbWzg4
   YpGPY5t58jX2IDrRLtYqK7X/pedXhXHvwVywYpXb5tQv6lcGqD9aklpIN
   OIw5/PdJX0JBAvjCB6ooPIbH581z6KzT9AzIlqeo4fYnbZWGjja8+a5wh
   zCVeTsNNIo48elHOt7U9lmlEsZ/7RkSsICWqrYQ6hskgtb0tAT0jY8zlA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="327054198"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="327054198"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581953765"
Received: from iboscu-mobl2.ger.corp.intel.com ([10.249.33.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:19:40 -0700
Date:   Fri, 29 Apr 2022 10:19:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tomasz Mon <tomasz.mon@camlingroup.com>
cc:     "nunojpg@gmail.com" <nunojpg@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [RFC PATCH] serial: Don't assume uart_ops .throttle is always
 set
In-Reply-To: <d16634147375cbebad48b143974432e0f40f842d.camel@camlingroup.com>
Message-ID: <717acce-e7c-559-863d-947b15fe4170@linux.intel.com>
References: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com> <d16634147375cbebad48b143974432e0f40f842d.camel@camlingroup.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1107659089-1651215841=:1616"
Content-ID: <fe35376f-3ce3-3e23-f093-2d76d1c1f1e6@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1107659089-1651215841=:1616
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <bf3257b6-c93e-792-3122-83518fe9ce8d@linux.intel.com>

On Fri, 29 Apr 2022, Tomasz Mon wrote:

> On Thu, 2022-04-28 at 20:11 +0300, Ilpo Järvinen wrote:
> > uart_throttle() assumes that a driver provides a throttle function in
> > uart_ops. But not all drivers do and there seems to nothing in
> > serial_core that would set it either. Thus, check it before calling.
> 
> If the driver does not provide throttle function, it should not
> set UPSTAT_AUTORTS nor UPSTAT_AUTOXOFF in port->status.
> 
> > diff --git a/drivers/tty/serial/serial_core.c
> > b/drivers/tty/serial/serial_core.c
> > index 6a8963caf954..18c9d46e0b85 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -697,7 +697,8 @@ static void uart_throttle(struct tty_struct *tty)
> >  		mask |= UPSTAT_AUTORTS;
> >  
> >  	if (port->status & mask) {
> 
> This if condition is always false if driver did not set UPSTAT_AUTORTS
> nor UPSTAT_AUTOXOFF in port->status.
> 
> > -		port->ops->throttle(port);
> > +		if (port->ops->throttle)
> > +			port->ops->throttle(port);
> >  		mask &= ~port->status;
> >  	}
> > 
> 
> I think this patch is incorrect. The assumption is not ".throttle is
> always set" but rather ".throttle is set when UPSTAT_AUTORTS or
> UPSTAT_AUTOXOFF is set".

Right, I kind of ended up concluding that's likely the case after sending 
the patch when looking into 9aba8d5b0111 (SERIAL: core: add 
throttle/unthrottle callbacks for hardware assisted flow control).


-- 
 i.
--8323329-1107659089-1651215841=:1616--
