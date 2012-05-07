From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Mon, 07 May 2012 23:04:18 +0200
Message-ID: <4FA838D2.9000908@suse.cz>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk> <20120503212219.568.15653.stgit@bob.linux.org.uk> <CA+1xoqezLCQh_fqJ1iNAs25X7Fm24W=-0J8zTZuVVJQnWTtSLg@mail.gmail.com> <20120507171126.5beddc27@pyramind.ukuu.org.uk> <1336408208.3638.15.camel@lappy> <20120507174240.4209c5cb@pyramind.ukuu.org.uk> <CA+1xoqez0PaX2KBHHN-etztwbFoU1cKx3NwMXX+PO4SguA3bRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48590 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab2EGVEX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 17:04:23 -0400
In-Reply-To: <CA+1xoqez0PaX2KBHHN-etztwbFoU1cKx3NwMXX+PO4SguA3bRg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On 05/07/2012 07:00 PM, Sasha Levin wrote:
>> So whatever your trace is showing, that's not the bug. Something more
>> complicated would appear to be afoot.
> 
> Oddly enough, tty != tty->link, but the lockdep warning triggers.
> 
> Any idea why it might happen?

I think so, both locks are the same lockdep class. So lockdep thinks it
is the same lock. However this is a false positive. I guess we need
mutex_lock_nested...

regards,
-- 
js
suse labs

