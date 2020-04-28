Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7026C83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB41206C0
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 08:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD1Iyp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:54:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgD1Iyp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 04:54:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBD6D30E;
        Tue, 28 Apr 2020 01:54:44 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A07733F305;
        Tue, 28 Apr 2020 01:54:43 -0700 (PDT)
References: <20200423220056.29450-1-john.stultz@linaro.org> <jhj1rodyeu1.mognet@arm.com> <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com> <jhj1ro9bzhg.mognet@arm.com> <CAHp75VeE_J-GE9o6QVxBk6RJ2fjSwATfR1etaT0CXCgAiidjPQ@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list\:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the port.lock spinlock
In-reply-to: <CAHp75VeE_J-GE9o6QVxBk6RJ2fjSwATfR1etaT0CXCgAiidjPQ@mail.gmail.com>
Date:   Tue, 28 Apr 2020 09:54:38 +0100
Message-ID: <jhjimhkrnw1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 27/04/20 10:02, Andy Shevchenko wrote:
>> I did a tiny bit of git spelunking; I found a commit that changed
>> uart_console_enabled() into uart_console() within
>> uart_port_spin_lock_init():
>>
>>   a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
>>
>> Reverting just that one change in uart_port_spin_lock_init() seems to go
>> fine on both Juno & HiKey960, but I think that doesn't play well with the
>> rest of the aforementioned commit. I think that this initial (index, line)
>> tuple is to blame, though I've added Andy in Cc just in case.
>
> The above mentioned commit reveals the issue in the code which doesn't
> register console properly.
>
> See what I put in 0f87aa66e8c31 ("serial: sunhv: Initialize lock for
> non-registered console").

Thanks for the pointer. I'm still a puzzled as to why it goes fine on one
board and not on another, but at this point I don't have any better
suggestion than the unconditional init.
