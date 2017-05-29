From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 06/10] gpio: exar: Fix reading of directions and values
Date: Mon, 29 May 2017 14:33:16 +0200
Message-ID: <CACRpkdZeRQdM1RrPzqWnJOFiwbdgiGgzo_cVdMhgp2URriNJLQ@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <7678f5c040c6b578fa008c9b510bb936a218310c.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7678f5c040c6b578fa008c9b510bb936a218310c.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 6:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> First, the logic for translating a register bit to the return code of
> exar_get_direction and exar_get_value were wrong. And second, there was
> a flip regarding the register bank in exar_get_direction.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
