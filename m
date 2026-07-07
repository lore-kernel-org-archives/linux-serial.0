Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0562386C08
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411104; cv=none; b=TQbV1CljfHxt7dXmr15r8nKhkTovX/YU+UpOFh8AKdC9zzA4WaTKrOun8P0M7g4A66O0cdhDvV1A6+mxlFMLZGBhUldukEa4ijj/n6w1E5925NDW+VRmXzFeiUv2MPFXANIW+48dHSBaLpuBt49bdWvHRkq4BQANCZHwySiDDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411104; c=relaxed/simple;
	bh=ztXmn+eCrSwh5ZiGnWR957nK0ZjcBtCetG6G6/NB6/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqjNnlkv7L4Qy7LSSygzvvFEfnp8WovWafIsTdU+ILWJwLxS8Yrz2/ri7sZQeG4tWTlAQuadMm23ZX9aG3uPPVH2WidLPrJIrymxOlTLrNodvd3xRmpGqI5j+LD9kt/hhthzbcZqZdCksijSYO2vRxQ9JQ+7C5crkRhskt0tKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WX88L11J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IN6g2tgL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX88L11J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IN6g2tgL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6676KTRf2922475
	for <linux-serial@vger.kernel.org>; Tue, 7 Jul 2026 07:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUooB1deojgOvP7ieAkOlre2HwGhobUrInjBUHYU6dk=; b=WX88L11JIeZc7NaH
	5BKM6YKzEwOc6c+K0YOQ7I28JB/jbuDrjo+HknAix/ofnhTWfAby/FzjvJmtEnFm
	m1/xyixlRhiZaWt46TfSTl7naE/SgvKBZbmFXAzdeLgD1pCJTI+BJ+5zgSw9WrOx
	QHfSbjdFbIHyDFhu0PyF3ibFOA0g1XxoDuYeJVrfeyndkPtMpMohSVGua9cLloci
	9yHI7uFl6OJhUn53wHYbJFVMVCE4ynVCvrqXtrCSnQQ/+VvfAktuMbyhuxEWDVL+
	6CCXApAjeJqJB8ZDanwJy9OGuUwIEZqLJkFN5p0BEowEI3BmNBwwdC4DoJNTgpey
	cDh+pg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t8cp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 07:58:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c267931ebso23648471cf.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783411101; x=1784015901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUooB1deojgOvP7ieAkOlre2HwGhobUrInjBUHYU6dk=;
        b=IN6g2tgLq4IJ4iB6tXiDV13KW2kwXMiSFg9HPLjnZfPsgHJjT4LGyx19ka5kQkHZJ3
         8bAv1q5+SKJgb8rEiLjmVL6Y/cLctsm21oR+bQBdctZlnMrxKTx1YwTgTI1tJrTNj1V+
         8twoUojPVm6UFjJ0LAs5zURfV+X/ipbahWodaWXam7WaMXa/C28pYvRHVfRF3dtBtiA9
         z8cYrMMTBtdvJFYHG0K2pa8jJEYlZctS6X3mEtgiyodCeKqHnLmNWFwSmHsIU/XR+V2u
         M8jYMc4zdN74ovJAYGK30PsoSd6BuFJHpXdFLSgznlmBf4cNydm0jprHNcMePVGGYKCW
         HeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411101; x=1784015901;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUooB1deojgOvP7ieAkOlre2HwGhobUrInjBUHYU6dk=;
        b=Bm6jD7uu1uU6wZnqxMUoh1H7AWPVd0gNSNOvNYlEWn4DOZ+e195TfeAgCqLKOR8M7v
         ubGDm7IyrlECx23IWrkTNFgnLwpsku1/9zJUuc21uFufsu6Fkl6y6ZNsaXEwvEA0Mn/Z
         SG0oJVRPWo5aPAWLlf0icjdDY4EtwroatcGusQaRh6T+fZurDERVGD+eXBWK7n+o7oP7
         ttHl11E79RaRU1sCpds1CAtL+6T5A12pFuHaIr216QLAPIBZFwwjsudEKVjFw201pRVR
         p4Pi18jRC7FD+Q/sd8rB7VOYCgkhaDphpzQiDC0bvCIP3eDinZx6OzIfVEN8OffRL87B
         fmxg==
X-Forwarded-Encrypted: i=1; AHgh+RrXZnn7UGM535KFOOqoCC3MCgDnmtjTUTPw4et8KzG/0dj06mUpUXxJFqN6PM6+Ye8f2EeD5tff7ZfhEdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CytVNtrDieAQVn9g1QWBS+7H4UYHpM7S3/zDoYg4h+8qP0ql
	dsPwBd8YJ8Mb3bLKk6X7GApUPCpuO84TGTGkx6v2PpenfVe3Zs0B7nrnWBeCCp26tQrzqhvR+As
	BqO2vAs1IEbw/UuahdC+j0//qUgBDim4PwpcAqqZQL7K1v9v8g/uSNRUJ2L/YttqZ2Kk=
