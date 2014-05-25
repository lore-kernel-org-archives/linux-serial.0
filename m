From: Prasad Koya <prasad.koya@gmail.com>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Sat, 24 May 2014 18:22:02 -0700
Message-ID: <CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
	<20140525003642.GC6946@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:60326 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaEYB3B (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 May 2014 21:29:01 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so7811462veb.24
        for <linux-serial@vger.kernel.org>; Sat, 24 May 2014 18:28:59 -0700 (PDT)
In-Reply-To: <20140525003642.GC6946@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

Thanks for looking into this.

With 16550A, I'm seeing this weird issue with 3.4 kernel. At random
times 8250 driver reads 0xcc out of IIR. I'm not sure why bit 2 is
set.

#define UART_IIR_BUSY           0x07 /* DesignWare APB Busy Detect */

Soon after this I'm running into "serial8250: too much work for irq4".
And this is printed after iterating 512 times in 8250_interrupt
handler. This message is printed one more time right after this and it
appears that console does not work after those messages. I was
suspicious about that 'busy detect' bit. Am trying to reproduce this
and see what is in LCR when this hits. Can I (or how do I) reset the
device if I see this bit set?

On Sat, May 24, 2014 at 5:36 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, May 23, 2014 at 10:08:49AM -0700, Prasad Koya wrote:
>>
>> I don't see anyone in kernel using UART_IIR_BUSY bit except Designware
>> serial driver. We are using 8250 driver for our 16550A and
>> occasionally we see UART_IIR_BUSY set and soon after that console is
>> hosed. In what situations is this bit set? I don't see much
>> documentation for this.
>
> UART_IIR_BUSY is not a bit, it's a magic bit pattern, which is I
> believe a Designware-specific hack.  As far as standard
> 8250-compatible UART's are concerned, if the low bit (bit 0) is set in
> the IIR register, there are no interrupts pending, and so you
> shouldn't need to check the 0x06 bits (i.e., bits 1 and 2).
>
>                                       - Ted
