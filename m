Return-Path: <SRS0=m2iq=5P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F685C43331
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06CD2072E
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgC3Owk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:52:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:64494 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgC3Owk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Mar 2020 10:52:40 -0400
IronPort-SDR: MIRYyY5gaX862ksA0nrrp5J+dbtAUPZ5FOu0NRb0HzlBhHKMFR4129YBmmSgejwQTN9XlCFq4R
 JZ3fHnAkgupw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 07:52:39 -0700
IronPort-SDR: rfW88gAjoLcRuxEMkeDyZmauk0DBi3xQ4Q1GXDFDjkXTWZvhWkbDmfca24k9dnZz35+i/xkTp/
 EroFjNmfikxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="237374537"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2020 07:52:37 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIvmJ-00EEWj-7l; Mon, 30 Mar 2020 17:52:39 +0300
Date:   Mon, 30 Mar 2020 17:52:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
Message-ID: <20200330145239.GV1922688@smile.fi.intel.com>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-5-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-5-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:19AM +0100, Heiko Stuebner wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
> standard, instead only available on some implementations.
> 
> The current em485 implementation does not work on ports without it.
> The only chance to make it work is to loop-read on LSR register.
> 
> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
> update all current em485 users with that capability and make
> the stop_tx function loop-read on uarts not having it.

> +		if (p->capabilities & UART_CAP_TEMT) {
> +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +				return;
> +		} else {
> +			int lsr;
> +

> +			if (readx_poll_timeout(__get_lsr, p, lsr,
> +					(lsr & BOTH_EMPTY) == BOTH_EMPTY,
> +					0, 10000) < 0)

			ret = readx_poll_timeout(...);
			if (ret)
				...

will look better.

> +				pr_warn("%s: timeout waiting for fifos to empty\n",
> +					p->port.name);
> +		}

-- 
With Best Regards,
Andy Shevchenko


