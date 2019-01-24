From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Wed, 23 Jan 2019 17:20:52 -0800
Message-ID: <CAE=gft7+=k-KcN9pk1fRR8RuGkdskkJPzn70FFZjOhAyr_-9aQ@mail.gmail.com>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Doug Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Get the interconnect paths for SPI based Serial Engine device
> and vote accordingly based on maximum supported SPI frequency.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index fdb7cb88..7bbbe9d 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
> +#include <linux/interconnect.h>

Sorted includes please, as mentioned by others.

>
>  /* SPI SE specific registers and respective register fields */
>  #define SE_SPI_CPHA            0x224
> @@ -589,6 +590,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>         spin_lock_init(&mas->lock);
>         pm_runtime_enable(&pdev->dev);
>
> +       /* Set the bus quota to a reasonable value */
> +       mas->se.avg_bw = Bps_to_icc(2500);
> +       mas->se.peak_bw = Bps_to_icc(200000000);

Like the i2c case, can we compute real value based on clock speed?
