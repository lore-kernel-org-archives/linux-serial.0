Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665ABC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4098520768
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCRPyP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:54:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:50380 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgCRPyP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:54:15 -0400
IronPort-SDR: dftVKVfMsgcCgoEaZUyRKqpsupQjKXkQkKliPLverLxhck2s7hzzWyeaqKvotVEu4+B8e7QbUQ
 g3SkeFz4ro6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:54:15 -0700
IronPort-SDR: Tjc3uIEmX3dQplYupWc5eSXp2BpVa6M28ayGV6FutVzKT/33/6CL3Y7l8bOV783m+C9pZZEp/l
 /8430xvsEc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="233880826"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2020 08:54:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEb1K-00Anye-UL; Wed, 18 Mar 2020 17:54:14 +0200
Date:   Wed, 18 Mar 2020 17:54:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200318155414.GR1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200318144320.GL1922688@smile.fi.intel.com>
 <20200318153754.dctd4q7e2fodeqsw@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318153754.dctd4q7e2fodeqsw@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 18, 2020 at 04:37:54PM +0100, Lukas Wunner wrote:
> On Wed, Mar 18, 2020 at 04:43:20PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2020 at 03:26:33PM +0100, Heiko Stuebner wrote:
> > > This series tries to revive the work of Giulio Benetti from 2018 [0]
> > > which seemed to have stalled at that time.
> 
> Oh dear. :-(  This needs a rebase on current tty-next.

That's what I was thinking when browsed thru the content, and thus commented in
the same way to this cover letter :-)

Thank you for looking into this.

-- 
With Best Regards,
Andy Shevchenko


