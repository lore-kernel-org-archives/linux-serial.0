Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0BC43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E072073B
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="u10eIKKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgDBNq5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:46:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55986 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgDBNq5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 09:46:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585835216; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=AuXWxacFMiwuBdrXF2wpRouR9O53pMajubgraeN7JGs=; b=u10eIKKAJzlIxauNfb3s4jWoChErwDFvEMtZSWWeJWmWWy9JR+IF2PM4MOjy2KtxAaJtwJ+j
 ran3a6dNYT1uXmZcvk+A4Irg1BfXq39gNlCos6u4XKQkEfEJjj6lhCYrBvIX9vF7DrqhXiz5
 oFliR6dnb4xcqkcg3tz87YU5QAg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e85ecbf.7f9fd0586998-smtp-out-n05;
 Thu, 02 Apr 2020 13:46:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E933FC44791; Thu,  2 Apr 2020 13:46:37 +0000 (UTC)
Received: from [192.168.0.13] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E822EC433D2;
        Thu,  2 Apr 2020 13:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E822EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
 <1585652976-17481-3-git-send-email-akashast@codeaurora.org>
 <20200331175207.GG199755@google.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <759e50d2-7938-75b6-ee0b-a9ea3722ea54@codeaurora.org>
Date:   Thu, 2 Apr 2020 19:16:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331175207.GG199755@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Matthias,

On 3/31/2020 11:22 PM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> On Tue, Mar 31, 2020 at 04:39:30PM +0530, Akash Asthana wrote:
>> Add necessary macros and structure variables to support ICC BW
>> voting from individual SE drivers.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>> Changes in V2:
>>   - As per Bjorn's comment dropped enums for ICC paths, given the three
>>     paths individual members
>>
>> Changes in V3:
>>   - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
>>   - Add geni_icc_path structure in common header
>>
>>   drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/qcom-geni-se.h    | 36 +++++++++++++++
>>   2 files changed, 134 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index 7d622ea..9344c14 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
>>   }
>>   EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>>   
>> +int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
>> +		const char *icc_ddr)
>> +{
>> +	if (icc_core) {
>> +		se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
>> +		if (IS_ERR(se->to_core.path))
>> +			return PTR_ERR(se->to_core.path);
>> +	}
>> +
>> +	if (icc_cpu) {
>> +		se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
>> +		if (IS_ERR(se->from_cpu.path))
>> +			return PTR_ERR(se->from_cpu.path);
>> +	}
>> +
>> +	if (icc_ddr) {
>> +		se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
>> +		if (IS_ERR(se->to_ddr.path))
>> +			return PTR_ERR(se->to_ddr.path);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(geni_icc_get);
>> +
>> +int geni_icc_vote_on(struct geni_se *se)
>> +{
>> +	int ret;
>> +
>> +	if (se->to_core.path) {
>> +		ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
>> +			se->to_core.peak_bw);
>> +		if (ret) {
>> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
>> +						__func__);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (se->from_cpu.path) {
>> +		ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
>> +			se->from_cpu.peak_bw);
>> +		if (ret) {
>> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
>> +						__func__);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (se->to_ddr.path) {
>> +		ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
>> +			se->to_ddr.peak_bw);
>> +		if (ret) {
>> +			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
>> +						__func__);
>> +			return ret;
>> +		}
>> +	}
>
> With an array of 'struct geni_icc_path' pointers the above could be
> reduced to:
>
> 	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++) {
> 		if (!se->icc_paths[i])
> 			continue;
>
> 		ret = icc_set_bw(se->icc_paths[i]->path, se->icc_paths[i]->avg_bw,
> 			se->icc_paths[i]->peak_bw);
> 		if (ret) {
> 			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed\n",
> 						__func__);
> 			return ret;
> 		}
> 	}
>
> similar for geni_icc_vote_off()
>
> It's just a suggestion, looks also good to me as is.

I thought giving individual path name will increase readability. But 
that doesn't seems to be adding much value on cost of repeated code.

So, I will make the suggested change in next version.

Thanks,

Akash

>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
