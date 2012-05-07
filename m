From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Mon, 7 May 2012 19:00:24 +0200
Message-ID: <CA+1xoqez0PaX2KBHHN-etztwbFoU1cKx3NwMXX+PO4SguA3bRg@mail.gmail.com>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk>
 <20120503212219.568.15653.stgit@bob.linux.org.uk> <CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com>
 <20120507171126.5beddc27@pyramind.ukuu.org.uk> <1336408208.3638.15.camel@lappy>
 <20120507174240.4209c5cb@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:65025 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756791Ab2EGRAq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 13:00:46 -0400
In-Reply-To: <20120507174240.4209c5cb@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> So whatever your trace is showing, that's not the bug. Something more
> complicated would appear to be afoot.

Oddly enough, tty != tty->link, but the lockdep warning triggers.

Any idea why it might happen?
