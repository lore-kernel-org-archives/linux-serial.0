Return-Path: <SRS0=ZUfo=6K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E19C54FCB
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 23:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A41C20700
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDZX01 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Apr 2020 19:26:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgDZX01 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Apr 2020 19:26:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E058731B;
        Sun, 26 Apr 2020 16:26:26 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1F23F305;
        Sun, 26 Apr 2020 16:26:25 -0700 (PDT)
References: <20200423220056.29450-1-john.stultz@linaro.org> <jhj1rodyeu1.mognet@arm.com> <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the port.lock spinlock
In-reply-to: <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
Date:   Mon, 27 Apr 2020 00:26:19 +0100
Message-ID: <jhj1ro9bzhg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 25/04/20 05:04, John Stultz wrote:
> On Thu, Apr 23, 2020 at 4:14 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 23/04/20 23:00, John Stultz wrote:
>> > Which seems to be due to the fact that after allocating the uap
>> > structure, the pl011 code doesn't initialize the spinlock.
>> >
>> > This patch fixes it by initializing the spinlock and the warning
>> > has gone away.
>> >
>>
>> Thanks for having a look. It does seem like the reasonable thing to do, and
>> I no longer get the warning on h960.
>>
>> That said, I got more curious as this doesn't show up on my Juno (same
>> Image). Digging into it I see that uart_add_one_port() has a call to
>> uart_port_spin_lock_init() a few lines before uart_configure_port() (in
>> which the above warning gets triggered). That thing says:
>>
>>  * Ensure that the serial console lock is initialised early.
>>  * If this port is a console, then the spinlock is already initialised.
>>
>> Which requires me to ask: are we doing the right thing here?
>
> So I got a little bit of time to look at this before I got pulled off
> to other things (and now its Friday night, so I figured I'd reply
> before I forget it on Monday).
>
> I did check and lockdep is tripping when we add ttyAMA6 which is the
> serial console on the board. I wasn't able to trace back to why we
> hadn't already called spin_lock_init() in the console code, but it
> seems we haven't.
>

So on the Juno (ttyAMA0), the first time I see us hitting
uart_port_spin_lock_init() is via:

  uart_add_one_port() ->  uart_port_spin_lock_init()

Since port->cons->(index, line) is (-1, 0) at this point in time,
uart_console(port) returns false and we init the spinlock. When then
happily trickle down to uart_configure_port() -> register_console()


On the Hikey960 (ttyAMA6) I see the same initial flow, but (index, line)
is (6, 6), so uart_console(port) returns true and we skip the
spin_lock_init(). When then hit the splat on the rest of the way down
uart_add_one_port().


I did a tiny bit of git spelunking; I found a commit that changed
uart_console_enabled() into uart_console() within
uart_port_spin_lock_init():

  a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")

Reverting just that one change in uart_port_spin_lock_init() seems to go
fine on both Juno & HiKey960, but I think that doesn't play well with the
rest of the aforementioned commit. I think that this initial (index, line)
tuple is to blame, though I've added Andy in Cc just in case.

> Also I checked on HiKey as well, and there I'm seeing the same lockdep
> splat and this fix seems to resolve it. So more digging is needed. If
> anyone has a better idea of what might be awry or if the lock does
> need to be initialized in the driver (it's a bit inconsistent, I see
> some drivers do but others don't), let me know.
>



> thanks
> -john
