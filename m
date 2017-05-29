From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 08/10] gpio: exar: Refactor address and bit calculations
Date: Mon, 29 May 2017 14:34:54 +0200
Message-ID: <CACRpkdYLup9ES78z==bb99KfSiyAtv4WnQGnfhtJcL=6rZFeVg@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <ee7ffa22693e844c76f30ce2e96123aefe217e3a.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee7ffa22693e844c76f30ce2e96123aefe217e3a.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 6:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Make the address and bit calculation more friendly for introducing a
> "first pin" offset later on. The new form is also more compact and
> regular.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Whether you go with a separate patch or as Andy suggests.

Yours,
Linus Walleij
