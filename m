From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Mon, 6 Dec 2010 10:53:20 +0100
Message-ID: <AANLkTimxU-YL_wy9ZTjKXX+68u_KcPzhSn9mOU_MnzQS@mail.gmail.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
	<AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
	<20101203151547.GA30898@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49370 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0LFJxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Dec 2010 04:53:21 -0500
Received: by qwd7 with SMTP id 7so1052555qwd.19
        for <linux-serial@vger.kernel.org>; Mon, 06 Dec 2010 01:53:21 -0800 (PST)
In-Reply-To: <20101203151547.GA30898@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Fri, Dec 3, 2010 at 4:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Why don't you stop
>> the clocks if RTS is cleared? This would have allowed the line
>> discipline driver to implicitly control the UART clock and there wil=
l
>> be no risk of losing data, as well as no non-standard behavior
>> involved. In fact, you'll be transparent to the upper layers in this
>> case.
>
> I've no idea what you're thinking, but you can't stop the UART clock
> because RTS is deasserted - or DTR for that matter. =A0Neither of tho=
se
> two define whether characters will be transmitted or received.

What I'm mostly up to (and I guess Par also is) is how to conserve
power for the Bluetooth UARTs. For a Bluetooth UART, there usually is
a kind of signalling protocol, either inband or out-of-band, that
allows the host and the chip to negotiate about power conservation
during inactivity periods. These protocols do not belong to UART
implementation and are usually implemented as line discipline drivers.
While BT chip is sleeping, we don't need the UART clock running but we
need to have a decent way of telling the UART driver it can shut those
off. Using RTS for that, even though not being applicable in all the
cases, seems to work pretty well for Bluetooth UARTs. So if we just
add a flag if an UART is used for BT or not and then use RTS for this
kind of communication, will it be okay with you?

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
