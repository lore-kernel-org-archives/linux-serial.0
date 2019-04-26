From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Date: Fri, 26 Apr 2019 17:35:21 +0300
Message-ID: <20190426143521.GW9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190426084038.6377-1-esben@geanix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@geanix.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Florian Fainelli <f.fainelli@gmail.com>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 26, 2019 at 10:40:36AM +0200, Esben Haabendal wrote:
> This series adds a driver for adding 8250/16550 UART ports as functions to
> MFD devices.
> 

The patch 2/2 disappeared.

> Esben Haabendal (2):
>   serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
>   serial: 8250: Add support for 8250/16550 as MFD function
> 
>  drivers/tty/serial/8250/8250_core.c |  36 ++++++-----
>  drivers/tty/serial/8250/8250_mfd.c  | 119 ++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig     |  12 ++++
>  drivers/tty/serial/8250/Makefile    |   1 +
>  include/linux/serial_8250.h         |   2 +
>  5 files changed, 155 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/tty/serial/8250/8250_mfd.c
> 
> -- 
> 2.4.11
> 

-- 
With Best Regards,
Andy Shevchenko
