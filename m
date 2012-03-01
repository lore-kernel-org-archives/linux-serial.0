From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/6] Remove tty_lock from the console drivers
Date: Thu, 1 Mar 2012 22:10:19 +0000
Message-ID: <201203012210.19222.arnd@arndb.de>
References: <20120301194831.11322.38295.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120301194831.11322.38295.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 01 March 2012, Alan Cox wrote:
> 
> This needs a fair bit of testing and a bit of review wouldn't go amiss, but
> it does drive the tty_lock() mess out of the console and correct chunks of
> console locking in the process.

I've spent an hour looking at the patches and trying to understand the code
paths you touch.  The use of console_lock for more stuff than it's currently
used for is slightly worrying, mostly because it's still an old-style
semaphore and not covered by lockdep because of that, which might make testing
harder, but it also seems to be the logical thing to do as you write.

Other than that and the VT_WAITEVENT issue that Jiri pointed out, nothing
else caught my eye, it all looks good.

	Arnd
