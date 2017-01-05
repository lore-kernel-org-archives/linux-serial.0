From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: remove comment about schedule_timeout
Date: Thu, 5 Jan 2017 16:40:16 +0000
Message-ID: <20170105164016.79c6e594@lxorguk.ukuu.org.uk>
References: <20170105154840.24795-1-cascardo@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105154840.24795-1-cascardo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On Thu,  5 Jan 2017 13:48:40 -0200
Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> Ted T'so has added the function size_fifo in 1999 for the 2.3 series
> [1], a long time ago.
> 
> During the 2.5 cycle, Russell King has restructured the serial drivers
> and, in that process, has suggested using schedule_timeout instead of
> mdelay in size_fifo. [2]
> 
> It was only at 2.6.7 that Greg Kroah-Hartman added the msleep function
> to the core kernel, as people were starting to duplicate it. [3]
> 
> However, as size_fifo is called under a spinlock from the autoconfig
> function, we might not use msleep here, so removing that comment is the
> appropriate thing to do.

No.. it's still a flaw in the driver that we can't use msleep here. It's
one of those things that people want to know if the probe locking ever
gets restructured.

Alan
