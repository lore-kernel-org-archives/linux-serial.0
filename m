Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6F481650
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167733; cv=none; b=dhUVA/wIhIjC7LNe/coJgLfXHJAzczZwuisUVo6OL6I4EKooJ8lTOiTff6QK7zqn5kTLflx0cOiSf7PHQQzPcnoaKCx2EctYd3Er0jb53YcHlFdA9m0qHQIg8uT6BaIUGXUBQFg7bUUftbM2kIt+OOyvwGqLnyScXjegiK6GvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167733; c=relaxed/simple;
	bh=UqvzQZF+a+YBDiE3dPxoSY4txFf1GjSNRE0yqZqWl5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgIPxy/dflvQ8LNFF9FcfWdj9r+qF7kTeHfxbg1+7pCVwAqiHXcPovHIEIBkmdb87FCm4g87iUQC3mojxzS6ucXRTWUNZpPCyujudGAXs4Y74NJL7ro5rzahkLJHCrbi8EhsjVEFk2vP6+RcIErwOF2cOYqeFkMsOcF5L26Jv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+4AJWdi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWC34EaL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+4AJWdi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWC34EaL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBcoJm3161397
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 12:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+fYsmaCOswGfXIcjuZ4YVs1Tv5hzJto3q+rRnzlZDec=; b=L+4AJWdioG+c+ta7
	YIeFC+C6VwsQVYQKlFICre85GROY41erDMA6dTGiXamvlCxpI+G324jr8n5zFgjw
	VkD432rX0+In0NDhkj8nc8bs/QkW6z/Dg5YGMAIqHouM51bUpREE+H7Rx6u8yg6I
	FYLckwljTE7bIM9SBSn7UBRopE/2qgUu7j8Uk7aml0HcEJCq7NzZu50yM6ufl+fV
	z2uAVQyaFSHIHiyqHQBVMBS6CbpXSDj+Xqkd63HsiYrOOhiHkIeWVeVfc5NQyZCH
	GiKJm/+41f6/tOQ24+rqwf0gA4A05hSc/GMsYAyz76wOqeRrbVTBCo/ZFOygStmT
	MKxbLA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qtvwk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 12:48:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90c4d46037eso205606d6.1
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790167731; x=1790772531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fYsmaCOswGfXIcjuZ4YVs1Tv5hzJto3q+rRnzlZDec=;
        b=bWC34EaLJ2F7ASZVzD2Vgl4LDktyDlKv6wBps81n0KkUVDp+UA865idKpjVncmrE4o
         f0Lc54gY96SyT6Y5HxZSIVb2eAzqww+kznQh4HM0PCh9UkK5FniOF3Gs1ZQVLSsts5cg
         guys/TMcya86h3NuQmH2Gl/F7STltEWEJicRKJZQE6lmr3cI1TI0VnwV3FU5NKLjNNPc
         tMZ86GeDe6aTtkrsXBHfz8ojHB36F3jK4aM6wQN2ScYBT1HrY0xtwDS/8xNzLmag/E9O
         gSALlgRK3/Z7SGydJQSOneNn9dlhN/xvs3OJAySMkOKs4Qy0qPh1g6Tvy/il0606IaNA
         WpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167731; x=1790772531;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fYsmaCOswGfXIcjuZ4YVs1Tv5hzJto3q+rRnzlZDec=;
        b=EDzPJp1lRJukO5KRnzfkfS0g/Xs3mQ6t0MvDVlCExP1ESQaRhcoGzi9xfjwDzxbcpB
         BIRqkHdfbvesuitcE5CYC6Z0sgDKlhisXA00RH1xXpFPK9LeWYctluL9lSb5U1sYicbQ
         Rf3/P6//CAjLuEtPGHQmQqLbkXM/0BHk2EETgT76s7/nuGhGVIRMVJu0/VXKFD8VUABZ
         R2Cs8n3dpExNnYzSRWe7OUyAL3t63tIxoVaz5FYablnfIphvdHolpVXlUNklNZtfy0t2
         67lDP7v6CmWxkAm/ZL3DkMSAspsl4xaWsqd+isB+JiwAe3MVqWcFEMiT8pyekcxBraLZ
         fMCg==
