From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: ifx6x60: avoid uninitialized variable use
Date: Wed, 25 Nov 2015 11:07 +0100
Message-ID: <6445070.Vs3hNH0JSm@wuerfel>
References: <3244991.qANsXoqoKs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3244991.qANsXoqoKs@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Jun <jun.d.chen@intel.com>, channing <chao.bi@intel.com>, Russ Gorby <russ.gorby@intel.com>, Vasiliy Kulikov <segoon@openwall.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 24 November 2015 23:04:00 Arnd Bergmann wrote:
> gcc warns about a potential use of an uninitialized variable in this driver:
> 
> drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_complete':
> drivers/tty/serial/ifx6x60.c:713:6: warning: 'more' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (more || ifx_dev->spi_more || queue_length > 0 ||
> 
> Unlike a lot of other such warnings, this one is correct and describes
> an actual problem in the handling of the "IFX_SPI_HEADER_F" result code.
> 
> This appears to be a result from a restructuring of the driver that
> dates back to before it was merged in the kernel, so it's impossible
> to know where it went wrong. I also don't know what that result code
> means, so I have no idea if setting 'more' to zero is the correct
> solution, but at least it makes the behavior reproducible rather than
> depending on whatever happens to be on the kernel stack.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Cc everyone who contributed non-cleanup patches to this driver,
> maybe someone has more insight into the operation of the driver than
> I have and can comment on whether this is the right fix or not.

Grmbl. Please don't apply this version for now.

The patch fixes one issue and made the warning go away in some
configurations, but my randconfig tests still show the same warning
in other configurations, as there is a second way that the 'more'
variable ends up being referenced without being initialized.

Let's wait for comments first, but I assume we will have to initialize
the 'more' variable as well, or possibly that function needs to
be rewritten.

	Arnd
