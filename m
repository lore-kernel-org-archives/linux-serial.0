From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Wed, 6 Feb 2013 20:31:34 +0800
Message-ID: <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
	<20130206115219.GE17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54305 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3BFMbg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 07:31:36 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so1023791wgh.31
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 04:31:34 -0800 (PST)
In-Reply-To: <20130206115219.GE17833@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: jslaby@suse.cz, Linus Walleij <linus.walleij@linaro.org>, anton.vorontsov@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Patch Tracking <patches@linaro.org>

On 6 February 2013 19:52, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 06, 2013 at 07:47:14PM +0800, Haojian Zhuang wrote:
>> If uart driver is probed defer, console_setup will be called later
>> after __init && __initdata sections destroyed. And amba_console isn't
>> defined in __init or __initdata section. So we needn't define
>> pl011_console_setup() && pl011_console_get_options() in __init section.
>
> It sounds like there's a deeper problem here - if this driver being
> deferred, why isn't it being retried after the pinctrl stuff gets
> its driver registered?
>
> We've had bugs in this deferred probing before, I wouldn't be surprised
> if there's more... and we should not be "fixing" drivers because of bugs
> elsewhere.

It retried if driver is being deferred. But those console setup
functions are released
since they're declared in __init section.

rest_init()
   --> creates kernel_init thread that could free __init section memory

deferred_probe_initicall() creates a workqueue that is used to retry
deferred probe
function.

I think that these two threads are competing.

Best Regards
Haojian
