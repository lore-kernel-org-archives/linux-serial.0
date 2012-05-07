From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Mon, 7 May 2012 17:11:26 +0100
Message-ID: <20120507171126.5beddc27@pyramind.ukuu.org.uk>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk>
	<20120503212219.568.15653.stgit@bob.linux.org.uk>
	<CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33572 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab2EGQIi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 12:08:38 -0400
In-Reply-To: <CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> I don't believe that this change is correct.
> 
> Consider the following scenario:
> 
> tty_release -> tty_lock -> pty_close -> tty_vhangup -> tty_lock

We hang up tty->link not tty.

It's now a per tty lock. So I think we are ok.

Alan
