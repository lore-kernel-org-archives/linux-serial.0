Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5334C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920566500E
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCPK5H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236898AbhCPK4q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 06:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589DB6500C;
        Tue, 16 Mar 2021 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615892205;
        bh=qYj+UoaQGxPVGvYnc2Y0oDyMDhy9FuDHQwz7UlNR5g4=;
        h=Date:From:To:Cc:Subject:From;
        b=JHFnBJcspD6S1T/j0b+dQlvqLE5BLq1XUjbh1ug/fcQgAOEqTBay1IQ95o5bF4DmP
         bCn+3sIhdFV2iYuAdzrA0GQbPqgVk4yaFU/9XYxjJkw7oy3Ah1UFK3bl8Nlr1/ID7P
         IVD66cNiWJ43CTzmBtkyNfHEWm25GdYktyWAXzK2unbQ6CFBJuv+bOH5wZmDPZJg8I
         LyusaWdwDiJ96nL+Rl5s0gXcA8ZRv0/164CaV+BYH96Z769beDf6AJDBPmFJKpwcgj
         OoCq/kgUnwt7fmLMoSW+3kS3sbj7CUn2AaT0uRzS43UmkVs5hhW631heNZzfVDg9nA
         ErDPfNM+sQrIw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lM7Ng-0000qd-I4; Tue, 16 Mar 2021 11:56:57 +0100
Date:   Tue, 16 Mar 2021 11:56:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: threadirqs deadlocks
Message-ID: <YFCO+FEjWPGytb2W@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Thomas,

We've gotten reports of lockdep splats correctly identifying a potential
deadlock in serial drivers when running with forced interrupt threading.

Typically, a serial driver takes the port spin lock in its interrupt
handler, but unless also disabling interrupts the handler can be
preempted by another interrupt which can end up calling printk. The
console code takes then tries to take the port lock and we deadlock.

It seems to me that forced interrupt threading cannot generally work
without updating drivers that expose locks that can be taken by other
interrupt handlers, for example, by using spin_lock_irqsave() in their
interrupt handlers or marking their interrupts as IRQF_NO_THREAD.

What are your thoughts on this given that forced threading isn't that
widely used and was said to be "mostly a debug option". Do we need to
vet all current and future drivers and adapt them for "threadirqs"?

Note that we now have people sending cleanup patches for interrupt
handlers by search-and-replacing spin_lock_irqsave() with spin_lock()
which can end up exposing this more.

Johan
