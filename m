From: Greg KH <greg@kroah.com>
Subject: Re: Serial Core crash in tty_open
Date: Wed, 28 May 2014 07:36:50 -0700
Message-ID: <20140528143650.GC24698@kroah.com>
References: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51017 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705AbaE1Ogw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 10:36:52 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC6FC21263
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2014 10:36:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Abhijit Lamsoge <abhijitelinux@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, May 28, 2014 at 02:25:06PM +0530, Abhijit Lamsoge wrote:
> Hi All,
> I had written a char/serial driver for Kernel 3.0 to 3.1 in old times
> and it used to work absolutely fine.
> Now I need this driver for some bluetooth, virtual mount-point for
> data transfer to and fro to mobile,
> for kernel version 3.8 onwards, however, there is a big crash, when I
> do any data transfer on the uart_port created by this driver.

Lots of things have changed in the serial / tty layer since 3.0 days.

Why not post your code to be merged into the kernel tree so that this
doesn't happen in the future when apis change again?

greg k-h
