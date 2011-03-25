From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] TTY: serial_core, fix dtr_rts NULL dereference
Date: Fri, 25 Mar 2011 11:00:40 +0000
Message-ID: <20110325110040.6866d671@lxorguk.ukuu.org.uk>
References: <4D8C7253.3040204@suse.cz>
	<1301049956-6933-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33638 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751454Ab1CYLAT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2011 07:00:19 -0400
In-Reply-To: <1301049956-6933-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, jirislaby@gmail.com

On Fri, 25 Mar 2011 11:45:56 +0100
Jiri Slaby <jslaby@suse.cz> wrote:

> Under certain circumstances uart_dtr_rts might cause an oops. It dies
> because port->tty is NULL. To fix this, let's take a reference of
> port->tty by tty_port_tty_get. And if it is not there already, fail
> gracefully.

The uart helper layer assumes here (and a couple of other spots) that the
IRQ handler for the tty takes the port lock.

I think the *right* fix is probably to pass port not port->tty into the
helper in the first place but that seems to ripple into a lot of drivers.

(passing port->tty to things that then go tty->port is braindead and
causes half the mess in the tty/serial code)

