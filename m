From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Date: Tue, 18 Jun 2019 09:49:03 +0200
Message-ID: <20190618074903.GA5216@kroah.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611105603.4435-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
> Changed by Stefan:
> Only call mctrl_gpio_init(), if the device has no ACPI companion device
> to not break existing ACPI based systems. Also only use the mctrl_gpio_
> functions when "gpios" is available.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please do not add a signed-off-by from people for an old patch that was
reverted.  It implies that I still agree with this change :(

greg k-h
