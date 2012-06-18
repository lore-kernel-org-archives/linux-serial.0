From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/tty/tty_io.c: fix a potential memleak at
 do_tty_write()
Date: Mon, 18 Jun 2012 17:04:15 +0100
Message-ID: <20120618170415.4d035911@pyramind.ukuu.org.uk>
References: <4FDF1DDA.3030704@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34622 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab2FRQAe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 12:00:34 -0400
In-Reply-To: <4FDF1DDA.3030704@oracle.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jeff.liu@oracle.com
Cc: linux-serial@vger.kernel.org

On Mon, 18 Jun 2012 20:23:54 +0800
Jeff Liu <jeff.liu@oracle.com> wrote:

> Hello,
> 
> Looks there is a potential memory leak at drivers/tty/tty_io.c: do_tty_write().
> It did allocate a buf_chunk if tty->write_cnt < chunk, however, buf_chunk was not
> freed after the writing is done.  Below tiny patch could fix it.

Why should it be freed, we still have a reference to it.


Alan
