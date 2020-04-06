Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BDCC2BA19
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346C20678
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDFKw1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:52:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:52283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDFKw1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:52:27 -0400
IronPort-SDR: mAgSOo+e6hQiR9xOIMlJyY1utSAaO0DSumuaiCdWMnZxbXItcjrN5Rh2rSNDQaJkleQnUlxgZg
 EJ+XtSR1skJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 03:52:27 -0700
IronPort-SDR: 3iO8vEClobRDdW9tOWuf47BYkZUXI19mvjxa1J8lgAFzmykLZlvxW9Plc1iPXPu3mRYpxosP6B
 uP4zeP3uNRkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="424316506"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2020 03:52:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jLPMh-00G9kw-A5; Mon, 06 Apr 2020 13:52:27 +0300
Date:   Mon, 6 Apr 2020 13:52:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered
 console
Message-ID: <20200406105227.GP3676135@smile.fi.intel.com>
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
 <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Apr 04, 2020 at 08:50:56PM +0300, Anatoly Pugachev wrote:
> On Thu, Apr 2, 2020 at 8:20 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The commit a3cb39d258ef
> > ("serial: core: Allow detach and attach serial device for console")
> > changed a bit logic behind lock initialization since for most of the console
> > driver it's supposed to have lock already initialized even if console is not
> > enabled. However, it's not the case for Sparc HV console.
> >
> > Initialize lock explicitly in the ->probe().
> >
> > Note, there is still an open question should or shouldn't not this driver
> > register console properly.
> >
> > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > Cc: David Miller <davem@davemloft.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/tty/serial/sunhv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> 
> fixes issue for me, sorry for the late testing

Thank you! Can you formally provide a Tested-by tag?

-- 
With Best Regards,
Andy Shevchenko


