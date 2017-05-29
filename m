From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 05/10] gpio: exar: Fix iomap request
Date: Mon, 29 May 2017 14:32:39 +0200
Message-ID: <CACRpkdYUrzByYGT+5JgwZRSENv_rt4HRacxmb9+tJqXLbcUAbg@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <c21343907d05284978a19aaa09491fd873c708ff.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <c21343907d05284978a19aaa09491fd873c708ff.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 6:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> The UART driver already maps the resource for us. Trying to do this here
> only fails and leaves us with a non-working device.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
