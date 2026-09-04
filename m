Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F93793DF
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508965; cv=none; b=tnjpQ1jS8mSFoUGChccYwoDz2NZZ5wqNdkJPrY50WzM6eGNBEeGwJjFX0UEyZ9ReFq5mZ4KYo1PL2G+/9flMPxP8fpb01hZDudqEAZ98OpoE9AbgGhMXsJh+TyO+7Hi0onjtwG1x8ryWyV44qLd5VVFtvi/cPTeND3eH6LT/VIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508965; c=relaxed/simple;
	bh=WTAIKvytlk2I8p/t98psK0dcy8mt5QDKoTHGeYTrjGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=futV7tsumPhzbepnYdUPkv75lGxeLfbYv63dF3Iu+/cOvUYBlg7E9PqU8NLPn1Fkd7cDy5thgTJ+fgD8nixQYgGq5Y7FrukMDfeSDVk+wIC8K0Z5AwPOBozciLeNKSN22eRIrwxMhj0NbhMVDRAl8Lu6EdOb8BHQyyUCHfa+mdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAtcJU0Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HItnk2vA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAtcJU0Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HItnk2vA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mw3G3727027
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 08:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fi5a8HO1L6d+cRGqALVB/lcAuXENeCkxfrd/FXPuJLI=; b=RAtcJU0Y3c1d0ynz
	PSaJM44u7ix+S1hRNvOcGzJS/GRUepQeD5GudLqCOK3LCuC3egz2mKIWQmx2v/jO
	7hn1DMGB7PUuNau0/ShNg3TDcuISgU/iBmwcHN0ATT2Ulo83i0dxldarMU1kcxIF
	7OEzPOOxsiwF7rNtftGvpoleIJBSaFeL7j85NM9YvTW+BOG5EgsLcAx3qCDy+G/Z
	p8bVwoe+NjbW5hnwtxx5alOGUKWzblPINabwur2CfUSMoDKdSCZo1RemynMLFgFS
	vs877WxUb5C0HH6b+rsXotTJEhYl9CJrx33WW0WHyRFowzW+fIdMLtdA+QLrN0sO
	98pFwA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvke8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 08:02:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e8a7ae2c2so1483326d6.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788508957; x=1789113757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fi5a8HO1L6d+cRGqALVB/lcAuXENeCkxfrd/FXPuJLI=;
        b=HItnk2vAHk8VhRfCCWQV6AZ9nWjNiF3PUUNqh3PXXrCs6lWKFE657T0FP+sGJmkldG
         GkpH7OIWOZQbH02OQtJbpNPdr1JpZ7Hgde5+494bTQaOtw2S/kVoaPGFswCPK2GK0xAq
         w6Ji6czkGrw5nbJFtJpiyyfNec+IKgkgRIT+5ExjAUTjxNLHPYn5EU007FeWpya67dFN
         RRwI0nYdtWPPs1tjFYnqLbVQLvZOUMENWiEiqTZChHv+sbz/lcvg/iGS2JRdkszNUeZg
         cT63uvuYnNquOqCsjMoQDiLqxIsi9yx93/0AzVrvz6KLYkFQZ/9UXSTmEKG96ysk6T3x
         ow+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508957; x=1789113757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fi5a8HO1L6d+cRGqALVB/lcAuXENeCkxfrd/FXPuJLI=;
        b=cb9DnKP3Sq1AuXY375D0CF7bsLpkEFCmayv2s8QBSAx2dyNUs89ZqyRdCT281riqyu
         UTynbsOzGUFLqqfhPiatkBD9zE++13IBj2/V9Q3cpPjsjTb+bNNET/PPV/03uvduYpWn
         y5ExHLmwehJmmUQrBDDZm5LwatGO5DKcWTf2f4qx0Z3sgWDRLR9rWM+a85RGTXQGPPQo
         GHPdidoTc4LB/kdfEm5J6LrPW/5DNLlAWAW/QZKY7rjV/lEz3uxs+N1b4UroM9LVqK3C
         ECr1ZKff9p9KHUfLiY4nFZftaADQ48G6ABz1t7yyzXeQd465oHsqY/yWkmeK7n/3zw5h
         870Q==
X-Forwarded-Encrypted: i=1; AKwUvBxQy86NE48o3N7Xw24trqBYY6ahucX6CePQkvX6nXTCDpOcBmUFGyF5abs0kKZjLLY7H03oJq2HOSybc88=@vger.kernel.org
X-Gm-Message-State: AFuF++mWo4SLC57WLkhTWaI8Q6eivfvjNpcxU4HCdfTpM7+ejfLYWjwF
	tQvypzdvN9TMp8iIKrjqmwv74msXOx0d+/BWVzEM5F0G8j3dN3ppuV3E+e2ITIchkijvsV1rsOj
	Z2O2ZRf9BiUQpqODMmb20IcFB+LHwoEXyEp/jU7UcBC+x9EldAgTDko6hzzQmh6Mua8M=
