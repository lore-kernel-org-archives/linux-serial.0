From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: linux-next: Tree for Nov 10 (8250_mid.c)
Date: Thu, 12 Nov 2015 12:44:55 +0200
Message-ID: <20151112104455.GC4355@kuha.fi.intel.com>
References: <20151110131914.297a5e60@canb.auug.org.au>
 <5642338A.1000502@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5642338A.1000502@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 10, 2015 at 10:12:26AM -0800, Randy Dunlap wrote:
> On 11/09/15 18:19, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do *not* add any material intended for v4.5 to your linux-next
> > included branches until after v4.4-rc1 has been released.
> > 
> > Changes since 20151109:
> > 
> 
> on x86_64:
> 
> drivers/built-in.o: In function `mid8250_set_termios':
> 8250_mid.c:(.text+0x10169a): undefined reference to `rational_best_approximation'
> 
> CONFIG_RATIONAL is not enabled.  Just need to select it I think.

Good catch!

Thanks,

-- 
heikki
