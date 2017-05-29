From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 04/10] gpio: exar: Allocate resources on behalf of the
 platform device
Date: Mon, 29 May 2017 14:32:05 +0200
Message-ID: <CACRpkdbZYHCehHU+SaS7U2y9zAV=wSLLYzCgt-bJd-Uo9VijHA@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <be82bb59d303876de7b16aa49cf7cda6b080e0e7.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <be82bb59d303876de7b16aa49cf7cda6b080e0e7.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 6:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Do not allocate resources on behalf of the parent device but on our own.
> Otherwise, cleanup does not properly work if gpio-exar is removed but
> not the parent device.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
