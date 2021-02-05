Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C06C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Feb 2021 22:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBE664F95
	for <linux-serial@archiver.kernel.org>; Fri,  5 Feb 2021 22:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhBEWDs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:03:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:10451 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhBEOyy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Feb 2021 09:54:54 -0500
IronPort-SDR: fbow1SMS9mnoBCZ8GswElMHBZJsSnWoS4gsEUnFXzRLOL1jurmc22naBE0JqKf+QPYTOXSU0/Y
 CEcP08WQzAIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="160595538"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="160595538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:20:06 -0800
IronPort-SDR: bJv9HjO06iK3CnORcnUqhd/OCT5yH1n20ago7+MetwsPjFUjOHaWLAn6glEntGlOvPxRhkJ+P/
 d0PWVU8iDrCw==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="484205707"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:20:03 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l81xo-002Any-MC; Fri, 05 Feb 2021 16:20:00 +0200
Date:   Fri, 5 Feb 2021 16:20:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 0/3] Handle UART without interrupt on TEMT using em485
Message-ID: <YB1UEHEPVQCAjsMO@smile.fi.intel.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204161158.643-1-etremblay@distech-controls.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 04, 2021 at 11:11:55AM -0500, Eric Tremblay wrote:
> Thanks everyone for the comments. I apply most of the comments on version 1
> but there is still a pending point with the Jiri comment about the safety of:
> struct tty_struct *tty = p->port.state->port.tty;
> I thought about adding a check with tty_port_initialized() before accessing
> the pointer, but I saw some other places where that same pointer is accessed
> without further protection, at least from what I see.

Thanks for the update. Unfortunately I'm a bit busy with other prioritized
stuff, but I will review this next week.

> Changes from v1 to v2:
> - Use UART_CAP_NOTEMT instead of UART_CAP_TEMT
> - Use some predefined macro to reduce magicness
> - Reset active_timer in temt timer handler
> - add uart_get_byte_size
> - set UART_CAP_NOTEMT in uart_config for PORT_16550A_FSL64
> - Improve commit messages
> - Improve grammar and spelling
> - Add Giulio and Heiko SoB to reflect previous work
> 
> Eric Tremblay (3):
>   serial: 8250: Handle UART without interrupt on TEMT using em485
>   serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
>   serial: 8250: add compatible for fsl,16550-FIFO64
> 
>  drivers/tty/serial/8250/8250.h      |  1 +
>  drivers/tty/serial/8250/8250_of.c   |  2 +
>  drivers/tty/serial/8250/8250_port.c | 68 ++++++++++++++++++++++++++++-
>  drivers/tty/serial/serial_core.c    | 29 ++++++++----
>  include/linux/serial_8250.h         |  2 +
>  include/linux/serial_core.h         |  2 +
>  6 files changed, 94 insertions(+), 10 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


