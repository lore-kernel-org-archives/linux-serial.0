From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/9] [RFC] tty : make receive_room internal to N_TTY
 line discipline
Date: Mon, 5 Mar 2012 23:42:34 +0000
Message-ID: <20120305234234.12df898f@pyramind.ukuu.org.uk>
References: <20120304190513.0b7a881b@mat-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56806 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2CEXkk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 18:40:40 -0500
In-Reply-To: <20120304190513.0b7a881b@mat-laptop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>

I had a bigger dig into this and I think the path to make it workable is
probably

- Finish getting rid of the tty_lock (ie the last remnants of the BKL)

- At that point we can rework the logic in tty_ldisc a bit and you can
  then hold tty->ldisc_mutex across the entire ldisc_receive. That will
  be a natural sane way to lock the ldisc.

- Once that is in place it is possible to fix TIOCSTI and selection using
  that mutex to single thread.

- Which then lets you fix the receive_room logic because its all running
  under a sensible locking model.

I don't see any shortcuts here.

Alan
