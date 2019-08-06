From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/4] serial: mctrl_gpio: Add a NULL check to
 mctrl_gpio_to_gpiod()
Date: Tue, 6 Aug 2019 09:45:34 +0200
Message-ID: <20190806074534.5w773nltywxyiljz@pengutronix.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-2-frieder.schrempf@kontron.de>
 <20190802121231.wk6yg5mkyivs3rni@pengutronix.de>
 <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f866213b-fd3b-8602-6c11-56cb65a1ea05@kontron.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Frieder,

On Mon, Aug 05, 2019 at 09:01:39AM +0000, Schrempf Frieder wrote:
> On 02.08.19 14:12, Uwe Kleine-K=F6nig wrote:
> > On Fri, Aug 02, 2019 at 10:04:10AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> As it is allowed to use the mctrl_gpio_* functions before
> >> initialization (as the 8250 driver does according to 434be0ae7aa7),
> > =

> > Actually I was surprised some time ago that 8250 used serial_mctrl
> > without first initializing it and expecting it to work. I didn't look in
> > detail, but I wouldn't go so far to call this "allowed". The commit
> > itself calls it "workaround" which seems a better match.
> =

> Ok, but if this is considered to be a workaround and as the 8250 driver =

> does not use mctrl_gpio_to_gpiod(), we should maybe just drop this patch =

> instead of encouraging others to use mctrl_gpio before initialization.
> =

> I'm really not sure what's best, so depending on what you will propose, =

> I'll send a new version of this patch with adjusted commit message or not.

I wouldn't encourage usage of mctrl-gpio before it's initialized. So I
suggest to drop this patch.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
