Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951FAC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7886A20758
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgERPVE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 11:21:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:53159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERPVD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 11:21:03 -0400
IronPort-SDR: 6iWKZeFdubQnpSqmi5Ak0g5NLBMRHQoQF+4DAjduguiJeYV8HvMGqHGsXGGkQa8sJpcWZbljQW
 ojzbTOBdQ1Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:21:03 -0700
IronPort-SDR: Ko8otbQvSOw607L2ZQnKU0DqdX9LG4vgAeNmmVlkY+X5MBRQzpOuCBFNa7KpRKVLnxjsa3pF1h
 y5RYzX/Jg/yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="342826406"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2020 08:21:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jahZf-007S65-TE; Mon, 18 May 2020 18:21:03 +0300
Date:   Mon, 18 May 2020 18:21:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 5/5] serial: 8250_dw: add em485 support
Message-ID: <20200518152103.GI1634618@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215610.2131618-6-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 17, 2020 at 11:56:10PM +0200, Heiko Stuebner wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Need to use rs485 transceiver so let's use existing em485 485 emulation
> layer on top of 8250.
> 
> Add rs485_config callback to port and uses the standard em485 start and
> stop helpers.

Would it prevent to use native RS485 support?

...

>  	p->serial_out	= dw8250_serial_out;
>  	p->set_ldisc	= dw8250_set_ldisc;
>  	p->set_termios	= dw8250_set_termios;
> +	p->rs485_config = serial8250_em485_config;
> +	up->rs485_start_tx = serial8250_em485_start_tx;
> +	up->rs485_stop_tx = serial8250_em485_stop_tx;

-- 
With Best Regards,
Andy Shevchenko


