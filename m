From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Date: Sat, 9 Feb 2013 22:31:05 +0000
Message-ID: <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk> <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
 <20130206163811.GI17833@n2100.arm.linux.org.uk> <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:58394 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592Ab3BIWb0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Feb 2013 17:31:26 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so5446504iak.1
        for <linux-serial@vger.kernel.org>; Sat, 09 Feb 2013 14:31:25 -0800 (PST)
In-Reply-To: <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, jslaby@suse.cz, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Patch Tracking <patches@linaro.org>

On Sat, Feb 9, 2013 at 5:22 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 7 February 2013 00:38, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Feb 06, 2013 at 05:31:24PM +0100, Linus Walleij wrote:
>>> On Wed, Feb 6, 2013 at 1:31 PM, Haojian Zhuang
>>> <haojian.zhuang@linaro.org> wrote:
>>>
>>> CC Grant on this issue...
>>>
>>> > On 6 February 2013 19:52, Russell King - ARM Linux
>>> > rest_init()
>>> >    --> creates kernel_init thread that could free __init section memory
>>> >
>>> > deferred_probe_initicall() creates a workqueue that is used to retry
>>> > deferred probe
>>> > function.
>>> >
>>> > I think that these two threads are competing.
>>>
>>> Now that is the *real* problem. The __init sections surely should
>>> not be discarded until *after* all deferred probes are complete
>>> and the deferral workqueue terminates.
>>>
>>> How about writing a patch to fix that instead? (If possible...)

That just masks the issue. See below.

>>
>> Well, we have the facilities to flush workqueues, so it should be possible.
>>
>> However, I'm just wondering if this shows that we _do_ need to get rid
>> of a pile of __init marked functions as well as fixing this, thanks to
>> the deferred probing we now have (maybe the whole __init thing becomes
>> useless with deferred probing?)  There's nothing really to guarantee
>> that the pinctrl stuff will be available by the time the init sections
>> are discarded (it could be in a loadable module?) or indeed any other
>> resources that might be necessary.

If it is a probe function, then yes the __init annotations need to be
removed or the driver needs to use platform_driver_probe(). This has
been the model as long as I can remember. As long as a driver has a
.probe hook, the driver core can call it at any time. Deferred probe
has only exposed the issue.

If you want to discard the .probe() hook, then the probe() pointer
needs to be cleared from the driver structure before discarding the
sections. Otherwise the driver core can still call it which is what
happens in deferred probe and can happen if a device gets unbound from
a driver and then re-attached.

>> I think in this regard, deferred probing has opened a similar can of
>> worms which hotplug devices created (which eventually ended up with
>> killing the __dev* marking).
>
> At first, I considered to remove those __init functions. But it may seem
> unreasonable.
>
> Now I'm trying to reuse wait_for_device_probe() after do_initcalls(). Please
> help to review.

That patch doesn't actually fix the problem, it just masks it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
