From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch for panic in n_tty_read()
Date: Tue, 26 Jun 2012 15:21:59 +0100
Message-ID: <20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
References: <4FE886C6.7090606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44736 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894Ab2FZOSN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jun 2012 10:18:13 -0400
In-Reply-To: <4FE886C6.7090606@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

> We had few customers who met panics in n_tty_read() with following 
> backtrace:
> 
>       #8 [ffff880018b8dcd0] page_fault at ffffffff814ddfe5
>          [exception RIP: n_tty_read+0x2c9]
> <register output removed>
>       #9 [ffff880018b8dea0] tty_read at ffffffff81300b16
>      #10 [ffff880018b8def0] vfs_read at ffffffff81172f85
>      #11 [ffff880018b8df30] sys_read at ffffffff811730c1
>      #12 [ffff880018b8df80] system_call_fastpath at ffffffff8100b172

What serial driver are they using when they hit this ?

> 
> My patch for this panic is attached (tty_panic.patch), in short - I 
> believe that we need to hold &tty->read_lock while checking 
> tty->read_cnt in while-loop condition in n_tty_read() here:

We can't hold the lock for the loop because we touch user space memory.

Alan
