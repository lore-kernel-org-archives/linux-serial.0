From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] tty_lock: Localise the lock
Date: Fri, 4 May 2012 20:48:21 +0000
Message-ID: <201205042048.21771.arnd@arndb.de>
References: <20120503212151.568.91854.stgit@bob.linux.org.uk> <20120503212219.568.15653.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120503212219.568.15653.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 03 May 2012, Alan Cox wrote:
> 
> From: Alan Cox <alan@linux.intel.com>
> 
> In each remaining case the tty_lock is associated with a specific tty. This
> means we can now lock on a per tty basis. We do need tty_lock_pair() for
> the pty case. Uglier but still a step in the right direction.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
