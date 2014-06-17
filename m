From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH tty-next 14/22] tty: Remove tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 10:00:59 +0200
Message-ID: <4575870.N9RCpZ4UMg@wuerfel>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com> <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Karsten Keil <isdn@linux-pingi.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 16 June 2014 09:17:11 Peter Hurley wrote:
> tty_wait_until_sent_from_close() drops the tty lock while waiting
> for the tty driver to finish sending previously accepted data (ie.,
> data remaining in its write buffer and transmit fifo).
> 
> However, dropping the tty lock is a hold-over from when the tty
> lock was system-wide; ie., one lock for all ttys.
> 
> Since commit 89c8d91e31f267703e365593f6bfebb9f6d2ad01,
> 'tty: localise the lock', dropping the tty lock has not been necessary.
> 
> CC: Karsten Keil <isdn@linux-pingi.de>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

I don't understand the second half of the changelog, it doesn't seem
to fit here: there deadlock that we are trying to avoid here happens
when the *same* tty needs the lock to complete the function that
sends the pending data. I don't think we do still do that any more,
but it doesn't seem related to the tty lock being system-wide or not.

	Arnd
