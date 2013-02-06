From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 6 Feb 2013 17:31:24 +0100
Message-ID: <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
	<20130206115219.GE17833@n2100.arm.linux.org.uk>
	<CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:42407 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab3BFQbZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 11:31:25 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so1792654iag.31
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 08:31:24 -0800 (PST)
In-Reply-To: <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, jslaby@suse.cz, anton.vorontsov@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Patch Tracking <patches@linaro.org>

On Wed, Feb 6, 2013 at 1:31 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

CC Grant on this issue...

> On 6 February 2013 19:52, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Feb 06, 2013 at 07:47:14PM +0800, Haojian Zhuang wrote:
>>> If uart driver is probed defer, console_setup will be called later
>>> after __init && __initdata sections destroyed. And amba_console isn't
>>> defined in __init or __initdata section. So we needn't define
>>> pl011_console_setup() && pl011_console_get_options() in __init section.
>>
>> It sounds like there's a deeper problem here - if this driver being
>> deferred, why isn't it being retried after the pinctrl stuff gets
>> its driver registered?
>>
>> We've had bugs in this deferred probing before, I wouldn't be surprised
>> if there's more... and we should not be "fixing" drivers because of bugs
>> elsewhere.
>
> It retried if driver is being deferred. But those console setup
> functions are released
> since they're declared in __init section.
>
> rest_init()
>    --> creates kernel_init thread that could free __init section memory
>
> deferred_probe_initicall() creates a workqueue that is used to retry
> deferred probe
> function.
>
> I think that these two threads are competing.

Now that is the *real* problem. The __init sections surely should
not be discarded until *after* all deferred probes are complete
and the deferral workqueue terminates.

How about writing a patch to fix that instead? (If possible...)

Yours,
Linus Walleij
