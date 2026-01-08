Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFF145B3F
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843862; cv=none; b=QC9nPMySw9er0/5m6woZjv5YjtB5s6yWyILERv9YXTW9pPSJHtZjy/KcOiZ1LCWBuMEq/g4xldIB8C5H3db11yERpgIo551MQKgBsuJEVj21gPeLGG9Ff55lEb0Vmo0OwP7nfE8Q7+5oWLIG3HTauk+svnSByGfHMXAxuUe40zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843862; c=relaxed/simple;
	bh=nPz9YN3ZKg4qM0hoRcl0MSCzDHeS49HS02aeYIFURgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru/U0OJA10O/SRzQQefl5KjuLGVKEX6IbSVlWpaJdIF4LmB9lKdz6nSH1U0YCBrTN7IwUOLbyFsJeC1OP2+On2a8hwgJqy7mHrNv4VsN9MPgPfrGA47WqnmUhEJEkDDxWTXQS2eGR24uwJE8wg6aaoFHJ9KqWNWqMwVyLQNVRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFrrlk27; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaLAnRiu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFrrlk27";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaLAnRiu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6081DuGs877530
	for <linux-serial@vger.kernel.org>; Thu, 8 Jan 2026 03:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AyhaKcRTZ87kyRrMP8Gl5ERKBywP1044Z0AKTZfSCRg=; b=eFrrlk27G5Lj0WR8
	Kg9yf8cewzCEQEDR2WiOvhGpUlb7X98qrm8pkJP8XbokcBumbi3euH3QkrNpxW3k
	kl1COLAot5zSWf1T7iZKMV1Z99OQY8vdX7LD+bMcK6XZZXfGQZN1rmhh840tiy3Y
	A2vkEkWIvubowBmtAfH85sPZHqcx7yXXHrkBTeRQifDSh+RWNIVjWbJ9jcxc7Nni
	2NcB5bHjBta8SHr2yepb8wMWYuCnu4UmDFT/2UoXf1cAeWdY3UwnuD44Rzl7kJg8
	vlIDuAoYuv0Jx4PxfF2tvb+eg9UHDdG1JQYD2FpGox7iZqpVQ/1abBKxP/R9bG3m
	rzAOEA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2r30d5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 03:44:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f25e494c2so17935795ad.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 19:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767843858; x=1768448658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyhaKcRTZ87kyRrMP8Gl5ERKBywP1044Z0AKTZfSCRg=;
        b=QaLAnRiuihFYjHrs8LMMY5UPkDY7VSbAbJa9W2ZSOzenzt3KkxGtevcYBd/htcxDzM
         ST7w7iVrMK/waIE4BGC7zm2RBFad+POvDlTxCvEiwiMHGWuv205MZv61mcLnFduwFxYg
         ufBBuvJlLs1mpu7MCsTpLsTaojn2WOWzA8goWo8/nuvA6wvwWx3SCYwSZLdQU9MBq/SV
         Ep+kt/J9mFwhPb7RA9aPaYZpENjpu4UwpefDRydyHkN+MyfuUy2p7u/KUlSHWmJYDCJ2
         SnMihGFCmoPYiFxRbQd5UiIOGPiuyljlhbNieGrmW74fMyCqlnDMwHJ+deQxjXBeJRed
         CAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843858; x=1768448658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyhaKcRTZ87kyRrMP8Gl5ERKBywP1044Z0AKTZfSCRg=;
        b=OUPIAx6mUhK8tVvTjvEGhBQida8Rgm9i2DV+o2neuWXjUF8Q3keRR5LL8tobncDRfG
         f8Rgv6FaXmpxQe8r8kRmCCC3/i94vZrCBN1NyvWQAd8P4rutVr1klHdskOobULr9TWmy
         fkyuytfAeFcUKWd9WwsOce53Bjz2desXzjUPhgknJbLpX/WIQZaHvasz39u1rfZBp1Mv
         0R3ogDU80IbYSkmW3kfMcKTwqlT/tV5+OVuV4DQdNF81ESqvFJdznDk7jzHhUlhwQWOd
         Jg6rTwFDBBvMvm5a7rIHz1b5kkwtw5o+XkPGE1M0KkhQ8losKBW8LrymUu1WFmRml0wC
         jPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIxRt+D3DbVNqfpp8g9WzGxQR4LE8ksRQc1+HeeKxvRP2rkHirCHbZJk9UsIeNOWWNbRyflMBptgiEZEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7wUmz0zfkaQRDyDphz+vpHmM8s11Mr4972ivjSu9mVsUdqUy
	T34iahn7UpoC56cAkxO99ksYB1RQU97KT/baQEZwb8PVVEUdD65eOTWWS9a8n7GDC118OqWmQ/e
	DddEUGvSeG74FK3SazeOtHNBrgaH8oMjbbgj5equ6be7PCjb0hi8qAwwqBph3eCZtkoM=
