From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] tty: uartclk value from serial_core exposed to sysfs
Date: Thu, 6 Sep 2012 09:23:17 -0700
Message-ID: <20120906162317.GA25171@kroah.com>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
 <1346894238-12870-1-git-send-email-tmshlvck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346894238-12870-1-git-send-email-tmshlvck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 06, 2012 at 03:17:18AM +0200, Tomas Hlavacek wrote:
> Added file /sys/devices/.../tty/ttySX/uartclk to allow reading
> uartclk value in struct uart_port in serial_core via sysfs.
> 
> tty_register_device() has been generalized and refactored in order
> to add support for setting drvdata and attribute_group to the device.
> 
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>

Thanks, that worked, I've now applied this.

greg k-h
