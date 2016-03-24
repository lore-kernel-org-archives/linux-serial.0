From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/4] serial: imx: some irq and handshaking fixes
Date: Thu, 24 Mar 2016 09:14:13 +0100
Message-ID: <20160324081413.GR6191@pengutronix.de>
References: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

On Thu, Mar 10, 2016 at 11:26:05AM +0100, Uwe Kleine-K=F6nig wrote:
> this series doesn't solve all my problems but at least some. Now for my
> remaining problem my machine at least doesn't reset (by watchdog) but
> disables the serial irq instead which at least allows to debug further.
> (Still I'm a bit out of ideas.)
> =

> The last patch doesn't fix a real problem I have, just noticed that
> while working on the handshaking stuff.
> =

> It would be great if these patched made it into v4.6-rc1.

I have to rework this series. There is an unclear situation that results
in a stuck irq on i.MX25 because I'm unable to clear the DCD irq. Also I
missed a hunk in "let irq handler return IRQ_NONE if no event was
handled".

I will post a safer series later today. Please don't apply this one.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
