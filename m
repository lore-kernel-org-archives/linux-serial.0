From: Aras Vaichas <aras.vaichas@gmail.com>
Subject: Re: can't detect 16550A at port 0x010 on Vortex86dx board
Date: Mon, 9 Jul 2012 16:15:59 +0100
Message-ID: <CAJkQPOmBQPejYxa7=nW6pczCP+soYgLCxhuGHQMg3MjO0aZVmQ@mail.gmail.com>
References: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
 <20120706235459.5886e2ee@pyramind.ukuu.org.uk> <CAJkQPO=GYpDYOTiQ+Z-cs34=RRwnJLED79Xo4sZXg_Nd_2xM_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33194 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2GIPQl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2012 11:16:41 -0400
Received: by qadb17 with SMTP id b17so1694636qad.19
        for <linux-serial@vger.kernel.org>; Mon, 09 Jul 2012 08:16:40 -0700 (PDT)
In-Reply-To: <CAJkQPO=GYpDYOTiQ+Z-cs34=RRwnJLED79Xo4sZXg_Nd_2xM_A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

> # cat .config
> <snip>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_SERIAL_8250_NR_UARTS=5
> CONFIG_SERIAL_8250_RUNTIME_UARTS=5
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_VORTEX=y
> </snip>

CONFIG_SERIAL_8250_SHARE_IRQ=y

It needed IRQ sharing to make it work.

COM9 on a Vortex86DX is now working in Linux 3.3.8 but it requires
more than a simple serial driver patch.

I'm not entirely sure how to go about creating a proper patch for the
changes I have made. My serial driver writes to the South Bridge, but
it's a quick hack using outl() calls to the right addresses. Should I
use a proper PCI function call?

I also modified the x86 io port mappings in /arch/x86/kernel/setup.c.

Do I either add #ifdef-ery to setup.c, or create a new entry in
arch/x86/kernel/cpu/ and do my different io mappings there?

Aras
