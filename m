From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 03/12] serial_core: Handle TIOC[GS]RS485 ioctls.
Date: Thu, 9 Oct 2014 10:07:38 +0200
Message-ID: <CAPybu_3b6epYcQ1c0L0E1so7BNJ7DndA4E2nHDfj8OYjR3u0Zw@mail.gmail.com>
References: <1412798258-23655-1-git-send-email-ricardo.ribalda@gmail.com>
 <1412798258-23655-4-git-send-email-ricardo.ribalda@gmail.com> <1412799101.28467.68.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:56421 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaJIIH7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2014 04:07:59 -0400
In-Reply-To: <1412799101.28467.68.camel@acox1-desk.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, LKML <linux-kernel@vger.kernel.org>

Hello Alan

>
> What is the locking between setting/getting/driver use of the config ?
> This really needs a lock (termios sem I think is perhaps appropriate
> given when the values are normally referenced).

I tried implementing it with the sermios sem
((&(uart_port)->state->port.tty->termios_rwsem)), but some drivers
access the rs485 structure inside their irq handler. So I have see
options here

1) Protect the structure with uart_port->lock spinlock
2) Assume that an assignment is atomic on critical sections where I
cannot hold the rwsem.

I think 1) is more correct. Any issues that I continue in this
direction? Any better idea?


Thanks!

-- 
Ricardo Ribalda
