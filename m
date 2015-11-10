From: Andi Kleen <andi@firstfloor.org>
Subject: 4.3 serial driver crashes with console shortly after boot
Date: Tue, 10 Nov 2015 01:29:39 +0100
Message-ID: <20151110002939.GG3533@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter@hurleysoftware.com
List-Id: linux-serial@vger.kernel.org


Hi,

With 4.3 an x86 server is always crashing roughly a minute after boot
in __uart_start/uart_tx_stopped. This is repeatable over multiple boots.

The back trace is
flush_to_ldisc->n_tty_receive_buf2->n_tty_receive_buf_common->
commit_echoes-> uart_flush_chars->uart_start

It seems to follow a bad pointer here 

ffffffff813bbdfa:       f6 80 f4 01 00 00 01    testb  $0x1,0x1f4(%rax)
<---
ffffffff813bbe01:       74 01                   je     ffffffff813bbe04
<__uart_start.isra.1+0x24>

Unfortunately I don't have the contents of RAX which scrolled away,
but since CR2 is 1f4 I suspect it's NUL.

It seems to depend on the order of the console=... arguments on the
kernel command line. With console=tty0 console=ttyS0,115200n8 it
crashes, but when reversing the options it does not crash.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
