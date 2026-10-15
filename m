Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B14E8DEB
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056965; cv=none; b=MrPuvPSqvmgP91Y4MB/g55tH+GQk+jnjndGPOW6yaWJ2HqjcEz04LooFx4LHNzjOxDOjVP1eUc3wkXQ8sPH5p2V+/u8f55yBpzG8qF8QbN1QZnfEccvwgkuPbsrYtZdNrWnzDoVa7b9WPM6QWH0zVgsbv/y+ezzMvv81nZeE94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056965; c=relaxed/simple;
	bh=TK5BnQdSuuQirHxFtHidOKQXdjYka8Ot2F1POC8pMfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+gkxNmCFyrK40a8bPv9iu6DnkvlXZzzuf/iq/FKYhU5iPihrNAx2GENO0JZxxqGk1d/9JSI7bSLo7tHZ52NvWjw14rUXKoVaD6OOXXpm9G9fWRdrUZUuy4gbLrkWSTKM5JLfSOoDQZhkYCqjysy4Aydt2LprMd0g3z421P6ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKly8Guj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQZWbnFW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKly8Guj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQZWbnFW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9NtbN2738642
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 09:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ikdy1S0BrrUvYwTxuXOoiMGXXmPJoceKB/d1OMsbJz4=; b=CKly8GujUFdq+Ozb
	DGd6bdE71DJK6sovv1622SDhHMBWd3Rg57E4094mhT52dHM8W0MCUryGiw4cHHSg
	55FZUedFiOYXRVC0+hAFplGBB+QV6Fb9oUH/c7vEvWeficPf51yN/qKDjB1yx2zq
	GJrzhre7SGXWmmc1d6PgY+MahiXNwrng5Bor+9gouOZCvnntP7u/osmD/uasRPFt
	Zc8NlxGoDVJcUpNHAL58KyrdJrlZj/RodiadzWnbUZxi2u5OJXOef3DzG3kqF+Ea
	Mz9B6P3+DhcxvatIz4FwgW+iNyBNiG0D+zArBBFHApArzMnMadqpAecoRu/yEyC1
	Fzaoyw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds9b0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 09:36:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5360b8cf8f5so2689431cf.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792056962; x=1792661762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikdy1S0BrrUvYwTxuXOoiMGXXmPJoceKB/d1OMsbJz4=;
        b=SQZWbnFWEuNcYrjUWIEP2CYNsu/P6Q3b2YuRXWGHQDWKqXfwP1La+3cAQj89YKWOwV
         rmV3bEwFipp4/Y9+Rrs9+eDo2ttkScl1wPINvSF87lMjFXZBHFdzDLDHOxYyDUN9NKhB
         oo45ExQpN1jlwYao+wGfE56DsxMfZIA28PdxrGQZKZZPm8oxRVk2cVMmw/Lo5mIK/Ixy
         EYWj+xRKTJoNylpoXwnOMiJ9Bj38ML0R80cV701lT2RyS2ijweciXMpje+MWy+HqaJsh
         ghjJp/KrX+YHzL80OK5V92pbUSjO8s6dz10XinIOqbSQMS/2mar0lJ0ercbg1QKn1NNC
         Nl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792056962; x=1792661762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikdy1S0BrrUvYwTxuXOoiMGXXmPJoceKB/d1OMsbJz4=;
        b=hbI1g+s67zkgO1ArjZORnx3nnrTILF/SCxAF6koCG3lBwQoG8Ma/goE81pJf1UxHz9
         aK4I8EmIs++xQ9kyuJH6M1NgOhBVi44KqBCjN6EOqbEOuEfAboqBGJh507OW2lkieKsE
         HdH+L0acuhmoxJabYv/Ac1ChZK16TrdtomlL4ozqESQ/pKaUM5lwDRH+pQnF/BqOKA3X
         TfWM/OnR23XdyySLld5B3lsXnwVS9XdBZXJ2CIuEBgccbzXY/9QvzsVYWv3yVbtek6cD
         cCK3tkMijYwauoQkti9oSOi79mBM3PUvIZJlVTrUPvgmVVsYRJYMo3MGUvN6XqyJ3Tln
         5lng==
X-Forwarded-Encrypted: i=1; AKwUvBwpzNR/Pb8qnZwA3+fNQe5AAQ9qTs++yelKNZbIrmMUn373O1wyajbg0ULG3l8I3WsS7gph11iBRsXEaxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiT5CY4TnqOpA0F0FQ79ZonjsfGX76qV6g0o6OMaTOcBGY92h2
	sodSzLimN/JUdiAKOZyxhW0KXIXFSxGCB3OA4T7T8JO3SYgsMQmeMFgEcdqCtof1+i7Hupl6/2m
	6ZRpDOt/qztVLhA91t4M7jfoV3dykT56qd01BBf9XPpKZ+Sp7s08oU2NuF9mxfWU+aCA=
