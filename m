From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] serial: bfin_5xx: split uart RX lock
 from uart port lock to avoid deadlock
Date: Thu, 3 Feb 2011 01:29:08 -0500
Message-ID: <AANLkTi=Kp6ix8j5dG6RTySZcScTnRBKsVReTp7v0Y8XP@mail.gmail.com>
References: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47676 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1BCG33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2011 01:29:29 -0500
Received: by iyj18 with SMTP id 18so752391iyj.19
        for <linux-serial@vger.kernel.org>; Wed, 02 Feb 2011 22:29:29 -0800 (PST)
In-Reply-To: <1294723003-8496-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org

On Tue, Jan 11, 2011 at 00:16, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> The RX lock is used to protect the RX buffer from concurrent access i=
n DMA
> mode between the timer and RX interrupt routines. =C2=A0It is indepen=
dent from
> the uart lock which is used to protect the TX buffer. =C2=A0It is pos=
sible for
> a uart TX transfer to be started up from the RX interrupt handler if =
low
> latency is enabled. =C2=A0So we need to split the locks to avoid dead=
locking in
> this situation.
>
> In PIO mode, the RX lock is not necessary because the handle_simple_i=
rq
> and handle_level_irq functions ensure driver interrupt handlers are c=
alled
> once on one core.
>
> And now that the RX path has its own lock, the TX interrupt has nothi=
ng to
> do with the RX path, so disabling it at the same time.

ping ...
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
