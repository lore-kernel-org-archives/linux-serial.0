Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E942125A
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577169; cv=none; b=Qpt9n5nFwTDHOampNBeX4GZTQwQAu/Rv9Wz4tDvJPEj68mdFLjbz2ueroICdkcrIxhbBAL+XWDlpYwv1Ml4KxIhmSUeF+E0BSSQTMkmBFjPX2YRJ+GIIu0ZFcFHLK2I0XhnetxTwtS/LDFjIxW0pV0A3pIVemGN1iRNMB63lxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577169; c=relaxed/simple;
	bh=XsBMHAWN4RghzlvwrXqgof1mlIw+SjmfHFjk6r+5B0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwDJgU4Mvd1e/BI65fF+cIZRL861+pS8yj9Hvfr1u34+H0eBPdMl76opLNHHpY2NpKcnH+WhceSB00plZxM/FgZfb/7Vgne5FEZHa+InwoBPFR+rNcwXoOgrp9DIzjB5v4Aept88ZFC0i4lt607OhkfFYYN1+HcyU82LP74bvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSATzLFn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QE6M/QDC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSATzLFn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QE6M/QDC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv54X2481253
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=; b=YSATzLFnnZ+16q3D
	VP+z8TjUTxnbRnz24+6Ir1k401gnJmtxWw58juPIrAsYpFc0bbdcTslnnzzcsCSQ
	6vvgKAKL35YVkIywBiDM4eai4pRnuVpESxcfxZdVs5qkH/mv4TevM7IiXw5GaPKj
	TuOmmICeRG4DlFZcmu1jS48G1lAGTG6M8zRvpQ12eF41pNYUfwbL8P2TQltPmwpL
	yyReKJMbu48DgFNyQdyKVSmVCNFPXL33ep1ubIxU/HjiSAMTK+L88m+ecOIRQbcL
	kIBGQJ9AWbtVPtr77+hAoTZzEUq6r84B3n373onzvC/jROWzHuzP47aXn7elfbXE
	cCSHdA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsgvax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 13:12:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d9cef8d15so65467511cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787577165; x=1788181965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=;
        b=QE6M/QDCP19v0X2Lbwh/JcCb0pA+ZybrW5JOH+oUfd/uGabJiUaIdNec0tTpsWk1XC
         FvEIuWBTAaCS/6ED5ckJouxSCTH80Puj5XfnTAqEwfSOtqJG7NGzeyEQSLc1HDkOdI4T
         5I2mT0cUZl4/nBoV2TgjyZUcihHjGlFUUN469XCAkzKntFg9TN2+EKy1yDSt3gTzCZ3w
         XZewv/uKBYm+MXbgaKPqEiLpaT2jb4ysZVjjE1bO1RLNb+O6lyA99GyKFGVoPvBXHeRR
         BoNTUEl4WAYJNQLywaz2SyG0wJogrAo8YXrR17u1d4eqpxMoh7+XNc95XfVVdCF6Rfod
         TShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577165; x=1788181965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=;
        b=DhFdlPSrwINKJFE+GJaDYqHW6jmAfvVCgxbLcLhNe41kH24GtEAMyGfswx+ZEDMrjO
         wDIwZ/I8YtTMx1aOh+Kf7O6a1X9vaHubdq6rum0I4+yHed3JnD9Lf34CHZIDTD9DESEI
         BzOXeByWwEYZz/Rytfz/fps6G3gRWhYUQv5kvJwdxHngDVmnLUXzuFDKympyLwEU6NIG
         MbXC6+7+h+cpYymt1FFVD8SlxGHuArqFSzfX11K809qSmjxHqmnJzUN+YQ2wDRmJXZVB
         tbN20aj0uxrAttJOWH9pprjIJn7vY1mF8Uk6sBBzicyv01s8Ffb3rwVAdp9OwDlMN28X
         2tig==
X-Forwarded-Encrypted: i=1; AHgh+RpAJ8ydUoTIWttYh5d8QWBdxr8gKzL9EIJMuZT44oH5VV4fbSwBFnOqTQbues710BDSVZcosgU7zFFRWoY=@vger.kernel.org
X-Gm-Message-State: AFuF++kxt1YJsotn6PBPIeHd9bHLbNr/nf4e5U0chyGZNu3b09N2E1e4
	TSDVp1o1ugFfF4RDTjYsusJtaE8hVZ/K3gA7b/m9FE5wquHqUfxWwy/GEWO30NC7zC7HgFyjr2q
	vARlMqQGdGiehAqijrqMqsQ2SBaCOGZBQiXO4Ba0paYMHuPpiFqYOxJg81OFazHjswKU=
X-Gm-Gg: AR+sD13EzQT864/p/C77pTOg2W7uuxsWayNRulgVgJ1RV9UfZRDlsr1UMWrQIjmTxJ+
	OOXHT4i3wgVXFTC7RTTtb07FbcNq0PTMaHQVyVvZpsezStc4m25GK28rXG10lIkcGUCsOwL6fU+
	lfNJ1z2LWEJ0SrG9Dr4wha37MPsOpqUr/7UJXZBgZRttMqyN78siqvMd0S1yuESvhNFvhTImpcM
	FkxxePckd0Q2Oy5jleiQ7J1LogqR8DYGXSedP3pq6kkzBGBucOLgGsHwz6iXxe71VLgqTy/yBwz
	nIv/IjZm7VRZeHdE+5VivGhaPwyWGF45Sc/QKQjjESOE03oRGcVCkfsb0hmIEnVrh09mDr8usw0
	ZVJ7LY1HwO+hWP0cVtQMe80ifXlt9fF9fxj8=