X-Gm-Gg: AY/fxX4TifbkLSaNQ99pK4quKvp9mk20t1aNJ3naM0NiB7kB2rgI+UM64AfqCcsXt/S
	ltMSrTEvGhdysBg9iOcW9BwrVa4l7R5rZqcXV5u8nGIt6alikaYe04+YEKei09me+aTPm+8mjo5
	WEe07vWApeX3GpmenFRl7uaEFDZ4RxI700wCnjUvozYtQwzKsRMFN6R9P+EwXZrhgtnl/AzzHYR
	oV3V70qxXaT9YkQlvVJOUxwzLEC+uiWsghV177fsqsoRQ6gIm956JISyYqR3cGcu8zAxcBrDfcT
	XR+UZ8dHnGC46L/mf8PqXJIXWn6st8EJG1ozMH6J6kWuEsb5xnWjGmYr27hLoiSb9Uu6qR3fux6
	rxoNUHNY/uClictAkpQtX3BYfevfeqNYRzF8qD4JV
X-Received: by 2002:a17:902:d511:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-2a3edb775b6mr47955785ad.14.1767843858279;
        Wed, 07 Jan 2026 19:44:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe3IIUIinIDemcmtGGMAaQzqMVMErby+gw7b+7OcqE8dh7iXGPMzpeDAbLXk0JgeahN5MNVw==
X-Received: by 2002:a17:902:d511:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-2a3edb775b6mr47955455ad.14.1767843857578;
        Wed, 07 Jan 2026 19:44:17 -0800 (PST)
