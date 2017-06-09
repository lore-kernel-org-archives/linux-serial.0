From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 03/11] gpio-exar/8250-exar: Fix passing in of parent
 PCI device
Date: Fri, 9 Jun 2017 10:29:11 +0200
Message-ID: <20170609082911.GA29675@kroah.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
 <63100617e55d78ab881baaa6baf44e8d74d0e816.1496388533.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63100617e55d78ab881baaa6baf44e8d74d0e816.1496388533.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 02, 2017 at 09:28:46AM +0200, Jan Kiszka wrote:
> This fixes reloading of the GPIO driver for the same platform device
> instance as created by the exar UART driver: First of all, the driver
> sets drvdata to its own value during probing and does not restore the
> original value on exit. But this won't help anyway as the core clears
> drvdata after the driver left.
> 
> Set the platform device parent instead.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
