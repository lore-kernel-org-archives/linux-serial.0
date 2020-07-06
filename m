Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9BC433E2
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DBB20715
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgGFOgd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:36:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:42412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbgGFOgd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 10:36:33 -0400
IronPort-SDR: Wk/EzmFMnlpMH/tvI6zseqFMClAJgNcrJ/WzXZGqJEBOJgLcHOvrTabR3UsRMDzL7nj/YKorvP
 UXcuz3XTjxKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232275145"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="232275145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 07:36:32 -0700
IronPort-SDR: 197XpvSNO4Pxuwgkhm+N9dJu+0taevNk6vVUETM7wpVM6g9eNAPPWRvJghJjmf+INib912jpLW
 8bih+GL9UD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="482722608"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2020 07:36:30 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jsSEQ-000KDC-UN; Mon, 06 Jul 2020 17:36:30 +0300
Date:   Mon, 6 Jul 2020 17:36:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1] serial: core: Initialise spin lock before use in
 uart_configure_port()
Message-ID: <20200706143630.GX3703480@smile.fi.intel.com>
References: <20200706140036.75524-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706140036.75524-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 06, 2020 at 05:00:36PM +0300, Andy Shevchenko wrote:
> The comment near to uart_port_spin_lock_init() says:
> 
>   Ensure that the serial console lock is initialised early.
>   If this port is a console, then the spinlock is already initialised.
> 
> and there is nothing about enabled or disabled consoles. The commit
> a3cb39d258ef ("serial: core: Allow detach and attach serial device
> for console") made a change, which follows the comment, and also to
> prevent reinitialisation of the lock in use, when user detaches and
> attaches back the same console device. But this change discovers
> another issue, that uart_add_one_port() tries to access a spin lock
> that now may be uninitialised. This happens when a driver expects
> the serial core to register a console on its behalf. In this case
> we must initialise a spin lock before use.

Abandon this version, please, I forgot to squash it with the typo fix.
v2 has been sent.

-- 
With Best Regards,
Andy Shevchenko