Received: from [192.168.1.2] ([49.204.107.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a51dsm63750155ad.18.2026.01.07.19.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 19:44:17 -0800 (PST)
Message-ID: <1260b788-3156-4116-8683-7e2c46bdafcd@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:14:12 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom_geni: Fix BT failure regression on RB2
 platform
To: Mayank Rana <mayank.rana@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20260107162610.1582626-1-praveen.talari@oss.qualcomm.com>
 <0d214cab-1844-4d0c-870e-13421f4b7ca6@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <0d214cab-1844-4d0c-870e-13421f4b7ca6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAyMyBTYWx0ZWRfX2ICm0JOe1pnE
 GWRyjuBgAZN4xAIhxZQzVEuCNtEcitT9w7KaTXSMdS/knz1J6YO+4kxREk8YQM3xmZfPfg57hXI
 UDgqbF+XYBfpg88rI4HfIsDYPEBaSikM5YYE+/2xz1iUO8gq5BqQsBo8iNPH/pKfnBBUMPr2qLG
 CQant5NoBVyjj5OaaFBe6G5BlbIQ6Qqa2bwvV5Q/2FHYsUOtdYFyBJTARlhtkwI715KGddUjuzb
 Afz2ser+G0S7XT+wNcGtGOIpYlrJXm9ntTKCPvm3SfZtbLrT0/oOswTeMnyHzHi0DLfFZ0mwHQz
 uI30gqNo1cSiLv54N4xgjwb8BJczxmvUzBE29AQdZgLT/XXP8psVVHedwUg8C/9lWzu+vNJrF5f
 RTyHr4UjRo5wQ/2/iDtAw1VEdo6P8YZHbJIh1d/2yYa1sjtgb2/euhnWr5++2wtOvk2Br9s0hyG
 jTaI4AhZPYiJx18ujvg==
X-Proofpoint-ORIG-GUID: yddyHX6oPVAQ02X7xbUuzZi6t8HWQuLB
X-Proofpoint-GUID: yddyHX6oPVAQ02X7xbUuzZi6t8HWQuLB
X-Authority-Analysis: v=2.4 cv=S4nUAYsP c=1 sm=1 tr=0 ts=695f2813 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=+gEgXnvjvgnLECGlQBulyQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XTfrK5f9tDC1lpa1uY8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080023

Hi Mayank,

Thank you for the review.

On 1/8/2026 3:09 AM, Mayank Rana wrote:
> 
> 
> On 1/7/2026 8:26 AM, Praveen Talari wrote:
>> Commit 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial
>> driver") caused BT init to fail during bootup on the RB2 platform,
>> preventing proper BT initialization. However, BT works correctly after
>> bootup completes.
>>
>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>> called before wakeup IRQ setup. The uart_add_one_port() call activates
>> the device through runtime PM, which configures GPIOs to the "qup_x"
>> pinmux function during runtime resume. When wakeup IRQ registration
>> happens afterward using dev_pm_set_dedicated_wake_irq(), these GPIOs
>> are reset back to the "gpio" pinmux function, which impacts the RX GPIO
>> and leads to Bluetooth failures.
>>
>> Fix this by ensuring wakeup IRQ setup is completed before calling
>> uart_add_one_port() to prevent the pinmux function conflict.
>>
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Closes: https://lore.kernel.org/all/20251110101043.2108414-4- 
>> praveen.talari@oss.qualcomm.com/
>> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial 
>> driver")
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v1 -> v2
>> - Updated commit text.
>> - Added Tested-by in commit text
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/ 
>> serial/qcom_geni_serial.c
>> index 6ce6528f5c10..46a9c71630d5 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1888,12 +1888,6 @@ static int qcom_geni_serial_probe(struct 
>> platform_device *pdev)
>>       if (ret)
>>           goto error;
>> -    devm_pm_runtime_enable(port->se.dev);
>> -
>> -    ret = uart_add_one_port(drv, uport);
>> -    if (ret)
>> -        goto error;
>> -
>>       if (port->wakeup_irq > 0) {
>>           device_init_wakeup(&pdev->dev, true);
>>           ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
> 
> do you need to handle error handling part here as calling 
> uart_remove_one_port() shall result into NULL access related crash while 
> accessing port->port_dev as port_dev is not allocated 
> (serial_base_port_add() add is not being called due to moving 
> uart_add_one_port() later)

Yes, you are correct. Will address it in next patch.

Thanks,
Praveen Talari

> 
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1901,7 +1901,6 @@ static int qcom_geni_serial_probe(struct 
> platform_device *pdev)
>                  if (ret) {
>                          device_init_wakeup(&pdev->dev, false);
>                          ida_free(&port_ida, uport->line);
> -                       uart_remove_one_port(drv, uport);
>                          goto error;
>                  }
>          }
> 
>> @@ -1906,6 +1900,12 @@ static int qcom_geni_serial_probe(struct 
>> platform_device *pdev)
>>           }
>>       }
>> +    devm_pm_runtime_enable(port->se.dev);
>> +
>> +    ret = uart_add_one_port(drv, uport);
>> +    if (ret)
>> +        goto error;
>> +
>>       return 0;
>>   error:
>>
>> base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
> Regards,
> Mayank

