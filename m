From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
Date: Thu, 19 Apr 2018 19:15:26 -0300
Message-ID: <CAOMZO5C9GxqVJWB18j7JQ+3D93eL1r_PG5woxmOc=8cZRdVX=w@mail.gmail.com>
References: <20180416153502.11814-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416153502.11814-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 16, 2018 at 12:35 PM, Stefan Agner <stefan@agner.ch> wrote:
> To reset the UART the SRST needs be cleared (low active). According
> to the documentation the bit will remain active for 4 module clocks
> until it is cleared (set to 1).
>
> Hence the real register need to be read in case the cached register
> indcates that the SRST bit is zero.

s/indcates/indicates

> This bug lead to wrong baudrate because the baud rate register got
> restored before reset completed in imx_flush_buffer.
>
> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
