From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date: Wed, 23 Jan 2019 17:19:09 -0800
Message-ID: <CAE=gft6dT0HXzrmberdGg2nS-hp1M68mzbxJyEBOmdrh5x1p1w@mail.gmail.com>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Doug Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Get the interconnect paths for I2C based Serial Engine device
> and vote accordingly based on maximum supported I2C frequency.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc..e8fe63a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spinlock.h>
> +#include <linux/interconnect.h>
>
>  #define SE_I2C_TX_TRANS_LEN            0x26c
>  #define SE_I2C_RX_TRANS_LEN            0x270
> @@ -508,6 +509,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       /* Set the bus quota to a reasonable value */
> +       gi2c->se.avg_bw = Bps_to_icc(1000);
> +       gi2c->se.peak_bw = Bps_to_icc(76800000);

Can you compute a real bandwidth based on the i2c bus speed, rather
than some max vote?
