Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD4C4332B
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C255320735
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgCWNlI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:41:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:13182 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgCWNlI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 09:41:08 -0400
IronPort-SDR: nn9pnNMY+7ZaBXMQDXR9Jl6EM9931r7AQsIZapt6bUYNTg9qXzkrQwLZIRXreEFn15g2RauMhu
 hSTeYUZVL2Zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 06:41:07 -0700
IronPort-SDR: uFLy6JJSeTGnzmRiJJAKN4vHXRp+7R5BWZMIg3TpWRlZH5cu21kaeqeWTOz6YtofvpCaCkytRq
 vqRtAC/oXBuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="325572569"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2020 06:41:04 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGNKE-00CFod-HI; Mon, 23 Mar 2020 15:41:06 +0200
Date:   Mon, 23 Mar 2020 15:41:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Message-ID: <20200323134106.GL1922688@smile.fi.intel.com>
References: <20200318142640.982763-1-heiko@sntech.de>
 <5640842.EtOnNDtpGh@diego>
 <20200319054034.dyq7yydqi6yg7jhf@wunner.de>
 <6241816.LpgjcNKrfa@diego>
 <20200323131714.vmhjws5xpj6yf536@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323131714.vmhjws5xpj6yf536@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 23, 2020 at 02:17:14PM +0100, Lukas Wunner wrote:
> On Mon, Mar 23, 2020 at 09:25:57AM +0100, Heiko Stübner wrote:
> > Am Donnerstag, 19. März 2020, 06:40:34 CET schrieb Lukas Wunner:

> "rs485-re-gpios" seems a bit cryptic, how about "rs485-rx-enable-gpios"
> or "rs485-full-duplex-gpios"?

First is in align with well established pin name, second is its elaboration,
I'm for any, but last.

-- 
With Best Regards,
Andy Shevchenko


