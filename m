Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4103491EB
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802422; cv=none; b=eEwa2BU0TZePIuCeus+P+1U0wY+QPyr/AWKpfwiNeCT78jT+F5m3qEBrb4NcLg09C3RjAP6Aw0b2LtFc/sIv6YAcC1n8riOo9lOvBEJd6L4phkUQHC+0OAX8D3rR33d6Cwgt+ULhZealCi2nmN5cm//Uwtx+Yfd0IGHpC86/aWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802422; c=relaxed/simple;
	bh=Xw8ELvSCrRosD9sofuOOGWikeQaTd9RciqW+TMiyFxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfIg7wu7VtIVoCRMpuGgaofDTVMCJ/tpIeod7J4BxJqFk93PvtyZAYgx6nRitJUFPaOnBFZRF05HpKxQcJZsuWAyL/GxoYiC50bZSd6OJIfzp5s0r+qghSV417aY4UF40+aB2VmDLKONWE+EAfu+87Ml1PMFQmAkxX6ZBYjroKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XP3RdLZc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxGMcKyR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XP3RdLZc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxGMcKyR"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079q33V218339
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 16:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OpUTT4AKvk1DAYuJpTpagouL
	5okdKqW3MjX1dmuWCiY=; b=XP3RdLZcwQgoWLS8OR2JKvcFC62ISnPii/qodqGH
	XFlf8rPto8VqeqTZvpy/9LpoUNXaIWMMnruqOKjAJo042lYK90GIf2aLFV/YtSJ6
	YYkcjWGcizpXPCT1k7LcaSgDq7CoRPR4rmmGWEW9SIc/WxDdoMjcYAeho/Xf76Y3
	lySyaVQvH9m2Kjw6HO4Wdg/lNAScXvRdDFCv1V3cNSEbjDsDHpR3m6NX3onsJxbQ
	NL/7j/SC/UfYJQUHmvycWxqYXtcPIhF3ccWMrz8wweXXhozrzwMX5FqpT9fBz9ml
	5CojbzdmhkZyEe7+A8uA4/U+1VXiB2+Elcu3v123Jh/6nw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn8095yk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 16:13:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f35f31000cso34639211cf.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767802410; x=1768407210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpUTT4AKvk1DAYuJpTpagouL5okdKqW3MjX1dmuWCiY=;
        b=WxGMcKyRxM3pRnmG4E62c7emPMWmqZsDOeruCUaBGUeEiy8naurq616JcMwrMcoyPz
         CzdgmzIwdaEpJj2lM0YIc4MDAKn+t9rgX92X2c2GDgi/WlGc6kOJbxkvQm2IJjA6JLfb
         BHPaM0BZ0qDynqMs9d/2S0DRTG5OOQRKXTtSbZ/zcKj2ARTOvJLhI3wj/pqFrk7OIiCU
         NC0i4aZtoXzKbqTY/54HFTP+02Olr/8Jx25RCx3yHeY17bUC+ygtLMLVWfRwJ2qQk6lP
         Pkuj94rsAXuLWf6Najv/cRWG8b9unOewH/Imx+2ZPFch4DJmmjndwhiwvdlMpSJ4OiUn
         eIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802410; x=1768407210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpUTT4AKvk1DAYuJpTpagouL5okdKqW3MjX1dmuWCiY=;
        b=FpI7ZGjpXXbvh+il0860VYvikaoob6FgL3UXEA55Jrqz9ZYab8+6+PrYd2dM0DRmqe
         MD5CpTvO7/O+JWVxQreo379VeYzgQyT8+eYddXZo2qDDlwwhN/VS84i476fF21Z00HNX
         l/aiVvWqkh70fpTI1fWv5jjugvBPkfjfkCf/MWarMiUGLCnXFMuDdjXU/PUx2vb8Qu2i
         WJEzARuK+Mt4HX+8IyN3t3n2NApDBrRLuXbo9AHJtJyTqoWZA3Q3FJOiGBCdRQHZpRda
         lWcZknybasO0JhlAwQAGMbkpRtItguptvFPmn4i9q3mGYOa2qAxUwTdcjMclGIOaY7vn
         ZpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0e8UsMdbJAdlWyiL/XiVtv3gT++U28PCc7JZyJ4gn0XJN+N4Y642kJMyJRqJYZh2o1jMy7Xb0p8O9mpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dPyUoAV//TkO0YrRBpF+b9GWCccIRrjsIk0dMGDOT8lo027F
	PcyTBrU0XXC0aHg7I315qrbEkwPPJ2OUYlkmGZUCzkY96xPnldoJgkIrfH0DOqv8ulXxORIAepf
	priJolMwzqPfCOn4j3auNG9qCLA4GMUEldLxhpK4uHmCjK2nIEu5TeCD7QWQzBJFzVpQ=
