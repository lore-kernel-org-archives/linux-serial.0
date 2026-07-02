Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF762749C1
	for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2026 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960549; cv=none; b=DAAKvWIuem/Yo6f3EEaNAJ7IGid857eQum2P5eOcMyTTzTAa8SwQn4Eh6ntUYdLbo3PbBU7gNd9Llr06xNIS2bqIDNfrO7U39dBbSOppT0CC4DTPoZpU4G2q9CFgePrS1atkqCHpcKEBWp9GBnEVgYIPhS8Gk4zanceOT4CxRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960549; c=relaxed/simple;
	bh=AfVlfqVRM83w/2+kbTyFI/v1InzBtt6aUMbIahCrumM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut5XXJHJ3w/U/RuVPQT81/RSa7Rb4gRw+fJcJuylpV2SNYCkvVeo/hPKuLHSm7XIJ2i1v5jdQLGUjv5qP9UP5ciIqJPpIDjM/Hvyen4orJrAz/X1mX7YO/obIdlSghaJxqTWpK5Z2hM2s1gYbHwI6WvaVQYQudEdbH5otkpOh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jC7nawt3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ek3w9Hgq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jC7nawt3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ek3w9Hgq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KJBo2959716
	for <linux-serial@vger.kernel.org>; Thu, 2 Jul 2026 02:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lLaxFpS100Xk7qebtOIZC9YPDVj1gBjt4peUMTWselI=; b=jC7nawt3ScLwBbnz
	1mG93i6dkmMbzsQWDwKKdnlTw0AdW/WgQuu/rUzq9LX+bXEZlrbCvfpyvngQ871o
	sDdmiVajT5W9WYS+RUkIPZu5h4W+XjC/YS5R7t6ilETgLK19lbSnf8TQq2yDnjpc
	ZHv4Wc2i3Fgp14QSgup0+BvY9bVBIXvPk3eYKad8QDqMvDz1hHcq25vEnuopa+NZ
	8lhfTASdd52U2Rok3mzlSCM+WkJupIebo66YFnS2920l8cBooW6hdcwhb2OWAkCv
	2EKQJY2HNFI/+pHYytx+ZO0Eg/GgKAtNurdqatHo3bcsxrwxwjmgW4JJ1Jbv8Kzw
	C60ZZg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f563mj4nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 02:49:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88da04b71dso1451499a12.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782960546; x=1783565346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLaxFpS100Xk7qebtOIZC9YPDVj1gBjt4peUMTWselI=;
        b=ek3w9HgqditCgvpUq0gVVrASlLRFmHF0CYAWBxx3cO0riu4qfLM9pcVoPhB1IPL67z
         NEx348VR6u4iEU6DbnXhz8zwmOMgqvNilCzZv4SvCvgonZ0RaXc1Takg8AlJ5jO1iLmO
         ijofZTLHDH3TnTk+OHuMNxkhnoLzD+eLFOe6VJzRaNNe5kQJshCS3i/m1lB4QgA8uk8y
         kURGHsxLu4lVd4dYNhg1IzVa+p4iRs01HDxEWwQqb6KKgICpmmPcIZQSM2ZgBj6czZQe
         zwkJAhXROum/8ebeo7c1fRC3rqjEGDudjXwkC9sAg9DycYCG5v40BDxoX2P0K/qW6Gg2
         Y3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960546; x=1783565346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLaxFpS100Xk7qebtOIZC9YPDVj1gBjt4peUMTWselI=;
        b=IJ113MdygH65nzIRClq11LSHjmce/UiI/DEFoAiETcxaBlw86AgFWMpV5GFkH7Pavd
         rfSLQUXn16MbLsB7LcYgYMeLeAb+wx+MJFkeDsrHyJ81b8t8mXzCJRzYgfPhn+7AISsb
         GUAZnUB6EJ6R5mwj6Sr2jDCB1WOO152VRxoj2Vb69iBqzfn3ykI8ucCVIAhPoSqYuXkP
         c/Wq5Y0RN2STcP9F2pegS8jvpgStK/LQlFNUHHvv0nw0AL8sr4ZXXzy8h5X7ZmAug7aP
         NrEs+pW8jXfxWYjRNuPXPa95f2CsgtQ3ocVp05NyrTwiix+ghPadjN2oD9DgTutxVbHz
         odog==
