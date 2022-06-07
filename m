Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB558C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiFGOqR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiFGOqQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 10:46:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5950033;
        Tue,  7 Jun 2022 07:46:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="302086240"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="302086240"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:46:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="532634778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:46:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nyaTB-000VmS-MK;
        Tue, 07 Jun 2022 17:46:09 +0300
Date:   Tue, 7 Jun 2022 17:46:09 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] serial: 8250: Adjust misleading LSR related
 comment
Message-ID: <Yp9ksSTrFb+11d7h@smile.fi.intel.com>
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
 <20220607082934.7242-5-ilpo.jarvinen@linux.intel.com>
 <CAHp75VfK4v15HrBwwD9b7q6EYdcp3VnP5RGKVuPeSWk4TSyq+w@mail.gmail.com>
 <e22db21a-cfc3-b7e4-3fd9-6cee9e189213@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e22db21a-cfc3-b7e4-3fd9-6cee9e189213@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 07, 2022 at 03:11:32PM +0300, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Andy Shevchenko wrote:
> > On Tue, Jun 7, 2022 at 11:16 AM Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:

...

> > >   https://www.spinics.net/lists/linux-serial/msg20555.html

> > Can it be transformed to lore.kernel.org link?
> 
> Unfortunately no, AFAICT. I tried searching but I couldn't find one
> from there (In fact, I tried even before submitting them because you
> previously told me I should use lore links instead).
> 
> More importantly though, it seems that the link was not the one I was
> supposed to use (I probably copy pasted the url from a wrong window while
> investigating all turns of it). This is the correct link:
> 
>   https://www.spinics.net/lists/linux-serial/msg16220.html

Indeed, that discussion by some reason is not in the lore archive.

...

> I put the correct URL now into Link tag.
> 
> I'll resend tomorrow to give the dust some time to settle.

Fine with me, thanks!

-- 
With Best Regards,
Andy Shevchenko


