Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A4EDEC43
	for <linux-serial@archiver.kernel.org>; Wed, 13 Sep 2023 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbjIMMGz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Sep 2023 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjIMMGz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Sep 2023 08:06:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E25019A7;
        Wed, 13 Sep 2023 05:06:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5340C8088;
        Wed, 13 Sep 2023 12:06:50 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:06:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20230913120649.GI5285@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-3-tony@atomide.com>
 <c7688d45-4b63-20-b1c6-2dc1e83e875@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7688d45-4b63-20-b1c6-2dc1e83e875@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [230912 12:24]:
> On Tue, 12 Sep 2023, Tony Lindgren wrote:
> > +struct serial_base_console {
> > +	struct list_head node;
> > +	char *name;
> 
> Can't this be const char as too?

Yes thanks,

Tony
