From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Wed, 4 Dec 2013 09:08:49 -0800
Message-ID: <20131204170849.GB14859@kroah.com>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-serial@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 07, 2013 at 10:25:55AM +0100, Linus Walleij wrote:
> This passes the errata fix using a GPIO to control the RTS pin
> on one of the AT91 chips to use gpiolib instead of the
> AT91-specific interfaces. Also remove the reliance on
> compile-time #defines and the cpu_* check and rely on the
> platform passing down the proper GPIO pin through platform
> data.
> 
> This is a prerequisite for getting rid of the local GPIO
> implementation in the AT91 platform and move toward
> multiplatform.
> 
> The patch also adds device tree support for getting the
> RTS GPIO pin from the device tree on DT boot paths.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
