Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086B3264F9
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517921; cv=none; b=FBXiLe7OmuhMZm2GhWjTuPoSkitHrmox/RtxmG0ixQwk6QEYhgEX2+rUgjlLEaDTPNf4q4yUmg24KpCYA3VP8y21Fu201lR8DCGPATwxUEIDMo2ldA72e87dDwhHKWW/Jso/5eXDLmhKhZBMlIjpBS6uBgwn2+kjNxQk3eOGxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517921; c=relaxed/simple;
	bh=Gd7g9+WBJaMupWdChk+ZOSr7l2BJlZhFGSvUDw3FDp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNrvu3Gx9FvmT1UpnW3MrPFs3ccBL6sSncHR7FvKRcc/FkAmTB5wEnseZ6Cc/LuwBqe5tXW8vF9VRLa9j3Dq8CXUE7R2DMZrE0Ht0Zb44wlS+cZ6PFoh5HpoFSHEVaQbB0Vmp4e6IcsMmIv5usNG6ghl0tLYZV9G9ZD+SCnvPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1sNzDbV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBPvpEJv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1sNzDbV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBPvpEJv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62CGO2593557
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 06:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=; b=Q1sNzDbVpF3+KFyl
	58FlpFLdlRjAH/5dYPXCZ1NYG2+F+hekOA7Q7oJylgeN3YUhew3ZA3FVzUiH+5qK
	pa8iXkc19AWujB3IURifJ18KaYuXVZWl5YakTQhSnsp162mxRrtYSnFuBf6Bfe8P
	hXZFijh3ILg17+UPTj8n4RFSwkbEsoYgEDZwxhXYjeSGLL/ISX/Deokzxh8CvPKI
	yQloxhtMOvyfAIpkJvlKuTIVpTprwpEv4p7Ne+0r6sEe1LmAeVotsjyEK8cmXB8l
	Doivkx3wUbRCG9GRXvHf4bugUM5Q+kJlt/sAtIOAzSwkrf+6WdJLX0rcFD3/EqPH
	pHXJ5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrjj3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 06:58:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1184858a91.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786517918; x=1787122718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=;
        b=JBPvpEJvgU4Oqb9mmKaLL3fsE2N6zlw+l1W3Z9TJ5OUeyINNeC7ot2FFHjCVokWJDq
         qB1zXQ9rl0gONh6kpd5MnjZxheWVKpuoAlB/oW8uBvyceHV3a4Y33zwUjKMbpOVGR2RL
         B/SmN4j79ZTCFa5pxiAF5GdioVeOcfTuaw4XMnnAoyoFZBl2wlmGA6KcSFmybZNHjkjG
         nboKG1Gata3+Amy1SWoUK6uV+5RtZt1xvqafrPqALwStVuiw0AFSTKH3AQ227u1PJf+6
         DtAmQBtof7NEDqNIzks/seua3B4DQw7ktep/lK+VwekEohzFbo/UPcoYiZahOHZpDQ1N
         rO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517918; x=1787122718;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=;
        b=onydsKcCMBfrNSe830FPF9v01vFrWv7oOqqICKxKEPUvlz6P8pG7FVJU/jztxDi0HE
         xzPRHAfCol+bI4xEPcpnfJ/CfBpu+ACXM3MdMUkB8zO52mBVo8u4/fAgVwImAyihcqXL
         w9yuheOQIKengmYPKBplzlsmDCLaUArUz7qYyWKDSOCy59rg4DoVF8L8ThzC3Jgu64er
         W3cBKDcPX9ADmhdOKzOXHsbVgHnEJf2+NdAOEj/Ayw3107+L4ft8lWUVUO8+F6ZIKvZt
         rnV7XfHzV5VvvnHv/w8pRYgv8LbIK3qt8MydJRQhG50vumO6H8Am5isqCQ71UyR1A64t
         NS2w==
