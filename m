From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] clk: emev2: Add support for emev2 SMU clocks with DT
Date: Tue, 1 Oct 2013 18:15:26 +0900
Message-ID: <CANqRtoRD35Ei31PK8a_TOp=2uiYPCoaJuDb6tyZtQL8s0PavNw@mail.gmail.com>
References: <52410F86.4040301@renesas.com>
	<20130924131542.f865fad4dec98e024c0d4676@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130924131542.f865fad4dec98e024c0d4676-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 1:15 PM,  <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org> wrote:
> Common clock framework version of emev2 clock support.
> smu_clkdiv and smu_gclk are handled.
> So far, reparent is not implemented, and is fixed to index #0.
> SMU and small numbers of clocks are described in emev2.dtsi.
>
> That function and numbers of clocks are equivalent to current
> sh-clkfwk version. It is just enough to run kzm9d-reference.
>
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/emev2.dtsi     |  84 +++++++++++++++++++++++++++++++
>  drivers/clk/Makefile             |   2 +
>  drivers/clk/shmobile/Makefile    |   5 ++
>  drivers/clk/shmobile/clk-emev2.c | 104 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 195 insertions(+)
>  create mode 100644 drivers/clk/shmobile/Makefile
>  create mode 100644 drivers/clk/shmobile/clk-emev2.c

Hi Yoshii-san,

Thanks for your efforts on this. I'm very pleased to see that you
describe the clock topology using DT. In general I think your patch
looks fine, but I have some comment related to the multiplatform
integration, please see below.

> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 7b11106..3e64ac4 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -32,6 +32,8 @@ obj-$(CONFIG_ARCH_VT8500)     += clk-vt8500.o
>  obj-$(CONFIG_ARCH_ZYNQ)                += zynq/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-$(CONFIG_PLAT_SAMSUNG)     += samsung/
> +obj-$(CONFIG_ARCH_SHMOBILE)    += shmobile/
> +obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += shmobile/

Here I believe it is enough that you only use
CONFIG_ARCH_SHMOBILE_MULTI. Building common clocks to coexist with the
old legacy board code does not make any sense IMO. If you think it
makes sense for some reason, please explain why. =)

> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> new file mode 100644
> index 0000000..6a26eb6
> --- /dev/null
> +++ b/drivers/clk/shmobile/Makefile
> @@ -0,0 +1,5 @@
> +ifeq ($(CONFIG_COMMON_CLK), y)
> +obj-$(CONFIG_ARCH_EMEV2)       += clk-emev2.o
> +endif

I don't think you would need the above ifeq/endif wrapper if you only
used CONFIG_ARCH_SHMOBILE_MULTI above.

Apart from that it looks good to me. And, yes, I have tested this on
my KZM9D board together with multiplatform and it works very well!

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