X-Gm-Gg: AfdE7cnQq4yZR3dxjHyGZriwDGHirSioYahYgLCYTMh6fOadX9raoXspb+BJJtzrIn6
	AlStXijHZ6+ntd5XN7VS/pmLZpqp1CW1B3fnG8JnO3NxU+c2GulS2x3m2corBKCu0g/6A9+X9H1
	V2KDnCzz4B4aJhTNhhWBD5um7zIkOG6X12uzuuW73AscXbUzeqNd12LdYTg5rIHeUwSYSioegND
	1Q/v7FJPxYSoB5hHZFRgf1FiJcK9+LaG38Cudcqhi2eZS5E5VOGEvcF7/e21hxMOBKMfulx+/6r
	Hnb++z6iDaQTLeu5yl36q6x3lwG2nrEV2uA4KfzGjfHDGYzDhc8H9SfmNToxOpiYi3H4oOLRA4M
	Oke+1jb6YyD6b0p1kucW9OeUDXLhiUirtyQw=
X-Received: by 2002:a05:622a:38f:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c4beeb5e0mr117304311cf.11.1783411101074;
        Tue, 07 Jul 2026 00:58:21 -0700 (PDT)
X-Received: by 2002:a05:622a:38f:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c4beeb5e0mr117302721cf.11.1783411095878;
        Tue, 07 Jul 2026 00:58:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bc655sm74024066b.41.2026.07.07.00.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 00:58:15 -0700 (PDT)
Message-ID: <45bf13a4-6538-43b0-9563-38178c4d0282@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: msm: Disable DMA for kernel console UART
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Sam Day <me@samcday.com>
References: <20260706-serial-msm-console-dma-collision-v1-1-3179b8cb1d89@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-serial-msm-console-dma-collision-v1-1-3179b8cb1d89@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zTA3fh2lRFQJRGMlPbS0WSQm97Duft7d
X-Proofpoint-ORIG-GUID: zTA3fh2lRFQJRGMlPbS0WSQm97Duft7d
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cb19d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=K9FbrMKJn3BnTdmCLQ0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NiBTYWx0ZWRfXzJnz55CsR9iB
 NOz3CMfJdQyz/0ABxDamFdrKwFpoCAvvjolAGDKODFo/FEynhDVppHqBTbW+NEx0rYNnjiH1R5x
 TiREydutciKpb/a07Rd3sJhFWmbnRvEBOiYJKwuLiXvP9Q1ohI0CudV9+oBUeJmmN/K571CGDdG
 v4vDxPOfjf/SYHU+0C4lu8HELcm2MMFBhpstfBMf8vx/m4sOrMUFBdtMa0tIzUhgaJZw1kLZMxZ
 /dlasSFixWOeDwZUFvs+QTzfS4MMqR6tojDq7bhdZvxYsPDNa5o3CWoP6DG9HTxRdLicOdTeJ7S
 ORqL8s0RCZU666GVvFOzu+ZNCbIczDqLcfFXg6exwdkiwBH+Rab3RTMkhvJnpqcV4xFx6dzakGa
 D+GWzY3YwNWnQrLhKT3GP4r4W2x9wZThTRLv2lQlcc4HnPR6u/SBOJwuKn2KMEuO5lHDJa2U5z+
 5ruhysAr59/CMwTg0XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NiBTYWx0ZWRfX2I4015qaaCgJ
 x97Q5R8JcNjN97mgBAKwO61XoJeQGqkt6C03lt49qqEUK3xExT95SdAV+/lzg6abQRlqrnSJ3a2
 XoIC5qwzhC9duRUEKosCREUFpG+c+d8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070076

On 7/6/26 8:03 PM, Stephan Gerhold wrote:
> At the moment, concurrent writes from userspace and the kernel to the
> console can trigger a race condition that results in an infinite loop of
> the same messages printed over and over again. This is most likely to
> happen during system startup or shutdown when the init system starts/stops
> a large number of system services that interact with various kernel code.
> 
> When userspace writes to the TTY device, the driver initiates an
> asynchronous DMA transfer and releases the port lock. At the same moment,
> the kernel printk path might grab the port lock and re-configure the UART
> controller for PIO, without waiting for the DMA operation to complete. It
> seems like this collision results in zero progress being reported for the
> DMA engine, so the same text is printed to the console over and over again.
> 
> For the kernel console, we want a reliable output path that will be
> functional even during crashes etc. So rather than implementing complex
> code to synchronize the kernel console write routines with the userspace
> DMA write routines, simply disable DMA for the console UART instance.
> 
> Similar checks exist in many other serial drivers, e.g. 8250_port.c,
> imx.c, sh-sci.c etc.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
