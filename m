Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F59C07545
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 12:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjJXMqD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJXMqD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 08:46:03 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDD6ECC;
        Tue, 24 Oct 2023 05:46:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id ECB3E80AA;
        Tue, 24 Oct 2023 12:45:59 +0000 (UTC)
Date:   Tue, 24 Oct 2023 15:45:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <20231024124558.GM34982@atomide.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
 <ZTe7xIBCQ8e5DKZL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTe7xIBCQ8e5DKZL@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [231024 12:42]:
> On Tue, Oct 24, 2023 at 03:29:55PM +0300, Tony Lindgren wrote:
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 11:52]:
> > > What does this change the sysfs tree to look like?
> > 
> > On x86 qemu for the ttys:
> > 
> > # find /sys -name tty
> > /sys/class/tty
> > /sys/class/tty/tty
> > /sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
> > /sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
> > /sys/devices/virtual/tty
> > /sys/devices/virtual/tty/tty
> 
> I believe the question was how serdev device will move it's location
> in the hierarchy.

If used, a serdev device serial0 will appear instead of the tty in
the same location.

Regards,

Tony
