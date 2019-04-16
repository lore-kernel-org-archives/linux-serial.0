From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sc16is7xx: fix unused label warning
Date: Tue, 16 Apr 2019 15:11:01 +0200
Message-ID: <20190416131101.GD7406@kroah.com>
References: <20190416123321.3577638-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416123321.3577638-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Slaby <jslaby@suse.com>, Phil Elwell <phil@raspberrypi.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Mao Wenan <maowenan@huawei.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 16, 2019 at 02:33:14PM +0200, Arnd Bergmann wrote:
> A bugfix introduced a harmless warning:
> 
> drivers/tty/serial/sc16is7xx.c:1523:1: error: unused label 'err_spi' [-Werror,-Wunused-label]
> 
> Move each label inside the correct #ifdef.
> 
> Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Someone sent this same patch a week earlier.  I'll merge yours into
it...

thanks,

greg k-h
