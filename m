Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF849EC57
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997755; cv=none; b=ukrslweEc0UCLq8oFQmmu3KGMvXw+z7v4BhQ1p2HhtRyKLHjd+KngCHNu/aS9CLBeSiJDUEKP+3mOxcR1xgOz2PienvC6B6eSgOMqflcLUAmn+zvnppUEyEnVY9/FeNH1ZFB+c9NXBJ4mLNK1i0cDUXl9x+3P2bWxoyAM+TV40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997755; c=relaxed/simple;
	bh=Pj6ozmh9fsmLs7MZSns+mq0MCLoIzeXiXHUT53zAR3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obICTsGBmUmAWkDk/u/OzqpVn/hMQHk8WF7/OV9E0L3S4sDMF+YcuC+3+TLXGzzuJERUq2zmVir6Iu26JqlbgSJP+IUlW4HWggPDmeEaUoKJ3tApbjaKfuYYZeG7mWWzBobZRE0xrnAPUXAfzQXxSeOSJmnF4F5m5xdVwtOyBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hSviSdN5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYj8E1sQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hSviSdN5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYj8E1sQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe0eC934293
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=; b=hSviSdN5LN1yE0PV
	q3rwlw+kWayzSE5elW84oTO05970RHEikA/vhSuK0powQP21hkIGjvGCnzlR4tsy
	Qw4Y76vuFRjKM5/XIlD7GrNLt03yDOApO1S5FpyWYYLcULTA0kRFQDPqAsiGPweU
	7Hc/q3GsQgb21s6v55WlXD4LiWNUIck51lGfvv0Zad6PeKjliUk24EwcA+sI6Zjk
	yAe+twZKvvY3z+Yku6LeEcAhEXHrYU8/WDOEa6IiV3WgZtAmFPOprMpI2ztbKRzB
	gc6j5A95eWxpfnjFBnOmFpLB2qgZ6KM5fsfmuB0xSYFzjI0PFmoUZ4QMixCgWOcJ
	pz35OQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8bav1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 13:35:51 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82f9e26ebso109222e0c.1
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789997751; x=1790602551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=;
        b=XYj8E1sQalTzRuRwDZayLUCDekSLftrDd4dO1PhiHU0gtXYYYM/CxK1nsle/yxfoQd
         HI6SXIUgQSp+pYoLAVtFK3r1PTczdBZLO3S4j3/SwXFMQg8oyuuvIaFO38HdkZypi+dd
         VZxlYPQkzGY2GbdMYfQevUrq4GXJ3iOtfmtzePZCjJpmRR7MPZYnMqV1R8jKlQaGRpYq
         XO40ae4dC1N75eNPSzyMIq566OW7gCkPEC2/qorhFn2JtTe+13QBCoruxBwoa+Pyg7VC
         VbO5mKktrFJZ1El0aVuPO2opboI+pWIzoR29OuKV7kno+vkemkqr2MuBL/IMwv9Gy8RZ
         L+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997751; x=1790602551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=;
        b=ZyfMkRgQPoScpnTUED0vfvV5PFyFfTxUWfrox7qA3EwyX2M/GchdMbVsW8Iuf1J7lo
         OG+fZcTTdvtEHcr3j7nZxnBQ2CBTJp813lwDaetY+Qk2BxTNyBMbc3dQBFPhEiOIj5je
         ues7KxC3nQ96ocjPaIh4nMVXtmHKyV1lC0y8CCLt1p1rD4yTJQmgiU9Wqj7AiVHnYjW1
         qQCoQWcP/bQrBilYZa0JbGAyBh68LtduT2ayu94Z7XzvKZj0PC66fuJGY+Pjk+NOvJj3
         CNrhwX8MWtkX/CwKxKl9+KgX06ghtZv+6xc/SlHzdDqlIj0VRP0JexAzl/tTf0bO47AM
         9lHg==
