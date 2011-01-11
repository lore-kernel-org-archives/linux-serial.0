From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] drivers: char: hvc: add Blackfin JTAG console support
Date: Tue, 11 Jan 2011 00:31:57 -0500
Message-ID: <AANLkTim1n+DNChvuqJKRTAKs2xjpDCV-yV_y9nyQc8RL@mail.gmail.com>
References: <1294713837-4929-1-git-send-email-vapier@gentoo.org>
 <AANLkTinnuxvx9+eNvCqjK2GW2XQPn4LjK4WfMj=f20Xw@mail.gmail.com> <201101110441.33841.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64208 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1AKFcT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jan 2011 00:32:19 -0500
In-Reply-To: <201101110441.33841.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On Mon, Jan 10, 2011 at 22:41, Arnd Bergmann wrote:
> On Tuesday 11 January 2011, Mike Frysinger wrote:
>> throughput seems to be a bit lower. =C2=A0the Blackfin JTAG hardware=
 has
>> basically a 4 byte fifo that is filled/consumed in a single shot. =C2=
=A0and
>> the Blackfin can produce much faster than the host can consume. =C2=A0=
so
>> atm, i have it send out 4 bytes, and the hvc layers take care of
>> calling back into me at some point. =C2=A0if i add a busy loop to ru=
n a few
>> hundred milliseconds (like HZ/4), it runs much nicer. =C2=A0but obvi=
ously
>> doesnt give anyone else time to run. =C2=A0i cant schedule or anythi=
ng as
>> the write layers are called with a spin_lock_irqsave. =C2=A0any tips=
 for
>> how to speed this up a bit ? =C2=A0or is it a wash with hvc ?
>
> You could try lowering the hvc MIN_TIMEOUT value. If you want to
> change it for blackfin, you could probably make it a configuration
> option. However, if it really takes a few milliseconds that you need
> to wait between two accesses, MIN_TIMEOUT should already be small
> enough.
>
> You should really not need to sleep in your output function, as
> the khvcd() timeout logic tries handling this in the best way.
> There may be a bug in that logic though (wouldn't be the first one
> there), so try to see what the timeouts are when you get into
> this problem.

np, i'll poke around a bit.  i'm ok with merging this driver now since
it seems to be functionality equivalent to the old code.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
