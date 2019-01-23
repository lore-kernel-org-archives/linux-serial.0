From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/6] soc: qcom: Add wrapper to support for Interconnect
 path
Date: Wed, 23 Jan 2019 10:14:38 -0800
Message-ID: <20190123181438.GM31919@minitux>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-3-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548138816-1149-3-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Stephen Boyd <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, georgi.djakov@linaro.org
List-Id: linux-serial@vger.kernel.org

On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:

> Add the wrapper to support for interconnect path voting
> from GENI QUP. This wrapper provides the functionalities
> to individual Serial Engine device to get the interconnect
> path and to vote for bandwidth based on their need.
> 
> This wrapper maintains bandwidth votes from each Serial Engine
> and send the aggregated vote from GENI QUP to interconnect
> framework.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 129 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    |  11 ++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 6b8ef01..1d8dcb1 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -11,6 +11,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/qcom-geni-se.h>
> +#include <linux/interconnect.h>
>  
>  /**
>   * DOC: Overview
> @@ -84,11 +85,21 @@
>   * @dev:		Device pointer of the QUP wrapper core
>   * @base:		Base address of this instance of QUP wrapper core
>   * @ahb_clks:		Handle to the primary & secondary AHB clocks
> + * @icc_path:		Array of interconnect path handles
> + * @geni_wrapper_lock:	Lock to protect the bus bandwidth request
> + * @cur_avg_bw:		Current Bus Average BW request value from GENI QUP
> + * @cur_peak_bw:	Current Bus Peak BW request value from GENI QUP
> + * @peak_bw_list_head:	Sorted resource list based on peak bus BW
>   */
>  struct geni_wrapper {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +	struct icc_path *icc_path[2];
> +	struct mutex geni_wrapper_lock;
> +	u32 cur_avg_bw;
> +	u32 cur_peak_bw;
> +	struct list_head peak_bw_list_head;
>  };
>  
>  #define QUP_HW_VER_REG			0x4
> @@ -440,6 +451,71 @@ static void geni_se_clks_off(struct geni_se *se)
>  }
>  
>  /**
> + * geni_icc_update_bw() - Request to update bw vote on an interconnect path
> + * @se:			Pointer to the concerned serial engine.
> + * @update:		Flag to update bw vote.

So update = false means "yes, do update, but subtract from the global
sum".


You track the bandwidth request for each "se", so I would recommend that
you turn this parameter into a "enabled" and track that as well for each
se. Then in this function you loop over all the wrapper's se and compute
the sum of the enabled ses.

> + *
> + * This function is used to request set bw vote on interconnect path handle.
> + */
> +void geni_icc_update_bw(struct geni_se *se, bool update)
> +{
> +	struct geni_se *temp = NULL;
> +	struct list_head *ins_list_head;
> +	struct geni_wrapper *wrapper;
> +
> +	mutex_lock(&se->wrapper->geni_wrapper_lock);
> +
> +	wrapper = se->wrapper;
> +
> +	if (update) {
> +		wrapper->cur_avg_bw += se->avg_bw;

I find this fragile, as you're relying on the se drivers always doing
the right thing.


That said, all you're doing here is sum up all the SEs bandwidth
requests and send them to the interconnect framework, which will sum
them up. Why don't you just call the interconnect framework from the SE
drivers directly?

You can still define the interconnects property in the wrapper DT node
and have the SEs do of_icc_get() from the parent DT node.

> +		ins_list_head = &wrapper->peak_bw_list_head;
> +		list_for_each_entry(temp, &wrapper->peak_bw_list_head,
> +				peak_bw_list) {
> +			if (temp->peak_bw < se->peak_bw)
> +				break;
> +			ins_list_head = &temp->peak_bw_list;
> +		}
> +
> +		list_add(&se->peak_bw_list, ins_list_head);
> +
> +		if (ins_list_head == &wrapper->peak_bw_list_head)
> +			wrapper->cur_peak_bw = se->peak_bw;
> +	} else {
> +		if (unlikely(list_empty(&se->peak_bw_list))) {
> +			mutex_unlock(&wrapper->geni_wrapper_lock);
> +			return;
> +		}
> +
> +		wrapper->cur_avg_bw -= se->avg_bw;
> +
> +		list_del_init(&se->peak_bw_list);
> +		temp = list_first_entry_or_null(&wrapper->peak_bw_list_head,
> +					struct geni_se, peak_bw_list);
> +		if (temp && temp->peak_bw != wrapper->cur_peak_bw)
> +			wrapper->cur_peak_bw = temp->peak_bw;
> +		else if (!temp && wrapper->cur_peak_bw)
> +			wrapper->cur_peak_bw = 0;
> +	}
> +
> +	/*
> +	 * This bw vote is to enable internal QUP core clock as well as to
> +	 * enable path towards memory.
> +	 */
> +	icc_set_bw(wrapper->icc_path[0], wrapper->cur_avg_bw,
> +		wrapper->cur_peak_bw);
> +
> +	/*
> +	 * This is just register configuration path so doesn't need avg bw.
> +	 * Set only peak bw to enable this path.
> +	 */
> +	icc_set_bw(wrapper->icc_path[1], 0, wrapper->cur_peak_bw);
> +
> +	mutex_unlock(&wrapper->geni_wrapper_lock);
> +}
> +EXPORT_SYMBOL(geni_icc_update_bw);
> +
> +/**
>   * geni_se_resources_off() - Turn off resources associated with the serial
>   *                           engine
>   * @se:	Pointer to the concerned serial engine.
> @@ -707,6 +783,47 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
>  }
>  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>  
> +/**
> + * geni_interconnect_init() - Request to get interconnect path handle
> + * @se:			Pointer to the concerned serial engine.
> + *
> + * This function is used to get interconnect path handle.
> + */
> +int geni_interconnect_init(struct geni_se *se)
> +{
> +	struct geni_wrapper *wrapper_rsc;
> +
> +	if (unlikely(!se || !se->wrapper))
> +		return -EINVAL;
> +
> +	wrapper_rsc = se->wrapper;
> +
> +	if ((IS_ERR_OR_NULL(wrapper_rsc->icc_path[0]) ||
> +		IS_ERR_OR_NULL(wrapper_rsc->icc_path[1]))) {

You have a probe function for the wrapper, initialize the interconnects
from there instead. That way you don't have to do this.

> +
> +		wrapper_rsc->icc_path[0] = of_icc_get(wrapper_rsc->dev,
> +						"qup-memory");
> +		if (IS_ERR(wrapper_rsc->icc_path[0]))
> +			return PTR_ERR(wrapper_rsc->icc_path[0]);
> +
> +		wrapper_rsc->icc_path[1] = of_icc_get(wrapper_rsc->dev,
> +						"qup-config");
> +		if (IS_ERR(wrapper_rsc->icc_path[1])) {
> +			icc_put(wrapper_rsc->icc_path[0]);
> +			wrapper_rsc->icc_path[0] = NULL;
> +			return PTR_ERR(wrapper_rsc->icc_path[1]);
> +		}
> +
> +		INIT_LIST_HEAD(&wrapper_rsc->peak_bw_list_head);
> +		mutex_init(&wrapper_rsc->geni_wrapper_lock);
> +	}
> +
> +	INIT_LIST_HEAD(&se->peak_bw_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(geni_interconnect_init);
> +

Regards,
Bjorn