X-Forwarded-Encrypted: i=1; AKwUvByYGl2Wf9briHOncp42Lgk0zerMRt+Zgz20kvRvBjHuwIVNgNXkt500Pr7rB9EKzgsmR9oFA0vGx/6N0Xg=@vger.kernel.org
X-Gm-Message-State: AFuF++ktXCcuH1cV29SgnogDC9kTdLOWixnxyPIm8KIgm2S3Un8VgDQ7
	bPYEBsSilVyOEA50pkhXd0ZQgvucDPBRB0RqXx1jN/+8aBa5a3ciJDhp3K0hikDIruq4kuIMCyY
	6WkdGoQ9qLviehhcSibS2C5TAfSQ05sKOD/IcFv1jp2noyL1MWtRO8a8ZUxu6THb7Y40=
X-Gm-Gg: AYBFou2o/1bVd7l5rAjXjZI/Bd0rJr1ROIwHZnRcPN8LGn+6gX5H3omW9RXLwAUG3DW
	Ob/W9Ua55V/ZMRki3tNAxWdaH3H/vsc8KBlvOlXIqtt7m4ehrfs38TsadtpXt43T4Ouny0zbldI
	2B0X7NYzCihFmrruWSzG5IgGRroIwSZZOWJsOi79IHwD8TmAE0jzjga1WF9qNoNeXk6jAkFWOJC
	x+xTl+0n19XTt6dl+Yl8ch4F4DgkDg4sChHJeZ7iOCV9zhwm+k+MOhZV6e3OuZQUxmtcl9R4wEL
	XG/mJX/9VfhHRybbW0IPamHAxL0Y3pE+C5hwlXviY6156Cpa7H2V03/HUQESGSuAIy4DJu4vXWs
	tNWXjnURueOI/BPBl1NqqRQ==
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3529529e0c.0.1789997751189;
        Mon, 21 Sep 2026 06:35:51 -0700 (PDT)
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3529489e0c.0.1789997750828;
        Mon, 21 Sep 2026 06:35:50 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dd344asm4368300a12.18.2026.09.21.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:35:50 -0700 (PDT)
Message-ID: <4970855f-37d9-45da-ae05-027a605c03f5@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke
 <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
 <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfX9p46iqxRqjD3
 0oe+k4OS/NUxjdpB4V5c7YCPwa2NiMBww8tdViIDCY8w93EPfX+NL4WgY+NrPtNbW1hppCcsB0w
 5WfQKC4s4sF5B6QykG+qqmv9zNeewm19lFCN6NTKKMAfz7oIdzKLUb3ssjqXh30cqoShGxY8VHr
 VQK/ZClARgV7EReWSOE4OozCIhn0ZFFYoIznrSuSTeMT33nGMm9VlyuSKGmVMfu3eL2xnPd0Hgl
 TtD09ZGpeKYKvCIt/ySsWazQ+4cDpsat3dJBdZNn50oVRuKg5B7lCtPUuNX5an30KFsYNRcpgan
 EAogWbZa8wdtfmuY1jtmVgePoUc+Qhou2h3a6J+BA7EY4EbhWZ+vqCFJ8RxzfE8mGGK5aLUy1d0
 W5K53uk2Mh7tgFoF2+zj7LRAMAHYIy8DuDCuIJGNj3EphUmIXjAxCbonpQWf0PJP5g5HI9roJx6
 SxeQgyAfoUbyX+OMMMg==
X-Proofpoint-GUID: O1OqyC24lddphQpxE7Jjgd_qPmRG_HYE
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab132b7 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8Lir4zOpp7cNL01G2WUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: O1OqyC24lddphQpxE7Jjgd_qPmRG_HYE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfX+qMbNoFMGZ9w
 RvU711j7uKwfu8aN2WH3H+AjubINdZSaaCXp8JEJonMdNs/4opXd2DHzzlN9n7kAHfz2zMBQ3wn
 yRMsS7sAZ8R+qjyFiNW0ohIUyTuGcKg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210197

On 9/15/26 3:26 PM, Viken Dadhaniya wrote:
> The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
> rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
> values are several orders of magnitude too small. For example, the
> 50 MHz threshold is represented by 2500 rather than 25000000 Bps.
> 
> As a result, clients using these constants can severely under-vote the
> QUP Core clock.
> 
> Correct the constants to their intended Bps thresholds so that the ICC
> provider selects the corresponding QUP Core 2X clock rate. Drop the unused
> definitions.
> 
> Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
