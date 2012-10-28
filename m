From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PATCH] TTY patches for 3.7-rc1
Date: Sun, 28 Oct 2012 15:22:16 +0000
Message-ID: <20121028152216.2339f828@pyramind.ukuu.org.uk>
References: <20121001183046.GA13042@kroah.com>
	<506A0FCA.2020908@suse.cz>
	<20121001221350.GA10172@kroah.com>
	<508D033E.8030109@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56845 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2J1PRN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Oct 2012 11:17:13 -0400
In-Reply-To: <508D033E.8030109@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, Stanislav Kozina <skozina@redhat.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, 28 Oct 2012 11:04:46 +0100
Jiri Slaby <jslaby@suse.cz> wrote:

> On 10/02/2012 12:13 AM, Greg KH wrote:
> > On Mon, Oct 01, 2012 at 11:48:58PM +0200, Jiri Slaby wrote:
> >> On 10/01/2012 08:30 PM, Greg KH wrote:
> >>> Stanislav Kozina (2):
> >>>       tty: Fix possible race in n_tty_read()
> >>
> >> The (pretty hopeless) commit log says:
> >>     Fix possible panic caused by unlocked access to tty->read_cnt in
> >>     while-loop condition in n_tty_read().
> >>
> >> Just curious, what kind of panic that can cause, can you be more
> >> concrete on that? I suppose two readers, one eats everything, the other
> >> is a killer? And should we backport to -stable?
> > 
> > Stanislav, you are the one who could reproduce this, any answers here?
> 
> Ping?

Thread here

http://permalink.gmane.org/gmane.linux.serial/8365
