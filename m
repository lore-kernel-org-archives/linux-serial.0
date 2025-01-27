Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69717BEC5
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000244; cv=none; b=ZfhV6CRkgJamsEzj52G/kcsi1GrBJM+PFknY1i7rYZsHm3p0b1uF02hv/mCDMyYj26rC4eL2mRGSbKawWCfiD3d6tl2k2tJBJVxCBG1yruq+ZO8aK/5M+w0Wj7tetnjzH7MGrhbqiEIaVCUzrnAzJXDULh4LptfHFou+F4FwWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000244; c=relaxed/simple;
	bh=oMtKn1w8MV7RLORjGlWvvKkp8uiAuM8uule2Sri1DiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tu9Nlx6dLAWz/5S1AVna5N/0DC7D+H+iJWbLVemGB5voEtXeqjEIkZE6XH2cbADCNezoF9rZG0q4OB6Y+GPIIBFM/oPwhY3XRpuIJlwPDMkBoXChkPcZAKcvBvOOaFIlmNRrM+kHOyMn+KbB4lPL81ZaJ70RbWbeOLoQvyq+lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VbqmqTb0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbqmqTb0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RD3sFf020754
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 17:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JnFriaF66qty0fntObxiPXMC9qtMds3asWVEQb56mxM=; b=VbqmqTb0HjxQSMJX
	Z0rsKuXrXEr4OCJRTmIf+hC4H6uRoYff6BwMe4dia7XPT+cMTueTix0nFY7rfeNQ
	+qW/crq1ILW+Tv0mT5lHJYsbHqW5ET4zLhV4aviwVuATeb2a/wyaEPzely88ppM5
	J8RmS0bYULha9ux02NRlODwp6L1JoGHO2Zapl0+0J9SnilfuJPoOVvNxq/qLMDA4
	qMXRno9sZRqQLqLiwK2U7uhmJRzGo3hmzBUEtuPMcK5Vb6ZwBx2m4m2eOtiLev4l
	2XZh4z0msNtPjdDsihOZ1n1pjL+JGw+3lTigmdLO3XxPHXZRmwnD/zJc5l8T/D3l
	m6mXiQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44eapq8mx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 17:50:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467975f1b53so13882361cf.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 09:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738000239; x=1738605039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnFriaF66qty0fntObxiPXMC9qtMds3asWVEQb56mxM=;
        b=U/3mShC2Bu+4KHfmjtO1CQmvH0Qq6Sp3+vT0LoQKnEkqicy/3u+GJ0E/gV4iN+hI4r
         4Xrx9S/lK3RFun/Akuji1rBr16xSbFPDsaKPOJx6axELB4hfIJie6OX6Qu1z5suGw0UG
         J0ziqM9+1KrqoupCCbcxnMOMrPNdo/cObZpmt2pybNVGQUUE0O+hRvfZZhPcaXFuKLxM
         C649RH7+kIepFxfMlNw4ImvdA6E5rY11rvZxLUt/zWI14JTcHQEGYSZ6Nzqma0cFKIQz
         lrJ5lLVqP785utcZR3ThSjD8dOs7wHByCEa6IGQClrkMz/6SuAlLU9MiQ/VHi2S6Do8K
         yojQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHx0340r5ePRr6jaRuie/p5+frz64FHafzCrbvqxq7XI/sLDxMO5I24a5V6YJykUPFNUZm1geJ98yjY10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJBc3dtx3Aq1RCXOsT5CZkG2PmZn9HYfwpO8Spkenks7kheMc
	TxdcuNC7QVwPn3gV8fGzC7h3F1INlSSzrjFpKXS1dVWqG40J4x8V0EctBLNT+MKEAJgGdjTBVQH
	1AvDk/2crIVlH7WfcJjTyMa21Q4K6JOxP+EaPO0JB+pGVkRW4YTToVwKWnWrz22s=
