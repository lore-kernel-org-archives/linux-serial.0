From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Tue, 14 Aug 2012 13:15:57 +0200
Message-ID: <502A336D.7070304@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <5022779F.8060309@redhat.com> <20120808162725.713e7a61@pyramind.ukuu.org.uk> <20120809111620.GA3516@redhat.com> <20120813152654.GA5091@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815Ab2HNLQI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Aug 2012 07:16:08 -0400
In-Reply-To: <20120813152654.GA5091@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


> I looked a bit more at this. Excluding memory corruption which could
> zero tty struct, the only possibility to nullify tty->read_buf is
> call to n_tty_close(). So NULL pointer dereference on n_tty_read,
> in "while (nr&&  tty->read_cnt)" loop can only be caused by calling
> n_tty_close(), while performing n_tty_read().

Correct.

> Stanislav patch solve that problem because we do not touch tty->read_buf
> any longer once tty->read_cnt become 0, and because n_tty_close() clear
> tty->read_cnt (by calling n_tty_flush_buffer() ->  reset_buffer_flags()).

Correct.

> However looks like main problem persist, we should never do
> n_tty_read() after/during n_tty_close() and before n_tty_open(). That
> must be an issue in upper layer i.e. tty_io and tty_ldisc, which should
> give guarantee about ->close(), ->read(), ->open() ordering.

Correct.

> I'm going
> to look at that more closely.

Thanks a lot;-)

Regards,
-Stanislav
