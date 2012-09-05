From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv5 1/1] uartclk value from serial_core exposed to sysfs
Date: Wed, 5 Sep 2012 16:42:21 -0700
Message-ID: <20120905234220.GA30393@kroah.com>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
 <1346887016-10415-1-git-send-email-tmshlvck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346887016-10415-1-git-send-email-tmshlvck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 06, 2012 at 01:16:56AM +0200, Tomas Hlavacek wrote:
> Added file /sys/devices/.../tty/ttySX/uartclk to allow reading
> uartclk value in struct uart_port in serial_core via sysfs.
> 
> tty_register_device() has been generalized and refactored in order
> to add support for setting drvdata and attribute_group to the device.
> 
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-tty |    9 ++++++
>  drivers/tty/serial/serial_core.c    |   36 ++++++++++++++++++++-
>  drivers/tty/tty_io.c                |   59 +++++++++++++++++++++++++++++++++--
>  include/linux/tty.h                 |    4 +++
>  4 files changed, 104 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
> index b138b66..2f10855 100644

Odd, what tree did you make this against?  It doesn't apply at all, even
if I mess with it to try a --3way merge, it still throws up a ton of
conflicts.

Care to do it against my tty-next branch in git?

thanks,

greg k-h
