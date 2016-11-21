From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Mon, 21 Nov 2016 12:07:13 +0100
Message-ID: <20161121110713.prjwxrvh66bztvbe@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1479726011.2807.11.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1479726011.2807.11.camel@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Christoph,

On Mon, Nov 21, 2016 at 12:00:11PM +0100, Christoph Fritz wrote:
> On Fri, 2016-08-05 at 08:58 +0200, Uwe Kleine-K=F6nig wrote:
> > Once this is done (and still an issue)
> =

> Yes, patch b5ca028fe9ba2090a (ARM: dts: imx6sx: document SION necessity
> of ENET1_REF_CLK1) is done and mainline and DSR irq handling is still an
> issue.
> =

> >  I'd suggest to standardize a dt
> > property
> > =

> > 	disable-dsr;
> =

> Would you go forward?

Currently I don't have the need and time to do this myself. So if you
want to propose a patch and send if for review to the dt and serial MLs
that would be a good next step. If you add me to Cc (or To) I can take a
look.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
