From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 3/4] serial: bfin_5xx: kgdboc should accept gdb break only
	when it is active
Date: Mon, 25 Jan 2010 20:57:57 -0500
Message-ID: <8bd0f97a1001251757p6dd61c85g43b3edcc9f2ce93f@mail.gmail.com>
References: <1263899593-12178-1-git-send-email-vapier@gentoo.org>
	<1263899593-12178-3-git-send-email-vapier@gentoo.org> <20100125161120.74cea0d4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:54197 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0AZB61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jan 2010 20:58:27 -0500
In-Reply-To: <20100125161120.74cea0d4.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

On Mon, Jan 25, 2010 at 19:11, Andrew Morton wrote:
> I expect that we want
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[PATCH 2/4] serial: bfin_5xx: need to disa=
ble DMA TX interrupt too
> and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[PATCH 3/4] serial: bfin_5xx: kgdboc shoul=
d accept gdb break only when it is active
>
> in 2.6.33 and the other two in 2.6.34?
>
> If so then should either of the above two also be backported into
> -stable?

sounds OK to me, thanks
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
