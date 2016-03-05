From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: msm_serial: remove static clk rate setting in probe
Date: Sat, 5 Mar 2016 14:26:59 -0800
Message-ID: <20160305222659.GA6557@kroah.com>
References: <1456831373-14839-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456831373-14839-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 01, 2016 at 11:22:53AM +0000, Srinivas Kandagatla wrote:
> The issue with setting up a fixed clock rate at probe is that it woul=
d
> overwrite the console rate set by the bootloader for its console devi=
ce.
> This would result in serial out corruption or missing log when we sys=
tem
> is booted with earlycon. This is not a issue if we boot system withou=
t
> earlycon.
>=20
> This setup is ateast not required with the mainline driver.
>=20
> Originally the issue was noticed on DB410c which is based on APQ8016
> chipset.
>=20
> Without this patch the console log with earlycon would look like:
> ...
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_c=
pu_ids=3D1
> [    0.000000] NR_IRQS:64 nr_irqs:64 0
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD+HH=EF=BF=BD=EF=BF=BD0.699378] co=
nsole [ttyMSM0] enabled
> [    0.699378] console [ttyMSM0] enabled
> [    0.702003] bootconsole [uart0] disabled
> [    0.702003] bootconsole [uart0] disabled
> ...
>=20
> with this patch I can see all the skipped lines on the console
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm=
_serial.c
> index dcde955..0a31b3e 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1580,7 +1580,6 @@ static int msm_serial_probe(struct platform_dev=
ice *pdev)
>  		if (IS_ERR(msm_port->pclk))
>  			return PTR_ERR(msm_port->pclk);
> =20
> -		clk_set_rate(msm_port->clk, 1843200);

Delete the unneeded blank line as well please, when you resend this.

thanks,

greg k-h
