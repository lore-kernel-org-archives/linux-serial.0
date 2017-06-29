From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 10/10] serial: exar: Add support for IOT2040 device
Date: Thu, 29 Jun 2017 16:49:02 +0200
Message-ID: <20170629144902.GC23512@kroah.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
 <47c8206a1f97b6c987dfb8761805317406ab1a34.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47c8206a1f97b6c987dfb8761805317406ab1a34.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 09, 2017 at 08:33:18PM +0200, Jan Kiszka wrote:
> This implements the setup of RS232 and the switch-over to RS485 or RS422
> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
> to switch between the different modes. The external logic is controlled
> via MPIO pins of the EXAR controller.
> 
> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
> an LED.
> 
> As the XR17V352 used on the IOT2040 is not equipped with an external
> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
> subdevice IDs. Thus, we have to check via DMI for the target platform.
> 
> Co-developed with Sascha Weisenberger.
> 
> Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
