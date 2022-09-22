Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D951C54EE9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 15:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIVPDj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVPDi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 11:03:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69BB0B12;
        Thu, 22 Sep 2022 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663859017; x=1695395017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i1X+Kw1EhDzOgSQjTNTYpeXTnF6Aj3QadsTCaZZZLsk=;
  b=iaXGJSgINoMR7FeDs9jq36sAFPR2EbM9z8zAJ+xaiez7Buf7l9vBbisX
   ETr2AGFFycjNXfeNhEA+D5NxALxY2dzfKpJ1vlT3a08ve456ahVoWJ7hl
   R286TQ06JwGwbXNag1kxIYAS9jiQW5WcaJaklbWGNXywE9ThA9vB4SvQS
   FZlOwvpHKqk0A3N1UEGi+Xl8FUp68XgITe27rRif7koHRxE13wz8cDU5e
   oAPEL9UM4DhbzCT9fDGZAY5A0iLO3xu4nDlOgz0AmsNweZQ1vTi0qvFCO
   ApxpKvJIrFyuqRNE1SBYvrrH/99oApkANK43p6RiYslaMGh3yuS0mHK6v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280038552"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="280038552"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 08:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="688323707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 08:03:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obNjE-0063GN-3D;
        Thu, 22 Sep 2022 18:03:04 +0300
Date:   Thu, 22 Sep 2022 18:03:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <Yyx5KGjVgyiasqyv@smile.fi.intel.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
 <Yyxs8o7tB6BVS0Kt@kroah.com>
 <1ae6a32c-9f3d-ee56-a26a-7a90b4ee2bfe@linux.intel.com>
 <YyxySWYgJ7ceavcM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyxySWYgJ7ceavcM@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 22, 2022 at 04:33:45PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2022 at 05:24:55PM +0300, Ilpo Järvinen wrote:
> > On Thu, 22 Sep 2022, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 09, 2022 at 12:11:02PM +0300, Andy Shevchenko wrote:

...

> > > Breaks the build :(
> > 
> > I'd guess it's because uart_xmit_advance() is current only in tty-linus,
> > not in tty-next.
> 
> Probably, can someone resend this when 6.1-rc1 is out?

Sure.

-- 
With Best Regards,
Andy Shevchenko


