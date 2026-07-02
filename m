Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1624D8D8B
	for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985802; cv=none; b=pB8H32YRG+ZWRrk6GvOQqbd5KCXO1PQRB8BTSlTbJY7t4/1LyDyZ/5TBcG6pm5Fvl6Ghg88W4gC72gSSupYCgR3gccQZv4swch4SiRqdQBP4mJTopyu7WAgTpnbWwOh6ru8wZdElfEICULGNkehM7Y+zXm1+hT4zpzVr3xotrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985802; c=relaxed/simple;
	bh=+aEA+WL+lhQ8/LMNDDj+Ae2GqHVXWUMR4IxffTyTgo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGoxHYrdzPNrhPdwfM/4mGrV7nz79Th08b+tPyqm1MacCFYutdkINeKgpS6KIYlyLRveTOTBrYZQQ7Kwfxf2AjLANVjzXvXHB/jiZc8XOcMcKKCjM/0ogFxTkpiPzClgkV/q3bEk5bCIwEK51SXEGRhBPuIHGb52N/UiiFxDtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RF+6P1/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqi+Yydv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RF+6P1/o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqi+Yydv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627Tsqw3964234
	for <linux-serial@vger.kernel.org>; Thu, 2 Jul 2026 09:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BFEvju+fHqbHwUz13O0lBoZLeevj7Pcr7HLGdvh0MNY=; b=RF+6P1/ont/PO4u8
	7o7Zhtz5CBzlMZ6LpioPqYb0kWUTr0zNflvRM37NSe0z+p4hNZ4W7Uuf5VJcCWwD
	pvkiEUSLYk51kx4NArMSJjpXNA42nNnGxsO2M0vPMVr6/zNhBP/SabXFwxUq18+F
	iGQsVIJjG3egiZi4AVQolRT4j8ty+QmV9WxSVyDBSA1lfIzuIuJOIYug3N8addZS
	OU/MPb92RDCu+JN2tMcbeflVLSGv/cMGGU1J2bD007027Q2khnPs7+8uzQV1LiBw
	5GxCcr1/jzFKX3A8gLwNtgRdgVHpCGUdiGXQRHn3ouQF14LxBK9MGxZl94pDflAe
	iqmCPA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc0j9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 09:49:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84240683a82so464372b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985798; x=1783590598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFEvju+fHqbHwUz13O0lBoZLeevj7Pcr7HLGdvh0MNY=;
        b=hqi+YydvOhCF8KtUVeGJjdNoIoHNgCUekYrwYMPn9Zvy8EOE4/p1+2zjaBxYaddqKr
         WGf8U3/5n1MB9li2zgnX9JnhQ+lZ6b1UOJkDx1qKutp+gwlotNi50v14lGrSbB4pk/3W
         D2t/lTVHyRRdjCuLw9IVQlQRDLFfRDGnqBv6ba60fCGO7m45U3LYIaa6cEQ42SD1OR1R
         tPwZlAHoCDGMPPLBJiMGiCEwYXJE2o1rR9cRx8nxoTTCOA+UkOKOD9KkNMAgMVyKizX6
         ZXurrSesMjOe5tkhq47zLYvnAJ85pTqJyxdDhIkWA2eRvRfb8LVQiu1w9RUYTSUZ3bvk
         uGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985798; x=1783590598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFEvju+fHqbHwUz13O0lBoZLeevj7Pcr7HLGdvh0MNY=;
        b=mdC673jNvD/9yrFYvd7v0LCv0VbqTzJ6dfpi0TofGq1yuKZG1U/XOaXxME5XfAx58Y
         J+ETmq6wN+Dvn8GQJQ5jWU4Bw6BVIuQXnoHsOlg4XZQdL1zYoia5nzyOtxd/+vuOpuzy
         e7V67YKgDKKaDnTwyGt4JdIpSPN0bHGDTCEXbxnycMQueXb9I/qEYokShnxCrNYvylu8
         xH6v9mR7ka6dtMsQ/ERRU7rUld44CkPYrtiWeaEJxq17m58J3NWobeR6bbklDsozmxPJ
         //7vymNJM/tRGPYIQDfmRDa0ExibxyfbYOt06Z/AORhJT+6S7SXmaRCbutUGTBx+HudM
         C16A==
