Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671746;
	b=Cdu1UhQykG55PFfL7yTqKSpf36I4dxyOVpYc/qoWbEt69YracjOFyKM7wwvVgxyhTbno
	 s8VaRWlhHbnyCS9oFCqRBE+pWIhxUfW9CEJU5hCsIUyNsbcAlFXFE3j/lxaL0mjaKcs/L
	 O/QdZuYKV9niIYjRd9YCKVVWLuV1x7FfHK6gj4b5/KHlTpbRlb1kTdLswPDzerZEIkOeV
	 ExP742wa15IPfA/za7x08ENb8zp09D4MS2yXuC+8jhzsYhivuhORENz8e24eDqXFCwHdx
	 Hx750nLekA/tqHDmUErqYA9Kj1WWYGlF2N9onSHXN+6yWMD5evU+QJeV7E9s2vP5T6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
	b=JQM3BNf/QYhhed1LB1oV3jhIZ9kBs9D4l8XTQq6gO8rS3WeE4ng3JoFi2Zq5pcyTIT9O
	 9jFu5vSkbgK55/gv0T4svKcpYHcigpvhLh58YeUsRoSCyr92Bo0/t/cI+U6kilSu2rbSS
	 i2EUptq13M/mWF1n1SswoBcPjWynZVvqfEqlrHw+v4W+7kM+oKNW/QJpyz0G9YuGREEy7
	 CaQbL2aVGuhGxrZuuSQ39/bpEoqnv9OZvmzslhYbDwWV9tmkRF6S6X2CPv1xPBNVi4KCw
	 C+An7tkyEfm9Kzv9qsrzldJbxhbod2RgDR5+2pjEGY8NASxIqtnrStTHFYk3x1JqVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EF606A31D
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944EF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA02Oc1962798
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=; b=b7FjuHriWyJcQF6b
	oVxgz8d4XnoXFI7faQANh+GAqlf1hwx2KqrTuYLjyW5FpjEwS2L/kimmAc3pa4AB
	CT4m7ayULxWWZG3q3wZbrPIeLAHicmVkjguUeG7SFxAspd6FWvaKxbVB3HurC8OK
	fcUz/yF/RvrJD4lPFSo6JhfOzG2b4VNvQPZIQxfZkBQgvZJephazPUFFGQ73TqiJ
	R5iVVRCTGKIlJJQdCgbkZ6MEHpNZ0Go3fRbWPJuCci5ZvlhXGO52remI9hyptRID
	m9aiYahu2KCq3Fmjs91IJukRzfggloF1DzztroxWsu6nIhC08nEbKX1fDlEAVsCH
	olWzmg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ak5g4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:22:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e94f72fb9fso16273885ad.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792671744; x=1793276544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=C6zvZYVDvsQzlkSCBnbfBSEinTQ5aqEOrZNT674hCUTK3Z05R+AH6DP0WTc4lrKLzq
         +pHyQwZQfA89UHm81BY5XebO+yKhsStKDNo/bb/r5ijlIw08rB48z7jdfSphizItJbq6
         f+H3UlJilQPQOOB4erv+ZTLSQCR5y3vZw7ipABz59FsDCLTHvPj8c+5v8jl/hTBVBbow
         Yy724azzBS6hhZ09zZa6IW0tE2c72VLgTx89YOy4SEyBu4Faoz692cMJMWFMC08uJdZt
         TP9FEUjo7ZFUeowAtZmVF3OFihn7b+/hpHpgojpxauF2sHALP64B2pKOLNPSZe+NLo7e
         +n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671744; x=1793276544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=osNp6ebMTZ3tf992yXJl8cU0FwKtaDxUqIJEEK37Z7+fqzYMu7posjgmUcyq/shfsz
         KawRnBJ0UQxRv0nXgrr66K3CDofZCF5/3AASDhR7CAffLZpxj/w8ctANKXWYyqODdoGT
         s5HDbLVL2H8XgUv1HiP/2Bj9g7smO7xBHiDZmwCyRSe5O986x9wm7WqnbXv/uZk43+/6
         rIeJE1EUNZnIxzuoiPhFWAuYwpRVB07Lb17aL2T+K2kEVptpOV7prhdkEJmUu+t5iTj1
         Xhnz1HjE6Xx+vTjBfUUtME+m+5Nbf6plQSpVBa35WGcudRbTbeofWH6/EifVdma86B3B
         8TvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfFGVJFG/O7B4BTeRdYv47K5MawiuzNoaLXnb5X6m70tx2tdO+UNr5cjqV3VuXgPkw4mFZmK4txKmEnZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe3StmBLQScGkfo+Qighx2vSsDK0zY7yqKhZltFYiMyhFiDsb7
	KLUmPL5kyUaY0TkpBEpXQ7Yr6Anl9K6eLJkzSz9J15lfn1mOrF/WX/9X7yf8c/krFBcCMsIIyLI
	FwqAHIcjrEcuhCLbHBjy2nllb+MK41qflIajVGb0CruTlrqb6pYhG9JbiQEX/JxTU8VQ=
