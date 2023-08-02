Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18595C001E0
	for <linux-serial@archiver.kernel.org>; Wed,  2 Aug 2023 11:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHBLwu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Aug 2023 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHBLwt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Aug 2023 07:52:49 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E179273C;
        Wed,  2 Aug 2023 04:52:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A761780AE;
        Wed,  2 Aug 2023 11:52:36 +0000 (UTC)
Date:   Wed, 2 Aug 2023 14:52:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <20230802115235.GL5191@atomide.com>
References: <20230725054216.45696-4-tony@atomide.com>
 <202308021529.35b3ad6c-oliver.sang@intel.com>
 <20230802092354.GC14799@atomide.com>
 <2023080236-gurgling-violet-b54e@gregkh>
 <20230802104752.GD14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802104752.GD14799@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230802 13:47]:
> OK. The fix might be just to check for device_type in serial_base_match().

FYI fix sent as "[PATCH] serial: core: Fix serial_base_match() after fixing
controller port name" [0].

Regards,

Tony

[0] https://lore.kernel.org/linux-serial/20230802114846.21899-1-tony@atomide.com/T/#u
