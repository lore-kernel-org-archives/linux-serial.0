From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: fix error handling in
 of_platform_serial_probe()
Date: Tue, 18 Jul 2017 09:27:32 +0200
Message-ID: <20170718072732.GA15573@kroah.com>
References: <1498862969-4919-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498862969-4919-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On Sat, Jul 01, 2017 at 01:49:29AM +0300, Alexey Khoroshilov wrote:
> clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
> while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/tty/serial/8250/8250_of.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

I've had to drop this from my tree due to the obvious build warning it
adds to the system.  Always test-build your patches before sending them
out, it makes maintainers grumpy when you do not do that :(

greg k-h
