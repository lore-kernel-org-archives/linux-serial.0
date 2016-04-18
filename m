From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v2] tty: msm_serial: remove static clk rate setting in
 probe
Date: Mon, 18 Apr 2016 15:16:39 -0500
Message-ID: <20160418201639.GA9967@hector.attlocal.net>
References: <1457318800-26090-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457318800-26090-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 07, 2016 at 02:46:40AM +0000, Srinivas Kandagatla wrote:
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
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>

Greg,

Can you pick this one up?

Thanks

Andy