X-Forwarded-Encrypted: i=1; AHgh+RpFIVLLboKTXeDZ7ZzfZCOQA8Efs3xZ5w+LaOEd/eTybr1586+Qmz7HubqIIt+w9E5rjR0gYvPzoFYxupw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9p0ksyOOqsYcM0bI7QXkeUt9nDIwg/GJ9yxdTGQm5HER2YtI
	YPPkSweYNNWIRuCYn3onbQ7A2+m1EbsLgmYlerMQWD1b+u3wN//+5cHzmceYm33nH8v/cWd2GBi
	N76VggqflgMjB41PyGFcsrJkuusgvJYjcWks80J0tynEeO6btDTWaqFbbCkG5qqb7S28=
X-Gm-Gg: AR+sD119xBB/YWgTd/XTHl4gxNKvstxs3XgWkW4sJkTZ9yaPr3sUBvX81rusnGji8ka
	6YXfI/gDKp5zbMZH59vciTC7zgPwjJlr6k6bN8AtMBdxJ3W7JEZurMTfoI2NO5ehaRJZkdN36UU
	IJVAb5nqO5IuKdyFSgU8KejAKLzQRUzVtfoaZMWivhCooq0RcJo7silZ0u2Aspjafp4iatTdKzo
	EFhgh8EivuUBqAXgKLCZ2FTXOpDoug1MaxUf1Dfpln+uF5vBTpQndhioBoStq7s9TDRU9H5nwk5
	1yywiqOGb6iDdK1eC/v5mPIeaSkRrL2q+Z8JJc8IUP/+J++GOzSqILu++sGSf+d40UpDxltp6d3
	ggC9m2BKbhgRLLYzfwk1TAAK2i33OzeoYGQ==
X-Received: by 2002:a17:90b:28cf:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-393012af827mr3137303a91.8.1786517918079;
        Tue, 11 Aug 2026 23:58:38 -0700 (PDT)
X-Received: by 2002:a17:90b:28cf:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-393012af827mr3137220a91.8.1786517917524;
        Tue, 11 Aug 2026 23:58:37 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d30b9sm2391336a91.13.2026.08.11.23.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 23:58:37 -0700 (PDT)
Message-ID: <61eb40e1-1eae-45a3-af65-62eaaf27edc4@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:28:29 +0530
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
X-Proofpoint-GUID: Id0MkCbXaOphNLbG3BVxQMOMcPMrNCUN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX+cxFGxAHJMkR
 pQpsJI4aS+rLLMSlZFFuoObg+cl0TVOSbdykT9Sc8Topr/flJsGbk1kC2fHRk1QPdKSl4zJpKj5
 K71kP4v+6JS7OyIbrDt1yjNn+WOrLHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXxBzaXvwQjwPI
 L661yAwGHkbie7dEP7+FkyDwI51jAjpbf+AYKHgNTuK+JeThGPjN6TNJKScsa3gr41l/1uyf056
 OjJ7w3gfhgNOGdNoa7qAt4AsmQsz1pcXxTdTlMfudEqDpFdGWItuxRUomlmBMTLBjzKB7tW7t9n
 Swc9PkvuViafZ1vu++taSwGKGZGTjb26wmLOteiOrbwFxdccFhbGlQgO5JX/YFvjcnJN3ROXf2+
 yL3fWFhs+CCQiNDtlTEUgu/dRYNEP3zPEFQGx81xTbRoSNbTUj8bz80FLOQ4bKTc1nIkZk91UJN
 Fs2OxpQWs6f7Au3J0lwGSn9nqRG5DUvr/ql5b3tdFJoTHeS0G7BlNsIAG18kosQldvep7KE+Wms
 jpGHKyo8XrIlhzJNKQx16ufsMWOp4MJE4FKMIn5rINZwebyXWSEZ1/Y1AAmE6UDwCYQrwsiK7FG
 wpYZnR3D5QaxmsZ676Q==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c199e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dS1doENrTls30Ym8nGUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Id0MkCbXaOphNLbG3BVxQMOMcPMrNCUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
> 
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
> 
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Acked-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
