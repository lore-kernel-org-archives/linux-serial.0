From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 01/10] TTY: serial, cleanup include file
Date: Wed, 9 Nov 2011 21:59:01 +0000
Message-ID: <20111109215901.16f44570@bob.linux.org.uk>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40661 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab1KIVrz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Nov 2011 16:47:55 -0500
In-Reply-To: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jirislaby@gmail.com

> ...instead of taking and dropping a reference in both uart_insert_char
> and uart_push_chars there. But it may be as well an overkill, as this
> stuff is not time critical. So any opinions? (If not I will proceed
> without ticketing having tty_port_tty_get/put in every call. Like I
> have it now.)

The cure for this is different (and a spot more invasive)

We need to move the tty_buffer objects into the tty_port. At that point
the lifetime becomes

	create device (and tty_port struct)
	request_irq

	lifetime of physical port (ttys come and go)

	free_irq
	free tty_port
	done

and the locking goes away. On the flush_to_ldisc side we know the port
physically exists because the work queue for the ldisc is killed and we
wait for it when we kill off the port (we may need a spot more checking
there)

This needs every tty of all kinds to have a tty_port even if isn't used
for anything else. That also cleans a ton of stuff up because then we
can always put the tty_port in tty->private_data which means we can
clean up some of the glue further.

Alan
