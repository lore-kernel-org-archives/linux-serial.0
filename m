Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0DEDEC4D
	for <linux-serial@archiver.kernel.org>; Wed, 13 Sep 2023 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjIMMat (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Sep 2023 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjIMMap (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Sep 2023 08:30:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E32E1BCA;
        Wed, 13 Sep 2023 05:30:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 166118088;
        Wed, 13 Sep 2023 12:30:41 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:30:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: core: Add sysfs links for serial core
 port instances for ttys
Message-ID: <20230913123039.GK5285@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-4-tony@atomide.com>
 <ZQCBAXcFwDqZyBZP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQCBAXcFwDqZyBZP@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230912 15:17]:
> On Tue, Sep 12, 2023 at 02:03:45PM +0300, Tony Lindgren wrote:
> > +	tty_dev = device_find_child(port->dev, &match, serial_match_port);
> 
> Can be written as
> 
> 	tty_dev = device_find_child(phys_dev, &match, serial_match_port);
> 
> ?
> 
> > +	if (tty_dev) {
> > +		sysfs_remove_link(&port->port_dev->dev.kobj, "tty");
> 
> Can be written as
> 
> 		sysfs_remove_link(&port_dev->dev.kobj, "tty");
> 
> can't be?

Yes that's shorter.

Thanks,

Tony
