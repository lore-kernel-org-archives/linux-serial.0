From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: msm_serial: remove static clk rate setting in probe
Date: Wed, 2 Mar 2016 17:41:10 -0800
Message-ID: <20160303014110.GH24999@codeaurora.org>
References: <1456831373-14839-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456831373-14839-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/01, Srinivas Kandagatla wrote:
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

at least? May be worth mentioning that this code used to be
required because the clk_enable() call would fail if
clk_set_rate() wasn't called first.

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

otherwise

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
