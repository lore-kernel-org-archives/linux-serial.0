Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DB36308A
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519494; cv=none; b=oB2ge9bikWawSdjyUURoAlKSJgn8BdBqYn9IoXqp3PvS6mlSaKMoIYZHSc4yJK5EGLkS+YDeoMRqkwc7VP5wX2wtXPY7n/FeVOcfmOhXBg9ADpgJkyOBSsb8rmDsqXIsTjD+iD761vV8JKA4KR9eBhJITR0t0TfOTp2wNFCaIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519494; c=relaxed/simple;
	bh=idEgIKuwLufALjp/jBV+Ut+lHDpRAhTiRSvAWJe3BF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+x1zkK8HrCQ+PwYBEUeGNPEVzbdavhCzrc6zYljE1Xnk9TY6jCq8IW3WYQ+bLYy2htHBg2EzLWXbD3fWD+eLj0g51UhZHh3UodOt5JFOTFaqK9c3VBncFWTSbxSzpoyhsFjScG+ISFJN95c/QuBU5tucJdSo1Nnh7tSkOYdj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zm+rjJtA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQeO8ynG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zm+rjJtA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQeO8ynG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C629dd4090945
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 07:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=; b=Zm+rjJtAIhhcVVmq
	JDFGgDHRb4vGNP0a3JP6Bkam278h3H4CuLU/ueuWx94zrh+FIQwq4a9AkdnaiGei
	RpZh9f8IMHxtsHa2o968rt4MLpIrUn2oufEH7/LFDsl48yVS6dDwYyT0s7tI8AqY
	A9uHYU0yc+BADE8Xluuv5PbuQyfsJm+vFwMVw8ZujWwUldlsUeVDmk13qWxnPUqm
	QUnLr0QdYLIfinuax6pszF6kZTtozeassr6PvRvCwrrT18Y6AxGnFK6whzABp3E1
	rkwV+TJ2KWan2wv0aEQdJSUqzlc/w37QkaA6DgRPXHzqM7a8tfhkek+3OBkvP7OS
	zIs9OQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049bv220-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 07:24:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so18896805ad.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786519490; x=1787124290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=;
        b=UQeO8ynGeX4EQtAhzgsoXL4ypXKcAAmepTP5+2bbvAUpK/sfYPTCK4XTvo//6bgh8+
         3UMhSwV1PezGWGBuMV0N8YulgbbvZstm9DwljMlb7XcGAzc43Uy7UYpIkawVPruSeZ3q
         kNig8kasg8PHO3y2vs1kNH3bs5B43zQmJNEKXo/6U/pqO0xfSNb/b0PqhD0J8+juaeTf
         kMCr0rlr4DPUun43AcJv1mgl9BAx8aC55KmIxt0s3vdonNVPIc/d2zqysXNJ3bgbhdZl
         nnGZYNZotjSJA4vAIlc3m78G6Idn8KmhhzhYHfKZpScYZHPQKf8z7/Q45JU1epmDh3yQ
         rNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519490; x=1787124290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=;
        b=LcS+Na46f59zw1CGopOY4e3VJUunUxvOQSSw2SPzWorhxwkgO5MujqpioYsry4P3PK
         qMPuVqNTroCgO0pEhq8WCSqVJ/PVkLa7ZK0KtZgSEGwAsPtrveiyExuoL7KmxGuEkUab
         msAflSzrCfXsBhPpwBvndftDSrP/tdju3+99llaqV9D9VDaniQrJnMm2HFDgzuZBjX4B
         BGM0BOx7aepXapqrpNMfzpcxASYEBfe2uNjf6sBPaFKA42z25HVSxegbufY5544o6jer
         rhEQUCYkb8mvfS/Vfc83JgkqjXeDWADahfH+RyDYtg8eloFVTMPaPHuqKOag8hJOXwUm
         CZtw==
