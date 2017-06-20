From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 03/10] gpio: exar: Allocate resources on behalf of the
 platform device
Date: Tue, 20 Jun 2017 10:14:26 +0200
Message-ID: <CACRpkdb=bwcxDOOZ9YXqQsBTfXSKi=K6fjmVzve6Ppe8BhtJYA@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com> <5e21502713a4a65b91a6366e67ab361f650d4b3c.1497033197.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5e21502713a4a65b91a6366e67ab361f650d4b3c.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 9, 2017 at 8:33 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Do not allocate resources on behalf of the parent device but on our own.
> Otherwise, cleanup does not properly work if gpio-exar is removed but
> not the parent device.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied.

Yours,
Linus Walleij
