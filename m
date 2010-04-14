From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC PATCH 0/2] serial 8250 platform PM hooks
Date: Wed, 14 Apr 2010 19:39:41 +0200
Message-ID: <t2wf861ec6f1004141039kf25acdddrb1e4639c17ecc8f6@mail.gmail.com>
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:39031 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab0DNRjo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Apr 2010 13:39:44 -0400
In-Reply-To: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>

Ping?  Noone interested?

On Wed, Mar 24, 2010 at 7:16 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> The following 2 patches implement a PM hook for platform 8250
> UARTs and a sample PM implementation for a MIPS SoC.
>
> Patch #1 hooks a new .pm callback in struct plat_serial8250_port to
> the rest of serial_core's PM infrastructure,
>
> Patch #2 implements uart power gating for Alchemy line of mips socs
> using the new hook.
>
> With these 2 patches serial console on my test system survives
> suspend/resume cycles without having to resort to platform-specific
> hacks in the PM code.
>
> Thanks,
> =A0 =A0 Manuel Lauss
>
> Manuel Lauss (2):
> =A08250: allow platform uarts to install PM callback.
> =A0Alchemy: UART PM through serial framework.
>
> =A0arch/mips/alchemy/common/platform.c | =A0 17 +++++++++++++++++
> =A0arch/mips/alchemy/common/power.c =A0 =A0| =A0 32 -----------------=
---------------
> =A0drivers/serial/8250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 31 +++++++=
+++++++++++++++++++++---
> =A0include/linux/serial_8250.h =A0 =A0 =A0 =A0 | =A0 =A06 ++++++
> =A04 files changed, 51 insertions(+), 35 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
