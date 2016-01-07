From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] serial: 8250: Fix serial port driver for OF
 platform devices
Date: Thu, 7 Jan 2016 14:44:48 -0800
Message-ID: <20160107224448.GA5905@kroah.com>
References: <1452126221-1253-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452126221-1253-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 06, 2016 at 04:23:41PM -0800, Guenter Roeck wrote:
> Commit afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
> moved the serial port driver for Open Firmware platform devices from one
> directory to another, but a mixup in Kconfig options resulted in the driver
> never being built. This results in runtime failures for some xtensa,
> openrisc, and powerpc configurations.
> 
> Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I have a patch from Peter that fixes this a bit differently, I'll go
queue that up now, thanks.

greg k-h
