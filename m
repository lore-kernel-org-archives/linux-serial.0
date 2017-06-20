From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 00/10] serial/gpio: exar: Fixes and support for IOT2000
Date: Tue, 20 Jun 2017 10:19:29 +0200
Message-ID: <CACRpkdZYSFTa63BF5u-J=pu2XwUbVZiQGAtZybhjQno6vVbe=g@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 9, 2017 at 8:33 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> This makes the gpio-exar driver usable, which was prevented by a number
> of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
> driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
> series, so I'm also cross-posting to the serial and gpio lists.
>
> Changes in v6:

I merged some of the patches, that applied. Let's see if they survive
in linux-next, else I guess we need to fix this in the -rcs or for the next
kernel cycle.

Yours,
Linus Walleij
