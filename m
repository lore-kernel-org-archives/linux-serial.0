From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Fri, 30 Jun 2017 09:15:31 -0300
Message-ID: <CAOMZO5A-fF5V4obGD-XEnSbt8TB2wsCTJRjvKXfxM_SjKXdQXQ@mail.gmail.com>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
 <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com>
 <20170621140556.GA766@archie.localdomain> <CAOMZO5DXxaJ6PveJb9912rog8xvfqgsg3O3u3a-ffWUj9ZnpCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5DXxaJ6PveJb9912rog8xvfqgsg3O3u3a-ffWUj9ZnpCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Fugang Duan <fugang.duan@nxp.com>, G.Schenk@eckelmann.de
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Wed, Jun 21, 2017 at 11:12 AM, Fabio Estevam <festevam@gmail.com> wrote:

>> I'd also prefer fixing the underlying problem.
>
> Yes, that would be much better.

Just saw Romain's patch series that addresses several imx uart DMA issues:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/516845.html

If you have a chance, please give it a try to see if it helps on the
RS485 DMA case.

Regards,

Fabio Estevam
