From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/1] tty: serial: imx: allow breaks to be received when
 using dma
Date: Tue, 20 Feb 2018 15:25:36 -0300
Message-ID: <CAOMZO5C_dRcoNhe_YWjLmPnkxv0RNkKLmkxXbTGZ6uUh75CRwQ@mail.gmail.com>
References: <20180220182038.4325-1-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180220182038.4325-1-troy.kisky@boundarydevices.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mort@bork.org, linux-serial@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 20, 2018 at 3:20 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> This allows me to login after sending a break when service
> serial-getty@ttymxc0.service is running
>
> The "tty_insert_flip_char(port, 0, TTY_BREAK)" in clear_rx_errors
> fixes this by allowing the higher layers to see a break.
>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Tested-by: Martin Hicks <mort@bork.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
