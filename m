From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 03/11] gpio-exar/8250-exar: Fix passing in of parent
 PCI device
Date: Fri, 9 Jun 2017 09:21:48 +0200
Message-ID: <CACRpkdah8Bgo2Ga5RK8+9=dqr0pizSYd50wqQk++TyycW6=xnQ@mail.gmail.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com> <63100617e55d78ab881baaa6baf44e8d74d0e816.1496388533.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63100617e55d78ab881baaa6baf44e8d74d0e816.1496388533.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 2, 2017 at 9:28 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

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

If I get Gregs ACK on this I can merge patches 2-11 through the
GPIO tree.

Yours,
Linus Walleij
