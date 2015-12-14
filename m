From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Add device tree support for r8a779[23]
Date: Mon, 14 Dec 2015 08:49:18 +0100
Message-ID: <CAMuHMdXjQ+N5zfJnQa97N_ob4WUtLTUgePL99e40SjT=tDGfuA@mail.gmail.com>
References: <1448587224-8633-1-git-send-email-horms+renesas@verge.net.au>
	<20151213065250.GA2230@kroah.com>
	<20151214062722.GH18143@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151214062722.GH18143@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 14, 2015 at 7:27 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Dec 12, 2015 at 10:52:50PM -0800, Greg Kroah-Hartman wrote:
>> On Fri, Nov 27, 2015 at 10:20:24AM +0900, Simon Horman wrote:
>> > Simply document new compat strings.
>> > There appears to be no need for a driver updates.
>> >
>> > Also update the name of the r8a7791 to M2-W: the name changed a while back.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Doesn't apply to my tree :(
>
> I'm a little confused.
>
> The tty-next branch of the tty tree seems to be v4.4-rc5.
> And the patch seems to apply there. Please let me know what
> I should be using as a base.

Greg has applied the patch from Ulrich, which added support for r8a7793.
Hence your patch adding support for r8a7792 and r8a7793 no longer applies.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
