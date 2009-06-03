From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 04/11] Blackfin SPORT UART: fix overrun errors
Date: Wed, 3 Jun 2009 04:03:46 -0400
Message-ID: <8bd0f97a0906030103i64bc1a9duc5aeaea7bd3f8365@mail.gmail.com>
References: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
	 <1243926700-30485-4-git-send-email-vapier@gentoo.org>
	 <20090602100018.415b1dfc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:40846 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbZFCIDp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jun 2009 04:03:45 -0400
In-Reply-To: <20090602100018.415b1dfc@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>

On Tue, Jun 2, 2009 at 05:00, Alan Cox wrote:
> On Tue, =C2=A02 Jun 2009 03:11:33 -0400 Mike Frysinger wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>>
>> Push the ty_flip_buffer_push() call from the IRQ handler to a timer =
so as
>> to improve performance and decrease likelihood of overruns.
>
> This should have no effect on a modern kernel.

well, we wouldnt be making changes if we werent seeing data overruns to=
day

> There is 64K of queueing between you and the ldisc nowdays.

i dont think that really matters ... we do too much work in the
interrupt and so we miss new data

> Furthermore unless you set tty->low_latency the kernel already basica=
lly
> does this aggregation for you as the buffer push queues stuff for the=
 ldisc
> to wake up and process.

i guess we could try setting the low_latency bool instead and see if
that fixes things
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
