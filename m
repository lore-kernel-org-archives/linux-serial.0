From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: use initializer instead of memset to clear
 local struct
Date: Fri, 23 Dec 2016 08:20:26 +0100
Message-ID: <20161223072026.GA23895@kroah.com>
References: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 23, 2016 at 12:21:48PM +0900, Masahiro Yamada wrote:
> Leave the way of zero-out to the compiler's decision; the compiler
> may know a more optimized way than calling memset().

But no, it doesn't, it will leave "blank" areas in the structure with
bad data in it, which is why we do memset.  See the tree-wide fixups we
made about a year ago for this very issue.  Are you sure none of these
structures get copied to userspace?

> It may end up with memset() for big structures like this after all,
> but the code will be cleaner at least.

Please leave it as-is, unless you see a measured speedup.

thanks,

greg k-h
