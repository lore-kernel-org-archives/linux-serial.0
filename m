Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4240B6FC
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571608; cv=none; b=dVdUHABATz8s7bJRurMGqNY4x9+JvbtrUw7CW/QAu8DFS6k4/WzO4UZUgQouSqFfNeRs17XKxdE+cB/mHFDs0A17KyJvLLHxCx1bDc3AKBPevcfC2ibQEcMptI5ULOWTz2OTpLHJixwoVFCVHps5hDQbg9pbNZ2YAdXC41r5PNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571608; c=relaxed/simple;
	bh=mhM1nJgariA7Drln0GvxSUCFkFDiM3od2qwlyHrudFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbL9qvKdxLPFB0zyTim84+eOjZl8yov/MyzP0mRf9w4liGxSF4qHYtAiUQm4YTHbVs0Y58RVzDqopyULdEm76eJJHMeWQzKfSF3Yp/aHC2zc1XAMOqKm24+UWIaoIuIvWCCeX3IcglxX07Ap0iI+NTUmy17xd5zT9ZC9QwgOSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFJI3fRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbsCTWw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFJI3fRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbsCTWw9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMen33407080
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=; b=iFJI3fRU23uszfgu
	5sEEIzYEiTTWjY1lLLHsvKScGW1RZlun7PE2G2leVNNyC5gj+t4lxuZpkWDMJBoZ
	7EFRFKRd1CkFXa2bxK4W4YfsWUUTBSkkAQTsXFtU86Ys5cOj6uMCbzUrtrag4eVb
	cJl/kxC9jSRcvT5OkGz06ZeFsHdmpF68J5Be8yqRhapo5MsFG38diRuSJIk+XBTu
	tushN3mu71MMuQnbh3Ln2PThkoIYOfGfVBX39ZSTJQnrpqVpYNiH5vXzCbIw7FEx
	6+UeqFTb9ea82QUhLuPY69R2WrpoCo7diq1RQKGBo5bL3oLbeLX6Mvp6+fg4q1R8
	G7cD8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk0swv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e6d253330so3703345a91.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571605; x=1788176405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=DbsCTWw9qBigNpukJCfLohk0niBZIcPnLiUe5MK1YvR1kNtfOL9bxrmgeE24mIz/Qw
         YVPNF3l961Db6M4e8+Kozmr4Ubs0I018s/DyrOW3PjyCZbTYE7jO2peV/HYk0vXjrxN8
         Tt1LjCIi+EFKNVqLIIoLmfDRntM7X/W4RkYUFyUEzge/wo7M/yI06K3Fj/Yj6oltqX3f
         NeRXNY/BtInmePjX2EGPotcRnsQODsm7UR6gFvSw7B7LpTB/rD5OSXGjD9FVZJpH+KeH
         7UidrantMfF5xAQmM2QKktkZcpDZYj8DpuUBJyTRvJHoh+AQl5gB/tgRKpCyuqmEXGdR
         9V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571605; x=1788176405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=dnc3Rz+FL2znP7IwpGGUkYnt16ian5hYHCDFBqEG+UDvOBTd/L+eTWGIW1o8Lztgqs
         0o8YWN+cfZXwnijhNOXFdJrojXGXekytAs8wIReoc4KlYnROylIVN0coYIbYZHyc+Bmx
         NxwZ/FWZSoq96x2TiLH2mvo9ExzOjJNTO3PPNSZ9KC5LznepvHRaQTPsbGXx8PThGuZ9
         pUZ+SP1bIPWoygSEyZ6LSOSN9V8+k8NkSn3yDr6uOmbuLH/4HWKTE1f9zCOcaWl9otQB
         YrucfPbMlhwFn4OWyGo6n2mWjZatG17DO3hfd7NPTW3Y7w0SMEVp3k7MDSikA6Hby86J
         Uk8g==
