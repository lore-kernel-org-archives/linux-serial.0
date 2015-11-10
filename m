From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: 4.3 serial driver crashes with console shortly after boot
Date: Mon, 9 Nov 2015 20:52:41 -0500
Message-ID: <56414DE9.20707@hurleysoftware.com>
References: <20151110002939.GG3533@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110002939.GG3533@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andi,

On 11/09/2015 07:29 PM, Andi Kleen wrote:
> 
> Hi,
> 
> With 4.3 an x86 server is always crashing roughly a minute after boot
> in __uart_start/uart_tx_stopped. This is repeatable over multiple boots.

Sorry about that. There was a similar report about this with 4.2 which
I thought was fixed by:

commit e144c58cad6667876173dd76977e9e6557e34941
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Sun Jul 12 21:05:26 2015 -0400

    serial: core: Fix crashes while echoing when closing


> The back trace is
> flush_to_ldisc->n_tty_receive_buf2->n_tty_receive_buf_common->
> commit_echoes-> uart_flush_chars->uart_start
> 
> It seems to follow a bad pointer here 
> 
> ffffffff813bbdfa:       f6 80 f4 01 00 00 01    testb  $0x1,0x1f4(%rax)
> <---
> ffffffff813bbe01:       74 01                   je     ffffffff813bbe04
> <__uart_start.isra.1+0x24>
> 
> Unfortunately I don't have the contents of RAX which scrolled away,
> but since CR2 is 1f4 I suspect it's NUL.
> 
> It seems to depend on the order of the console=... arguments on the
> kernel command line. With console=tty0 console=ttyS0,115200n8 it
> crashes, but when reversing the options it does not crash.

I've just tried to reproduce this without success on my current
tree which has some additional patches I just posted this am. They weren't
intended to fix crashes but they directly impact the area of concern. Could
you try these three?

[PATCH v2 2/4] n_tty: Ignore all read data when closing
[PATCH v2 3/4] tty: Abstract and encapsulate tty->closing behavior
[PATCH v2 4/4] tty: Remove drivers' extra tty_ldisc_flush()

links to those patches

https://lkml.org/lkml/2015/11/9/260
https://lkml.org/lkml/2015/11/9/259
https://lkml.org/lkml/2015/11/9/261

Regards,
Peter Hurley