X-Forwarded-Encrypted: i=1; AFNElJ9X9r/NqeOvTJ2+QH3hOfRzKyNOxHlxRCimlZpyTkux5bth9Wq9p9oW1JfBEz7ZE7DOGN0SGgeMnT+eczk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeO4Pxqk5fQOw2denGR6jjOBFSp5oPGj5dyCthSdvwOq1+ozqn
	viYUsFY0RaB6jUZ7TIm1UFvOwt+xoHgea1Uyz9JRJy/67fPckxkQhYsFHcOEtPq8fUsvHxLBnRb
	zYDSWEGf01CIP2Z7CeQeplka3WxYvRYdlP/i9DfECM6FHUMDRv+X2Ok30wweZ5u6UjtqiofxTm3
	o=
X-Gm-Gg: AfdE7cmIg8EVibU1KgsfXTWZT7IKt6Hjh2uhXnKUHgO7tFzxnOwVvLVc+lYH2ish6bq
	jeGyZQRHWCYFiNGfO7kmjfJoTeeJtUsNAJYKXEa9wKNPXeSNbsXjnWzG4irzMqjY9r/8U0iMhbq
	uw0SiuCo9O+yTKmhoEkk00xWYOUpAulgBaupUAgUMxMtWwHH6/+quA2ykFC1I83FlU6RcB/4nMC
	XKKqoa7+7foBLhXGAJnp9k0P8yUSNZJwNzLLlgamKB83HjR43TQ0H2lF994ChPrUl4r3pgKMdrI
	Ltz7ODzZRubp1cvjIdK0FnuHmAcUj9gLnX6Mraumz556AhBxXlbDXc0Zk4gg0tROwsGAmnw7nmn
	op48sfPPkWbeG1lRNfJff/DigaKSorEGZtEHj7caWu2w=
X-Received: by 2002:a05:6a21:696:b0:3b2:a8cd:ef4e with SMTP id adf61e73a8af0-3bfed3b2776mr4936149637.28.1782960546022;
        Wed, 01 Jul 2026 19:49:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:696:b0:3b2:a8cd:ef4e with SMTP id adf61e73a8af0-3bfed3b2776mr4936097637.28.1782960545007;
        Wed, 01 Jul 2026 19:49:05 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.106.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc544sm3802085eec.25.2026.07.01.19.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 19:49:04 -0700 (PDT)
Message-ID: <4fa2a2ef-90ec-4f06-8611-c508ce0bbec8@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 08:18:57 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <73243e36-175c-4fe3-a448-b30eef9c44ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qbo_y3HQ14FdzH1cE37lleO8uc8KL9GZ
X-Proofpoint-ORIG-GUID: qbo_y3HQ14FdzH1cE37lleO8uc8KL9GZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNSBTYWx0ZWRfX596hz6k5cQwd
 Rkc/Z1i2iUDPJgpoJt0WaWrq8DU1qP+QrvjwFqWYelfqHKUQOJe5fMnf1ZNfca6/8ZV4N1wuytu
 bcJeTSjr1DTpxGIgOpd82UuUP+UsNSepDDWdrT4Rw/wF+3XsprEneIMO7Qnx4MEm4PtOzUghM7u
 fuJc9K743Yt6jqEI4bsgh/VJNoOQqmQ5pkfaWb6rlkXZKFL64lhII/0D57o/cAVqG4GqKUI50l1
 bzg9uywSf0T5d68koP6Ue9o9d94U3+Q9WvIuwIH4mXncI/sXvbzbtuoXpJeSNHNwxFN/C33z5KF
 yxCOYVxi8Vt3xKjlE3WulH8nIBku7Vvuhv84IXuJU8i7duXvEiL5jx3ohrebr5mxxtxSaGQ3PDG
 sU3lv+mAUaCQOw0WHIYD/0V4y+l1SvF9vUp3ljy4KPyehja4cmtNP5Pu2r20lrYfbvzrIsZeTOr
 J8UpGL48xUxLHru1J7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNSBTYWx0ZWRfX28qNGSz7oj83
 yaHKw5veuEczcuX9ZUP6g8D0BalLpfAfwXrWxhL3omE2kkw1wovGCY/mUgYAkiDIGCenDrWrg9y
 8+J0oDyubuh8XQnwhnxuA/1oS0veUA4=