X-Gm-Gg: AYBFou3DCRL/goFHLYut6jD+eaJ8gMjSktWsxlZSbSVebHfm30UUflPeCu1wajWvBuR
	WdXFF5zZhMLhT8Rr6MWcRfdtQTE59YEeWoAlNHS8zE3HdCQnICrls5E4lgk97ZsgFsLiu9tTVX+
	AjMvUBZgvmYBuqge99u8ZxJvaWJCdV87cKtlIqgmtvjFBpHygH3ZyeyUfdP+3A7brh2gfrscjbg
	HcH3Y+Ca0cQakQlJu2vXQGtTQRHXDcbtcMRQDE9xckWEuBtfwa2f6NK8Zcg4U3DVi/omrFn5fNt
	ma0zwCVF12hj7jrqJgr8zVfraIjuQFWd3c9eOAJrV6S4dmP4K8Irgv3oZ/VF7ZvzKedaAQSUM5b
	EHvIGocGB1WatBq9EhYEMfA==
X-Received: by 2002:a05:620a:4629:b0:939:287f:301c with SMTP id af79cd13be357-939809187b8mr305796485a.6.1788508956958;
        Fri, 04 Sep 2026 01:02:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4629:b0:939:287f:301c with SMTP id af79cd13be357-939809187b8mr305792685a.6.1788508956555;
        Fri, 04 Sep 2026 01:02:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036652sm73050066b.2.2026.09.04.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:02:35 -0700 (PDT)
Message-ID: <bbd0216d-8b50-424b-be1b-06453118a61b@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:02:33 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: qcom_geni: don't ida_free() the console port
 line
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LgB6Mwt3poDAzUa03VK4r23zPi9S5HYZ
X-Proofpoint-GUID: LgB6Mwt3poDAzUa03VK4r23zPi9S5HYZ
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a9a7b23 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=_GIM3uVGm_PXN5_7RB8A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MyBTYWx0ZWRfX0pafMOidrv7t
 VGz+IgKutYk3tTDhOqSP6j0zj38p810KQNNbvfrkG0MIEKNQNOHjzJzhbHBXGRPimRuMKjN5KI/
 +JPe59qaaIhxnzDzlc1VyVM7tt4izq0OA679PrDR2lK0zZUXB+nlfGWu+EFuCczf/sF/pKZS7wd
 q5IBuZhyO7wV9Pp6gp08pdH/fajSVK7cB1ItFDgVTNWa0a25cgyIODQo6aQZeGWcc4VV4gVITZx
 b5KQI5OI5wNLMd4AWZjX6fc66oM2NGSOvgc3R8VFpC6vXAWu8f6YTFyM8puuyLBj3S4MzJTaPhf
 NTL1/QzjHUXePi3VaO+93vcwCLIGXZC1MsFKG81pmjNQSbd94AaeQRPUFFI2mpTxkGye/5IQC8C
 LOMQZQeoRYBthB325HO5gWDhdfcywGVUna+WrcL+pv4ZNJin/yicdLfnbBLrbeoZJi7cdwUShxQ
 gtdULUmkThI7z9cnN9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MyBTYWx0ZWRfX+mlsyavwp5aJ
 LHYKZE/m81Qe+EVrfDvx/VZeM9LnzB42Kper4l7MSzIX00puuuAvZOq+MDR+ww9+YFKNB7IQyOX
 eZ5oUXxbBc1x2CB6COpGiXcb3WKN6oo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040073

On 9/4/26 9:09 AM, Neil Armstrong wrote:
> The console port (qcom_geni_console_port) is a static instance whose
> uport.line is hardcoded to 0 and is never allocated from port_ida.
> Only the non-console path in get_port_from_line() calls ida_alloc_range().
> 
> Fix the qcom_geni_serial_remove() and the matching probe() error path
> so unbinding the console device doesn't hit:
> 
>   WARNING: ida_free called for id=0 which is not allocated
>   <snip>
>   qcom_geni_serial_remove+0x58/0x80
> 
> Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..bdbdfd7dfaac 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  						port->wakeup_irq);
>  		if (ret) {
>  			device_init_wakeup(&pdev->dev, false);
> -			ida_free(&port_ida, uport->line);
> +			if (!uart_console(uport))
> +				ida_free(&port_ida, uport->line);

GPT points out this will always return false before uart_add_one_port()
is called

Konrad
