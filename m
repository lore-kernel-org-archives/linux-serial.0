From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
Date: Tue, 11 Nov 2014 11:35:23 -0600
Message-ID: <CAL_JsqKE=p_d53A7n4QZpQc_z0tbAp0bhZGerjsUt2BSSvGgtw@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
 <CAL_JsqLYoUKr71Q-hfLQhXOVL72Gy7PkO-Zd4rBc0Fn-prOqTw@mail.gmail.com> <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41388 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaKKRfq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Nov 2014 12:35:46 -0500
In-Reply-To: <CAJiQ=7C5ki+9opnH68Kw9a573PmO=ANeiVutmVROUP2Typn2qw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org

On Mon, Nov 10, 2014 at 1:50 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Mon, Nov 10, 2014 at 11:22 AM, Rob Herring <robh@kernel.org> wrote:
>>>> This can be solved with a udev rule to create sym links.
>>>
>>> Is it safe to register two console drivers named "ttyS" with the same
>>> major/minor numbers?  Maybe there is a trick to making them coexist?
>>
>> No, but I think you can do dynamic minor numbers. I seem to recall
>> this coming up with the Samsung UARTs a while back.
>
> The other variations I've seen in the tree are:
>
> nwpserial: ttySQ, major 4 minor 68 (not 64)
>
> sunhv, sunsab, sunsu, sunzilog: set uart_driver->major to 4 but let
> uart_driver->minor default to 0
>
> SERIAL_ATMEL_TTYAT: compile-time selectable between ttySn (4/64) and
> ttyATn (204/154).  txx9 does something similar using
> SERIAL_TXX9_STDSERIAL.
>
> A whole bunch of other SoC serial drivers use major 204 and a custom
> name like "ttyAL".  Some of these show up in
> Documentation/devices.txt; others don't.  ~3 drivers use 204/64 from
> the middle of the Altix assigned range.
>
> What is the current best practice for new drivers?

I think it would be using dynamic numbering, but would be good to have
others weigh in here. It looks like a dynamic major would solve your
problem. See tty_register_driver. Also, there was a patch to make this
the fallback behavior instead of an error[1], but it was never merged
(and it's not clear why). This was the Samsung related change I was
remembering.

Rob

[1] http://lists.linaro.org/pipermail/linaro-kernel/2014-January/010383.html
