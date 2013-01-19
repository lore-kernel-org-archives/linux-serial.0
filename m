From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: Correct tty buffer flush.
Date: Fri, 18 Jan 2013 16:07:08 -0800
Message-ID: <20130119000708.GA32591@kroah.com>
References: <50BDF661.30303@ilyx.ru>
 <20121204141223.2ecb0f76@pyramind.ukuu.org.uk>
 <50F66AE4.2030408@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50F66AE4.2030408@ilyx.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 16, 2013 at 12:55:00PM +0400, Ilya Zykov wrote:
>   The root of problem is carelessly zeroing pointer(in function __tty_buffer_flush()),
> when another thread can use it. It can be cause of "NULL pointer dereference".
>   Main idea of the patch, this is never free last (struct tty_buffer) in the active buffer.
> Only flush the data for ldisc(buf->head->read = buf->head->commit).
> At that moment driver can collect(write) data in buffer without conflict.
> It is repeat behavior of flush_to_ldisc(), only without feeding data to ldisc.
> 
> Also revert:
>   commit c56a00a165712fd73081f40044b1e64407bb1875
>   tty: hold lock across tty buffer finding and buffer filling
> In order to delete the unneeded locks any more.

This patch doesn't apply to my tty-next branch, can you redo it against
linux-next so that I can apply it?

thanks,

greg k-h
