From: Greg KH <greg@kroah.com>
Subject: Re: Serial Core crash in tty_open
Date: Wed, 28 May 2014 07:37:26 -0700
Message-ID: <20140528143726.GD24698@kroah.com>
References: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
 <CAKnSG-bX89qBe-TJUAJBTBGS1Y9sq3sc4L9GBrwKpxUxE2QHKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41920 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753791AbaE1Oh2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 10:37:28 -0400
Content-Disposition: inline
In-Reply-To: <CAKnSG-bX89qBe-TJUAJBTBGS1Y9sq3sc4L9GBrwKpxUxE2QHKw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Abhijit Lamsoge <abhijitelinux@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, May 28, 2014 at 02:34:07PM +0530, Abhijit Lamsoge wrote:
> Hi All,
> Crash Starts here.
> 
>  1498.722292] ------------[ cut here ]------------
> [ 1498.722305] WARNING: CPU: 3 PID: 5029 at
> /build/buildd/linux-3.13.0/drivers/tty/tty_io.c:1474
> tty_init_dev+0x1d0/0x1e0()
> [ 1498.722308] tty_init_dev:  driver does not set tty->port. This will
> crash the kernel later. Fix the driver!

Doesn't this explain the issue well enough?

