From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] ARM/serial: at91: move machine quirk into machine
Date: Tue, 5 Nov 2013 04:53:29 -0800
Message-ID: <20131105125329.GC18093@kroah.com>
References: <1383643722-14189-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383643722-14189-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 05, 2013 at 10:28:42AM +0100, Linus Walleij wrote:
> This removes the dependency on <mach/gpio.h> from the AT91 serial
> driver by adding an mctrl callback quirk.
> 
> Long term it is better if the driver calls the generic GPIO
> interface (gpio_set_value()), but this gets a hairy cross-depency
> into the machine-local headers out of the way for now.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greg, if you're OK with this approach please give me an ACK
> so I can take this through the ARM SoC or GPIO tree in the end.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
