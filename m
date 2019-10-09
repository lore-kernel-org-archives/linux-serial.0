From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Date: Wed, 9 Oct 2019 11:12:20 +0300
Message-ID: <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com> <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Anson Huang <Anson.Huang@nxp.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <Linux-imx@nxp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 9, 2019 at 9:53 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The patch is fine given the changed behaviour of platform_get_irq. I
> wonder if it is sensible to introduce a variant of platform_get_irq (say
> platform_get_irq_nowarn) that behaves like __platform_get_irq does
> today. Then the imx driver would just call platform_get_irq_nowarn
> without having to check the number of available irqs first.

It's being discussed in parallel thread about
platform_get_irq_optional() which won't issue a warning.

--=20
With Best Regards,
Andy Shevchenko
