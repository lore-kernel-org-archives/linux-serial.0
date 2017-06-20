From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 05/10] gpio: exar: Fix reading of directions and values
Date: Tue, 20 Jun 2017 10:16:45 +0200
Message-ID: <CACRpkdaOQF9o+UAioRJSyJ1DL+5_uKaAfxvnNPt9DhRL4pA9PA@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com> <379d9c7235c36ff524e88a056be45622f23bdea9.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <379d9c7235c36ff524e88a056be45622f23bdea9.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 9, 2017 at 8:33 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> First, the logic for translating a register bit to the return code of
> exar_get_direction and exar_get_value were wrong. And second, there was
> a flip regarding the register bank in exar_get_direction.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied.

Yours,
Linus Walleij
