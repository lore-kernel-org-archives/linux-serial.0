From: gpramod@codeaurora.org
Subject: Re: [PATCH v2] tty: msm_serial: remove static clk rate setting in
 probe
Date: Wed, 20 Apr 2016 11:36:00 +0530
Message-ID: <1d51e468662254075fe2a8477f7addad@codeaurora.org>
References: <1457318800-26090-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1457318800-26090-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-03-07 08:16, Srinivas Kandagatla wrote:
> The issue with setting up a fixed clock rate at probe is that it woul=
d
> overwrite the console rate set by the bootloader for its console=20
> device.
> This would result in serial out corruption or missing log when we=20
> system
> is booted with earlycon. This is not a issue if we boot system withou=
t
> earlycon.
>=20
> This setup is at least not required with the mainline driver, this co=
de
> used to be required because the clk_enable() call would fail if
> clk_set_rate() wasn't called first.
>=20
> Originally the issue was noticed on DB410c which is based on APQ8016
> chipset.
>=20
> Without this patch the console log with earlycon would look like:
> ...
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64,=20
> nr_cpu_ids=3D1
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
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Tested on DB410C. Fixed below curruption with earlycon:

[    0.815843] msm_iommu_ctx 1e3b000.qcom,iommu-ctx: context periph_SDC=
2=20
using bank 27
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD[    1.411080] console [ttyMSM0] en=
abled
[    1.411080] console [ttyMSM0] enabled

Tested-by: Pramod Gurav <gpramod@codeaurora.org>

>=20
> Changes since v1:
> 	- removed empty line suggested by Greg KH
> 	- added reviewed-by
> 	- added extra comment suggested by Stephen Boyd.
>=20
>  drivers/tty/serial/msm_serial.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/msm_serial.c=20
> b/drivers/tty/serial/msm_serial.c
> index dcde955..3bf41ab 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1579,8 +1579,6 @@ static int msm_serial_probe(struct=20
> platform_device *pdev)
>  		msm_port->pclk =3D devm_clk_get(&pdev->dev, "iface");
>  		if (IS_ERR(msm_port->pclk))
>  			return PTR_ERR(msm_port->pclk);
> -
> -		clk_set_rate(msm_port->clk, 1843200);
>  	}
>=20
>  	port->uartclk =3D clk_get_rate(msm_port->clk);
