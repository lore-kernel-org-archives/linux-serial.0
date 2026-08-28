Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E7471418
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928061; cv=none; b=h1/FkhnhJousToMfO6mK+4miWld1v7b2TJFokA8JtgGYXUxwvOJPmvUb54+ytoTrAe7nJjeYRukaocXBErQXrygPp5F0nkqxEEIstFAaHPufZUjQmOQl9wW1MMXaAqbqhOo31q8+BaPBvuqOb0wa6hntm3Am4dl6Yt7Y02kjrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928061; c=relaxed/simple;
	bh=Gp5cNpvqC7YnJtgTQ7as6KDz2NHZgVd+cRvOfbagt4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYc+xsAgd5t9sOsgIzxgu0ju4ZVpDp+EVOOIQ8VLwS2wluMMHcmmYFSft+F7ZBjXlHtaCOujf2nl79G9KUYoTUPZvPwT8sD9nBACMZdNvz+2mYYi402dbsSywg72TTc3HdWDMKE2uKsHfRN4qWkLt+BfadW2m/pBs9GCwLOkcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOwr2w0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqWzxXYR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOwr2w0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqWzxXYR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDkisb038259
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bOnsUsh8Wpvj84UUQA6eFNHOjYX12MlSNu7SoY1Zd+U=; b=nOwr2w0CXUmoTKuT
	hUt/J/AQUWqI7HpQzuuQIwfNcc00QVT88jHKRYBWipO/oYGa5hsQ5ZMwnD+CtEDt
	BNvfr+6hozp0aXCMwQw4HIFkYmw7smmiRf7ksjeBPKbg8mFSv7mNTnSlQhjh7Z6J
	U7g8E2sZdECdUNch279hX0bbGW4E4XMzoQfqVeOMIdiaXYYWPuvfVMtWVDqjcBEB
	2ee0AD6EIEON/ds6iXB4N7+51/rrmeKoby6lGQQwbJYuYIeX5mZkNM8uOE4QS+cF
	BSmoVcYba+d9ecfbEgShY1o6YRbRoii1If6TSixgkB4QUdjtEJhJjpmrVu9BK7o0
	bNWeKQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afgyt8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:40:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc640dfde3so13126255ad.1
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787928059; x=1788532859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOnsUsh8Wpvj84UUQA6eFNHOjYX12MlSNu7SoY1Zd+U=;
        b=UqWzxXYRN1xO3Po2LFdzqnu6h+IhwyW5oTn5b4bxe8VAfhJjb4TGEPmBULfW46NhuP
         Pw5q4qx3UsKazHF4pSwBVR0j/77el7DrK4MyunlEtUL/2e10PqRY2rbmQ0lPNjGgtKSD
         COWubfboMxIhc3TWKbaCApHBReaQFKMalB84SzygdHkMy2DwlMfZjMoT6BgLQX+qnJ/5
         yGfZUiqSD1U7UdKLSoGjMoNtnfegd3+/Mk9OogukzJ/W8rZWFamSnyh/pdUDm1d5RiLL
         y+pM+yxt30VYwOooB4670SJuo/g9rzRWrE8Nm5mPc9QR4jqrjFHTImiIRZ6ZGcDZilcF
         ZwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787928059; x=1788532859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOnsUsh8Wpvj84UUQA6eFNHOjYX12MlSNu7SoY1Zd+U=;
        b=VGRiVlItQiHLh0VoRq++Nrq2OC2mP2aFlYhQf0RS5kVRoZ5AWAslPiae+LtmlDcbPI
         GMfAHUtrNNm9AZ1GdAV3J+b3mHmm55xmSHZHYP9rd5cEQZZ+QFqZPe6p8iIl29XiMJTJ
         dqsGBkyZ6DUhdxkA4Ru/iNy+kx6IqkXHKuWm1CdtQGx7XxECbnh9iR7Lr60VudbOVj22
         XqzxzM1vCeJDTvIKNxpK0/nLXcU9I22vvQTNC4QAeQz2uLF1MaEoUkqZJN8dizJzOVBE
         YYn25kzr4sdsVdKPoive9FW3s6lnvj+ufwyO0AB7nanEeJc9chfw8fY7BACN9R+IhwCD
         vmWw==
X-Forwarded-Encrypted: i=1; AHgh+Rr08TTss4OxigRO/HMqo75Y7/4DDd1d2P5oRjYlsWmywO3zop3Ruw2lbrAJkj7IwpurcgcD8TJb/vOvqiw=@vger.kernel.org
X-Gm-Message-State: AFuF++n/DGQUtGYIeTN+kWKZgeToyG5s1rkH5SO+GVOxOqhbnYIwvoqN
	HNddZYdJjDvJ5TlkMpGnuNQn0f4wrXqjjiJ2A8hJHfgtqpYHPErbAc6DJOPFBVBOzpMqIfsrLpv
	eWQ69Kgk4zSJX1O33tOJg1EjOEStT/JoSsNmZ16Aef2QOKafUAF5xRiUpDNJuKT1fXj0=
