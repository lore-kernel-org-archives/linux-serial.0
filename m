Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D83FFFA7
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525994; cv=none; b=ji+RbyptKucg5wJAZs+9pVROns6E0nrrPFT1Fy4qAq7Q3IjaKKUzz1nZF3tJoBp+L+HbJe5Nj1CkYaI/DLjQtEnPKbIOwaMwNuS2dqt+wDRsasJP+yS4bcTCZt3uQxZN94xEFxSqm77hebRkNLUDxBTPBZWpnbjVC4tU3d9RTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525994; c=relaxed/simple;
	bh=ocgX1pDw3Akkw8kPU55zkyixBru7VgTxC2qT9emL7gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olvJtTHD6veuw22Fb6LcvHdORZbCv9z2fDq4pIFlGhPL5bdo3rmtq0VVZgqHPfHUf8OMINJjDSPeQmson2Y80ApIT1km6YQbOkUcxzM3FQmT/j8b9UkdBzyNzCgKR03iaoDaVeHUv5cP7RS4/n3PTZROmIBGpChgvQv5DSOOMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osRJ3OkD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MlodgneH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osRJ3OkD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MlodgneH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8Yqll3847943
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 09:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=; b=osRJ3OkD/txwrGrJ
	lYo1OSnlvhhGF2/i/13Kk7xLHpWivjlqAtdThdDCHwc/s3INThmnBrcB7/pHbgST
	pHDUOtI0/SRtNYiJuVTPGDs9/WB/L/mpnGHwbMmA/vUH24Qm0RkxNIf9rvbvD/mi
	cnohwO9Jl61A45tm9uE2iamEmWawRtIN8P/w9AsuIIFcZfX7IqOgi2PjtaxgCJYv
	t5PpN3VcOt0gsNEFwzU4Q02tQb5bGnmtcqHnZIw5ElWmkIGLV5Tu0AtBuSuJfnG4
	CznYM1wo3J/6JAbGhzpf8/HISfINk1wpHjohJR41rICy2jZLt5tYzRDIxwhleqRI
	17YWHg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k315-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 09:13:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso1362969a91.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525991; x=1787130791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=;
        b=MlodgneHx3h4LPKC9I1/3d92DFw6aChr4Ldy+qUCOw4dZ5WQZsWuBX/ov5Hwy74fNO
         LLHBFVew17tYR7Tul3u6l4jaLpFxbcbDn1BHltBHgtXWtrUftZqiMyYkpyxKOP0ZWYjX
         Cqk6U+jkj7JwhBNMMFvh+8c2D5ehLQDMc/3bokn2gXUvUFlrtEbTe+VbA/kkpb6gAzhr
         IMVQLe+4LISV7kQTKbsWFblJg0NoIZTdStsMgHCMSNIr0cGBwV2ZBNO+r5xPvMwgfFHv
         lk9nI6n+MvIkiv/3BwOCQ2Ayf9qiM6bWk//nIOA+Tu5ajI+S5oCci5iNw8W06aQ2YU8i
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525991; x=1787130791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=en3WBeGYYKKXUQNTqjZIewPokiWrCYWKofzjGcl8Hwo=;
        b=dp83JgIORc8OTr1ZR64vPHTHUatS47BVAaAMABN4aoC4QVWJcrM2aWouJJDClO8Okx
         1RMIUMkKnk8GbxmWzEuwJMnD9IXXEyc0cFTM2OpWt+Cpy1Yi3hpmjLORJTEFD/01e6z7
         M/tAKOmjATlaJ0VINY9cF9QIJM5Y4l431Hhw4ZYEfiVx5nUbw54anKtoh1/CcpgZ7Cu3
         5yqyXIM/cQveDQaYBxkJZe/hNIfk9rvn8MVao2ZjV4A0v59Oe7u4JEQZRGIIUmU64kwW
         dXrr86a0duJcCa+nlcWkk+Kn6+eILv9m1MoJwCzsQamuCcexkQTdfqX6dKjpwObxUKyu
         PkAw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+25ZHGOhTS3L1r/GGyfTc9T9SJG5n/XyQKkBUUCWqdlXiCFlmFSuJzvHvS31gSh8spC8RWfoJah3B2LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMoBNg37V/tf6hc6PMzjV17J01VL1ry2Hyv8fe7Uk+ydcN28p
	K1SoXZiRjCTMXcyNb8/R6SnKIlKfsaf4TnxnkC1oL7OWehM5He89ope8Up9+rtmEB7d1zd7DHNN
	zZwimr7vuSgmJDTmH2P3rzN8Cyc7D1AhWgQ/i1loKV/rxJwEx1E2Wy9ti4pz4U7Lqgcw=
