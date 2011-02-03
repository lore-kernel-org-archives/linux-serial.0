From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] serial: bfin_5xx: split uart RX lock
 from uart port lock to avoid deadlock
Date: Thu, 3 Feb 2011 16:56:30 -0500
Message-ID: <AANLkTi=hXukoc6hd7+0zC-eO36wrheMr_xUCDPQBee4P@mail.gmail.com>
References: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
 <AANLkTi=Kp6ix8j5dG6RTySZcScTnRBKsVReTp7v0Y8XP@mail.gmail.com> <20110203183242.GA20886@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38663 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab1BCV4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2011 16:56:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id 18so1522716iyj.19
        for <linux-serial@vger.kernel.org>; Thu, 03 Feb 2011 13:56:50 -0800 (PST)
In-Reply-To: <20110203183242.GA20886@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Thu, Feb 3, 2011 at 13:32, Greg KH wrote:
> On Thu, Feb 03, 2011 at 01:29:08AM -0500, Mike Frysinger wrote:
>> On Tue, Jan 11, 2011 at 00:16, Mike Frysinger wrote:
>> > From: Sonic Zhang <sonic.zhang@analog.com>
>> >
>> > The RX lock is used to protect the RX buffer from concurrent acces=
s in DMA
>> > mode between the timer and RX interrupt routines. =C2=A0It is inde=
pendent from
>> > the uart lock which is used to protect the TX buffer. =C2=A0It is =
possible for
>> > a uart TX transfer to be started up from the RX interrupt handler =
if low
>> > latency is enabled. =C2=A0So we need to split the locks to avoid d=
eadlocking in
>> > this situation.
>> >
>> > In PIO mode, the RX lock is not necessary because the handle_simpl=
e_irq
>> > and handle_level_irq functions ensure driver interrupt handlers ar=
e called
>> > once on one core.
>> >
>> > And now that the RX path has its own lock, the TX interrupt has no=
thing to
>> > do with the RX path, so disabling it at the same time.
>>
>> ping ...
>
> Is this needed for .38?

it fixes a possible deadlock that exists in current .38 rc, but i
wouldnt call it a "critical" fix as it only affects certain edge
cases.  so if you want to merge for .38 or .39, either is OK for us i
think.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
