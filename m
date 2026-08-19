Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82443451988
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138026; cv=none; b=eqGZW2+XDegRUMAV/EBoPArjbEJQVFb0gky2DyK0rrUBB6rQncyOQ6p27+4KShqW7ZcDjQKAPH+bOA3pP86etnCK1rQP9rTulGiSjQMWLtnMoQaG1mgWQ0SizSgFfsn7NHV213/pXV79zWkO9eelQ63tBeUMhpnZ/EnMTQCvmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138026; c=relaxed/simple;
	bh=909ro/fzf/GQehxNHMqOgCUY8OQL2KUAAFxDDPFuGf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKPpAvIBqRhOLr9CV7BUmP3z/wvPy7Yc6xuyH3zFslfikqxKZeV3gPy9f0frg8cZJKu2ZZYYKNSQfUPmfBhv67nVDl7zFd6hiFhi90/NtJYeg5KxDhZzVb6c6LAVw4WhgaSg3v1MleXweI3EqBRZbRRLVHt4LonDGoh7CvJDcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6KbtOGk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YUXWBJjt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6KbtOGk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUXWBJjt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA8PUf4182147
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 11:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ig6FvSRli1ZqS5uDLkbhiTZeNooor70ALrndiWqEtrI=; b=R6KbtOGk0MOGWZ1p
	gb4jfVydfHxpojFg0GJhs/q21UKl0i/VEiMcB/DcdwHtPGBYoMh9TelId8APGW1H
	mpPKtwLl/mIxWgYIR8VeZHgVifvtEMkhIxaUenX8yCpWRX6UUErn/p0Z/tbgCq5E
	z7azllfMmg6bu707r3cmjGJjj5A22/uc3byH36q4v6RtVqDR1ovUIJfbXPM65JbJ
	HBzd2gq1Jwt7/1TUCgQaILpad8RK8lhnHnmp/F5Kq0Q5IhCm/cW2VwUWd353s6em
	hslwnuteh06ocWdwq+C8G72MQYUVL5B6khbQ/E2RLw6EtvSj50lRTRT4hhS/+8UB
	pR0x9Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkaw6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 11:13:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfd1772d8so1547781cf.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787138023; x=1787742823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ig6FvSRli1ZqS5uDLkbhiTZeNooor70ALrndiWqEtrI=;
        b=YUXWBJjt6l/r8oS+3+ufi/6/qNBvMdE+AENmKJveui9yji9be9e/tVtm8VlrwLw2mU
         NVwnY88ZiYNN2TKqXTE8gzbw+QjSOrJ+zeyj91N3p7fSa0o3BI3F7XaflDD72TsAJ5F3
         esitBffIC/rTb6XfBPd840bPpqELmmcAPwkifvhJWzH3So7cY/W898eMSAVnGDc4uk04
         UP1cgFRqIX8mr7oTZFIwmkUB0FumXEyJsW8As7iAdSzH2R3hR+JMWUV9wu/QD6/Z0SaF
         vXkekwQGni9D9Ef+5F+wVKluGF7SVI47eaKhU/EIcxhNwslgGNgiGi/QroJBAQxFYzdK
         oWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787138023; x=1787742823;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ig6FvSRli1ZqS5uDLkbhiTZeNooor70ALrndiWqEtrI=;
        b=RMyppyBXMvNXnii0vCWSS0GBRYPhxQzT1QKha3Zq5epVYvTgzVxv9xXkM947kRTUtE
         gvOs93z9vvbd+qjeswFlJx+pesADPCyhXNmBd5IBNYVVt5ANZLSUF4RAPXEa9sArL0vJ
         QcMxhnbrw8tl6WSH2qTKmYUFO0H+i1L6HT96ffVxVUQCKKUu/yZ3XsE75jnebggXDTsl
         fbSJAmQa+Z4qKKqZQlUwtD7M0CUostmb1Gm36nspFVdWwpMLM0a+QA4yJI/yXWvdCAl9
         Ql1S3tGwQbeewl1CGZqB/bMDOgiGZEFIHmERqs/r4sRGE9bipelaAUSuQVUwiF9EeUUR
         92wQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbR/yqqK11bQNdinzxO0RpMDRsxtqYpuhqbGu5Vp8/U7OaM7CdrmCjpVvJ9rm0cP1+p/v8K+kj7xlml08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmig6LnWNDf1E5kFLe0k5i9WAWhzPXAgxMX6vFZQaRGDEQ+23F
	8wq6nUBI5nHyUeRzsnKkfiob8sbxwMnGi3WTj0KSSmYRqFZIi2/lRlCwHe4FwBDmVqnczYTaeeo
	RXyJxdWT+24OZqdocmRZjml71QANQKanZwCDB6uiW8GjxfKuPqGUfPa8m+/3XfLozxYM=
