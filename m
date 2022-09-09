Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74FECAAD3
	for <linux-serial@archiver.kernel.org>; Fri,  9 Sep 2022 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIIKRs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Sep 2022 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIIKRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Sep 2022 06:17:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF3129C6C;
        Fri,  9 Sep 2022 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662718666; x=1694254666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=twmve2pp6FrQGPPjMyndpXyUbQtJvOD5cguRNbI4b8k=;
  b=LNomahuwvi9Ima+PTJbdzu13/NoqIfSY+viDyk/pqJBLgBx79r1tzYSL
   dNoApEmfTG1kXPexjt5yrVSLkOnzgJSVr74dgajVbkCQroE1DD3+TgInx
   J1Z9d7/kEEmk+6RDwZegYRqg7UCmN/cNPMoF4gyjJAfwJeNYUJ6e+YmuL
   AxtryTlJqF1dhFEQ5n/+rHl9+vi8LzjChrxmhxJm6CtIJRvLhC7ZZ1bM8
   qrx/X5LSkcPjR9zWWolCv8ztbsyLSZRcJLUzn/aCZ+0kyCr+LA82LfYdn
   gMWGxIjVDSQvpWL1Gbs9lPoNAG+6/EN6iiIjouvKPq/0ooZcE6tQhWfrt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323652426"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="323652426"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:17:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="592559923"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:17:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWb4v-00AW30-1f;
        Fri, 09 Sep 2022 13:17:41 +0300
Date:   Fri, 9 Sep 2022 13:17:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <YxsSxbB47TNm2p0B@smile.fi.intel.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
 <81acf91-ba43-f276-fca7-ac9c9e721a88@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81acf91-ba43-f276-fca7-ac9c9e721a88@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 09, 2022 at 12:16:58PM +0300, Ilpo Järvinen wrote:
> On Fri, 9 Sep 2022, Andy Shevchenko wrote:
> 
> > uart_xmit_advance() provides a common way on how to advance
> > the Tx queue. Use it for the sake of unification and robustness.

...

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks!

> Please note though that I already have patches for almost all these but
> I've not just submitted the remaining ones yet.

My interest only for a limited scope of 8250 compatible UARTs, I have sent
just a couple of patches and I don't think I will send more.


-- 
With Best Regards,
Andy Shevchenko


