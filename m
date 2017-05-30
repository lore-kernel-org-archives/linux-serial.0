From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 0/9] serial/gpio: exar: Fixes and support for IOT2000
Date: Tue, 30 May 2017 21:39:27 +0300
Message-ID: <CAHp75Vc=RTYjv5wuHK-KpSSwJLpqRtAr+eCxa8zHa6-Lt68aNQ@mail.gmail.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1496127684.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> This makes the gpio-exar driver usable, which was prevented by a number
> of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
> driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
> series, so I'm also cross-posting to the serial and gpio lists.

Few comments here and there, overall looks good.
After addressing them, take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to patches that are missing it.

-- 
With Best Regards,
Andy Shevchenko
