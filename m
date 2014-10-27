From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 20/27] tty: Refactor __tty_hangup to enable lockdep
 annotation
Date: Mon, 27 Oct 2014 18:13:48 -0400
Message-ID: <544EC39C.3010703@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com> <1413491125-20134-21-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-21-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On 10/16/2014 04:25 PM, Peter Hurley wrote:
> Refactor __tty_hangup() into:
> 1. __tty_hangup_common(), the portion requiring the tty lock
> 2. __tty_hangup(), which performs the pre- and post-lock processing
>    (TIOCCONS redirect undo) and calls through a function ptr parameter
>    to lock/hangup/unlock
> 3. __tty_hangup_standard(), which performs the lock/hangup/unlock
> 
> Allows an alternate function to lock/hangup/unlock with the
> nested tty lock.

I just discovered that lockdep provides an interface for setting the
lock subclass after lock initialization. Which means that the lock
subclass can be changed just for slave ptys, which allows lock nesting
without specifying the subclass at lock time. Which eliminates the need
for this patch and the follow-on.

I'll respin this series.

Regards,
Peter Hurley
