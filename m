From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: Patch for panic in n_tty_read()
Date: Fri, 20 Jul 2012 14:18:22 +0200
Message-ID: <50094C8E.5010308@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab2GTMSc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Jul 2012 08:18:32 -0400
In-Reply-To: <20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Alan,

My apologizes for really late response, I completely missed your email:-/
>> We had few customers who met panics in n_tty_read() with following
>> backtrace:
>>
>>        #8 [ffff880018b8dcd0] page_fault at ffffffff814ddfe5
>>           [exception RIP: n_tty_read+0x2c9]
>> <register output removed>
>>        #9 [ffff880018b8dea0] tty_read at ffffffff81300b16
>>       #10 [ffff880018b8def0] vfs_read at ffffffff81172f85
>>       #11 [ffff880018b8df30] sys_read at ffffffff811730c1
>>       #12 [ffff880018b8df80] system_call_fastpath at ffffffff8100b172
> What serial driver are they using when they hit this ?

 From kernel log:
kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
kernel: 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kernel: 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

>
>> My patch for this panic is attached (tty_panic.patch), in short - I
>> believe that we need to hold&tty->read_lock while checking
>> tty->read_cnt in while-loop condition in n_tty_read() here:
> We can't hold the lock for the loop because we touch user space memory.

You mean call to tty_put_user(), correct? Thanks for this catch.
So what about to unlock the lock for this time? Because we need to hold 
the lock while checking tty->read_cnt in the while loop condition, correct?

Thanks and regards,
-Stanislav Kozina
