Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38630C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2C3613B8
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhDGKQK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:16:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:61725 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236823AbhDGKQK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 06:16:10 -0400
IronPort-SDR: IQWc3r/IAXbQ6EpZ1lQg8OMRxEixySjoG1PzEjk2Ixlj1Ib8R2CADarMEZh7SwakhGnRNe5+yG
 bXFKbgpTZpmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172749947"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="172749947"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:16:00 -0700
IronPort-SDR: JoP7u+O2DkItjgJSXhqqPo54dyzqtU85/wPouK98WrPw83W3SRfbSXvLWgF4b/xGPtoO9/2EfF
 GZ1rlaz5b3Bg==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="418702566"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:15:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU5E2-001z1c-PS; Wed, 07 Apr 2021 13:15:54 +0300
Date:   Wed, 7 Apr 2021 13:15:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] defconfig: enable SERIAL_SH_SCI
Message-ID: <YG2GWmhPBA+fuKAr@smile.fi.intel.com>
References: <20210407101406.8562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407101406.8562-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 07, 2021 at 01:14:06PM +0300, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry for noise, it's not for upstream.

-- 
With Best Regards,
Andy Shevchenko


