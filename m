From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 7/7] serial: imx: add support for half duplex rs485
Date: Fri, 20 Feb 2015 16:34:11 +0100
Message-ID: <20150220153411.GP19388@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
 <20150219093752.GO19388@pengutronix.de>
 <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?aur=E9lien?= bouin <a.bouin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kernel <kernel@pengutronix.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 19, 2015 at 10:45:47AM +0100, aur=E9lien bouin wrote:
> I hope this link will be ok :
> http://marc.info/?l=3Dlinux-kernel&m=3D142366865609389&q=3Draw
Good heavens, this patch is broken. It depends on user space to get the
reference counting for the gpio right if at all. It uses a reserved part
of the struct serial_rs485 while being driver specific. It ignores
gpio_request returning an error (well, it does a dev_err in this case,
but continues to use the gpio). It does change how frame error are
handled even if rs485 is off without mentioning in the changelog.

Are you aware what happens if a user issues the rs485 callback without
being aware that padding[0] has this meaning?

I'm sorry, I like my patch better.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
