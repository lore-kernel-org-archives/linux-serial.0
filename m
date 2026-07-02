Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A0477999
	for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983864; cv=none; b=AZ7U+RKDHxHAfmSsmo5jCp9r4VKMPplwy+d69ekqQkgtdD7TSSdro8ygy/09Aod7FMNgtk5UstTXbDE5lpkQMXU70BX6ZvT2K4pYyVrLSF9YOjWcmkYVqGHPOugpUuQcHY2LnhTHhDXRsHLBS8zb/sfno2MZgGnm37qS83qdO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983864; c=relaxed/simple;
	bh=oVUVN33KyAA+G7ySmu0T5BL6MDa6QNPyaXVhOB1tb9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfVwSeemCEx/ltIaVm9t31lVWi3KRWFZtZlyhBYQ9s8+xsCfRELiJGkHL/mBMItdzHoXQYRGKppWLunmquJc3Oyi9Lx8laan40QwyFBUBuW8bnTrrLi1K0/5Y2CEQEhi7RUiSo7Yta/5vaWD0ttVszrBrelzNaRFqF2O6ExTY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P6mErtn9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNKTyjhH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P6mErtn9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNKTyjhH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66242sjX3460370
	for <linux-serial@vger.kernel.org>; Thu, 2 Jul 2026 09:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGwAednzqeRxCB22QWUBlMswoWJYl0ScI1kF4jRrqA0=; b=P6mErtn9yGlDXT0w
	FViNbJJbGHV8lHYlsMLHX18MF8KBThtrzNY8FWomtV/dSMN6EfyAodarTlQGlwCh
	xXPskHUq1FYORoAHUMlwKtFi+h896VcN4rFptqsj6iG7s+3m4cMIus47x9+nGEMX
	OY2YELNxhPxq4GB3Hte3Lq+/iT1Jc70cw37nuVA3dzPsHhjjMslo6qIml8UxCKud
	1o8aKL22WaTiVnnmXuu7tr1sjno+Ih/8sLXq71dlBQY8FvDcjl/PVZ6OWhuchT/D
	+SjfBCodvvwT5wS42b000jpO1xj1H/O9zc6Y21gUen3L20sbUD3DSVCKZZr7xezX
	ssgrkQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb13k2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 09:17:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so1776467b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782983857; x=1783588657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGwAednzqeRxCB22QWUBlMswoWJYl0ScI1kF4jRrqA0=;
        b=UNKTyjhHY8GEa2YcOfRqIuxigrO2c54+MiuGqYL2KVEd3O8yzipIlFpmzsKnGgO+6o
         RCE9PY0CaY3UrIpUDXUJCTbaTvs1xu8zjsmUV3M8sXQwwZXhmoIWvyl3Mz+tpG7PDwMv
         8OradjHLbxPidOUYLhga+XrKfftUeUAQiEiY5WZoEXAgnwlVMpq7gDIiWNmfVXzGMVBq
         dM/vf2IFBbZ+BAEPK4de6ziwx4wIIRsHExcOuSzx1GwHy4UZVvPNm/i9QqtlmyAEx5Vx
         qEgiqX42lsA/klo+yPSR0UtnIO1IlMvWDz1veJ0yUCN/Mb4YezWjthudQzAlYDjYdRoG
         CElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983857; x=1783588657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGwAednzqeRxCB22QWUBlMswoWJYl0ScI1kF4jRrqA0=;
        b=g/xPjy0GMiYsHmqxJujY+Ii74QRlIHd5pO6tA/N3yqpnfMIPZolR4DP3JC5PJgbtq1
         5YkcxuqJ+L4n31rFwlEXrOiy3nVsEO6Y2aH7ds0s8hE/fsncGZJAMHTEihdvmNSBJm3o
         k68dMSC3plqFIRwTupgaVvpLnZLjRk8E6aWzlaNRqLZW32A3wvwg3MCjv9NBg7PDUjFF
         Fqq46vUONIb02NPjT4zZ70wzyFZI5AgpCsdTMqzB8a7Ubq/dK4U8lcPlMaje8Erc6twT
         VLSQiXyLLUctuJyZi5uw49CliQijnqMisd2jn1gBOHLnmN9AzaC3/Ry29Qjy6eQbsbwy
         PYgw==
X-Forwarded-Encrypted: i=1; AHgh+RrYydleR/6USMPYX8335hOe6uhHJSfXoMhWAVDTOfmvAibWP3s3RtQdbfa0s82HftTHpOCwwhVEDsZkn5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCCAANR6dq9w5xcise4SfEfz35oD/nNx+m7IxrVYpEjHnEx4k
	wP3ugqZJ5aLr1cqbw6ZqGDH74KYS/7gqC3uG1xF/ryMypYQImWpofu2JPKV+dTgG3YZ7BvLEJD9
	NgxPu8/GP7+KpIqEBkqq96+na95EofeNGEU11qeMkYFiJMMjg2uRyY3/Itwyfw9nxFoU=
X-Gm-Gg: AfdE7cnmOc3ORpwgmuAlWAZ53LOvZOerZhE1dLzkfic6huTKHHDfVjTzbZcBzzUMlcQ
	oYXVyZLFAr0tczrO95IaFdNULxzfsdtnVRumxOMJAn+un/QxnfMswrKJ5V7YmQLVSTqKXfVKSyN
	l3d0bSnbnVLMmMmExmDfemvhblnqNA2Bs4MWTZlG934BsiwHDkD7c5TGYpdAtz0RKUqRyzEbpS7
	oF+jbj38V9q1Waq/4tAUR86pz5hZX/cyuOXqDKZyWgRSirhhzF0SFA0aIzJFBe4060uOHxTYweP
	lloN1DKhU+kR6W6qHi8gY/9QeeNu3+E7mZkMvSU8moiu31JV6wSVjPSyQNSOUZ3zHb4HHGk0WVq
	of93fEhIwVk8xmZuodmhs9aB9UJzlYSyCQjd0IOwzwk49
