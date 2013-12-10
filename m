From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] serial: samsung: move clock deactivation below uart
 registration
Date: Tue, 10 Dec 2013 14:52:40 +0100
Message-ID: <4640026.L8HxPz97OG@amdc1227>
References: <201312050054.39327.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <201312050054.39327.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi Heiko,

On Thursday 05 of December 2013 00:54:38 Heiko St=FCbner wrote:
> Commit 60e93575476f (serial: samsung: enable clock before clearing pe=
nding
> interrupts during init) added handling of the controller clock during=
 init.
>=20
> On most systems this clock is also one of the baud_clock sources and
> possibly used by the earlycon and thus already enabled by the bootloa=
der.
>=20
> Therefore a gap exists between s3c24xx_serial_init_port disabling the
> clock and an attached console reenabling it, making the transition fr=
om
> earlycon to regular console possibly hang the system - as seen on my
> S3C2442 based Freerunner today.
>=20
> Therefore move the disabling of the clock from s3c24xx_serial_init_po=
rt
> below the uart port registration, effectively creating an overlap and
> keeping the clock running non-stop if the console wants to grab this =
port.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/tty/serial/samsung.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Makes sense.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
