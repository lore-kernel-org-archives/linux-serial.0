Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCAC54FCF
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD7C208E0
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCYOml (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:42:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:13450 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCYOml (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 10:42:41 -0400
IronPort-SDR: aZ42MfS75Pkb1C+d361VhhQ3vxZ6dXhqnPgJacCdpHWc7EZ217OmLTlSzpKdhLAZ/eXKYOYcP6
 gUeeXf41azng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:42:40 -0700
IronPort-SDR: DOHsqqlJmd7yzNGn4yF4uvvKUqRhx64AwYe/CqKQdx1qSYoELmQVh0DA3KP0s3avq2LHceqkv/
 2d9B0vMel4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="247198748"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2020 07:42:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH7Eu-00CqVH-8L; Wed, 25 Mar 2020 16:42:40 +0200
Date:   Wed, 25 Mar 2020 16:42:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200325144240.GF1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <20200323131714.vmhjws5xpj6yf536@wunner.de>
 <20200323134106.GL1922688@smile.fi.intel.com>
 <1688171.mLF46rTMEE@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688171.mLF46rTMEE@diego>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 25, 2020 at 02:41:50PM +0100, Heiko Stübner wrote:
> Am Montag, 23. März 2020, 14:41:06 CET schrieb Andy Shevchenko:
> > On Mon, Mar 23, 2020 at 02:17:14PM +0100, Lukas Wunner wrote:
> > > On Mon, Mar 23, 2020 at 09:25:57AM +0100, Heiko Stübner wrote:
> > > > Am Donnerstag, 19. März 2020, 06:40:34 CET schrieb Lukas Wunner:
> > 
> > > "rs485-re-gpios" seems a bit cryptic, how about "rs485-rx-enable-gpios"
> > > or "rs485-full-duplex-gpios"?
> > 
> > First is in align with well established pin name, second is its elaboration,
> > I'm for any, but last.
> 
> So I guess the intersection of both your preferences
> is "rs485-rx-enable-gpios" ... and I did go with that ;-)


> I've now moved my rs485 things over to tty-next + taking
> 	- "serial: Allow uart_get_rs485_mode() to return errno"
> 	- "serial: 8250: Support rs485 bus termination GPIO"
> from Lukas' git-tree + fixing other things according to review comments.
> 
> I guess I'll now just sit on things till after the 5.7 merge window for
> the depending patches to get posted.

Sounds like a plan, thank you!

Or you can post anyway and resend after merge window. People will have a chance
to look at this.

-- 
With Best Regards,
Andy Shevchenko


