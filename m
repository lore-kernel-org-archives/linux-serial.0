Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5F1E515
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782784; cv=none; b=RZMKkJE16d8pa91Nv8O+Mexc1ADn1gaPxuFMIZ9q3D+xut23rvepNRV2yPtK5mFN9Ray8r/WW7NJ6bOr3WS26pwAWMu4xfAYREguLQyruubEKoUrNoa++Yt+14nxNE0OU20gPNvCuOON5IYrznWT3rt3ue+jQ7BSZmUgkUKEppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782784; c=relaxed/simple;
	bh=q5S4fdHqMsch4td/h2LL4IrtKsgHVAuzwFGJs8ryTE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsdqtnK/AaQ9BrttfCBA6Cy7hLscdXr6TLlfbe/UbzeHpVDlJqCpX7/PQ2tgAOaJKn3nBhc7YHULMYNQuJzXg2oA0tbCTbwJ/TdA1681eUv0waqEwderEfeznB8zUPXh1t6u7bqKl/pPMcmkkIV05eqBaKDTRdj5TZ/lffZIstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AybS1e2T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EMDfY80v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AybS1e2T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMDfY80v"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6074m0Jn1642748
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 10:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2nbs9WFJ7QadKnF6E6gy96Pbt7hBLo4hqc0fq+uZpnY=; b=AybS1e2T8z0cUUnN
	lxUakeSxOakxRcviDNWcI2yYplf8nOyiOdNzkJ+lqMrg7iniq4T8R512Q5g4M2qS
	nELQJ7tanNX0zWBobTexF4tmpoWWTpJfNiShRfpsJVccQ8HZhykbbVpdr75mGm6O
	rksZAT2lYf3iub1h4kpPRwTEi5hMDr9zo28hETAzoyacCa5qbWqpXVuR5No0bdW5
	CT3uOuU7vohsznImNTQsX3dxc3aFCA1BgA//HdU+EIdbNrLz6OndFJCjUlhDrO6e
	2jtiCdaIrWHipSq9VfizY4/JlrV2wEFTuUFXbHl2W/qxWyzIVnWs1AOZf1c/fo8q
	CVdqMQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhgsfh374-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 10:46:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f357ab5757so6307621cf.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 02:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767782781; x=1768387581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nbs9WFJ7QadKnF6E6gy96Pbt7hBLo4hqc0fq+uZpnY=;
        b=EMDfY80vvz/cJV6e5/EOrF3F3bYX7GWM4h/tc2mAwssXKqw/DZkwqJlEKwWymV4JyZ
         YrGKgjrQvrpA6k9QnWE+rBA4JkWBiXdDZC//XmV96PeFWpL1ho0/+eFUBxTqZaq2Nkgp
         8qMeGM35yXVcA2XJ9HjL7Y88epjiwKTsW/06DtJaXuHX1vBYLN/L4tXoWwLAgwYOcINa
         OvaLeIPJSC18f55BUb8mFd5Cxa+z1rqntmRHGZoOKrUPvFv8sS66VCCpDzCkjy9L2feH
         9YOYk0ma+B7k+GgnViTxrdnD6DQQif5snDsx4YY0H+fNLberEbX6E63Oo7+NaG/SueDt
         JQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782781; x=1768387581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nbs9WFJ7QadKnF6E6gy96Pbt7hBLo4hqc0fq+uZpnY=;
        b=arbuadBNO+fq+Ig7h+Q4x2kPqfz/sxnqFQ8FX5X1/E01gZQZ9kZKP5BBF35UvsRKna
         WQHrhCiwzeSZZyYH+w5hmesdkWjtJfK4EGeINIH4G0vNAmAgQuSrZvhIlTEweQ41O3gV
         ZdJEt/jjLhfpMsTEI4Gs7UahMzg6yWt39B8xyUip9WXYpwZYoRDFp3wQQDWvLX3qU+Rh
         wFtxkvZGAO5KQzYxUxzcj0PGi44vRh8yEX8i1AKQ6UbT0y+euNA/nDod0cvngZm6m2Dm
         lvarNGZOi2QyEw7zag/5WnN0nTPnwUf3ileORK7uWZyvqtkhzxBnErWGadvVDpcZB4BH
         onCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Xjs4FJ0uGbmavuqYQG4iCtmRt654wbksWudJqUG4U833TM79Llv3eGQOsqwaVs2TQjbBLEl8tOPKoj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3koBhgn5LXltlnSKTM27ihCOrgnLZmjlFwkskADJ5BxePrcf
	UGz3wmRa2PNv1JS7O+MXqt5PKeKHvxMfU4WClCEKcbZpWzO1gwWCQM0dnlPUdysbPzXcvGZqLoA
	aCQfwTn52/BrLeypsC5WEJvwSdsoF19SVAAyO3lj7jH5ZFK8Z5DYJv/+TniVvMn0ZkQQ=