X-Forwarded-Encrypted: i=1; AFNElJ+rzFM0wFpeUxBkToGyv6xj2p/CBy+83HYAmg5eXCFflPr/krYUTTyOLwmB5Ig9HMy2PTeFevs1AMmXBWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTjMfcGsXTVBFs2hiww9hXXQM9uSEhvQPGuQAm/s89EHvqgsv
	zGuAfxQE+W0NJFiHjfAQ7fRICZ1mr5bnwC6d8cgC7KmaWxicA5n+mmij+EmSCmgu7/zijCuXX4j
	Vy/b4rqpkWb6OlMcebeEFmwwLM7b3xeFCMft6VNT+0pFy7nlGcbE6TmzSYJKbyiJHyfc=
X-Gm-Gg: AfdE7clTE2FIlpcL73sYHE2DOXmW02YWz6r0D3DC2oviavPfGx4XQRH6PpP1aHZWnI2
	YVQAXLH5iW06sXVGOeu1YBtZFRLAGC791WcyaB6ZAnu9nz8RtQ1Q3qiCaVw0AdIaOhZh/yoHC5b
	A1qrqsPTmw1jgrUEzt0sv8wp8sR+aFTgD0DXNGAMOfIr/RQMlgB9V1OY9EWJqUwQ3UB6y4b/Ins
	UtZ6KzO32PU2eJIX2VHz2QCfWQwff/m9lRHq2bc+dXmQVbFu9H61WfVnDWUFQhANVbAwCQjHpgp
	MgPOQyRRiEG8/M9kgsyoQ773HkfcTekpdy/LNdqb2Hc9za7JzdRPVub7bG+8L/hkIvxplwIfTKr
	SyUthQbDqDF8nMotz/OuIp15YbgVEX44BJFUImA4DKjI=
X-Received: by 2002:a05:6a00:9283:b0:847:8f33:b159 with SMTP id d2e1a72fcca58-847bf8231acmr4258558b3a.10.1782985798338;
        Thu, 02 Jul 2026 02:49:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:9283:b0:847:8f33:b159 with SMTP id d2e1a72fcca58-847bf8231acmr4258543b3a.10.1782985797676;
        Thu, 02 Jul 2026 02:49:57 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.106.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94b3d0sm1097629b3a.36.2026.07.02.02.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:49:57 -0700 (PDT)
Message-ID: <f6c36949-54ec-4231-9ded-1b127fd4c3d0@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:19:52 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: add force suspend/resume to system
 sleep callbacks
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com>
 <73243e36-175c-4fe3-a448-b30eef9c44ee@oss.qualcomm.com>
 <4fa2a2ef-90ec-4f06-8611-c508ce0bbec8@oss.qualcomm.com>
 <a107b5ee-1140-4651-b5bf-90e2b793cebe@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <a107b5ee-1140-4651-b5bf-90e2b793cebe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ik2cwNz0AbwkV1SoW_0Hm9iByPFRKhAG
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a463447 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZY8+d+ilh5AZ8AQMB2/tOA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=wcYNnAJ3XbtdpYK58FUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX7o3FjECu1vlD
 Jb3HkKFVk9lZQqhimCPPZKgokmVEbHRARh1cD3AmcQ33N5yJ/QcVBhzG/D6CGEzpa0UdqmKd1xr
 /0qm6EjR3l8b46AfHUFbSUvai85hv40S4hDqU820u8sWl5LuZTppKXFXoCGuzuIRywdu/gBt8Nr
 N0fcQ6mu3ebSIP/dbFKFHizVR/hIT8i8h1VqobQhkmADeeeKLliGbTD1xxCIx2qthuF9QshHQof
 FJZ8+6R9RzL+uvmmBKZ64kCzeNRQCqhFNWJd5y6Q5H8kxHVea4C5Iis6pk8vMKhXmOViSo858/f
 UtAe+PqF7rnDRreerYp464wYYyGc3HWObZjAefzAkkTURQ0Ht9+n1jkZdCsG9kcCmLCzuu+htJR
 s2RNJElxzBaIs7Ji2OS71BBu5d25dEbC/xIHpgAyeAuJAdhbKH2F+MKPtim/3UoiFCs4wOyStSu
 akVNrlYa+WI1N/0nCGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXyLUPoUEzloB2
 8Rk9Exrm6s02h7E2wt9RUXr1k/hk6xw6GJzalRL/aU8yoZUczwci9owVY0fvAu93jTjWeOhcT/9
 7O+Jyr9Wp5oo0QkHaWbBQFuIvrrxrcI=
