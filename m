From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: Fix race condition if flushing tty flip buffers
Date: Mon, 8 Apr 2013 11:48:04 -0700
Message-ID: <20130408184804.GA4066@kroah.com>
References: <5149AFD0.8020604@izyk.ru>
 <1363800043-21449-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40558 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935047Ab3DHSsK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 14:48:10 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so3402345pad.39
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 11:48:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363800043-21449-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ilya Zykov <linux@izyk.ru>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Mar 20, 2013 at 01:20:43PM -0400, Peter Hurley wrote:
> As Ilya Zykov identified in his patch 'PROBLEM: Race condition in
> tty buffer's function flush_to_ldisc()', a race condition exists
> which allows a parallel flush_to_ldisc() to flush and free the tty
> flip buffers while those buffers are in-use. For example,
> 
>   CPU 0                         |  CPU 1                                  |  CPU 2
>                                 | flush_to_ldisc()                        |
>                                 |  grab spin lock                         |
> tty_buffer_flush()              |                                         | flush_to_ldisc()
>  wait for spin lock             |                                         |  wait for spin lock
>                                 |   if (!test_and_set_bit(TTYP_FLUSHING)) |
>                                 |    while (next flip buffer)             |
>                                 |     ...                                 |
>                                 |     drop spin lock                      |
>   grab spin lock                |                                         |
>    if (test_bit(TTYP_FLUSHING)) |                                         |
>     set_bit(TTYP_FLUSHPENDING)  |      receive_buf()                      |
>     drop spin lock              |                                         |
>                                 |                                         |   grab spin lock
>                                 |                                         |    if (!test_and_set_bit(TTYP_FLUSHING))
>                                 |                                         |    if (test_bit(TTYP_FLUSHPENDING))
>                                 |                                         |    __tty_buffer_flush()
> 
> CPU 2 has just flushed and freed all tty flip buffers while CPU 1 is
> transferring data from the head flip buffer.
> 
> The original patch was rejected under the assumption that parallel
> flush_to_ldisc() was not possible. Because of necessary changes to
> the workqueue api, work items can execute in parallel on SMP.
> 
> This patch differs slightly from the original patch by testing for
> a pending flush _after_ each receive_buf(), since TTYP_FLUSHPENDING
> can only be set while the lock is dropped around receive_buf().
> 
> Reported-by: Ilya Zykov <linux@izyk.ru>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/tty_buffer.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

What tree is this against?  Does it need your other larger set of ldisc
patches, or can it be applied without it?

confused,

greg k-h
