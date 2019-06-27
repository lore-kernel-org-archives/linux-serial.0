From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: mpsc: Remove obsolete MPSC driver
Date: Thu, 27 Jun 2019 08:09:35 +0800
Message-ID: <20190627000935.GC527@kroah.com>
References: <20190626160553.28518-1-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626160553.28518-1-mgreer@animalcreek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 26, 2019 at 09:05:53AM -0700, Mark Greer wrote:
> Support for the Marvell MV64x60 line of bridge chips that contained
> MPSC controllers has been removed and there are no other components
> that have that controller so remove its driver.
> 
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> ---
>  Documentation/admin-guide/devices.txt |    4 +-
>  drivers/tty/serial/Kconfig            |   14 -
>  drivers/tty/serial/Makefile           |    1 -
>  drivers/tty/serial/mpsc.c             | 2138 -------------------------
>  include/linux/mv643xx.h               |   46 -
>  include/uapi/linux/serial_core.h      |    2 +-
>  6 files changed, 3 insertions(+), 2202 deletions(-)
>  delete mode 100644 drivers/tty/serial/mpsc.c

I like patches that delete code, thanks for doing this!

greg k-h