X-Forwarded-Encrypted: i=1; AKwUvBxWBnKYmghg5V0Zuo522nPMMJDHP89LBOd0j+Gwv2Y/z4GRVSalmpbzZDrsTxcXFOU7F4jENmyhLHW/Cbs=@vger.kernel.org
X-Gm-Message-State: AFuF++nji/HJr41WgosVEtpfppHrPs8J6xrvB8cbntXc4kFMyTnXAs2i
	WNCsPBlcCbeE35DTszxCCXFPlnI+TNT1+hSossd04GQGdfX9Q1MfMNcRzphGny8d5/KDDmMY5Fj
	c6CLrcRwSDMJPv8tOhDn84zN8nQk21GWubGhFklL+P3H9C6qsZ4hfvBqX6dDPfokAcEI=
X-Gm-Gg: AYBFou2WfG3wqAvCVP9REWrdVyJKRgYfxcAyE0paslz2cWw/0XW3rTqEgjoZETi/Sk0
	eVesb8PdoPnJ0FdjpVrYAc9Yu6i4Dc2xC2wX960CN+geHGUq9gUWkvdDc+uVrywzUxewk/knjGD
	Bc460z1zuW9M15+gvuylr3A6KVb45apBEESjlzaeHtF8L0+WE25iAPscro7LV0KOxYHQoMWKmTQ
	Oh0AomrvlrLcXbeEKEesKNZ2cx4mdVP2w5b9R8m+Vv5UEvzGgQrXs08madcbwud3CQgw4rYDo4/
	7udVEycEORYPK5ajU6IUyqbpauK0Qg67+eVlXXHoLRO37u27vIItFBIM0qMecEnIAE3NLG3oXtb
	Z5uAC52a7akBp2ftRAyYm4e/4fsx0wIQc
X-Received: by 2002:a05:6214:5b86:b0:912:1333:e04f with SMTP id 6a1803df08f44-9140c1331abmr40600556d6.0.1790167730631;
        Wed, 23 Sep 2026 05:48:50 -0700 (PDT)
X-Received: by 2002:a05:6214:5b86:b0:912:1333:e04f with SMTP id 6a1803df08f44-9140c1331abmr40600186d6.0.1790167730121;
        Wed, 23 Sep 2026 05:48:50 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c6csm116628066b.16.2026.09.23.05.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:48:49 -0700 (PDT)
Message-ID: <8e12599e-be86-49a8-a9f1-7bc2abf2eae6@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:48:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: avoid unused-function warning
To: Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260915200435.3524505-1-arnd@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260915200435.3524505-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab3cab3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GCO5t0sYmCnv8Esj6DsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: _SYtRmHW7Qqo0m-msDinCaGyi4G5tvGe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX0nAOijQXu4Rw
 niqRn1cTEuhYxLD9HdWvlsW9sfA55Z3h+8HifQhmjFL8pvrESIXgutdKFvFQ4wyKyKGGg0SLZgh
 bYHFA8cijGkE1TZwauZVpmO2tqzkvYQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfXxdFBiqLbNa2R
 R/Z15qs8d0dG6fQv6G+B4netxahIOWRy13Bj2JFT4wBhWvNSYC4U3a1rUno/C8TaC+z5n4W8NLe
 QyPdeEj6DYicdYH49b4Q4ZHy/ybJQI1CvoccGPyKMSuhrcD/MxwcRgw2F+7aUZYvC0C0jMQFaKG
 pTLbk5eHWSIeXdK/8Mz7m2VZYRAIMZdCDKB/cTmnuqBrHdrJoC12Mh1+GblXJShCHHHWn+OQH3l
 DG3KFOG27yPS8auRciF7a7DfxgNzkEmCL1Gb8kQv167FMb693oGvPAYMoweKk+KxHp4jB15YNYO
 UsIY6i0GprRbV7awO9U2fRggxPKQbW+EYjnADJ4CWWGR527xp3/HL5PMiKnR4MGlzWNWVMLjRLa
 Ea9cOe73Eq9Ec+inAnymCCILQ+6OwZLnpgOSu0lA8QLrh2sTi429BVssAQnHIvRDVO0jWKsU+a4
 oz5tDzE/YMYOEEDNdIg==
X-Proofpoint-ORIG-GUID: _SYtRmHW7Qqo0m-msDinCaGyi4G5tvGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050

On 9/15/26 10:04 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The qcom_geni_serial_poll_rx_fifo_locked() function is only
> used for console support, but defined outside of the #ifdef block:
> 
> drivers/tty/serial/qcom_geni_serial.c:918:13: error: 'qcom_geni_serial_poll_rx_fifo_locked' defined but not used [-Werror=unused-function]
>   918 | static void qcom_geni_serial_poll_rx_fifo_locked(struct uart_port *uport)
> 
> Move the function definition to a more appropriate place that
> avoids the warning.
> 
> Fixes: 8200871327d1 ("serial: qcom-geni: Keep FIFO RX active during console TX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
