From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
Date: Thu, 8 Dec 2011 12:54:46 +0100
Message-ID: <CAMuHMdWM=dQDHmH=WmngB9dRFF-v+NgP2CPdAX5hVQX=iayA+A@mail.gmail.com>
References: <20111023141108.856998818@telegraphics.com.au>
	<20111023141115.208699274@telegraphics.com.au>
	<alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
	<alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
	<1323318004.12793.21.camel@pasglop>
	<1323318638.12793.23.camel@pasglop>
	<alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47027 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab1LHLys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Dec 2011 06:54:48 -0500
In-Reply-To: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

Hi Finn,

On Thu, Dec 8, 2011 at 12:26, Finn Thain <fthain@telegraphics.com.au> w=
rote:
> On Thu, 8 Dec 2011, Benjamin Herrenschmidt wrote:
>> On Thu, 2011-12-08 at 15:20 +1100, Benjamin Herrenschmidt wrote:
>> > So basic operations seem to work, I've applied the patch to
>> > powerpc-next.
>
> Then I guess Geert should not push this for 3.3 -- or does it make no
> difference?

I do not plan to push it myself, that's why it's not in my for-next bra=
nch.
The for-3.3 is just indicative.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