X-Gm-Gg: AY/fxX5zPIEV1EiL4ya4ZZxgg6LlS/JTA+rDTdZX+AyOYUiCceW9REVJ1ndT3xfGlSN
	R7tMb7RrG5ZzkP1ASduKe7h7v5giI5+zhrYCjvBOw0rFS+NfyJst+E/cZN6G+aQWduPlIJA9pb1
	riw9jZmnYRsHCSZ302JCD3EkRC1dsM9aMczEKyz/KNXedQo9jo9O6ohD5u9zHPPFuB52zDJNcRl
	yT7u+qJIjWa9cUj20kkHfNYjliJfmof8pxi6FQt9vmGP45847fmEZD62LaPyhWogw/BZDIvWbZ5
	95cZvbRbpnreDGbv/J/dmdBPqmipP8on0vjAmJbNkkq7Cyco9KJrkqRSs2SM2CWizqZUGTYlC9v
	RB68rMNXR16i5TnZiHtoyvOuJTHK4fD7Lm1eJDYNXYxy7A26dINBl7g4he93SvjAGnja6w7Egnu
	YEccDg/ttwisxb7LDbiLbAdg0=
X-Received: by 2002:a05:622a:488c:b0:4ed:e064:1638 with SMTP id d75a77b69052e-4ffb4a44fb9mr38411591cf.40.1767802409929;
        Wed, 07 Jan 2026 08:13:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHct3+CQG/jeWcyHoC2prjawsf5LsarToPv0u0g/W97n4bZyv7P1C4jn8aQYYuNGH4PaNFEQg==
X-Received: by 2002:a05:622a:488c:b0:4ed:e064:1638 with SMTP id d75a77b69052e-4ffb4a44fb9mr38411001cf.40.1767802409295;
        Wed, 07 Jan 2026 08:13:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d76013sm1424707e87.94.2026.01.07.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:13:28 -0800 (PST)
Date: Wed, 7 Jan 2026 18:13:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Subject: Re: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2
 platform
Message-ID: <vapb2r5xbrchobhtvwr43wdqbtd2pzxkfhiyzltipvpdkmaqyj@zkabog4sf4g3>
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
 <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
 <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
 <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
 <36d8fb98-562a-43dc-8b47-b4f6d29475f1@oss.qualcomm.com>
 <c0fd52a2-56a8-47cc-ad40-8c14c269445b@oss.qualcomm.com>
 <741df2ea-03fd-4af2-9a98-20d68658edcb@oss.qualcomm.com>
 <xrghvkbjc6cd6uk7qyvxylgr3veqsfbrjr7palmqqzhfvknb57@h4wvly7zzwa2>
 <db421081-7e23-4088-91fc-8d6aa83931aa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db421081-7e23-4088-91fc-8d6aa83931aa@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OtJCCi/t c=1 sm=1 tr=0 ts=695e862b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=K7YG3ynjBNmOUY7XFKwA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: kmBumlT6E2YcRsbP0a3KcurZI5o9ZeZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyNyBTYWx0ZWRfX14cCFsFEnsj4
 u28t9/LPf6cdusivMZPTi1FJndPkzUXlFSnV0jYsWXN+CAShzNJDd6DqXLlUr81HYzhoS7lBk85
 lt5aMiJIcqN7CeS1cm1DiknjKMWRGNidINvVyvXcpipq22S/j6ykIs3o3ZGAlurb2KugMYLYkU6
 Q06ayqF19mgbNu03+i2Gxm5YW5+/UvZW5HI+MzdXTResyJmP1nbI7uNCFZx1bx+Z86D9PX2mIBw
 I9x3K9a0SSOm+EQeWP6bU17BpcUS5EQY+WPApr2qugle/UGWPFZqlB+WtSGqPkvP8IOvyC9zqas
 8Ci/hNIRfiGMKW4G7QC/owCc/0keJZTSMlIMCpRn/Dd0yfP6WaKHbI14goShNSqtkmq09ux1R2i
 khCiwYX/SyImrCQpY93pySBtACyMQ6+2Aar3I1n+G18YuZGULNpy04WeGMNDt1fbV3oEgq72AoZ
 vrLzkpUXJRTFX2CGrhQ==
