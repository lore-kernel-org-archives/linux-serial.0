Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B925C825
	for <linux-serial@vger.kernel.org>; Mon,  5 May 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460903; cv=none; b=TTrmns48qrkVm7Q+cH49WvUKuInooI33XRj+H8qADkG3Y+uN3F+jEviW/VrRhj0qQx32QKacxl6DKspwulROH2z7QjjJkXsEGnCD613dlPjXpWKiqEHuwJlmH+r/+AVJNXXVRo/ZKVTZnRwCRKODaWZWG7rL+jhswPVgPGwtDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460903; c=relaxed/simple;
	bh=oksWoz/qfjF62lhOVwkmnzE68DlyPmns5CNFXyzzkwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGLZK4W9vLkBa7h4Jz9n8nxPV/DuRdYkOreXAuFn6c0IIHHwG41B7AjUsBRGD3d2CdCXlme/IDTmC3muvTNsR5EDJY7KLboeaC1CrMEKgSpHk6PWuphC1yxuuUkBY0F2EukUzKYKn1isbLo6kkpJJUQRMekshG/REBAAv9UxOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFji+27z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFji+27z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Bv5TY003852
	for <linux-serial@vger.kernel.org>; Mon, 5 May 2025 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4u8e0uMKU6snjywf73T2BPJqst0pyG3KVo1RsgJxxg=; b=VFji+27zWJlXNPRE
	IZhTs13tWR+rM99hSJepJ+Ma1MDn/1cec/06WQOPN6uO1SkELyLSEANbtgJ+AE/X
	FZ7N8haGB4r71tSzMAr2pDbAAQ+eFXjGLrFRg2ktpgkmqEiQaj2rzwFxrPyQmR++
	rqWqiJt6Zu2bRhwRybVzbheZFUekZ/AzxdJBSVad3CN8jYsg2mYgRvfrXYqbhaiL
	dagzqowDbFrWH1ty6aRLmZCzEvmSdh09QH0EPS6N0myiwojzCazYxAb9IGVWOvqN
	WK5dKDa4wBi9B6tPYAnVfg4vj2guvA5NyP17NrB2s6zXKp0GmWt1qrYnLdXFcmD4
	35Y6OQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da55vjnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 05 May 2025 16:01:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f3766737so14371766d6.1
        for <linux-serial@vger.kernel.org>; Mon, 05 May 2025 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460899; x=1747065699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4u8e0uMKU6snjywf73T2BPJqst0pyG3KVo1RsgJxxg=;
        b=bA7v/J2haZaKh3XmBY72j95mUBSBHORAqqK0AJvBY2iPzfJdwEvMr3xom9MOdqzdTg
         jVvaDpY4DNNdR3zXV2N2I3ed5i/r4SLDDjUd+rnTOEjkF+66QKqKMaMEZkWbzrA3DZ0O
         gat1d7wnpcjevDm/w0OsOs0Y1HmsTNUPddQ09KPFglIDBFCUkeAQAjP3v04Uf6/05F8W
         nNIZT3La1Ae2hxxbfzO3hfty4GUG0zcBEjadOv3U2iB0FxfBX60e6FteK4d+OfWxpNBo
         IOo+bgTa9C5tR66P1DrDAgta+eatmd5ywRyI13LH0lCdvGIvE9DT1pbY7yPx+1XCo5Kg
         zWbA==
X-Forwarded-Encrypted: i=1; AJvYcCWYNGLdMp+Kz2nkkr6RNhGjJLTavY2Rk4px5bXOiUz78nokbWZGOz0zqgGsv2b+Z0wD5eejrugDxDmVGTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYYxGK2cU5QLIIwadHfj9buAnwRa6VLYUA4cqlM7XfgWA11r4
	WG+mN6/Q1jBQzXrMN2Q+kGtuEMylNV6E+/bmvL0nfkJx5ZpQlN9mihJpr64Kz6aCIA2kn1UBLF6
	KAaIZ1j6f54SI9IRRFXcTIJMclWKfT326zjPqkqM3+HrB64PgrerrUBUKd/rcZfM=
X-Gm-Gg: ASbGncugm8ES8ZedLg4PVisPP80SCTvVBRW20G2DmGFewrO38PY0G2Zuzl4GWBwKGZo
	/pgbL0GjhMbBDjuj51+ypdP5eFqqUK+KJPqRgHLwsYLjdOFhXWN4HD+6+1EyksGr7L+oqO3Hd6o
	KHIBuAX2eXBpGD6htB94fsSftXQFbyW7TtxDYX36MTU+fM7gPE2w6jM2aX5OK3LuvOMYCYTT2kC
	zXsNRdx7uIrN0TthcG27ctMt7xjqlurLRdeWzDLCbRpLvknTyJdxfdGHLbp6d2SDIRHHFhu/olZ
	u0oHn19Fu+OBsrEqz+ODEUCAvN1Fy3ryVhm7IMR7mYA5QL3FbIt1XiZuTRnueenjBJo=