X-Gm-Gg: AR+sD13NzYy+psUAzAIdP814nDIvy+QIe+uaMk4FGrL6QK+z7NWV+Wu4VjktuKZ0TQs
	og4djG1r7r5JUuwLVFOno4QWQW7RRABQhEu+IV1e/1RJb+tyZV3PMPBlQ+Hqc5V0a6NyjHSkbUu
	Mg0mQL82KR+YMZ2He2sP1TL04KUySL1+3V0+Lj3E3ejz397a7cRizAoWtq/wGQl1yXx0zW99st3
	EzIGD7SJWlyMrVuVsCyGc5/hFqd408yB3bMyGd/a76kv+HXQ6ISwQYoNAoudTOaC+aLmrWdwY+K
	7XiZfc4AvDRrXVKKwe+L4Brv9odh3A8YwA8vqI5KorXyEhKyLBLERoGXTMu4mGGKHYSoIgXvGXd
	QQ69UcCYMKNJ0peECZS/ZbV915BvtmFIg5Q==
X-Received: by 2002:a17:90b:3c11:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3930119ed5cmr3829300a91.4.1786525991248;
        Wed, 12 Aug 2026 02:13:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3c11:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3930119ed5cmr3829241a91.4.1786525990816;
        Wed, 12 Aug 2026 02:13:10 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d239esm2915805a91.6.2026.08.12.02.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:13:10 -0700 (PDT)
Message-ID: <779ec0da-4b51-4f8e-a59f-d482f8e8dbaf@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:43:02 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
 <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX09LWD8pk4L1b
 LTQmY9z1KvD0d45GfBYQlCXWhcdABa517+9vMHGN5bYkj1YJ5iHgUL1z9/ZTbK4hzXO0gBfMc26
 csRpebG1p3oAUccazJUtawXAAaD0IUk=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c3927 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GpIJag5-aaecOpU0j1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 2C8NNKHtsWXktcCtiKXokmh7rnJlq4oh
X-Proofpoint-ORIG-GUID: 2C8NNKHtsWXktcCtiKXokmh7rnJlq4oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX3C8tusJOZmxr
 a3i0B1UKuae0Tyuj2J/llyrVtx6gJXn1o5E3tI766hnk+7gPd+Vwwl10HMdNb75TL3UqVrCNM2L
 BXZkVRMrC37nbgmoFweH1Di8Gdh+wlax/mKJejIyvr9AxD4tilXs/14ZEU9uD4Jsd5B7yTh8xB7
 5W5JErf4u7e4Be23rRkfaS3S59waU4eTIRBJ9l5FmOrVgITfLuIPwoBjwZSwY4Jl6/HMXokTUYS
 HG348PHje0Sa2r55INZNEAFyvAnOqqsmuHcO4pr+akizL1RvrvDlMFAohmz+9gufqAqJOtC9TE5
 1H/xtOSbynLg8m8VqQuBs3BJ7yUbs+Vd612/JjIaKf7wiJULpzbWx+CGJmi51aSaaEhxpbpnjSg
 m11BZWpg6OJkHdrAv02kUzWDmqRiqEWyCRMfPrUccXz85INQEm39Xp3xuooG2Yg8nA7eJe5fAto
 qLHugoN4SDXoyMPYmjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120073



On 8/12/2026 2:27 PM, Ulf Hansson wrote:
> On Wed, Aug 12, 2026 at 9:24 AM Mukesh Savaliya

[...]
>>> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
>>> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
>>> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
>>>                return 0;
>>>
>>>        if (!state)
>>> -             return -EINVAL;
>>> +             return 0;
>>
>> Won't this cause an issue to other drivers ? how are they going to take
>> action based on changed return value ?
> 
> I think it's rather the opposite. With the current returned value
> (-EINVAL) the driver doesn't really know what to do. It tried to drop
> its vote, but that failed - so what can it do?
> 
> Moreover, from genpd point of view, this fixes a real bug as the
> aggregation for the performance state becomes incorrect during runtime
> suspend/resume.
> 
Got it, thanks Ulf for your explanation and also read your previous 
comments.
>>
>> Remove Acked-by due to this till i give back.

Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