X-Forwarded-Encrypted: i=1; AHgh+RqNMiBLq07Y3xKK32U/uD6bie3e4YkSQhHRbt0A7IVmVHHYdeRYIqW+fixzsFGivoXox+a9P6LWWqwQqh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCnJkn/L9/MwQ9dh1upVceSCGqLHcoU/UNYsw/SqEwuCFHE0A
	eYdbrSJ2V32MFvIvFYOq1apjuRwDPQt2i0FdNYl3yqdlQLVCL1018ZvLCCgOoQ8M9WwpcgyMG9m
	6xgLnEp6jCmqIebP5GPkM2yv2EmEI8QYEtg4WdrhZvz07LHQn3e7wBSW9+JZWZdAg6/4=
X-Gm-Gg: AR+sD10vMl2OY1Gvi/fxbbGI+y5WZqPM4agcwCF0lnp5IhZCUd2mRswfo9R7KyPGgqs
	PSZBOcTYqsJLTtKYByV2SXjEldxrPCFLxehSc9zmu4eWRdD0+0xCwRt2MHUi4T2YEbhXhy4aLGL
	fS5I9LMx3azFK7ckomVjXWgt7F4CGMkMgBuvmsrchV1TxC4DOovfIhNDp0mMxCuWFBOEJaG2OGb
	yU5VIYHjdY7TU3jNt8nnUEF3dIPqU5q+nwwObO5tQLFot1nqFwFUpdEbvky0D6wwn6zcK9O2x4s
	q7ySo9llxoW9+bdFtoqE2n4oJYN0U/Cox8stgK/FBnFjMzIWeVydjhjAQZRCzDLUo+IfKwfyOB1
	sIdYhzjf5NU5M7eZpj6c5GDi8NqZBBxlQcQ==
X-Received: by 2002:a17:902:cf0f:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3453cce11mr40084055ad.10.1786519489973;
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
X-Received: by 2002:a17:902:cf0f:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3453cce11mr40083855ad.10.1786519489524;
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d351145d87sm2545055ad.23.2026.08.12.00.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
Message-ID: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 74egWYb9tBdhGxGe1nTvbtOcbDEoL6pK
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c1fc2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=9TDyKcSpi701ZX69LQcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 74egWYb9tBdhGxGe1nTvbtOcbDEoL6pK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX7OtIAwjBChzg
 crPBkms7u4SNoM2l0KoZ2b66K/bW/4hWjSUvov5tIJfKzLFUP458Ol340c8MHx+FV6q4IzbofRe
 UtiyJ4dtU/7rBd/6l4Av6HuAQ5GWQH5cLGmhOgRZuA5NZsKyUdwXlvkeeCWxruJ90TeAxrFdjFd
 t4L0MIiXtDjdasRsbnZ6Plq7ogU4jXR2nbPmJtFmeHyottlFxSFXTMCKrMSjqIMSAH1T7fP44+P
 X1FLlUbboIj7cguh2t8/bPLiovFt6FX6A6bbJEgQkGq4S5v9bu7HS6Ru50o0UZa6gxWV4Nxsjug
 f4WeT8NAIg7cCvmE4056b+0otvBhcmcOujA0i1tti/RBl6tIbRv+rTUGiNtxFxyOEGcABoyWbrT
 R4DrD7u2igaOdESe3hfPXgq++UM22YopVpu4iMg7h7fzXbBPUfAN/3DKeAirqN9edcIH5Nirm4w
 75T75/8izvQgli6UQfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX3v97Nc/koyHa
 xcDEdGxdSqGoXIAIhyc1YBcTIeyI3vEm0R62foVI9qYZ5xExduqzfXfU8RgAlzMve/j9p7Fjr6K
 ZG0DBGNK0Ce3rGAOGoExy37nu9GosB0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120057



On 8/5/2026 1:27 AM, Praveen Talari wrote:
[...]

> ---
>   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
>   		return 0;
>   
>   	if (!state)
> -		return -EINVAL;
> +		return 0;

Won't this cause an issue to other drivers ? how are they going to take 
action based on changed return value ?

Remove Acked-by due to this till i give back.
>   
>   	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
>   	if (ret)
> 

