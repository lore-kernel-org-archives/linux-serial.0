From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2 v3] tty/serial/8250: use mctrl_gpio helpers
Date: Tue, 28 May 2019 13:03:37 +0300
Message-ID: <20190528100337.GU2781@lahna.fi.intel.com>
References: <20190527111805.876-1-sr@denx.de>
 <20190527111805.876-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190527111805.876-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Mon, May 27, 2019 at 01:18:05PM +0200, Stefan Roese wrote:
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
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3:
> - Only call mctrl_gpio_init(), if the device has no ACPI companion device
>   to not break existing ACPI based systems, as suggested by Andy
> 
> v2:
> - No change
> 
> Please note that this patch was already applied before [1]. And later
> reverted [2] because it introduced problems on some x86 based boards
> (ACPI GPIO related). Here a detailed description of the issue at that
> time:
> 
> https://lkml.org/lkml/2016/8/9/357
> http://www.spinics.net/lists/linux-serial/msg23071.html
> 
> This is a re-send of the original patch that was applied at that time.
> With patch 1/2 from this series this issue should be fixed now (please
> note that I can't test it on such an x86 platform causing these
> problems).
> 
> Andy (or Mika), perhaps it would be possible for you to test this
> patch again, now with patch 1/2 of this series applied as well?
> That would be really helpful.

Unfortunately I'm not able to test this anymore. Andy should be able to
test this but he is on vacation this week.

Regarding the ACPI changes in this patch, they look good to me so

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