X-Proofpoint-GUID: Ik2cwNz0AbwkV1SoW_0Hm9iByPFRKhAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

Hi Mukesh

On 02-07-2026 14:47, Mukesh Savaliya wrote:
> Hi Praveen,
>
> On 7/2/2026 8:18 AM, Praveen Talari wrote:
> [...]
>>>> +     * When no_console_suspend is set the console must remain active
>>>> +     * across system sleep, so skip the force suspend path.
>>>> +     */
>>>> +    if (uart_console(uport) && !uport->suspended)
>>>> +        return 0;
>>> Rather use console_suspend_enabled and take action to go force suspend.
>> In uart_suspend_port(), uport->suspended is updated only after the 
>> console_suspend_enabled check. Therefore, its value directly reflects 
>> whether the console suspend path was taken:
>>
>> uport->suspended == 0 → the console was not suspended.
>> uport->suspended == 1 → the console was suspended.
>>
>> Looking at the code below, when console_suspend_enabled is disabled 
>> for a console port, the function returns before setting 
>> uport->suspended = 1. As a result, uport->suspended remains 0, which 
>> accurately indicates that the console was not suspended.
>> Therefore, I believe using uport->suspended is the more appropriate 
>> check here. Please let me know your thoughts.
>>
>
> I think it would be good to use console_suspend_enabled and take 
> action. Not to depend on after effect of the primary decision maker 
> variable.

Yes but i don't see strong reason not to use uport->suspended.

>
>> Code snippet from core layer
>>
>> int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>> {
>> [...]
>>
>>      /*
>>       * Nothing to do if the console is not suspending
>>       * except stop_rx to prevent any asynchronous data
>>       * over RX line. However ensure that we will be
>>       * able to Re-start_rx later.
>>       */
>>      if (!console_suspend_enabled && uart_console(uport)) {
>>          if (uport->ops->start_rx) {
>>              guard(uart_port_lock_irq)(uport);
>>              uport->ops->stop_rx(uport);
>>          }
>>          device_set_awake_path(uport->dev);
>>          return 0;
>>      }
>>
>>      uport->suspended = 1;
>>
>>      if (tty_port_initialized(port)) {
>> [...]
>> }
>>
>>> Here, it sounds opposite, if port is resumed, you don't go to 
>>> suspend within suspend function.
>> It is straightforward: uport->suspended remains 0 even after 
>> uart_suspend_port() is called, which indicates that the console has 
>> not been suspended.
>>>> +
>>>> +    return pm_runtime_force_suspend(dev);
>>> Is this really required ? if  uart_suspend_port() successful, what 
>>> will happen with this ?
>>
>> Yes, this is covered in the commit message. The key point is that 
>> uart_suspend_port() may not trigger the runtime suspend callback if 
>> the runtime-PM usage count remains non-zero. In such cases, 
>> pm_runtime_force_suspend() is needed to ensure that the hardware 
>> resources are properly suspended during system sleep like our i2c/spi 
>> supported.
>>
> I hardly see any other uart serial driver using 
> pm_runtime_force_suspend(), any do not see serial driver using runtime 
> PM ops directly. That being said, let's covered all use cases/testing 
> with this change.

It depends on driver design and using of PM runtime framework usage.

This change was tested two devices like system suspend and wakeup irq 
functionality.


Thanks,

Praveen Talari

>
>>> [...]
>>>
>>>
>
