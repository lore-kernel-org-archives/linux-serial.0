From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
Date: Sun, 22 Oct 2017 20:49:56 +0200
Message-ID: <20171022184956.exmjlpcbzkvlp7xg@pengutronix.de>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
 <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, =?iso-8859-1?Q?J=FCrgen?= Borleis <j.borleis@pengutronix.de>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, nandor.han@ge.com, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Oct 20, 2017 at 02:25:11PM -0700, Troy Kisky wrote:
> On 10/20/2017 2:20 PM, Troy Kisky wrote:
> > Since imx_disable_rx_int is only called by imx_startup,
> > let's integrate it into that function.
> > =

> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> > v2: new patch
> > ---
> >  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
> >  1 file changed, 10 insertions(+), 29 deletions(-)
> =

> While testing this series, I noticed that sending a break on the serial p=
ort caused
> =

> imx-uart 2020000.serial: DMA transaction error.
> =

> Is that normal ?

I remember that J=FCrgen (added to To explictly) hit this or a similar
problem before, maybe he can commen?

Best regards
Uwe
-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
