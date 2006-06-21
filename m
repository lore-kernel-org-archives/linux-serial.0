From: Alan Cox <alan@redhat.com>
Subject: Re: [Q] New tty flip interface doubt.
Date: Wed, 21 Jun 2006 09:42:08 -0400
Message-ID: <20060621134208.GA12884@devserv.devel.redhat.com>
References: <87hd2epuu6.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932154AbWFUNmJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jun 2006 09:42:09 -0400
Content-Disposition: inline
In-Reply-To: <87hd2epuu6.fsf@javad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Organov <osv@javad.com>
Cc: Alan Cox <alan@redhat.com>, linux-serial@vger.kernel.org

On Wed, Jun 21, 2006 at 04:16:33PM +0400, Sergei Organov wrote:
>   tty_insert_flip_string(tty, data, length);
> 
> instead has slightly more chances to transfer 'length' chars as
> tty_insert_flip_string(), unlike tty_buffer_request_room(), loops to
> find the memory.
> 
> Overall, what's the canonical way to transfer 'length' chars from a
> buffer 'buf' to the tty layer?

tty_insert_flip_string called by itself will try to do the right thing. The
tty_insert_flip_char interface can benefit a lot from you knowing the ideal
buffer size to use so its very useful in the case of 

	int bytes = inw(port->fifo);
	int count = tty_buffer_request_room(tty, bytes);

	while(...) {
		tty_insert_flip_char ..

It is also useful if you want a linear buffer for ease of copying.

In the USB case it may be helpful as it will try and allocate blocks of
memory reflecting the size of the blocks to be pushed to the user rather
than guessing. As you suggest for most cases it probably makes no real difference

