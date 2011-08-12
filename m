From: real mz <realmz6@gmail.com>
Subject: Re: [PATCH v2] serial:bfin_uart: Put TX IRQ in individual platform resource.
Date: Fri, 12 Aug 2011 10:39:25 +0800
Message-ID: <CAMk6uBnwL8Y+QFRYKux6LxXT1zkgEKzMtUhNEjD6UFL5tARYiA@mail.gmail.com>
References: <1312256727-13906-1-git-send-email-sonic.adi@gmail.com>
	<CAMjpGUeeNZ_S9hgz8pi-uTnJdcUjemuOusNa=fJ9muPPaSQLMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43941 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1HLCj0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Aug 2011 22:39:26 -0400
In-Reply-To: <CAMjpGUeeNZ_S9hgz8pi-uTnJdcUjemuOusNa=fJ9muPPaSQLMQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Sonic Zhang <sonic.adi@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

you mean the uart wakeup fix?
-steven

On Fri, Aug 12, 2011 at 10:17 AM, Mike Frysinger <vapier.adi@gmail.com>=
 wrote:
> On Mon, Aug 1, 2011 at 23:45, Sonic Zhang wrote:
>> Serial TX IRQ is not RX IRQ plus 1 in some blackfin chips.
>> Give individual platform resources to both TX and RX irqs.
>
> i guess you also need to fold in Scott's recent fix and send out a v3
> -mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