X-Received: by 2002:a05:620a:319a:b0:7c5:6fee:246f with SMTP id af79cd13be357-7cad5b37edfmr776321185a.1.1746460899153;
        Mon, 05 May 2025 09:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+/p0BrecmIrDNm5RILVrBtCb7WrTDff8xHjP9/Y7QIwhw3Dv3HKuLgZUUhA3XQT8Z4ktRng==
X-Received: by 2002:a05:620a:319a:b0:7c5:6fee:246f with SMTP id af79cd13be357-7cad5b37edfmr776317885a.1.1746460898565;
        Mon, 05 May 2025 09:01:38 -0700 (PDT)
Received: from [192.168.65.169] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3cc5sm521149566b.51.2025.05.05.09.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 09:01:38 -0700 (PDT)
Message-ID: <0f64aadb-badd-497c-b936-7644f5c5021a@oss.qualcomm.com>
Date: Mon, 5 May 2025 18:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: serial: describe SA8255p
To: Praveen Talari <quic_ptalari@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
        quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
References: <20250502171417.28856-1-quic_ptalari@quicinc.com>
 <20250502171417.28856-2-quic_ptalari@quicinc.com>
 <20250504-hilarious-ultra-grebe-d67e7d@kuoka>
 <6f97510c-eb6c-4f3b-b219-aa8d895b060b@quicinc.com>
 <20250505-ostrich-of-impossible-conversion-a0f8ac@kuoka>
 <4ebe065e-9686-4e35-bb00-a9e816fb8926@quicinc.com>
 <1de5c0b7-7761-4d0c-bced-7e26150e995f@kernel.org>
 <d96eb6b7-5b48-446c-8b33-ba282d896e85@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d96eb6b7-5b48-446c-8b33-ba282d896e85@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE1MCBTYWx0ZWRfX6A+uuDtOQBtN
 EPwARswYUXZLSZ7m6OAnuN7Ke3KE4HkMaORt/tXY30EDr2EpJ2V2VsSByCnPU6ly4ZTyepzl4w0
 T804lQGVmb60+2CAjFC0RLmbvOsj3SOfensd5qHd2mFUpWkOoR413hZ4KmEkdr0iedJzT009/Pv
 fzg5J2AN5m5QycXO5P39qtDtRqrbhHqd+d7+cT73diLpplVAJNlCtaZKsE57EzgCBtebJogV9Uy
 QMHW5RC4dXhxEGe/0qdVDIpktgp1NHbCNqQ/9TElNUwP5pJOjYD0VQ88aEfnIBPC3VWBtugBva6
 xYsDCvhFl98eg4+eDMl9/u1RRybgLG+hYkQ/Eu5jdlo7d1APl5m14UG6ADYfZby7GtdjCx7x8bs
 hOvIBxTeCt10sSQavJXIpi5LIhYDIE692ipiH7OpgylPzPvMICPqJSXg83heCRQ+5KV3K2hQ
X-Authority-Analysis: v=2.4 cv=M9RNKzws c=1 sm=1 tr=0 ts=6818e0e4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=4zt5D2LFsg2i9ozxeDMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: Ov7BbPkgirW3N2p191vXq9c1hJApiT49
X-Proofpoint-ORIG-GUID: Ov7BbPkgirW3N2p191vXq9c1hJApiT49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050150

On 5/5/25 3:42 PM, Praveen Talari wrote:
> Hi Krzysztof
> 
> On 5/5/2025 3:29 PM, Krzysztof Kozlowski wrote:
>> On 05/05/2025 08:51, Praveen Talari wrote:
>>>>>>> +    serial@990000 {
>>>>>>> +        compatible = "qcom,sa8255p-geni-uart";
>>>>>>> +        reg = <0x990000 0x4000>;
>>>>>>> +        interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> Why isn't here wakeup interrupt? Commit msg also does not help me to
>>>>>> understand why number of interrupts varies.
>>>>> Currently we are not using wake-irq because it is optional for our current
>>>>> implementation.
>>>> Great explanation. I asked why is it optional, answer because it is
>>>> optional.
>>> sorry.
>>>> What does it mean optional? This is part of the SoC, so how given one,
>>>> fixed SoC can have it routed or not routed in the same time?
>>> the serial driver doesn't enter runtime suspend mode until the port is
>>> closed.
>>>
>>> therefore, there is no need for a wake IRQ when the driver is in an
>>> active state
>> You described current Linux driver, so if we change Linux driver or we
>> try for example FreeBSD, then bindings are different?
> 
> Currently, the driver includes code to register the device's wakeup capability
> 
> but it lacks the necessary handler code for wakeup IRQ. According to the serial driver,
> 
> the wake IRQ is meant to wake up the device but the device remains active because
> 
> the serial driver does not enter runtime suspend mode until the port closed.
> 
> So it is better to exclude the wake IRQ until the appropriate code is added.

No, dt-bindings must describe the hardware in its entirety (to the
extent that software differentiates it), to the best of our
understanding, the drivers are free to exist or not, similarly they
may not implement all the features

DTB and kernel versions can be out of sync, so having a complete DT
description saves us from having to add explicit backwards
compatibility clauses in each driver and maintain them for the next 15
years, as well as letting the user update the kernel without worrying
about a breakage

Konrad
