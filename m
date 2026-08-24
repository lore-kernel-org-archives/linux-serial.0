Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD940B0E2
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572348; cv=none; b=CvpqKJcPBfW7t3Ef2VgWi3m4gqHgXzYhqfuz7OJnQRrpE+vIW6Wc2DFeICmSLwkDBHwes10zqKGYf60aHK+yY46gTPWpTHlnRNpM7iSHgop/lK7xyNYUgMUiIeWKulZiTgGWsG3xxYYqVUaTEKsmd9GeJ/yxht0gSQbxcBIZyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572348; c=relaxed/simple;
	bh=sMRgRGQgsr2UJjRCZNyqU+e1qO2Z+F/fILXvEUfz9kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgwcLhbDr3+Jf+aBz8rHcxDfYS6jsSiYcXzy0KWX4cQnQlXTbZMVSKh9LLrTubdItfuCAFY0VFwXOyHXCjXqVGL4Q3+Sn2coONhEHcl2g4Mf0r2xXLAWWFmi97J9nbxyRBKxJBt2K2QzB6WJ0jXiJ9kUij36clYqxi4iNLeElBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/BgdSS8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BNbUKL2w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/BgdSS8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNbUKL2w"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMVEk3869947
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=; b=F/BgdSS8clS99KgE
	ln/Y7Q00FCX+nGtbe/+Yft7sGhFr7OTYFucFgL66UgGRIcAAfrAleITNFt3cUDHU
	PfjVrGutPfdPBFxvd+SO06Eh0yg6RokbEaFtEbEJQ6Gipe2t931xLgpwV5ezY4iK
	Wo11KVugOMXaNmP53Mqt6gY57ygEWZsdpOW3Hxw2t8Y5Q2GUboNUCgLOzkw9Dqbj
	iuzfQa1BYPIhXwxaG1ZcW6Oi25netVd3e0obdIafEGQHou25mW6aob4XuCOKDINq
	4bg/DjyYUJ66k2hR7QS5W9SHvWYfJjKA+vVn1Ravono2PYDMOWR42Fm573gF2xV5
	eJTXEA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpjgjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 11:52:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso2421463b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787572345; x=1788177145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=;
        b=BNbUKL2wlPzjcGnOCFz9P2svlg2KkNiRBpqlsADDu80YV2ZaVSIaxqZAcKw8t43SRF
         tmOa/+DArnt4gtyESmpB2BzmI3eQznXIyPEIJfHWE2MCZcMNZIunHU7qVlSFhX0TTOck
         36Fy4LVfNLdA6K7URG9dfo9AAXDXfJaMkVfSDpO1A0VtxWlLCPKMTH7fZoTtawmYBS9f
         pwN40hLlbqEyylZ8ib6YXRuYaMgc8uEK/kQTeNvmbjjtSnmpIfWBCSs7Sqd3gsWR/Pxw
         9ogD4MuiKItgyBjjvJHwP5P3qqHWolWbfDDv5Bna7mNFDmWYGQAETiwCYxG1eH7S2bXr
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572345; x=1788177145;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzxqMflwKO5Na/m08OoIrLLFXSwEw43l+/aNS8d0JqY=;
        b=dzhJF5G7xpFf+rfhGYFMdUDe3SntD4n6JsvJAY/Di01s6BDiHtNqCEa/TOzkXLQgVe
         mxt6rRsZCMdYeKLXmpomXJscKe1V8OF7Tko2UMUK0SvtV8Ykj7Kv6WLblYrikCMan0Rd
         aNDoJbfPgimPWqaOzyrIS2EmVewCuFEIi61FYhznEWH8MiWL/HeiVn3ZMRCHA2TKbB+v
         dsHRbIZ/Rjrk14T21BA0z+WEnZwdP3zv0c0pkV82skHNG2AiZxbsQGpor93sMlK+Cu5R
         lXFHkc4V5iJYAhU1SbJVLLpB1I+4uSwG2HxME9pncjo35WhVvlb5aCph30N8IlYvIDEA
         3UrA==
X-Forwarded-Encrypted: i=1; AHgh+RpBBTW960YERuigzRYQZmksvfL+SyWrfnqT3YCVFyR0q8P20BbV+EHJre3nqB+qOUDiSqBv5VW535sOroc=@vger.kernel.org
X-Gm-Message-State: AFuF++mciZaTjAzUWK9OB991UWQTLZN5GjF5Iyc+ABtkyyY83ioHJvlN
	kVJyPQR+SGr7AjFJ750HnkKrKggP0aclpMjarR9c9rmWyL2NDN/niVSAdy0lNWBCaGavn6A2mFc
	+hmdYHfqIDlerZv3ZAmNZEeUtGQRe+OvevRtwlZXwnPjXRGkPhKH64fCAdaH3aCh/Ql0=