X-Gm-Gg: AR+sD121JoSy19+8y22jysb0UWKuhVbq4JVQvGnSYH4SGzg2uAzQ8eL6+a/Yk3x/v4r
	xeaLLclKSZod4g8CSk6fhZgNeHTdLPkBSci3ovaVN1DH3JQ4nBTMBBRCzDZjxy5XMNzC7S1RQw9
	7YgmNz9xfSWIjd49Kt9wFHEkMlTiHnTkFcCCUNEBmowlrO8rtQ8IvKvv7K2Dbf+YbhVUT7j8Q1o
	AsJ6/WHM/MivFeHxtQiozLDtYna7/ResZM3pLZ83Dr5eCaA/M9zH6qcEomqFl5EnPxZtgRlp81G
	Gmcd30nWsepwd98mSp98nnKZMZri0yEUftKSfCYnZ9dgLh9VRlayNM2l4zW53QNW2w+sGwjAe4k
	IgWXallyCQ9CcH7mMEDF7HVQG
X-Received: by 2002:ac8:7f0f:0:b0:517:6162:daf5 with SMTP id d75a77b69052e-52dd5c958aamr25088891cf.3.1787138022837;
        Wed, 19 Aug 2026 04:13:42 -0700 (PDT)
X-Received: by 2002:ac8:7f0f:0:b0:517:6162:daf5 with SMTP id d75a77b69052e-52dd5c958aamr25088541cf.3.1787138022385;
        Wed, 19 Aug 2026 04:13:42 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c7a6bd9sm57416566b.23.2026.08.19.04.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:13:41 -0700 (PDT)
Message-ID: <061e5547-4109-4965-8e97-fb126dea3a28@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 13:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] serial: qcom-geni: Propagate errors from optional IRQ
 lookup
To: phucduc.bui@gmail.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li
 <Frank.Li@nxp.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Yenchia Chen <yenchia.chen@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Zhiyong Tao
 <zhiyong.tao@mediatek.com>,
        Sherry Sun <sherry.sun@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zong Jiang <quic_zongjian@quicinc.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260807090945.41690-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260807090945.41690-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Jo3ZvdLEzp4JbS0ip06C7rLfLBwKuaZU
X-Proofpoint-ORIG-GUID: Jo3ZvdLEzp4JbS0ip06C7rLfLBwKuaZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NiBTYWx0ZWRfX5SiN5fxpXYMm
 I4Ojie66+/l+9OHDkVccCPaW6sd/pGTXLdXW4aj+z+H7SXJKh6SZpOMRxWp6l8l+0AC5uWzLQiz
 by6U/3iYG5Dm2u2qypjVTESOdbchSL27gUZQiVK4zjTcVCuHtMGW43ptQucYSXt/I6Gaq2GhpgG
 5WY8AmcQMCaHsusuBnp86vnpwQpVZ0y5uI4sgHnU9iynprXTS/mIIF6/gSMNOtVMAZfiYf8Ar6f
 fB9++TU66hQnNMixNbRFGTwcxFsPDVmanrgIsMrAyMoGXf8it6iiUFk4zhQdhpeufwIvVEsXwCd
 w1iRi9Co+xiAnC42SMb8CogIsZK+9pY9aPOX/7v4XH0ljefdaiYWBMWfZcC0Ji7gAD+Me715q57
 Kt5ylJUEXibJBEIt8ru68s1l1F/4QPI3QH8faV1JTYeV43GNuzd97z1PfZ4fqbOv0EjpS14faVR
 2iGi3LdMjW2fWaEKIEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NiBTYWx0ZWRfXz7QlwUn59uwG
 HNPdb3YbfUzXHn7QkkAo301bzSIif/zqw7QqJ71EsxeSNb5Odw7IkSgT8YWtFq0lENw3LHrzWpi
 unZnVnn1cKwqsrLtbkdZpeLBA+WGQrg=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a858fe7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HsG88Ws7tFqbOaRkTuUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190086

On 8/7/26 11:09 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
