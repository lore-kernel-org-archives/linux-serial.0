From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [GIT PATCH] TTY patches for 3.7-rc1
Date: Mon, 01 Oct 2012 23:48:58 +0200
Message-ID: <506A0FCA.2020908@suse.cz>
References: <20121001183046.GA13042@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59454 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab2JAVtC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Oct 2012 17:49:02 -0400
In-Reply-To: <20121001183046.GA13042@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stanislav Kozina <skozina@redhat.com>

On 10/01/2012 08:30 PM, Greg KH wrote:
> Stanislav Kozina (2):
>       tty: Fix possible race in n_tty_read()

The (pretty hopeless) commit log says:
    Fix possible panic caused by unlocked access to tty->read_cnt in
    while-loop condition in n_tty_read().

Just curious, what kind of panic that can cause, can you be more
concrete on that? I suppose two readers, one eats everything, the other
is a killer? And should we backport to -stable?

thanks,
-- 
js
suse labs
