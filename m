From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Fri, 3 Dec 2010 12:47:14 +0100
Message-ID: <AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59657 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758423Ab0LCLrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Dec 2010 06:47:15 -0500
Received: by qwb7 with SMTP id 7so9516355qwb.19
        for <linux-serial@vger.kernel.org>; Fri, 03 Dec 2010 03:47:14 -0800 (PST)
In-Reply-To: <20101109224012.GA21992@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 9, 2010 at 11:40 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
>> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
>>
>> This patch allows to control the pl011 clock using set_termios
>> callback. Any positive baudrate passed enables clock, otherwise
>> disables. This saves a lot of power on submicron designs since
>> we can clock off and disable unused UARTs.
>
> That's nice, but it seems like an overload of what people traditional=
ly
> think of when it comes to baud rates. =A0Why not just power down port=
s
> that are not open instead?

I like the idea as well and this is definitely gonna help conserving
the power for Bluetooth UARTs.

But using baud rate 0 is something I don't like. Why don't you stop
the clocks if RTS is cleared? This would have allowed the line
discipline driver to implicitly control the UART clock and there will
be no risk of losing data, as well as no non-standard behavior
involved. In fact, you'll be transparent to the upper layers in this
case.

~Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
