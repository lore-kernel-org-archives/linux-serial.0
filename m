From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 11:31:34 +0100
Message-ID: <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Geert,

On Tue, Feb 20, 2018 at 10:40:18AM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> =

> Fix this by adding a range check.
> =

> Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through D=
T alias")

huh, this patch fixes itself?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1d7ca382bc12b238..e89e90ad87d8245c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_device=
 *pdev)
>  		serial_imx_probe_pdata(sport, pdev);
>  	else if (ret < 0)
>  		return ret;

I'd prefer an empty line here.

> +	if (sport->port.line >=3D UART_NR) {

I would have used:

	if (sport->port.line >=3D ARRAY_SIZE(imx_ports))

which IMHO is better understandable
> +		dev_err(&pdev->dev, "serial%d out of range\n",
> +			sport->port.line);

Note that the same overflow can happen when a device is probed using
platform data (and your commit fixes that, too). Maybe worth to point
out in the commit log?

Other than that: Good catch, thanks for your patch.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
