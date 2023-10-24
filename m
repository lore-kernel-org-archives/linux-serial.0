Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FECC00A8F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjJXNjK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjJXNjA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 09:39:00 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 718E83273;
        Tue, 24 Oct 2023 06:37:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C955280AA;
        Tue, 24 Oct 2023 13:37:45 +0000 (UTC)
Date:   Tue, 24 Oct 2023 16:37:44 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <20231024133744.GN34982@atomide.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <ZTe9NdS160EU1RJJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTe9NdS160EU1RJJ@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Johan Hovold <johan@kernel.org> [231024 12:48]:
> Looks like this patch breaks the wakeup-irq hack in uart_suspend_port():
> 
> 	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
> 	if (tty_dev && device_may_wakeup(tty_dev)) {
> 		enable_irq_wake(uport->irq);
> 		put_device(tty_dev);
> 		mutex_unlock(&port->mutex);
> 		return 0;
> 	}
> 
> There may be more of these hard-coded assumptions, this one I happened
> to be aware of.

OK thanks I'll take a look.

Regards,

Tony