X-Gm-Gg: AY/fxX7RwJny5kwmbZiMHOJZPGkdEPqUWLDmILecidkQPKQBNq2v/sljRYS6Trv3QKJ
	VU7TlHSRMcDJWg2lt79F1Vg79lEbWavKcHm6YqUaCPD6jtrardA+zgwRTIbwsxxqW6BAUVdUReO
	fY5LmYLJ48mR7C1DSIQ4pR0urkk+Y3zdGqutV555DJQozYKJOOlvF/KdKn9bnJgINUByKT5sswY
	8s9p9loheoeG+4cM+4vZjcFw8k04z9HvVjHjz5OvFvmRxFJkxduz7f6+CHO4RcUUO0+x0Wuxp5F
	dKTuL5g+N4swtot4UWp72pSgl5m9SVZFFBv5nF0rQPmQdKyo/DRkCqjO18DLlE7SnWXI1IDkkZY
	FzsUjRRxsMDjZhTG4ceAYfAucI5yY3qY5Z1BzAQtDJ9uYnB/lccou8i8/iSYreqQawiY=
X-Received: by 2002:a05:622a:8a:b0:4f1:840a:c90f with SMTP id d75a77b69052e-4ffb47e3b0dmr21036281cf.2.1767782781489;
        Wed, 07 Jan 2026 02:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe6ogJjUEG1iOjplpGO6qSFKv7j2a4fS0YdQtvynV52g/BonPAF9TSUSzWAjYcQD1tMY84yg==
X-Received: by 2002:a05:622a:8a:b0:4f1:840a:c90f with SMTP id d75a77b69052e-4ffb47e3b0dmr21036051cf.2.1767782781047;
        Wed, 07 Jan 2026 02:46:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65ca0sm4375962a12.24.2026.01.07.02.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:46:20 -0800 (PST)
Message-ID: <c0fd52a2-56a8-47cc-ad40-8c14c269445b@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 11:46:17 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2
 platform
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
 <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
 <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
 <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
 <36d8fb98-562a-43dc-8b47-b4f6d29475f1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <36d8fb98-562a-43dc-8b47-b4f6d29475f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA4NyBTYWx0ZWRfX7V4uzO51xB3Y
 2Lx7iPRytT4P1kEyX62n58KlrpyIiieI+hp5sK4fPtOa6qW1Q2ScH3spERB7Nmvzvv5qSSQNoLf
 3GAB1K1aqdp0/otcSiA6iX4kdYQi5i/qfxIRq6NfnkVb4ZCqXnALn1dtPjzib/MB//bVgSwhtKp
 3nKvfwjWFJu4zCsm4rwqugnbW6kQTUYmNiOASr6XJw2m2/KOrdKjzfe0Iv1ciFqQbv8UL4W9U6m
 HRPjk/eb39ImIvSF74f9lQOw4CsZJ25yDpfjq1RHcVyg6lUHnBfeRPwvuk/EegQQCqW7QzCOqHh
 S7bwR2Bslslu4IECcnjeFSFLc/nv6hMTUyXRe52iCAHYy3nG6B97wziy1hQrqCcJlXC0MPXZJWa
 2luWXiGYa6N6bpZgoXTp7KFE39gpMgrf7UZUEQs3J1/ga9/mf0O7ShJ7CRjW0bpjwZY1zWSzel0
 7WcSMbHQeVBUUrwtNQA==
X-Proofpoint-GUID: VJH2kRE4gMxkTBCB4v-exMvZc7hJMAuN
X-Proofpoint-ORIG-GUID: VJH2kRE4gMxkTBCB4v-exMvZc7hJMAuN
X-Authority-Analysis: v=2.4 cv=Abi83nXG c=1 sm=1 tr=0 ts=695e397e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jycnLKW9hUOS54IP5eQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070087

On 1/7/26 10:24 AM, Praveen Talari wrote:
> Hi
> 
> On 1/7/2026 12:52 PM, Dmitry Baryshkov wrote:
>> On Wed, 7 Jan 2026 at 09:06, Praveen Talari
>> <praveen.talari@oss.qualcomm.com> wrote:
>>>
>>> Hi Dmistry,
>>>
>>> On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
>>>> On Wed, 7 Jan 2026 at 08:48, Praveen Talari
>>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>>>
>>>>> A regression in linux-next causes Bluetooth functionality to fail during
>>>>
>>>> linux-next is an ephemeral thing. Please reference the exact commit.
>>>>
>>>>> bootup on the RB2 platform, preventing proper BT initialization. However,
>>>>> BT works correctly after bootup completes.
>>>>>
>>>>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>>>>> called before wakeup IRQ setup. The uart_add_one_port() call activates the
>>>>> device through runtime PM, which configures GPIOs to their default state.
>>>>> When wakeup IRQ registration happens afterward, it conflicts with these
>>>>> GPIO settings, causing state corruption that breaks Bluetooth
>>>>> functionality.
>>>>
>>>> How does it "conflict with GPIO settings", what is "state corruption"?
>>>
>>> I mean the issue occurs because the GPIO state is being altered during
>>> the wakeup source registration process..
>>
>> Altered how?
> 
> During the runtime resume of devices, GPIOs are configured to QUP mode. However, when registering the wakeup IRQ using dev_pm_set_dedicated_wake_irq(), these GPIOs are reset back to FUNC mode, which impacts the RX GPIO and leads to Bluetooth failures

"QUP mode" and "FUNC mode" are tough to swallow even for an insider.. How
about:

"qup_x" and "gpio" pinmux functions

?

Konrad
