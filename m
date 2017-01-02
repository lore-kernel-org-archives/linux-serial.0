From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] serial: 8250: use initializer instead of memset to clear
 local struct
Date: Mon, 2 Jan 2017 13:27:20 +0000
Message-ID: <20170102132719.GD14217@n2100.armlinux.org.uk>
References: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
 <20161223072026.GA23895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161223072026.GA23895@kroah.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 23, 2016 at 08:20:26AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 23, 2016 at 12:21:48PM +0900, Masahiro Yamada wrote:
> > Leave the way of zero-out to the compiler's decision; the compiler
> > may know a more optimized way than calling memset().
> 
> But no, it doesn't, it will leave "blank" areas in the structure with
> bad data in it, which is why we do memset.  See the tree-wide fixups we
> made about a year ago for this very issue.  Are you sure none of these
> structures get copied to userspace?
> 
> > It may end up with memset() for big structures like this after all,
> > but the code will be cleaner at least.
> 
> Please leave it as-is, unless you see a measured speedup.

We can probably have both... we have an "optimisation" in ARM for
zero-based memset()s which was beneficial with older compilers, but
I suspect GCC 4 does a much better job itself of optimising
memset().  arch/arm/include/asm/string.h:

#define memset(p,v,n)                                                   \
        ({                                                              \
                void *__p = (p); size_t __n = n;                        \
                if ((__n) != 0) {                                       \
                        if (__builtin_constant_p((v)) && (v) == 0)      \
                                __memzero((__p),(__n));                 \
                        else                                            \
                                memset((__p),(v),(__n));                \
                }                                                       \
                (__p);                                                  \
        })

I suspect we should get rid of that with GCC >= 4.

I also suspect that it'll make no difference for uart_8250_port, as
it's rather large, but for smaller structures (eg, up to a cache line)
GCC can probably optimise to inline initialisation.

So, probably something for resulting code and performance analysis...

It's worth noting that 32-bit x86 always uses __builtin_memset() for
memset() on GCC >= 4, so GCC's memset() optimisations must be safe for
structures copied to userspace, or if not, 32-bit x86 is probably
rather buggy.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
