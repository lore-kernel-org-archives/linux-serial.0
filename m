From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: Correct tty buffer flush.
Date: Tue, 4 Dec 2012 14:12:23 +0000
Message-ID: <20121204141223.2ecb0f76@pyramind.ukuu.org.uk>
References: <50BDF661.30303@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50BDF661.30303@ilyx.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 04 Dec 2012 17:10:57 +0400
Ilya Zykov <ilya@ilyx.ru> wrote:

>   The root of problem is carelessly zeroing pointer(in function __tty_buffer_flush()),
> when another thread can use it. It can be cause of "NULL pointer dereference".
>   Main idea of the patch, this is never free last (struct tty_buffer) in the active buffer.
> Only flush the data for ldisc(tty->buf.head->read = tty->buf.head->commit).
> At that moment driver can collect(write) data in buffer without conflict.
> It is repeat behavior of flush_to_ldisc(), only without feeding data to ldisc.
> 
> Also revert:
>   commit c56a00a165712fd73081f40044b1e64407bb1875
>   tty: hold lock across tty buffer finding and buffer filling
> In order to delete the unneeded locks any more.
> 
> Signed-off-by: Ilya Zykov <ilya@ilyx.ru>

Acked-by: Alan Cox <alan@linux.intel.com>