X-Gm-Gg: ASbGncvyo0kA5+RilXEsxmeqCpUSa60Wu7rXkb1jlDAyyoKoN4hMPjBmA6O7UIrx58m
	9T3i8q7QtmcFhqy6/RHtfAZAQud9pjV/VRTst/JqAvDVEWTeoAqV2jFm32FDV0lEqpxOqEy4DZ6
	PJih/d22/otB/Oe8JozAbBR1/utmIFGZJklrQh7a+RaipKq7zhuKocn0Jtr8gVZziCkEURu/CRl
	OI9B3F2bQljztLSyKL7ctd3EIq8hBvGW0R7abeabpwohfUFmMh8Nx9eghlqJL0WR3swgM0fIuDt
	cM0B6ofSNUWLlOC0KqZNet1JPvyzcUxywrcheP9JhMUL2O6Ti7DqHTVMDpk=
X-Received: by 2002:a05:622a:30c:b0:466:8e17:cd1f with SMTP id d75a77b69052e-46e12a162demr247808751cf.3.1738000239329;
        Mon, 27 Jan 2025 09:50:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTkQ6oLODC3x3JbwOrNQK8XQgzzBtmvlUI8UYGTs+vXLEGw9XGJuWNXuUxMNcvKByjipgqYA==
X-Received: by 2002:a05:622a:30c:b0:466:8e17:cd1f with SMTP id d75a77b69052e-46e12a162demr247808531cf.3.1738000238876;
        Mon, 27 Jan 2025 09:50:38 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186d8ad3sm5668983a12.71.2025.01.27.09.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 09:50:38 -0800 (PST)
Message-ID: <65a880ba-f721-4720-81f7-6891c335f7aa@oss.qualcomm.com>
Date: Mon, 27 Jan 2025 18:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: serial: Add support for selecting
 data transfer mode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-5-quic_vdadhani@quicinc.com>
 <10060d39-87a4-4565-a2a6-80c93ac2266a@kernel.org>
 <dudqd2y42wy6iq2k73aphd5ol4mtq7z4c54zhd27rl745rrw5x@p3oummf2jke7>
 <374e16d6-46aa-4bdf-85e9-bc2e33c38057@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <374e16d6-46aa-4bdf-85e9-bc2e33c38057@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3iq2znTxlofL6ifitfdGk5Xmuav_cmFd
X-Proofpoint-GUID: 3iq2znTxlofL6ifitfdGk5Xmuav_cmFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501270141

On 27.01.2025 5:24 PM, Krzysztof Kozlowski wrote:
> On 27/01/2025 15:27, Dmitry Baryshkov wrote:
>> On Mon, Jan 27, 2025 at 08:02:12AM +0100, Krzysztof Kozlowski wrote:
>>> On 24/01/2025 11:53, Viken Dadhaniya wrote:
>>>> Data transfer mode is fixed by TrustZone (TZ), which currently restricts
>>>> developers from modifying the transfer mode from the APPS side.
>>>>
>>>> Document the 'qcom,xfer-mode' properties to select the data transfer mode,
>>>> either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
>>>>
>>>> UART controller can operate in one of two modes based on the
>>>> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
>>>>
>>>> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>>
>>>> - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
>>>>   qup common driver.
>>>> - Update commit log.
>>>>
>>>> v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-4-quic_vdadhani@quicinc.com/
>>>> ---
>>>> ---
>>>>  .../devicetree/bindings/serial/qcom,serial-geni-qcom.yaml | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>> index dd33794b3534..383773b32e47 100644
>>>> --- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>>>> @@ -56,6 +56,13 @@ properties:
>>>>    reg:
>>>>      maxItems: 1
>>>>  
>>>> +  qcom,xfer-mode:
>>>> +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
>>>> +      The default mode is FIFO.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [1, 3]
>>>> +
>>>> +
>>>
>>> Just one blank line, but anyway, this property should not be in three
>>> places. Do you really expect that each of serial engines within one
>>> GeniQUP will be configured differently by TZ?
>>
>> Yes, each SE is configured separately and it's quite frequent when
>> different SEs have different DMA configuration.
> 
> Well, I checked at sm8550 and sm8650 and each pair of SE - which shares
> resources - has the same DMAs, so I would not call it frequent. Care to
> bring an example where same serial engines have different DMAs and
> different TZ? We do not talk about single QUP.
> 
> Anyway, if you need property per node, this has to be shared schema.

I'd rather ask a different question.. Is there *any* reason to not use
DMA for protocols that support it?

Konrad
