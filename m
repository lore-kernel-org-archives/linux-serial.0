Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F738E80A9A
	for <linux-serial@archiver.kernel.org>; Wed, 27 Sep 2023 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjI0HlL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Sep 2023 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjI0HlK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Sep 2023 03:41:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3161811D;
        Wed, 27 Sep 2023 00:41:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1FBA680A2;
        Wed, 27 Sep 2023 07:41:06 +0000 (UTC)
Date:   Wed, 27 Sep 2023 10:41:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Message-ID: <20230927074104.GD5285@atomide.com>
References: <20230926061319.15140-1-tony@atomide.com>
 <ZRLBWrjUadvGCs/y@smile.fi.intel.com>
 <20230927042950.GB5285@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927042950.GB5285@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230927 07:29]:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230926 11:59]:
> > Btw, how close are we to getting rid the pm_runtime_irq_safe() call?
> 
> Very close, I think still doable for v6.7 merge window.. Below is what I'm
> testing with, there's one error that I've seen that may or may not be
> related.

I'm unable to reproduce the issue I was seeing with v6.6-rc3 with and without
the pm_runtime_irq_safe() dropping patch. So AFAIK no issues dropping
pm_runtime_irq_safe().

I was seeing some warning earlier after detaching kernel console and doing
any sysrq trigger on the serial port, seems like it was unrelated.

Regards,

Tony
