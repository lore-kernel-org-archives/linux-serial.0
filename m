From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 1 Feb 2007 12:02:08 +0000
Message-ID: <20070201120208.36ccb530@localhost.localdomain>
References: <6d6a94c50701310249o2b2c8024i4d3f28ec1601246a@mail.gmail.com>
	<20070131162123.67e22e23@localhost.localdomain>
	<6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46886 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422825AbXBALto (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Feb 2007 06:49:44 -0500
In-Reply-To: <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> I implemented the serial driver by myself, :). See the attachment.
> I didn't save/restore terminal setting in the my_set_termios().

Driver looks fine. 

> I trace this back till tty_tioctl(..., unsigned long arg), everytime I
> type "ENTER" key,
> the argument "arg" passed into tty_ioctl() is the address of a termios
> structure, which include wrong c_cflag. It seems once the flag is
> assigned by uart_set_options the first time, it's never changed. So
> even userspace application changed the flag, it will be set back soon.
> I'll dig into it. But I still think it's a bug.

Which application (see from current->pid) seems to be calling the
tty_ioctl with the "wrong flag" ?
