Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE4E7D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIURxR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjIURwu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 13:52:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059C43CAA;
        Thu, 21 Sep 2023 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316575; x=1726852575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j/e5kx3KtW0oiBzzN4+AezEayhJ5LGFpaU3KZp4ujsg=;
  b=k8SjMrjB4B/bqNJ8gPQQKiI3lu8QdSVRZVS0d8/V8UXu4dxNLwhuuUG3
   B4wsFLFbbnhMPu3WO1SDvyGtEivor+vZMJyj6EbrNNDCpL1JMSKE4x9tY
   jYqM8pmWjPRfZZmj622qVfBtPjMHH65iIYXyGihbDVrG2yN3+QkHivZ8M
   SWmCFvqSDB3fLZG0cr9y0dOdrqVXFTYsa5w4XGkpCETXQd7GUlDcVFLRb
   VS44T68Fj0cbz2hKOs5jq4tLTgAanDsSdBOm0XuNc4vB/811B4+xLvF6O
   uYpQcIhX5sOpuI/I33xV3/Ek++Qb3AfJbq+mxdBFsuTc57SiARBWCmJGG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444598202"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444598202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="837284511"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="837284511"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:30:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjHtD-0000000GsSk-2QdX;
        Thu, 21 Sep 2023 14:30:35 +0300
Date:   Thu, 21 Sep 2023 14:30:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Message-ID: <ZQwpWyWo3Pur7TEJ@smile.fi.intel.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
 <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
 <ZQwl+OXvhA6/x6f1@smile.fi.intel.com>
 <1165e159-62d1-4abd-88d7-b8eaeaf797df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165e159-62d1-4abd-88d7-b8eaeaf797df@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 21, 2023 at 01:21:46PM +0200, Jiri Slaby wrote:
> On 21. 09. 23, 13:16, Andy Shevchenko wrote:
> > On Thu, Sep 21, 2023 at 12:36:05PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 20/9/23 22:10, Wolfram Sang wrote:

...

> > > > -#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
> > > 
> > > I'm a bit surprised definitions are removed from the uAPI, isn't
> > > it expected to be very stable? Shouldn't it be better to keep it
> > > defined but modify the comment, mentioning "obsolete" or "deprecated"?
> > 
> > The numbers up to 20 must stay, they are being used somewhere, setserial
> > implementation in busybox (IIRC).
> 
> But they define it if we don't:
> #ifndef PORT_AR7
> # define PORT_AR7               18
> #endif

Yep, but the problem is that we may not use that number anyway, because two
different versions of kernel can clash on the same version of tool that will
think about AR7 while it's something different. That's why instead of having
reserved space, better to leave with names assigned.

> > NAK.
> I don't mind either way. But likely we should reserve the field if we go and
> remove it (setserial has a number->string mapping in busybox). Hm, then
> reserving it or keep it? Perhaps keep it is better... So ack the NACK :).

-- 
With Best Regards,
Andy Shevchenko


