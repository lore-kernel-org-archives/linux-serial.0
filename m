Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32BEC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  4 Feb 2022 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359699AbiBDP2Q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:28:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:58598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbiBDP2Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Feb 2022 10:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643988496; x=1675524496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL76kaqgmoqfADEJHWhRA8d3fcfFW+q28lXPw8jO6gg=;
  b=afrvXaiTQXEx+NTEj5u3Tc0bXruUgyY2luN7rkUzuufMkIze+vHesLAK
   +FRgn14AwaVzZ/SMFDmtPuKlvODbt3vWn7mauod9/+ouqMNOIklKhyD5y
   lMTQMveTCwXKEuKXnEzh/Kz/S3J+3NqZQH0CmUPn2ERbl7YYTCds+Ao7A
   Sg7yzAZTNJloHUxRg21yQ2MRk8v9Albj8apCE95xyTNcJ+osaCLV4E9kY
   lp987ydXjDU8xKuPFhjoyjh5mp0Ei8dJFxi2fmsewVgPKLJwutlUAolIU
   EuJwNuMa1DO4b0hXCe3smHKS8O/zM+qRqCQCSxGXybLQSHcBb8RehLP76
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228356643"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="228356643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:28:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="483637178"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:28:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nG0UU-000xtr-Dv;
        Fri, 04 Feb 2022 17:27:14 +0200
Date:   Fri, 4 Feb 2022 17:27:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Drop duplicate NULL check in
 uart_*shutdown()
Message-ID: <Yf1F0tgIJAnsp4Jo@smile.fi.intel.com>
References: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
 <Yf04R+REP6WahIIr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf04R+REP6WahIIr@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 04, 2022 at 03:29:27PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 02, 2022 at 06:56:48PM +0200, Andy Shevchenko wrote:

...

> What branch is this against?  It fails to apply to my tty-next branch :(

Linux Next, I think/
Let me rebase on top of yours tty-next.

v2 has just been sent.

-- 
With Best Regards,
Andy Shevchenko


