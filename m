From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] [RFC] tty/serial: imx: make use of format specifier %dE
Date: Thu, 29 Aug 2019 16:43:24 +0300
Message-ID: <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>
References: <20190829043716.5223-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829043716.5223-1-uwe@kleine-koenig.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jani Nikula <jani.nikula@linux.intel.com>, Enrico Weigelt <lkml@metux.net>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 29, 2019 at 7:40 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> I created a patch that teaches printk et al to emit a symbolic error
> name for an error valued integer[1]. With that applied
>
>         dev_err(&pdev->dev, "failed to get ipg clk: %dE\n", ret);
>
> emits
>
>         ... failed to get ipg clk: EPROBE_DEFER
>
> if ret is -EPROBE_DEFER. Petr Mladek (i.e. one of the printk
> maintainers) had concerns if this would be well received and worth the
> effort. He asked to present it to a few subsystems. So for now, this
> patch converting the imx UART driver shouldn't be applied yet but it
> would be great to get some feedback about if you think that being able
> to easily printk (for example) "EIO" instead of "-5" is a good idea.

> Would it help you? Do you think it helps your users?

No, it makes sense only for debug where the user is supposed to be
developer and thus needs anyway to know code base better than average.


--=20
With Best Regards,
Andy Shevchenko
