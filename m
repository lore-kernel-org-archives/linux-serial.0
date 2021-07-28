Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB1C4338F
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B8D6023F
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhG1PTZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:19:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:42774 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237139AbhG1PTV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Jul 2021 11:19:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="192278909"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="192278909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 08:19:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517571065"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 08:19:18 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m8lKy-0026Y2-5R; Wed, 28 Jul 2021 18:19:12 +0300
Date:   Wed, 28 Jul 2021 18:19:12 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Dennis Giaya <dgiaya@whoi.edu>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: max310x: Use clock-names property
 matching to recognize EXTCLK
Message-ID: <YQF1cK3lxJs2ND9U@smile.fi.intel.com>
References: <20210723125943.22039-1-andriy.shevchenko@linux.intel.com>
 <19b100cfa0c1eb8b5d321ff852f18f7ce5768149.camel@whoi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b100cfa0c1eb8b5d321ff852f18f7ce5768149.camel@whoi.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:17PM +0000, Dennis Giaya wrote:
> > v2: added Tested-by tag (Dennis), inverted comparison to leave
> > original flow
> 
> I've tested v2 with the inverted comparison and it works under the same
> test conditions as v1.

Thanks! It's pending for v5.15-rc1.

-- 
With Best Regards,
Andy Shevchenko


