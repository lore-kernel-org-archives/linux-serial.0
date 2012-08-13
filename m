From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Mon, 13 Aug 2012 17:26:55 +0200
Message-ID: <20120813152654.GA5091@redhat.com>
References: <4FE886C6.7090606@redhat.com>
 <20120626152159.2a34dcaf@pyramind.ukuu.org.uk>
 <50094C8E.5010308@redhat.com>
 <20120720161123.58fc9703@pyramind.ukuu.org.uk>
 <50221C30.20607@redhat.com>
 <20120808100019.6ca011a9@pyramind.ukuu.org.uk>
 <502256E8.5040300@redhat.com>
 <5022779F.8060309@redhat.com>
 <20120808162725.713e7a61@pyramind.ukuu.org.uk>
 <20120809111620.GA3516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab2HMP1I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2012 11:27:08 -0400
Content-Disposition: inline
In-Reply-To: <20120809111620.GA3516@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stanislav Kozina <skozina@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Thu, Aug 09, 2012 at 01:16:20PM +0200, Stanislaw Gruszka wrote:
> On Wed, Aug 08, 2012 at 04:27:25PM +0100, Alan Cox wrote:
> > On Wed, 08 Aug 2012 16:28:47 +0200
> > Stanislav Kozina <skozina@redhat.com> wrote:
> > 
> > > Fix possible panic caused by unlocked access to tty->read_cnt in 
> > > while-loop condition in n_tty_read().
> > 
> > Should this also be removing the BUG_ON check you noted in the other
> > email was not valid now ?
> 
> You talk about 
> http://marc.info/?l=linux-serial&m=134318985920881&w=2
> 
> Is possible that we can call n_tty_read() after n_tty_close() ? How oterwise
> tty->read_buf could become NULL?
> 
> If I understand correctly Stanislav's patch solve below race condtion:
> 
> CPU0					CPU1
> n_tty_read:				reset_buffer_flags:
> 
> while (nr && tty->read_cnt) {
> 
>   					spin_lock_irqsave(&tty->read_lock, flags);
> 					tty->read_head = tty->read_tail = tty->read_cnt = 0;
>   					spin_lock_irqsave(&tty->read_lock, flags);
> 
>   spin_lock_irqsave(&tty->read_lock, flags);
>   
>   tty->read_cnt--;
> 
>   spin_lock_irqsave(&tty->read_lock, flags);
> 
>   /* Now tty->read_cnt is negative */
> 
> }
> 
> what itself could have varsious nasty consequences, i.e. ininite
> loop. Is also possible that negative tty->read_cnt would result in
> tty->read_buf == NULL ? If so, I'm not quite understand that.

I looked a bit more at this. Excluding memory corruption which could
zero tty struct, the only possibility to nullify tty->read_buf is
call to n_tty_close(). So NULL pointer dereference on n_tty_read,
in "while (nr && tty->read_cnt)" loop can only be caused by calling
n_tty_close(), while performing n_tty_read().

Stanislav patch solve that problem because we do not touch tty->read_buf
any longer once tty->read_cnt become 0, and because n_tty_close() clear
tty->read_cnt (by calling n_tty_flush_buffer() -> reset_buffer_flags()).

However looks like main problem persist, we should never do
n_tty_read() after/during n_tty_close() and before n_tty_open(). That
must be an issue in upper layer i.e. tty_io and tty_ldisc, which should
give guarantee about ->close(), ->read(), ->open() ordering. I'm going
to look at that more closely.

Stanislaw
