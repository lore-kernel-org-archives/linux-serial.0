From: Fabio Estevam <festevam@gmail.com>
Subject: Re: serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Sun, 2 Jul 2017 20:09:33 -0300
Message-ID: <CAOMZO5DqpKweApJNZfbk0dYS6hLg08xhjoAJmhU7TE0WS70XYg@mail.gmail.com>
References: <CAOMZO5DA++c95DPrmzOHfFtD+zFcW6G9-0_cRBtg0E8TA8dwXg@mail.gmail.com>
 <20170702204731.GA7174@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170702204731.GA7174@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Sun, Jul 2, 2017 at 5:47 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> The two patches work for me!
>
> You can add my Tested-by tag if/when you submit them.
>
> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Thanks for testing.

I will wait a bit longer to see if we can fix DMA usage with RS485.

Regards,

Fabio Estevam
