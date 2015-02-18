From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] serial: imx: drop support for IRDA
Date: Wed, 18 Feb 2015 23:06:11 +0100
Message-ID: <20150218220611.GN19388@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AfE_tikox7d49=9ZtSD8R0_mGuuOQWZEg+E3rTqL4LSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5AfE_tikox7d49=9ZtSD8R0_mGuuOQWZEg+E3rTqL4LSA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hey Fabio,

On Wed, Feb 18, 2015 at 07:16:39PM -0200, Fabio Estevam wrote:
> On Wed, Feb 18, 2015 at 6:41 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Support for IRDA was added in 2009 in commit v2.6.31-rc1~399^2~2. There
> > are no in-tree users.
> =

> 'fsl,irda-mode' is still documented at
> Documentation/devicetree/bindings/serial/fsl-imx-uart.txt .
I wondered if I should remove it but decided to not do that for
compatibility reasons. The driver not supporting it any more is a
different thing.

> Is the irda support broken?
It is (was) inconsitent and did some things in strange ways. For example
instead of disabling RC it only disabled the corresponding irqs and
flushed the fifo before reenabling. I couldn't test it because I don't
have such hardware though.

> Maybe there are people using it in out-of-tree dts files?
I expect them to cry at some point if they exist. In this case I'm
willing to help them to reinstanciate support for it.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