X-Gm-Gg: AR+sD1078rhxDJfRLisfyGmwTObSkGdSD79qj9kgVdwYAyl4ZmUvbau59BLP0MlXAbA
	zKVebuM5JJbTipGSRUsoGG6j5iI1Vf02RF3VbFGJUrAKHQD2GIekwIg4BtBGxnrIXYvc2wBtGFg
	+e/yB74Zii5DCC1dyYnmWyy23c6k1lQ17kwmdg3Tk7a97t1oriERUzN7d0po/68n/6fEL20ybCK
	znO4luJGQU3mhljn8JmXGkLEqSVqjLHWSTsI8Wa7bGu96M5iwKJqzgNwhMsaBl7yFvNjmVuz3hm
	mLZT8B5X6Fc0BcFm7YdvnIrKIQ45RlKX3ZgVuyPAR2Jnt5f++bAs/fCa2tOFm2xKFcV9bDvs+JD
	zd/0nXtSguk8re0kvU5E/Ng3L+QkxAteq
X-Received: by 2002:a17:903:1ad0:b0:2d6:f9e2:af7f with SMTP id d9443c01a7336-2d74dca2148mr159874755ad.1.1787928058414;
        Fri, 28 Aug 2026 07:40:58 -0700 (PDT)
X-Received: by 2002:a17:903:1ad0:b0:2d6:f9e2:af7f with SMTP id d9443c01a7336-2d74dca2148mr159873985ad.1.1787928057780;
        Fri, 28 Aug 2026 07:40:57 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.106.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75986d2ebsm5934585ad.45.2026.08.28.07.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 07:40:57 -0700 (PDT)
Message-ID: <4368e295-c734-41a2-8725-433525b3db90@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 20:10:52 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: Fix unbalanced runtime PM resume for
 no_console_suspend
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uNQ1ZPFDjwvXTQDyimysgfB1EAHbMdu9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyNyBTYWx0ZWRfXz1r3XKyISwWj
 FQBXWkoZ1a4jl+bwlq2ZqJ1WUd7u83aPC63w0YInoorTDb45K1kYu+bCFT/tGNvdgdMWlxiK0zE
 7gXj55RIRnXmJ6AlcfaZk8vSbBty2aQ=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a919dfb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JqI1KGPJ/fv+aVyoZTfG2w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=D0tFkimwtIXZEwdZqEwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyNyBTYWx0ZWRfX8wYPNJtla+Y/
 XL066EF8FYDB6juikyz8yDqpRcfwCQLtPVU0dwJ4DD8I8ZgqoER6tZl7Vj4k/58pBY8F9skNiw0
 eBXJrpWyWjMNoZOUCPuiU49R+s3AH8vBhdBNQpR4NZxGmUMB1Or+hXx48FwO7K3Q/PWS9NVlSLQ
 H65SYuHMyM63g5Hwp/mmaw8FlCYEt7u+fRpvhbGLgX8ZQSlB7Dh3nMlPGhurfxCt+meX142hY04
 oUYdfrHQSBnop3rpEopnUrWLcWf+Qog7IoElSMlCl3fPj8ZCbxPWLragpeFHIshafw1Gk5K2wmr
 nUsUawjdfT9M9s38C14eDtI12+86Y9C0qTZtXA2K8CePPhJeXxINpFxhs6E5nagnxWYp5qp0u3C
 6kPzW0QR0RQLcex0lSgqVpKj2lgz/HwVZ9Umuwa1vpL6HOif/dU3pCE1owQqTLLWVJs4/aTTCca
 IT2HQbJmKJ06Iz/GWTg==
X-Proofpoint-ORIG-GUID: uNQ1ZPFDjwvXTQDyimysgfB1EAHbMdu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280127

Hi

On 28-08-2026 20:02, Abel Vesa wrote:
> When no_console_suspend is set for the serial console, the system
> suspend callback skips pm_runtime_force_suspend() to keep the console
> active. The resume callback still unconditionally calls
> pm_runtime_force_resume(), which triggers an "Unbalanced
> pm_runtime_enable!" warning.
>
> Only force resume when the suspend callback force suspended the device.
>
> Fixes: d0cd9c8d0fd5 ("serial: qcom-geni: add force suspend/resume to system sleep callbacks")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3633723acef8..a180a00c9e23 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -2099,9 +2099,11 @@ static int qcom_geni_serial_resume(struct device *dev)
>   	struct uart_port *uport = &port->uport;
>   	struct qcom_geni_private_data *private_data = uport->private_data;
>   
> -	ret = pm_runtime_force_resume(dev);
> -	if (ret)
> -		return ret;
> +	if (console_suspend_enabled || !uart_console(uport)) {
> +		ret = pm_runtime_force_resume(dev);
> +		if (ret)
> +			return ret;
> +	}

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Thanks,

Praveen Talari

>   
>   	ret = uart_resume_port(private_data->drv, uport);
>   	if (uart_console(uport)) {
>
> ---
> base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
> change-id: 20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-814e630326b9
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>
