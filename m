Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93796CA0FE2
	for <linux-serial@archiver.kernel.org>; Tue,  5 Sep 2023 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjIER3X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Sep 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbjIER2f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Sep 2023 13:28:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2153D52A35
        for <linux-serial@vger.kernel.org>; Tue,  5 Sep 2023 09:52:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 38E7E809E;
        Tue,  5 Sep 2023 16:51:49 +0000 (UTC)
Date:   Tue, 5 Sep 2023 19:51:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <20230905165147.GS11662@atomide.com>
References: <20230829035245.GF11662@atomide.com>
 <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
 <20230829201557.GK11662@atomide.com>
 <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
 <20230901044730.GL11662@atomide.com>
 <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
 <20230902043424.GM11662@atomide.com>
 <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com>
 <20230905155524.GR11662@atomide.com>
 <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Matthew Howell <matthew.howell@sealevel.com> [230905 16:43]:
> On Tue, 5 Sep 2023, Tony Lindgren wrote:
> > Maybe check if rmmod 8250_exar now somehow causes the following insmod
> > 8250_exar attempts to fail?
> 
> Could you clarify what you mean? It is at that stage that I normally see 
> the error in dmesg unless I have reverted the port id patch. In other 
> words, if I just load it as-is I get the error in question.
> 
> Do you mean to try loading the installed kernel module with insmod?
> If that is what you mean, I just tried loading the included binary with 
> insmod but did not get the error and it loaded correctly. I loaded it 
> with:
> 
> sudo insmod /usr/lib/modules/6.5.0-1-MANJARO/kernel/drivers/tty/serial/8250/8250_exar.ko.zst 

I meant maybe reloading 8250_exar fails. So the test I would do is build
build a plain v6.5 kernel, boot it, modprobe 8250_exar, rmmod 8250_exar,
and then again modprobe 8250_exar.

So maybe the first modprobe 8250_exar works after boot, but the second
modprobe 8250_exar won't?

> Do you see anything concerning or possibly incorrect with the way I am 
> building the 8250_exar module?

No I don't see how that would make a difference.

Regards,

Tony

