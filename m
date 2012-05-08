From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] pty: Lock the devpts bits privately
Date: Tue, 08 May 2012 11:18:35 -0700
Message-ID: <4FA9637B.1060609@zytor.com>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk> <20120503212205.568.25804.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59001 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489Ab2EHSTA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 May 2012 14:19:00 -0400
In-Reply-To: <20120503212205.568.25804.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 05/03/2012 02:22 PM, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> This is a private pty affair, we don't want to tangle it with the tty_lock
> any more as we know all the other non tty locking is now handled by the vfs
> so we too can move.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

> +		        mutex_lock(&devpts_mutex);
>  			devpts_pty_kill(tty->link);
> +		        mutex_unlock(&devpts_mutex);

> +	mutex_lock(&devpts_mutex);
> +	tty = devpts_get_tty(pts_inode, idx);
> +	mutex_unlock(&devpts_mutex);

> +	mutex_lock(&devpts_mutex);
>  	tty = tty_init_dev(ptm_driver, index);
> +	mutex_unlock(&devpts_mutex);

Conceptually this seems fine, but it would seem cleaner to me to push
this mutex into the called functions in devpts; I suspect the lock could
be eliminated or at least be made per instance there (which would make
massive-container people happy...)

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

