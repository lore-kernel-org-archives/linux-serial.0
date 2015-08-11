From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: fix baud rate range
Date: Tue, 11 Aug 2015 09:42:05 -0300
Message-ID: <CAOMZO5A22528bp57G4RJbb3__mMXEEaiiHa+oUrZskuLRWqZDw@mail.gmail.com>
References: <1439293561-7994-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439293561-7994-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>, Fabio Estevam <fabio.estevam@freescale.com>, Juergen Beisert <jbe@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 11, 2015 at 8:46 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Currently mxs-auart doesn't care correctly about the baud rate divisor.
> According to reference manual the baud rate divisor must be between
> 0x000000EC and 0x003FFFC0. So calculate the possible baud rate range
> and use it for uart_get_baud_rate().
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