X-Received: by 2002:a05:622a:1646:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52e09bb3048mr171483231cf.3.1787577165529;
        Mon, 24 Aug 2026 06:12:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1646:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52e09bb3048mr171482641cf.3.1787577165102;
        Mon, 24 Aug 2026 06:12:45 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d560f66csm527895e9.1.2026.08.24.06.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:12:43 -0700 (PDT)
Message-ID: <2329d1dc-9907-4338-8bb6-2a32e3e261ee@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 18:42:31 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] i2c: qcom-geni: Use common GENI resource
 initialization helper
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfXzHxsiGXZESUy
 EQcmCr7O0joxJMRO65ehetxbZWmvivydBTLvvyUakG23edCDlSRETQ3X0kEIjDWOxUo2CiBkN+q
 moqRzj50UJekSg3cJ/Wl9LT8U3//JPI=
X-Proofpoint-ORIG-GUID: MqvPPPXD0UUqNwY2USTaLVAW19AUOXSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfXwk+2y9n3r90C
 66KJ1y0/4Cg8A5BB/bpmtG6Dpzsv94il8Ij8a3i/kZOMEMRqK74b9FS/f1+Ww1Uuile2CxCmEft
 zfjuXR947WzmXH2qj5mB40UqFbmkFY52p+qvlG4skDepXhGDu3L/y/wexhI8/Fx6vwI8266kzDF
 QnBGNjIlgjSr+tm715KzgbnTXjjKnW6uMk206k3Pu+N/E9JjhXfRGimYO++S5Z4KirqbON+hyVy
 yfRVIsvJASrQKTBTVPMsz3g51514b9AzkRK1op9CS+0a8YP76NSkBbAZ9G3Of2oGF6B075k0C2z
 uHmnBo47f/Gk2y3MNfr7W3Upg5Y3+42XwTpwRo61GXa7wdmFauShQlcA4ED7OxfVPLM57cY8DEw
 IGU8fnRm/N9tafF6WImzMV/3g5hlH0kQKi+tStRwuBSez9bZMQHXKKTNRMywDjMO7R5Qgf7T1vv
 /EBahmnKwaSeqjANP8g==
X-Proofpoint-GUID: MqvPPPXD0UUqNwY2USTaLVAW19AUOXSx
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c434e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=M9ZTtoZWvZtrIhbvBKUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240111



On 8/5/2026 1:27 AM, Praveen Talari wrote:

[...]

> @@ -228,10 +228,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>   	val |= itr->t_cycle_cnt;
>   	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
> +
>   	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
>   				 itr->clk_div, itr->t_high_cnt,
>   				 itr->t_low_cnt, itr->t_cycle_cnt);
> -	return 0;
> +

This looks wrong to me.
First accessed registers and then we are setting ICC vote ? we should 
enable resources first.

> +	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> +				  Bps_to_icc(gi2c->clk_freq_out));
>   }
>   
>   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
> @@ -1100,24 +1103,6 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   	return ret;
>   }
>   
> -static int geni_i2c_resources_init(struct geni_se *se)
> -{
> -	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
> -	int ret;
> -
> -	ret = geni_se_resources_init(&gi2c->se);
> -	if (ret)
> -		return ret;
> -
> -	ret = geni_i2c_clk_map_idx(gi2c);
> -	if (ret)
> -		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> -				     gi2c->clk_freq_out);
> -
> -	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> -				  Bps_to_icc(gi2c->clk_freq_out));
> -}
> -
>   static int geni_i2c_probe(struct platform_device *pdev)
>   {
>   	struct geni_i2c_dev *gi2c;
> @@ -1188,6 +1173,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = geni_i2c_clk_map_idx(gi2c);
> +	if (ret)
> +		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> +				     gi2c->clk_freq_out);
> +

why not move to geni_i2c_init() ?

Check recent patch @ i2c: qcom-geni: add I2C frequency table for 32 MHz 
firmware-based SEs.

Let's agree to move there, to avoid issue.

>   	ret = i2c_add_adapter(&gi2c->adap);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
> @@ -1281,7 +1271,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
>   };
>   
>   static const struct geni_i2c_desc geni_i2c = {
> -	.resources_init = geni_i2c_resources_init,
> +	.resources_init = geni_se_resources_init,

why to add common driver function to i2c ? and also spi, uart ?
Can we not call that function from within i2c specific hookup function ? 
i think design wise should keep i2c as local function.

Also driver specific anything can be managed in local function.

>   	.set_rate = qcom_geni_i2c_conf,
>   	.power_on = geni_se_resources_activate,
>   	.power_off = geni_se_resources_deactivate,
> @@ -1290,7 +1280,7 @@ static const struct geni_i2c_desc geni_i2c = {
>   static const struct geni_i2c_desc i2c_master_hub = {
>   	.no_dma_support = true,
>   	.tx_fifo_depth = 16,
> -	.resources_init = geni_i2c_resources_init,
> +	.resources_init = geni_se_resources_init,
>   	.set_rate = qcom_geni_i2c_conf,
>   	.power_on = geni_se_resources_activate,
>   	.power_off = geni_se_resources_deactivate,
> 