X-Gm-Gg: AYBFou2Q6X6nBBTgBn38dJITe6U7fj/pAI9mP6UMrphCOBAkGkrGI5/w4k1RWxTCv3V
	1NUx0HT9Jn6au3k2rauA2ZmCX2mOneAUkiL8x6yG36a8Rw8wCRCzj0AUDbtogBEaGuT2aYMGmIT
	hYkM8XPqSB1bZDDIQHIon4TXsIJ7ExoftDqUaifoaApdQrTgdsVTra6KaMt4YkbHt/l5f1ym75L
	ux8OWQLZ6wzLP5U37SCnMb4Zr45nJgfQhpJwTZTF+Hmf3veR+UJNhOOo2morh0zgmxSOf9SqXGq
	gKH36mlnkcL4nC0SIRGEZQqj0ufqG4rbvvwbKyiRWEzLxry1AEs8N6/R0HiEwLFVVmim/C+bKOF
	pGsMZ7lA7Im4CEO6oEjL7+MLsqfOOVzNnKQ==
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591765ad.48.1792671744007;
        Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591515ad.48.1792671743527;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b412756sm23642595ad.24.2026.10.22.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:22:22 -0700 (PDT)
Message-ID: <5dfd7245-c2c0-4468-95ed-6bb8a385da98@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:52:15 +0530
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
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
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX5dLCisTQkOXo
 TjlK/GLGQQT5ysrTBVISC59ymB9/YOtJKnS4E8Sx+SArkCTjozDwowY4O009sxWGPa9iPgnM0ie
 2GuNpCGSrD7VV9TorgSpVu/D/bsbldPrpwI2MQwjZfjAdQPNGIURVvl7ev9JQO9O+h5Xpk7qZoj
 GiBIAmPI9ndUKIGhmzY/zY3mO1iYpcdrxohmu2k6GX7dS8lI+DoN4yj5g7xMMwlht2B9wkipvQm
 FITlOsTWseHINBLb5sTFGCfaz4QV+V6iJJLv3FIP2T0SC78IsTOGlxFG06BN1P8cGQrJQdZazRp
 9smZLueqMbRwS5V4jbO/JdaAg6Wu/mQ+KYEcCu9nofVWIQh+eD4suiM2ZUtPUTh6dNyL6UlAIF2
 18eoAfOR12kn4E7jaxZXcQJdbufckG9p8lz7DzDun4k0nDYMCQi8F4B4+TBEHgjAfPC7HrMsB/g
 UUgF0Z1Y63kgPPgGy1A==
X-Proofpoint-GUID: bJT0uwOOXZp9R32a006aPrPH1v4njYK5
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ada0000 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: bJT0uwOOXZp9R32a006aPrPH1v4njYK5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX5+jUpXaetnz9
 Y406ADfTz+h738SvPXDCqhBqRQC2+Iyp2viXNgWhFSAkK+/NSK012aH4hCow88rUnoDeCnpHQkY
 VBJa7mIB5pnYLT6gza/+H1VkrPT67bo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via
> geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
> computing a source clock and divider combination for a protocol
> requested frequency, unlike the Linux clock managed path which derives
> this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
> applies the matched source clock frequency with dev_pm_opp_set_rate().
> 
> Change this by treating the OPP table exposed on the perf domain
> device as representing the actual SE HW supported source clock
> frequencies, the same role clk_perf_tbl plays for the Linux clock
> managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
> iterating over this OPP table in geni_se_domain_attach(), so that
> protocol drivers on the firmware managed (SA8255P) path can also use
> geni_se_clk_freq_match() to pick the closest supported source clock
> frequency and calculate the required divider, and apply it with
> dev_pm_opp_set_rate() the same way as it is done for the Linux clock
> managed path, instead of relying on a direct frequency/baudrate-to-
> perf-level mapping.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
