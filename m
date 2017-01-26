From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v10 1/3] gpio: exar: add gpio for exar cards
Date: Thu, 26 Jan 2017 11:16:15 +0100
Message-ID: <CACRpkdb3L+C+rVB1FPWJ_gGxHPzGAgUFxEBYPTHJQ1_=06y5_g@mail.gmail.com>
References: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 19, 2017 at 11:23 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:

> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
>
> Add the gpio specific code.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Patch applied.

I think maybe we can simplify the patch even more using
select GPIO_GENERIC and just specify the different
registers to bgpio_init().

But that can be done as a separate improvement patch, this
definately looks fine.

Maybe you also want something like:

default SERIAL_8250_EXAR

so that the module is by default added as "y" or "m" depending
on what is selected for the parent device?

Yours,
Linus Walleij
