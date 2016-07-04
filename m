From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Mon, 04 Jul 2016 17:43:03 +0200
Message-ID: <13559901.NSWqUx1Nl6@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrote:
> Add support for two led triggers per UART instance that blink on
> transmission and reception of data respectively.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)

What is specific to this driver here? Could this be done in the
core tty code instead?

	Arnd
