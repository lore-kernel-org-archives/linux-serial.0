Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E2EC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 12:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiD2MgZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346257AbiD2MgY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 08:36:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9FC90E9
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651235586; x=1682771586;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pjRZBl/psMQeo1QmM+XU1/ZJ3sSGZRRCPpizH9qrJ0s=;
  b=YKEDAPC9pMT4herR6eWsUsg0PBavTj0fFm0Pw43VVw8GQ60bmA7LOlod
   af30BAqXts5Ey87+LVZNaw8jXvjllPN4W+qaKwyi2hD7P+ctTjnsMdxhy
   /NNvgwrW0/eI9iJnK2j0tbcqzDHKFEO7M9fdn//Wqj8H+msl/Wasli0bm
   B5aPjFOI3ftC8HU7d+eDHGAObXPK3BFRCSEcolvEUnkIXOg7YBz5dZXqC
   7gD2rsDKJYrBx/u8EbQ5WgUxmqFt15fltJ8qfmjb9H0aYGhAbBHzci6/X
   C3gbdcoOVQPBpCX47JYQ874JNo0wcx3w0XGHnqaA3Z9GmI/z3p29R7r7X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266159220"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266159220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="582103563"
Received: from iboscu-mobl2.ger.corp.intel.com ([10.249.33.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:33:03 -0700
Date:   Fri, 29 Apr 2022 15:33:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>,
        Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
In-Reply-To: <YmvWFQultpccovgb@kroah.com>
Message-ID: <3f44e8d-3d2d-db4e-6cfc-67ec5824c289@linux.intel.com>
References: <d4f254ec-b73-786c-dc47-629aab8a49df@linux.intel.com> <YmvWFQultpccovgb@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1342475657-1651235584=:1616"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1342475657-1651235584=:1616
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 29 Apr 2022, Greg KH wrote:

> On Fri, Apr 29, 2022 at 02:57:16PM +0300, Ilpo Järvinen wrote:
> > The driver must provide throttle and unthrottle in uart_ops when it
> > sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> > enable_interrupts functions.
> > 
> > Compile tested (w/o linking).
> 
> That shouldn't be here at all, put it below the --- line if its needed.
> 
> 
> > 
> > Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> > Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
> > 		     RTS status)
> 
> Nit, this should be all in one line.
>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Any reason why you are not cc:ing all the needed people as per
> scripts/get_maintainer.pl?

Yes there is ;-). Around here I'm being told that I should generally
avoid as much as possible bugging you unnecessarily. ...Or sending garbage
to you which I feel a compile tested patch for hw I'm not particularly 
familiar with surely could be. After all this should be tested first and 
then I'd be resending another version with Tested-by: xx Cc'ing you
and you would avoid all those intermediate garbage versions :-).


-- 
 i.

--8323329-1342475657-1651235584=:1616--
