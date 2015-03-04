From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Wed, 4 Mar 2015 09:55:37 +0100
Message-ID: <CAMuHMdX_co60Aez4_8iA4+41CMSD=Ky7af8mVJruQL-2v9m=0g@mail.gmail.com>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
	<1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
	<20150225172757.421.43718@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20150225172757.421.43718@quantum>
Sender: linux-pwm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-pwm@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, DRI Development <dri-devel@lists.freedesktop.org>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 25, 2015 at 6:27 PM, Mike Turquette <mturquette@linaro.org> wrote:
> From: Michael Turquette <mturquette@linaro.org>
> Date: Wed, 25 Feb 2015 09:11:01 -0800
> Subject: [PATCH] clk: introduce clk_is_match
>
> Some drivers compare struct clk pointers as a means of knowing
> if the two pointers reference the same clock hardware. This behavior is
> dubious (drivers must not dereference struct clk), but did not cause any
> regressions until the per-user struct clk patch was merged. Now the test
> for matching clk's will always fail with per-user struct clk's.
>
> clk_is_match is introduced to fix the regression and prevent drivers
> from comparing the pointers manually.
>
> Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Michael Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/clk.c   | 26 ++++++++++++++++++++++++++
>  include/linux/clk.h | 18 ++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index eb01529..09670de 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2171,6 +2171,32 @@ int clk_get_phase(struct clk *clk)
>  }
>
>  /**
> + * clk_is_match - check if two clk's point to the same hardware clock
> + * @p: clk compared against q
> + * @q: clk compared against p
> + *
> + * Returns true if the two struct clk pointers both point to the same hardware
> + * clock node. Put differently, returns true if struct clk *p and struct clk *q
> + * share the same struct clk_core object.
> + *
> + * Returns false otherwise. Note that two NULL clks are treated as matching.
> + */
> +bool clk_is_match(struct clk *p, struct clk *q)

const struct clk *p, const struct clk *q

> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -376,6 +376,19 @@ struct clk *clk_get_parent(struct clk *clk);
>   */
>  struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>
> +/**
> + * clk_is_match - check if two clk's point to the same hardware clock
> + * @p: clk compared against q
> + * @q: clk compared against p
> + *
> + * Returns true if the two struct clk pointers both point to the same hardware
> + * clock node. Put differently, returns true if struct clk *p and struct clk *q
> + * share the same struct clk_core object.
> + *
> + * Returns false otherwise. Note that two NULL clks are treated as matching.
> + */
> +bool clk_is_match(struct clk *p, struct clk *q);

const struct clk *p, const struct clk *q

> +
>  #else /* !CONFIG_HAVE_CLK */
>
>  static inline struct clk *clk_get(struct device *dev, const char *id)
> @@ -429,6 +442,11 @@ static inline struct clk *clk_get_parent(struct clk *clk)
>         return NULL;
>  }
>
> +static inline bool clk_is_match(struct clk *p, struct clk *q)

const struct clk *p, const struct clk *q

> +{
> +       return p == q ? true : false;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