X-Received: by 2002:a05:6a00:2e9b:b0:845:d274:c021 with SMTP id d2e1a72fcca58-847c51dad17mr4176463b3a.58.1782983856816;
        Thu, 02 Jul 2026 02:17:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9b:b0:845:d274:c021 with SMTP id d2e1a72fcca58-847c51dad17mr4176424b3a.58.1782983856203;
        Thu, 02 Jul 2026 02:17:36 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb985420sm1046311b3a.43.2026.07.02.02.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:17:35 -0700 (PDT)
Message-ID: <a107b5ee-1140-4651-b5bf-90e2b793cebe@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:47:31 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: add force suspend/resume to system
 sleep callbacks
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com>
 <73243e36-175c-4fe3-a448-b30eef9c44ee@oss.qualcomm.com>
 <4fa2a2ef-90ec-4f06-8611-c508ce0bbec8@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <4fa2a2ef-90ec-4f06-8611-c508ce0bbec8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FAHFkK5ILEByAzYMPw9yyFcNsTZ16auh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5NSBTYWx0ZWRfX2hSWdNJKLzn+
 JJKPQw+/iA4/0sdvgkWiOtMGeii6RInkgpR91qoua1sQNMsGWseZlh2nFnMwICsnhnptHed6qVe
 8zlGrbKvQX5UGJiK886Ak7moUpA01NI=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a462cb3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ve0Vv3Uji7OJGmRhxeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5NSBTYWx0ZWRfX+YujxrmoSAJv
 cGm4jGlX2wVn05AG5GFEwBpUEvftLaRv6qulnB60h/jPYvpe/Vx4sf27y6eiiQuplwbKkh6qWRW
 nLLyCdOB6rgcFvI/ecVaQebGLlmtWybGobyII4p9abZtT2YoBuIGIcBFm8nKmTdvvY8PEFcGF9Z
 cltWtafDVb0lt+lAmmPPoEEMstg/05UFJq/H2Q8EBSm8IX4a5a9EN92+xxy8pp/Dsp2oJq8C44f
 KmemRuBK0ljinAKRN1uu85hz59rNrpfUTsOwDm8V7gq43o2IRQ9rsoUFLWH7KmleIBXuBcKktjz
 /SwPEzsY4KhXdZjczCbcXqCwaAoxbiTfjEEUT35SVTTFzNMcC7lTsFjasQCbdQm4HFrNSydSEux
 nxbalsACkvWFVMs8U1MAP/7bRRlbS89DDPn0UkvwFimp97lAtY5dBqkNaEZbLzfUblVAHHLmXAU
 Snetw/Lh4W0qj6I0q0g==
X-Proofpoint-ORIG-GUID: FAHFkK5ILEByAzYMPw9yyFcNsTZ16auh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020095

Hi Praveen,

On 7/2/2026 8:18 AM, Praveen Talari wrote:
[...]
>>> +     * When no_console_suspend is set the console must remain active
>>> +     * across system sleep, so skip the force suspend path.
>>> +     */
>>> +    if (uart_console(uport) && !uport->suspended)
>>> +        return 0;
>> Rather use console_suspend_enabled and take action to go force suspend.
> In uart_suspend_port(), uport->suspended is updated only after the 
> console_suspend_enabled check. Therefore, its value directly reflects 
> whether the console suspend path was taken:
> 
> uport->suspended == 0 → the console was not suspended.
> uport->suspended == 1 → the console was suspended.
> 
> Looking at the code below, when console_suspend_enabled is disabled for 
> a console port, the function returns before setting uport->suspended = 
> 1. As a result, uport->suspended remains 0, which accurately indicates 
> that the console was not suspended.
> Therefore, I believe using uport->suspended is the more appropriate 
> check here. Please let me know your thoughts.
> 

I think it would be good to use console_suspend_enabled and take action. 
Not to depend on after effect of the primary decision maker variable.

> Code snippet from core layer
> 
> int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
> {
> [...]
> 
>      /*
>       * Nothing to do if the console is not suspending
>       * except stop_rx to prevent any asynchronous data
>       * over RX line. However ensure that we will be
>       * able to Re-start_rx later.
>       */
>      if (!console_suspend_enabled && uart_console(uport)) {
>          if (uport->ops->start_rx) {
>              guard(uart_port_lock_irq)(uport);
>              uport->ops->stop_rx(uport);
>          }
>          device_set_awake_path(uport->dev);
>          return 0;
>      }
> 
>      uport->suspended = 1;
> 
>      if (tty_port_initialized(port)) {
> [...]
> }
> 
>> Here, it sounds opposite, if port is resumed, you don't go to suspend 
>> within suspend function.
> It is straightforward: uport->suspended remains 0 even after 
> uart_suspend_port() is called, which indicates that the console has not 
> been suspended.
>>> +
>>> +    return pm_runtime_force_suspend(dev);
>> Is this really required ? if  uart_suspend_port() successful, what 
>> will happen with this ?
> 
> Yes, this is covered in the commit message. The key point is that 
> uart_suspend_port() may not trigger the runtime suspend callback if the 
> runtime-PM usage count remains non-zero. In such cases, 
> pm_runtime_force_suspend() is needed to ensure that the hardware 
> resources are properly suspended during system sleep like our i2c/spi 
> supported.
> 
I hardly see any other uart serial driver using 
pm_runtime_force_suspend(), any do not see serial driver using runtime 
PM ops directly. That being said, let's covered all use cases/testing 
with this change.

>> [...]
>>
>>

