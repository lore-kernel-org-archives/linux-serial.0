From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/1] tty: serial: imx: allow breaks to be received
 when using dma
Date: Sat, 24 Feb 2018 10:13:04 +0100
Message-ID: <20180224091304.y4z24frpy53nrgiy@pengutronix.de>
References: <20180224022750.20942-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180224022750.20942-1-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: gregkh@linuxfoundation.org, mort@bork.org, linux-serial@vger.kernel.org, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 23, 2018 at 06:27:50PM -0800, Troy Kisky wrote:
> This allows me to login after sending a break when service
> serial-getty@ttymxc0.service is running
> =

> The "tty_insert_flip_char(port, 0, TTY_BREAK)" in clear_rx_errors
> fixes this by allowing the higher layers to see a break.
> =

> Also, call uart_handle_break to handle possible
> "secure attention key."
> =

> FYI: Martin said the ROM sdma firmware works with this patch,
> but external sdma firmware still does not send breaks on a
> i.mx6UL
> =

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Tested-by: Martin Hicks <mort@bork.org>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