X-Proofpoint-ORIG-GUID: kmBumlT6E2YcRsbP0a3KcurZI5o9ZeZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070127

On Wed, Jan 07, 2026 at 07:38:10PM +0530, Praveen Talari wrote:
> Hi Dmistry,
> 
> On 1/7/2026 5:05 PM, Dmitry Baryshkov wrote:
> > On Wed, Jan 07, 2026 at 04:28:22PM +0530, Praveen Talari wrote:
> > > Hi Konrad,
> > > 
> > > On 1/7/2026 4:16 PM, Konrad Dybcio wrote:
> > > > On 1/7/26 10:24 AM, Praveen Talari wrote:
> > > > > Hi
> > > > > 
> > > > > On 1/7/2026 12:52 PM, Dmitry Baryshkov wrote:
> > > > > > On Wed, 7 Jan 2026 at 09:06, Praveen Talari
> > > > > > <praveen.talari@oss.qualcomm.com> wrote:
> > > > > > > 
> > > > > > > Hi Dmistry,
> > > > > > > 
> > > > > > > On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Wed, 7 Jan 2026 at 08:48, Praveen Talari
> > > > > > > > <praveen.talari@oss.qualcomm.com> wrote:
> > > > > > > > > 
> > > > > > > > > A regression in linux-next causes Bluetooth functionality to fail during
> > > > > > > > 
> > > > > > > > linux-next is an ephemeral thing. Please reference the exact commit.
> > > > > > > > 
> > > > > > > > > bootup on the RB2 platform, preventing proper BT initialization. However,
> > > > > > > > > BT works correctly after bootup completes.
> > > > > > > > > 
> > > > > > > > > The issue occurs when runtime PM is enabled and uart_add_one_port() is
> > > > > > > > > called before wakeup IRQ setup. The uart_add_one_port() call activates the
> > > > > > > > > device through runtime PM, which configures GPIOs to their default state.
> > > > > > > > > When wakeup IRQ registration happens afterward, it conflicts with these
> > > > > > > > > GPIO settings, causing state corruption that breaks Bluetooth
> > > > > > > > > functionality.
> > > > > > > > 
> > > > > > > > How does it "conflict with GPIO settings", what is "state corruption"?
> > > > > > > 
> > > > > > > I mean the issue occurs because the GPIO state is being altered during
> > > > > > > the wakeup source registration process..
> > > > > > 
> > > > > > Altered how?
> > > > > 
> > > > > During the runtime resume of devices, GPIOs are configured to QUP mode. However, when registering the wakeup IRQ using dev_pm_set_dedicated_wake_irq(), these GPIOs are reset back to FUNC mode, which impacts the RX GPIO and leads to Bluetooth failures
> > > > 
> > > > "QUP mode" and "FUNC mode" are tough to swallow even for an insider.. How
> > > > about:
> > > > 
> > > > "qup_x" and "gpio" pinmux functions
> > > 
> > > Yes, you are right. I am talking about "qup_x" and "gpio" pinmux functions
> > 
> > => commit message, please.
> 
> I hope the commit text below should be appropriate
> 
> serial: qcom-geni: Fix BT failure regression on RB2 platform
> 
> A regression in 6.19-rc1 causes Bluetooth functionality to fail during

Commit abcdefaa ("Foo Bar baz") caused BT init to fail....

Otherwise LGTM.

> bootup on the RB2 platform, preventing proper BT initialization. However, BT
> works correctly after bootup completes.
> 
> The issue occurs when runtime PM is enabled and uart_add_one_port() is
> called before wakeup IRQ setup. The uart_add_one_port() call activates
> the device through runtime PM, which configures GPIOs to the "qup_x"
> pinmux function during runtime resume. When wakeup IRQ registration
> happens afterward using dev_pm_set_dedicated_wake_irq(), these GPIOs
> are reset back to the "gpio" pinmux function, which impacts the RX GPIO
> and leads to Bluetooth failures.
> 
> Fix this by ensuring wakeup IRQ setup is completed before calling
> uart_add_one_port() to prevent the pinmux function conflict.
> 
> Thanks,
> Praveen
> 
> > 
> > > 
> > > Thanks,
> > > Praveen Talari
> > > > 
> > > > ?
> > > > 
> > > > Konrad
> > > 
> > 
> 

-- 
With best wishes
Dmitry