X-Authority-Analysis: v=2.4 cv=UopT8ewB c=1 sm=1 tr=0 ts=6a45d1a2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZY8+d+ilh5AZ8AQMB2/tOA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1ym4DecIM8o6dCVoxpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020025

HI Mukesh

On 01-07-2026 20:47, Mukesh Savaliya wrote:
>
>
> On 7/1/2026 11:27 AM, Praveen Talari wrote:
>> During system sleep the hardware resources (clocks, interconnect) are
>> not gated because the runtime-suspend callback is never invoked from
>> the system sleep path.  This prevents the platform from reaching its
>> lowest idle state.
>>
>> The system sleep callbacks qcom_geni_serial_suspend() and
>> qcom_geni_serial_resume() rely solely on uart_suspend_port() /
>> uart_resume_port() to manage power.  uart_suspend_port() drives the
>> UART PM state machine to UART_PM_STATE_OFF, which in turn calls
>> pm_runtime_put_sync() and eventually the runtime-suspend callback.
>> However, if the runtime-PM usage count is still elevated at the time
>> of system sleep (e.g. the port is held active by an open file
>> descriptor), the runtime-suspend callback is never invoked and the
>> hardware resources (clocks, interconnect) remain enabled across
>> suspend, preventing the platform from reaching its lowest idle state.
>>
>> Fix this by calling pm_runtime_force_suspend() at the end of
>> qcom_geni_serial_suspend() so that the runtime-suspend callback is
>> always executed regardless of the usage count, and by calling
>> pm_runtime_force_resume() at the start of qcom_geni_serial_resume()
>> to restore those resources before uart_resume_port() re-opens the
>> port.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> [...]
>> @@ -1963,7 +1964,19 @@ static int qcom_geni_serial_suspend(struct 
>> device *dev)
>>           geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ACTIVE_ONLY);
>>           geni_icc_set_bw(&port->se);
>>       }
>> -    return uart_suspend_port(private_data->drv, uport);
>> +
>> +    ret = uart_suspend_port(private_data->drv, uport);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /*
>> +     * When no_console_suspend is set the console must remain active
>> +     * across system sleep, so skip the force suspend path.
>> +     */
>> +    if (uart_console(uport) && !uport->suspended)
>> +        return 0;
> Rather use console_suspend_enabled and take action to go force suspend.
In uart_suspend_port(), uport->suspended is updated only after the 
console_suspend_enabled check. Therefore, its value directly reflects 
whether the console suspend path was taken:

uport->suspended == 0 → the console was not suspended.
uport->suspended == 1 → the console was suspended.

Looking at the code below, when console_suspend_enabled is disabled for 
a console port, the function returns before setting uport->suspended = 
1. As a result, uport->suspended remains 0, which accurately indicates 
that the console was not suspended.
Therefore, I believe using uport->suspended is the more appropriate 
check here. Please let me know your thoughts.

Code snippet from core layer

int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
{
[...]

     /*
      * Nothing to do if the console is not suspending
      * except stop_rx to prevent any asynchronous data
      * over RX line. However ensure that we will be
      * able to Re-start_rx later.
      */
     if (!console_suspend_enabled && uart_console(uport)) {
         if (uport->ops->start_rx) {
             guard(uart_port_lock_irq)(uport);
             uport->ops->stop_rx(uport);
         }
         device_set_awake_path(uport->dev);
         return 0;
     }

     uport->suspended = 1;

     if (tty_port_initialized(port)) {
[...]
}

> Here, it sounds opposite, if port is resumed, you don't go to suspend 
> within suspend function.
It is straightforward: uport->suspended remains 0 even after 
uart_suspend_port() is called, which indicates that the console has not 
been suspended.
>> +
>> +    return pm_runtime_force_suspend(dev);
> Is this really required ? if  uart_suspend_port() successful, what 
> will happen with this ?

Yes, this is covered in the commit message. The key point is that 
uart_suspend_port() may not trigger the runtime suspend callback if the 
runtime-PM usage count remains non-zero. In such cases, 
pm_runtime_force_suspend() is needed to ensure that the hardware 
resources are properly suspended during system sleep like our i2c/spi 
supported.

Thanks,

Praveen Talari

>
>>   }
> [...]
>
>
