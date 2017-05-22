From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/6] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Mon, 22 May 2017 17:44:56 +0200
Message-ID: <CACRpkdZmJB3Z-HHU5=_om7bLH3SAyzcTgoOAEsEnbAVSpz09Kw@mail.gmail.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com> <357209721396d57cb871ae69d72308b1a7c9cbd7.1495119548.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <357209721396d57cb871ae69d72308b1a7c9cbd7.1495119548.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 4:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
> rest is required to operate the UART. To allow modeling this case,
> expand the platform device data structure to specify a (consecutive) pin
> subset for exporting by the gpio-exar driver.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

I will need Greg's ACK on this too, but it seems
you are respinning it.

Yours,
Linus Walleij
