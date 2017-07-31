From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] drivers/serial: Do not leave sysfs group in case of error
 in aspeed_vuart_probe()
Date: Mon, 31 Jul 2017 18:53:32 +0930
Message-ID: <CACPK8XfyF3KG0Gx4uvdHwTKDXNLsLUtrYcWdNO991E4zkkz3pg@mail.gmail.com>
References: <1501268043-20687-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501268043-20687-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jeremy Kerr <jk@ozlabs.org>, Rob Herring <robh@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

Hello Alexey,

On Sat, Jul 29, 2017 at 4:24 AM, Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> There are several error handling paths in aspeed_vuart_probe(),
> where sysfs group is left unremoved. The patch fixes them.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks for the patch.

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
