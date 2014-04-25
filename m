From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Fri, 25 Apr 2014 09:11:06 +0200
Message-ID: <CAMuHMdWB4ZnwyNFXMK_rdCKAMOXt+HRMZKG+j4O-tdfiP_-PLg@mail.gmail.com>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
	<1418731.YSFS18bIMD@avalon>
	<20140425002641.GB31164@verge.net.au>
	<1922942.7jvlviEDpf@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58878 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYHLH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 03:11:07 -0400
In-Reply-To: <1922942.7jvlviEDpf@avalon>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Apr 25, 2014 at 9:05 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +     scif0: serial@ffe40000 {
>> +             compatible = "renesas,scif", "renesas,scif-r8a7779";
>> +             reg = <0xffe40000 265>;
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&cpg_clocks R8A7779_CLK_P>;
>> +             clock-names = "sci_ick";
>
> Clock handling in the sh-sci driver should probably be improved. The driver
> currently requires an "sci_ick" interface clock and supports an optional
> "sci_fck" functional clock. In practice, as far as I can see, platforms that
> provide both sci_ick and sci_fck set the two clocks to the same source.

That's right. As a consequence, the clock's enable count is incremented
3 times:
  - once for fck,
  - once for ick,
  - once for generic Runtime PM using the "NULL" clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