X-Forwarded-Encrypted: i=1; AHgh+RrVY0Dt+YyNBI+CMVoLooj31eFDhxhn0GlrZ76tSMGLQbTCqHQ8IGbgqbAi5WpQ9cl8eFcUA+lSoMwANjA=@vger.kernel.org
X-Gm-Message-State: AFuF++mrzEmFrDvzoawfgiSrr7pZ8IChc11MHG7R8C5If+fSLZ9WMERW
	oRZ4cu9VdGP9pGBvLNtqLmAMSOL/nN3phRqqwEkeWxpAJ+4P5ulYQSZ67Dv1inYS0RitzSjlmtq
	GmUNMlK4PPaJXPXp4+bkx8vN5PU9Xr+UXwVQq1ULuVgXvaL6P4x59/LN+hXSYVZpxmco=
X-Gm-Gg: AR+sD13m4dPOWEun7gtua8PznpGKWtjbgkb7iIpVzoWYRvUgLsLn0FXPqAGNKb50RVp
	xoObQ6uG3LXb3OJkR6dLBz3TBX0RSVXBw28inKHh4ZyKVoECe5x+yGTVtreZQoWkcfcFbqVLGGo
	IgH37PhZiukCfRgWnywvIal1f75aCCZn+vVN1919INoNolvGFBnQdzNwDi71hOTrWgy9zMYYGlT
	DJMcV+PC2gZK8wykbDhXSPtXFx8PzfMj/S/XtnQ3vfv8LA7pe1jM7LbyBvfit69xhZsXKV2qXrd
	q8ZGk7OOyz+fOq+RFze8U9mNovsKEL3yurKzxfFMP27jOtRF7Axu04df9wVS866bmJzHrpjolrE
	V7kBE8t/qNLtEhdniTwz4KPHC0YwmqeBoXv4=
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916697a91.6.1787571605417;
        Mon, 24 Aug 2026 04:40:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916593a91.6.1787571604902;
        Mon, 24 Aug 2026 04:40:04 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49e6f59sm9678818a91.12.2026.08.24.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:40:03 -0700 (PDT)
Message-ID: <9d73e9aa-240c-40b5-94cb-9b1b9c2ee380@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:09:55 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aJsiqEDg64m4TA7xo_kueP5em_Y4tO7Q
X-Proofpoint-GUID: aJsiqEDg64m4TA7xo_kueP5em_Y4tO7Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX6Lm/g845L0+6
 w2tdmFqm1QZy6HeEf37Crxwuw1aXsij9aLmVYkd5I2LRcCIbRKn7e2SseS1gtSUXx5Xkl2VziU1
 iRHTwhLLxgrAJ0Md7rMGoZRZ/AQGwlI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX6m7Qc6I/iEGY
 j9J+RiIOQqYO5X9Pjk7kFrzjcqwShNJNAq4t0SZ4yhLWrsqD1lbESjPKlmAYD5IeNhEnbYZ3KHd
 wAPmB+XOqkTJ1cpq6yTDSn+iB4aDG2wVMe2ufQo1BqLgb6vFXC/cBJlXt6WJxp5Jv2SbC3KswI7
 q29ixwAHYLe5vmTzSYZpN61b2gew5WLFgS1BjUcsCmMl9z2B+jrEP97xtdpePIQevUw9kCSyfa6
 jopX3319rI/jJW4AvDxQEZEVjyZS1JUTTievGhf3nZLXvExbvmIcpTM9O8WAZ1VKsqqW++nTZG3
 RyKG5oB3VxM2LEGt3zrMv+dQsRRUuaHRF7ZSaNAJQ3AsxvjBAGBDEJx5IJDsupJoPXxzSKGmCAR
 Rtzb0WPLdoxja5SwFChPVgF7/qGCiCIg5C4ZLP8UXtTS5tGa8+XBukIoDdVEfzIeq4LS6asuwLY
 PZDrD4z8+gYcAtD58LQ==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c2d96 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=qpM7YB9Ikm2qReIqoCUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240097




On 8/5/2026 1:27 AM, Praveen Talari wrote:


> @@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
>   
>   	uport->uartclk = clk_rate;
>   	port->clk_rate = clk_rate;
> -	dev_pm_opp_set_rate(uport->dev, clk_rate);
> +	ret = geni_se_set_rate(&port->se, clk_rate);
> +	if (ret)
Can you add trace log with an error for geni serial driver ?> +		return ret;
> +
>   	ser_clk_cfg = SER_CLK_EN;
>   	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>   
> @@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,

[...]

