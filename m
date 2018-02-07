From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gpio: serial: max310x: Use HW type for gpio_chip's label
Date: Wed, 7 Feb 2018 06:23:51 -0800
Message-ID: <20180207142351.GC29606@kroah.com>
References: <b2421132df00569baa90af8f2d19ad75242e8c48.1516996724.git.jan.kundrat@cesnet.cz>
 <CACRpkdaCGmsyFGZm+2t7Vnptvi2PwFRXbq28iepDgYO0LRiUWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaCGmsyFGZm+2t7Vnptvi2PwFRXbq28iepDgYO0LRiUWQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 07, 2018 at 02:36:33PM +0100, Linus Walleij wrote:
> On Fri, Jan 26, 2018 at 8:02 PM, Jan Kundrát <jan.kundrat@cesnet.cz> wrote:
> 
> > Some debugging tools (/sys/kernel/debug/gpio, `lsgpio`) use the
> > gpio_chip's label for displaying an additional context. Right now, the
> > information duplicates stuff which is already available from the
> > parent's device. This is how e.g. `lsgpio`'s output looks like:
> >
> >   GPIO chip: gpiochip2, "spi1.2", 16 GPIO lines
> >
> > Comparing the output of other GPIO expanders that I have available:
> >
> >   gpiochip4: GPIOs 464-479, parent: spi/spi1.1, mcp23s17, can sleep:
> >   gpiochip5: GPIOs 448-463, parent: i2c/0-0020, pca9555, can sleep:
> >   gpiochip2: GPIOs 496-511, parent: spi/spi1.2, spi1.2, can sleep:
> >
> > This patch ensures that the type of the real HW device is shown instead
> > of duplicating the SPI path:
> >
> >   gpiochip2: GPIOs 496-511, parent: spi/spi1.2, MAX14830, can sleep:
> >
> > Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Greg, pls apply this to your TTY tree.

Ok, let me wait until 4.16-rc1 is out first :)

greg k-h