X-Gm-Gg: AR+sD12kZ+AaEuif6ijB1cAcZ0WK6u8QPF3j+3ReuzZS5hX07LNfRA+wdsJjU21u3mA
	5AIj6C6xC1tLSTmMYiGU/Mn+cgd5XhTb4b89qTv5+he/TIZmDlg1C0ErliRWSFW774wIfjey4SV
	JvYUgPup7KBYNxFylUvqunUrl0xsQYBoiZeGP+eQk3TQS1lQi0P/FRTLIvUynAh/ATBabRsJTqw
	JWeMEd8vxAeSl7HuMyYL9jyqXqKJ/3viM/IVAgTCsxzCNBX/R9PwRDK1iRZsVUyY4cB8KPKiPHa
	VPl4bC/k5JeccTjxfPBALcThJLj7Wi/tUtpDfYWNwJdIH2T5Iv7JEopzSNwpaSIPer7HIojR5My
	AwteJmc55ds+winkXqwbXZYwATnr8GH78O1Q=
X-Received: by 2002:a05:6a21:888a:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3cd3e771df5mr36827803637.1.1787572345241;
        Mon, 24 Aug 2026 04:52:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:888a:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3cd3e771df5mr36827697637.1.1787572344804;
        Mon, 24 Aug 2026 04:52:24 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b1d6sm885985a12.15.2026.08.24.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:52:24 -0700 (PDT)
Message-ID: <3eb3b7ed-88d1-4185-accf-c81c14b1d408@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5OSBTYWx0ZWRfX3CNvqXRKEn5l
 Dy/g38iW7tz1GAF4gntV3wLTl3QvGWjlveFGgv5xW2wrTaizfRdQQSXpO1aLW9BgN2W8fIcSZR3
 wwVOkMeN6CfbC7j/cxILkL1zHXHtE8bQTOGiWB1LNZf3m2Hu4tEqMiyNRSkzoDuAuNm0YZRwdxm
 7JNNEP/3X5FAK6tipXx1VC81u+yIi2bIDdLLjf5I1K6Zc0oR3mXzBzMxcB3Pgvc+tSThKjucMzn
 xiVLKPFBKTnhcHXgvDTWI9yenrGrrH+9eyfxH+9GV5ma75561AuDv898/usLqjBZuEPb2VX1THI
 3wO0kWH3LA98cQmFsnN9RdoFdUItWALv/5+rNizbivBVGn+hnGzycS4R1fqFUtJbiKPwxzns3Ow
 Djn06roxeeGByptxA/D+2QmsQ12bUSVeR/Jdds0q7kkeyMNdQIluxVKsrLq/mPjdNz2DeDLA5FB
 SBD67eVaBwORelSlugg==
X-Proofpoint-GUID: fmLVsuDqYktpMZIo1DWZF24Ws14qW_-w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5OSBTYWx0ZWRfX6G8cnkymYyoo
 yY63jmghjKY2QsJIwb9upoeemu8rTNnJNf51+ZrM5xc/5iFZpcbcZO6NNdoFtevS8ZDo36N6xD6
 +eG+3HuqJxpRPz4Ty1EBPbxojXzm3gE=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c3079 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dtH3bwBEVQU6Jqvc-V0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: fmLVsuDqYktpMZIo1DWZF24Ws14qW_-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240099



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to look up the source clock
> index and divider needed to fill the GSI CONFIG0 TRE for a requested
> transfer frequency. To work around this, firmware instead exposes the
> SE HW supported source clock frequencies as OPPs on the perf domain
> device.
> 
> geni_se_domain_attach() now populates se->clk_perf_tbl from this OPP
> table at attach time, mirroring clk_perf_tbl on the Linux-clock-managed
> path. This lets get_spi_clk_cfg() call geni_se_clk_freq_match() to pick
> the closest supported source clock frequency and divider on SA8255P
> exactly as it already does when a Linux clock is present, and fill in
> the GSI CONFIG0 TRE accordingly.
> 
> Switch get_spi_clk_cfg() and spi_geni_runtime_resume() from calling
> dev_pm_opp_set_rate() directly to the new geni_se_set_rate() helper, so
> the matched frequency is applied to the correct device (the perf
> domain device on the firmware managed path, or se->dev otherwise)
> without the SPI driver needing to know which resources_init variant is
> in use.
> 

let me suggest little compressed commit message removing some duplication.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
so clock programming is handled centrally by the GENI core,
independent of the underlying clock-control mechanism.

> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c

[...]

> @@ -150,9 +148,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>   
>   	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>   				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
> +	ret = geni_se_set_rate(&mas->se, sclk_freq);
>   	if (ret)
> -		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
little verbose - "Failed to set source clock rate %d">   	else
>   		mas->cur_sclk_hz = sclk_freq;
>   
> @@ -847,7 +845,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>   	}

[...]

