From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -next 00/10] Fixes to controlling tty handling
Date: Wed, 22 Oct 2014 16:00:04 +0100
Message-ID: <20141022160004.11be0850@alan.etchedpixels.co.uk>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Thu, 16 Oct 2014 14:59:40 -0400
Peter Hurley <peter@hurleysoftware.com> wrote:

> Hi Greg,
> 
> This patch series:
> 1. removes stale code from the controlling tty handling functions
> 2. relocates the ctty functions to eliminate forward declarations
> 3. fixes several unsafe races when setting the controlling tty
> 4. eliminates holding tty_mutex as a necessary condition of
>    setting the controlling terminal
> 
> #4 is part of an overall effort to reduce the tty_mutex footprint.
> 
> Unfortunately, this series does not fix two other race conditions:
> 1. disassociate_ctty()/no_tty() does not teardown the tty<->process
> associations atomically wrt job control, so it is possible to
> observe spurious error conditions from job control (tty_check_change()
> and job_control()). I'm looking into inverting the lock order of
> tty->ctrl_lock and tsk->sighand->siglock() to see if holding ctrl_lock
> is a suitable solution for atomic teardown. Especially now that
> ctrl_lock is not used for flow control anymore :)
> 2. task_pgrp() and task_session() are used unsafely. These fixes
> will be clearer after #1 is fixed.


Reviewed-by: Alan Cox <alan@linux.intel.com>

I can't prove entirely to my satisfaction that the claim in #9 is true in
the presence of simultaenous hangups opens and setsid but the locking
appears to be correct for the cases I was trying to figure out anyway.

Makes my head hurt just reviewing bits of this so thanks for doing all
this work !
