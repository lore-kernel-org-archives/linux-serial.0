From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Date: Wed, 13 Apr 2016 11:13:36 +0200
Message-ID: <20160413091336.GH26941@ibawizard.net>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
 <20160412094846.GF26941@ibawizard.net>
 <20160412105856.GR10108@pengutronix.de>
 <20160412121759.GG26941@ibawizard.net>
 <20160412173032.GS10108@pengutronix.de>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160412173032.GS10108@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2016-04-12 19:30:32]:

> On Tue, Apr 12, 2016 at 02:17:59PM +0200, Petr =A9tetiar wrote:
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2016-04-12 12:58:5=
6]:
> > =

> > > ok, so UFCR_DCEDTE is set and UCR3_DSR controls the DTR output as
> > > intended. What is connected to the respective pin?
> > > MX6QDL_PAD_EIM_D25__UART1_DSR_B I think is the one.
> > =

> > It's routed out to Apalis SoM pin 120, which is then connected via 22R
> > resistor and through SN65C3243DBR RS-232 line driver to header which I =
use as
> > debug/serial console.
> =

> Then I guess the problem is that the rs232-partner asserts the imx6's
> DSR in reply to the imx6 asserting DTR?

Yes, that's correct.

-- ynezz
