From: Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] soc: qcom: Add GENI based QUP Wrapper driver
Date: Wed, 7 Mar 2018 23:46:36 -0700
Message-ID: <945b6c00-dde6-6ec7-4577-4cc0d034796b@codeaurora.org>
References: <1519781889-16117-1-git-send-email-kramasub@codeaurora.org>
	<1519781889-16117-3-git-send-email-kramasub@codeaurora.org>
	<152002326567.108663.16836885081217739460@swboyd.mtv.corp.google.com>
	<4ac213a6-081f-72c1-c9c8-6994786285c9@codeaurora.org>
	<152037339742.218381.11498404122038956963@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152037339742.218381.11498404122038956963-n1Xw8LXHxjTHt/MElyovVYaSKrA+ACpX0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Boyd <sboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, acourbot-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On 3/6/2018 2:56 PM, Stephen Boyd wrote:
> Quoting Karthik Ramasubramanian (2018-03-02 16:58:23)
> 
>>>> +       return iova;
>>>> +}
>>>> +EXPORT_SYMBOL(geni_se_tx_dma_prep);
>>>> +
>>>> +/**
>>>> + * geni_se_rx_dma_prep() - Prepare the Serial Engine for RX DMA transfer
>>>> + * @se:                        Pointer to the concerned Serial Engine.
>>>> + * @buf:               Pointer to the RX buffer.
>>>> + * @len:               Length of the RX buffer.
>>>> + *
>>>> + * This function is used to prepare the buffers for DMA RX.
>>>> + *
>>>> + * Return: Mapped DMA Address of the buffer on success, NULL on failure.
>>>> + */
>>>> +dma_addr_t geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len)
>>>> +{
>>>> +       dma_addr_t iova;
>>>> +       struct geni_wrapper *wrapper = se->wrapper;
>>>> +       u32 val;
>>>> +
>>>> +       iova = dma_map_single(wrapper->dev, buf, len, DMA_FROM_DEVICE);
>>>> +       if (dma_mapping_error(wrapper->dev, iova))
>>>> +               return (dma_addr_t)NULL;
>>>
>>> Can't return a dma_mapping_error address to the caller and have them
>>> figure it out?
>> Earlier we used to return the DMA_ERROR_CODE which has been removed
>> recently in arm64 architecture. If we return the dma_mapping_error, then
>> the caller also needs the device which encountered the mapping error.
>> The serial interface drivers can use their parent currently to resolve
>> the mapping error. Once the wrapper starts mapping using IOMMU context
>> bank, then the serial interface drivers do not know which device to use
>> to know if there is an error.
>>
>> Having said that, the dma_ops suggestion might help with handling this
>> situation. I will look into it further.
> 
> Ok, thanks.
> 
>>>> +{
>>>> +       struct geni_wrapper *wrapper = se->wrapper;
>>>> +
>>>> +       if (iova)
>>>> +               dma_unmap_single(wrapper->dev, iova, len, DMA_FROM_DEVICE);
>>>> +}
>>>> +EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>>>
>>> Instead of having the functions exported, could we set the dma_ops on
>>> all child devices of the wrapper that this driver populates and then
>>> implement the DMA ops for those devices here? I assume that there's
>>> never another DMA master between the wrapper and the serial engine, so I
>>> think it would work.
>> This suggestion looks like it will work.
> 
> It would be a good idea to check with some other people on the dma_ops
> suggestion. Maybe add the DMA mapping subsystem folks to help out here
I have added the DMA mapping subsystem folks to help out here.

To present an overview, we have a wrapper controller which is composed 
of several serial engines. The serial engines are programmed with UART, 
I2C or SPI protocol and support DMA transfer. When the serial engines 
perform DMA transfer, the wrapper controller device is used to perform 
the mapping. The reason wrapper device is used is because of IOMMU and 
there is only one IOMMU context bank to perform the translation for the 
entire wrapper controller. So the wrapper controller exports map and 
unmap functions to the individual protocol drivers.

There is a suggestion to make the parent wrapper controller implement 
the dma_map_ops, instead of exported map/unmap functions and populate 
those dma_map_ops on all the children serial engines. Can you please 
provide your inputs regarding this suggestion?
> 
> DMA MAPPING HELPERS
> M:      Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> M:      Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> R:      Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> L:      iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> 
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
