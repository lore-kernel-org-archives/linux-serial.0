Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FEEC46CA1
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbjIRI1R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbjIRI0m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 04:26:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D81AC
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695025581; x=1726561581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vj5zOPNBXIg9IMpMq0U/ppwlP/wRv/upuNl65pLyGLs=;
  b=dSJ5F79zKRK4gXMF1Cismf8gAgdbah/y/MingWBtVYZH6yvxLA/n3emg
   828OsBVSP1AKvYN1QEh57LkxjkM4Y4HIbUQ8cbUIInafdanquwOKJNgwR
   4msAJ7pRQRwIg1Q21Gz+oVv6Bd3MK6b/m8B4MFXyTxIqd9qbP++KgRbhE
   HxH2G0TjrIA15rf0RKA6pvozzD71MJQxmAKC5tWXFpnU6AuydY5RxLuWR
   Nv1x0R9NTZETZwbu5mEoc4wcaQ7chahPY3Pjr58fvrr2bNJOjfGkGrkyT
   JzfTjNws/LIQQetqYi/8aAL9FGkmBEJp5lAdxsPVQnEV7iY1GkFw7MG/y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383419641"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383419641"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="739038121"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="739038121"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:26:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qi9aB-0000000GSNn-2NjY;
        Mon, 18 Sep 2023 11:26:15 +0300
Date:   Mon, 18 Sep 2023 11:26:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <ZQgJp0AkHBvYH+es@smile.fi.intel.com>
References: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com>
 <ZQNZJwJoad0EkIYL@smile.fi.intel.com>
 <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 03:51:26PM -0400, Matthew Howell wrote:
> On Thu, 14 Sep 2023, Andy Shevchenko wrote:
> > On Thu, Sep 14, 2023 at 08:28:47AM -0400, Matthew Howell wrote:
> > > From: Matthew Howell <matthew.howell@sealevel.com>
> > >
> > > Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.
> > 
> > Too long line.
> > 
> > > Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> > >
> > > This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> > >
> > > Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
> > > Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > 
> > The patch 1 and patch 2 have not been linked via email, so mail archives and
> > mail clients do not see this as a thread. I suggest to use `git send-email` for
> > patches. With --thread option (which I believe should be default) it chains
> > the mails it sends.
> 
> I have not seen any way to setup git send-mail with this email as git 
> send-email seems to lack OAUTH2. If you can set it up with OAUTH2 & O365  
> I have not been able to find any documentation or guides on how to do 
> this.

We have O365 at the company, but git send-email works transparently. Perhaps
you have to talk to the IT in yours.

For reading messages we are using email-oauth2-proxy python script (you may
find it on GitHub), it can also be configured for SMTP (in my case only IMAP is
in use).

-- 
With Best Regards,
Andy Shevchenko


