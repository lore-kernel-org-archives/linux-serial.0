From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/8] gpio: exar: Allocate resources on behalf of the
 platform device
Date: Mon, 22 May 2017 17:39:39 +0200
Message-ID: <CACRpkdYd87PWHxVAA8kVLd+ehfAnwgtH_vRy6XrEz9YcQGWNXw@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <39cc60caa4f5c38d1449590b6c67cf026184306b.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39cc60caa4f5c38d1449590b6c67cf026184306b.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 9:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Do not allocate resources on behalf of the parent device but on our own.
> Otherwise, cleanup does not properly work if gpio-exar is removed but
> not the parent device.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
