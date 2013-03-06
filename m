From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 0/5] Fix session leader exit hang
Date: Wed, 06 Mar 2013 17:20:42 +0100
Message-ID: <51376CDA.50407@suse.cz>
References: <1362572457-29993-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362572457-29993-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Sasha Levin <levinsasha928@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/06/2013 01:20 PM, Peter Hurley wrote:
> When a session leader exits, it hangs up the controlling tty and
> then signals the foreground group processes with SIGHUP. This sequence
> can hang as reported by Sasha Levin, and noted in the changelog of
> 'tty: Signal SIGHUP before hanging up ldisc'.
> 
> 
> Peter Hurley (5):
>   tty: Refactor session leader SIGHUP from __tty_hangup()
>   tty: Fix spinlock flavor in non-atomic __tty_hangup()
>   tty: Use spin_lock() inside existing critical region
>   tty: Signal foreground group processes in hangup
>   tty: Signal SIGHUP before hanging up ldisc
> 
>  drivers/tty/tty_io.c | 144 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 96 insertions(+), 48 deletions(-)
> 

Hi, all three series look good to me.

-- 
js
suse labs