X-Gm-Gg: AYBFou0Q5rPX5C4TwZexGpQY+Hm9NYqO6V6/DPBaDf+VdFUzzlgWS+TbWY0eyw0sO2I
	Wa2tV/6X5mprinl43TaiwW0/EJIxzLXf43lppEVio2EgpALPZ2/VlEAShBQ7ivGS2q0Wlju+3+N
	DE0r+QJy84v0U4jrlhn77fotvFNRmADf2YJbN9ASZWIV8hoUGYAWQnfBrwdKEUBNhAWpeoDPUeO
	TDh6khe7PJy92CXBz4hYPXG6NvqeH2v7Y1lC+WYNP9u241P5RqgAnmDUWYhfd6CO9xAUCcBzanw
	oWDHn/2Lq/LE0uKhOtguLBuKHqe91sFCt7e3zi+MVWRGdhnUPjlKhbgWInWqFfuhu0epAfbowXo
	c/hgOFQcVTZTSVC+OivwBjA==
X-Received: by 2002:a05:620a:4613:b0:939:c7d1:7471 with SMTP id af79cd13be357-93ebd228f1cmr3387766085a.4.1792056961788;
        Thu, 15 Oct 2026 02:36:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:939:c7d1:7471 with SMTP id af79cd13be357-93ebd228f1cmr3387764185a.4.1792056961341;
        Thu, 15 Oct 2026 02:36:01 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203863511sm2317941a12.20.2026.10.15.02.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:36:00 -0700 (PDT)
Message-ID: <76801e13-ea0e-494f-afbf-8ea02842180e@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: power the console back up on system
 resume
To: Praveen Talari <praveen.talari@oss.qualcomm.com>, david@ixit.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260918-qcom-geni-pm-v1-1-cb587e215607@ixit.cz>
 <54d820a2-5fe8-49e0-bcfd-e2a7bf4df7c1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <54d820a2-5fe8-49e0-bcfd-e2a7bf4df7c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ljajNVqJrapY-BdUhc6prJ_aTUMpcbKM
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad09e82 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=zRDqW-Egxz1XbUpwT2YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX7USt8fJsk9+2
 fkOTsosxcmBzaYpI+W0Rsu3w9ibx4THcvdGmJMfWQopAhf7VK0KA2PtksWyEVCRV4OpQdmZsHUK
 8ihIOrqTOWhX+aCsp9C0JuisdfLoA/iUtMXRKhmzlBm3/MLM+IAP9DgrohkWz5Y5EY/+c96Y6DH
 vdgm1s3I6MJPZaqC3rw8izESs1YPo+S7C4N95lOhpyt+CjdiVtj78TIb2zEEV9ntgFZHkVcWRTh
 vyNw175TrqDtLg/4sn1r6fPz+H4V04euaZ/IZ5wzbg3YCciL5XzhwuPZyHbj2PlZm4BTG65C1rD
 7n7ZPBVs63sN6Fz7iL+ZlbwEwKa6XA9S8dBugyQsY0ZI1QdbMfYX6gD2vEXIO5HeI3wIagsV8OO
 nY+8ZuEkXk4EJC4yBT1G8vk9Hqd/T/MtI3uK/KVzOmn4fh5/jbww1d/QZIGOhWqAnfH3MNOtg9M
 P0H8JSlaT0doAVwuhJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX9qtZ7Ahr9TJK
 pP6qUHddXjW/bqB9kWqjdinR1vCSmOYwH3OU3/t7PyzsiIhGqsL/MpPpOCi7f7zhWTxi2bNn2/G
 MOtsusOvBasI3DxvBYrHTk2Ymofds4g=
X-Proofpoint-GUID: ljajNVqJrapY-BdUhc6prJ_aTUMpcbKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150038

On 9/18/26 3:28 PM, Praveen Talari wrote:
> Hi David,
> 
> On 18-09-2026 03:44, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>

[...]

> Specifically, is pm_runtime_force_resume() leaving the device in a
> runtime-suspended state despite restoring it from system suspend, or
> is there some interaction with the console's runtime PM reference count
> that prevents the port from being resumed before uart_resume_port() accesses
> the registers?
> 
> A bit more detail on why pm_runtime_force_resume() alone is insufficient
> 
> would help understand the root cause.

GPT came up with the following explanation:

1. qcom_geni_console_setup() takes a runtime-PM reference with
   pm_runtime_resume_and_get(). If the console is registered but no TTY
   is open, that leaves the port with a usage count of 1.

2. With console_suspend_enabled, qcom_geni_serial_suspend() calls
   pm_runtime_force_suspend() after serial-core suspends the port.

3. pm_runtime_force_suspend() considers a device with usage count <= 1
   and no children eligible to remain suspended after system resume. It
   sets the runtime status to suspended without setting
   needs_force_resume.

4. Accordingly, pm_runtime_force_resume() skips the runtime-resume
   callback. It re-enables runtime PM, but does not power the GENI port
   back up.

5. uart_resume_port() restores console termios before its conditional
   TTY startup. If the TTY was never opened, that startup—and its
   runtime-PM get—doesn't happen. The console remains powered down. If a
   TTY was open, startup eventually wakes it, but only after the earlier
   register accesses.

Konrad
