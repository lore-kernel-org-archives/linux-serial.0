From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2, variant B] tty: nozomi: avoid sprintf buffer overflow
Date: Tue, 29 Nov 2016 20:19:37 +0100
Message-ID: <20161129191937.GA3155@kroah.com>
References: <20161129115104.1755786-1-arnd@arndb.de>
 <20161129115104.1755786-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161129115104.1755786-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 29, 2016 at 12:51:04PM +0100, Arnd Bergmann wrote:
> Testing with a gcc-7 snapshot produced an internal compiler error
> for this file:
> 
> drivers/tty/nozomi.c: In function 'receive_flow_control':
> drivers/tty/nozomi.c:919:12: internal compiler error: in get_substring_ranges_for_loc, at input.c:1388
>  static int receive_flow_control(struct nozomi *dc)
> 
> I've reported this at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78569
> but also noticed that the code line contains a stack overflow, as it prints
> a string into a slightly shorter fixed-length 'tmp' variable.
> 
> A lot of the code here is unnecessary and can be expressed in a simpler
> way, relying on the fact that removing the 'DEBUG' macro will also get
> rid of all pr_debug() calls. This change should not change any of the
> output but avoids both the stack overflow and the gcc crash.

I like this, but I don't think this patch went far enough, we should get
rid of the "special" macro entirely and just use dev_dbg() everywhere as
the dynamic debugging interface is exactly for this type of thing (you
can turn them on or off per-line, no need for odd "levels".)

So I'll take this patch now to remove the obvious error, but follow-on
patches to fix it up "correctly" would be great.

thanks,

greg k-h
