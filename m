From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Fri, 4 May 2012 16:54:12 -0700
Message-ID: <20120504235412.GA5694@kroah.com>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk>
 <20120503212219.568.15653.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120503212219.568.15653.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2012 at 10:24:08PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> In each remaining case the tty_lock is associated with a specific tty. This
> means we can now lock on a per tty basis. We do need tty_lock_pair() for
> the pty case. Uglier but still a step in the right direction.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
>  drivers/tty/amiserial.c   |   12 ++++----
>  drivers/tty/cyclades.c    |    2 +
>  drivers/tty/n_r3964.c     |   11 ++++---
>  drivers/tty/pty.c         |   23 +++++++++------
>  drivers/tty/synclink.c    |    4 +--
>  drivers/tty/synclink_gt.c |    4 +--
>  drivers/tty/synclinkmp.c  |    4 +--
>  drivers/tty/tty_io.c      |   67 +++++++++++++++++++++++++++------------------
>  drivers/tty/tty_ldisc.c   |   30 ++++++++++----------
>  drivers/tty/tty_mutex.c   |   60 ++++++++++++++++++++++++++++++----------
>  drivers/tty/tty_port.c    |    6 ++--
>  include/linux/tty.h       |   23 +++++++++------
>  12 files changed, 149 insertions(+), 97 deletions(-)

You forgot the call in net/bluetooth/rfcomm/tty.c, I'll go fix that
up...
