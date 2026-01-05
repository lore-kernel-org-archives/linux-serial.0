Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749142D97B5
	for <linux-serial@vger.kernel.org>; Mon,  5 Jan 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629566; cv=none; b=a7BMYhCFD2R75I8gnxKioUQ+OSKubflPvejne+es3/NYKTqNH4PdDgG1yy4rVyKMq5zJWkgqE17oynsD7lpIUDIG3bkbbbE7vF+JrVxEdfzASc8PcfTK0A5TtLtAbYpx3PybQSkwQ+GCLC9iWuu2EJjInP3bnz0Y27DMm+6kUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629566; c=relaxed/simple;
	bh=OrU54GV2LVpLw9WXOrnrg/6soqblvlSw6DkzLXmYVoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwJit3pxEKwm7Y8DJB1olAF6lguzgKRPwCbmHz89RLF7l9fmAfROXsIKLMCsEwhYxxKSdgfBC+IkhA62Kc92S9/hNzcn1eCKLXMAoc/km60akzJtCWx6vfKayaQjxH99KAQ/5iXNSroyGGIaZL8TT7XeJGuVOR0Brc+zLFUAZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNFYfFs8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H7Nwe/7u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNFYfFs8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H7Nwe/7u"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605CdAcu4033980
	for <linux-serial@vger.kernel.org>; Mon, 5 Jan 2026 16:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vgVyJzNXMpB1SreYlCVQP+upMwomcjp+afmj3FAH7sw=; b=TNFYfFs8OUr1vhTI
	YfTCx7koE37kuNyxK3Y2pyAIoVlWK9f4cS7tyc80pV3VoV65TGXmh0kVNOv7U7GZ
	aOQbekMfb28H9iOYOvlS0j1+Jdq8VzffhwragtmNzCJiaRD27u95o4F+fVLDLhf5
	4GyQM9iNMvegenA6cAJJR0K7Q1Q82rPqrd5/F5aePXMZslVnvtKrKKmumKaSK04+
	Ikccvemj1oBJkd8lahlJcFCxuzf1n9PLJs1AYCpura4/hZLF6vMP5YFnMqdAFU4D
	pmTuu8zucw1CctyFx+QCuLuOlIknPGy6pK9PzHSoFmzTQZ/++bLoV0z8C6IZi6N4
	lrrRRw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg79nhsdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 16:12:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b895b520a2so142761b3a.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767629562; x=1768234362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgVyJzNXMpB1SreYlCVQP+upMwomcjp+afmj3FAH7sw=;
        b=H7Nwe/7u5uotZaGhjVJAlmuIDb0fm3gZrfWMWfQjrPpE51hJNzqJWCTgLqzMr2G9p6
         Yg6VXguO/f/XDJ97PX7MYPEF2zy80+1E1weyjXuk7A8WHQShrHCuUWMnz6rzuXXFdAFo
         zyLmj3k7OcG4R+3JNYw/SnNfWhQGtl7KdKuDR8M/R2b2zCUPPlMLro2l65BmyrqIU8of
         EOXcBvpdYrjlxIsfaKn6IBMNyw9hZ/VuP1mPxXLaw4AwGu7/9S8FLHnz6gPTLbPsroOH
         Jaa1qNR1YWB1z79P4+qVf5k2B7WnDdDMRvsnC+cUe46H+KqUMmxykYuPNSqwTjY6GTy4
         OFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629562; x=1768234362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgVyJzNXMpB1SreYlCVQP+upMwomcjp+afmj3FAH7sw=;
        b=Hi7CVE95bhHJmPa4g78JrkyWSqsXb63yVH04lneLwKws3ftPh02P7FWXqvp0BJ1mdS
         qUnEcyru3cJySDwtJKU/iFhMkS/H+i6eOuCLyNvhpjjZwI9+d3s0ynvP058c4QQw2/Z+
         crJSGgfHNlXAZbkXiFpp39QhIfHY2OE9+cfNkBQBv8Gx3dA6DwE+LKHnvNtL3QQK4hUm
         A/BCPUM7vHlerMY8Sa+Mz8TISNfpXYLOZjyUmjFzKokW7at2rfTnobzNQ6a5Jhqm1lF6
         jaDB4qsJZW4uUQSr11QUSbfJPnExeh566+iQpRO/4W02ASPOmzgKtfCRWirL+Dvi+ogX
         YTSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+OgDHRIO5YsW04dWt6RpcajLM5mP5bNk0sm1SLz583kdFl3f8tynxxohPV47vrlJkgpxiX2kajjJwyo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDq/8mTJ1lGCkduURiWA3Te80iL50SLkgs/NFl40+1E/fpbgPY
	Xw1HtTQ0POtfIlwiYACQM2TtEp0Dx3pNhz5aQ/lX7NmsPiUp/A0PRuCAgE8h/lDlT3bJPEAk+5N
	lIk8WU6PIrVeuWkj3wCEmNx9bgrqnxHMSto3885GZ5co9BxQ4MylENzB3KRhxEGQq/4c=
X-Gm-Gg: AY/fxX6y4rCs/1hTsz+ovnXXDS7aZXVbX3kUlrXVw7mqlG2s3OrOr5PTTm4rrYV6E9w
	e9U9LVe52WRm4C+6zYnJuTdXbrDCE1noB9dgvNRnae2zMeIdM78ibnpGSBCgxmZLLFg30tMp2RC
	Fojcmag5lNxMEwY8GPAZDy6nsUpih+nJ7f7vR4jUe1RiWD8EG+27XSA/wXKRCh2sibNb7FpMOGd
	SKEzXsLBc1x9LHwFhS74nFVto1IPuYzO2iq/tZcxl+LNPWIUmt+xqSa1VLwdrE2hTjhldfqPoVu
	6t3APeZ7336eBYcAx4cLlWqu/JGjSeGc0BTgU2wDFaZRCkkBWtA86Vh/SH/irj8JAArAINok4Fj
	9mLMH+YapaF+dv2dRFqKWYqdEMT9xHHgyYEjwUZNk
X-Received: by 2002:a05:6a00:1c97:b0:7e8:4587:e8d3 with SMTP id d2e1a72fcca58-818878abdb3mr143491b3a.70.1767629561933;
        Mon, 05 Jan 2026 08:12:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRjwDvoF08ImTrFOuu5dBZHLArSCa5rNn+RBUwZaD/Jh+OU5669NrgO+VjRyBY9+a8VvBylQ==
X-Received: by 2002:a05:6a00:1c97:b0:7e8:4587:e8d3 with SMTP id d2e1a72fcca58-818878abdb3mr143439b3a.70.1767629561102;
        Mon, 05 Jan 2026 08:12:41 -0800 (PST)
Received: from [192.168.1.9] ([49.204.109.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-818770efea8sm230201b3a.10.2026.01.05.08.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:12:40 -0800 (PST)
Message-ID: <d97cef3d-b6c0-42fc-952c-1b9eff8b730c@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 21:42:32 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] serial: qcom-geni: Enable PM runtime for serial
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        krzk@kernel.org, bryan.odonoghue@linaro.org,
        jorge.ramirez@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
 <20251110101043.2108414-4-praveen.talari@oss.qualcomm.com>
 <2zeqt3tu36qcxs6xrzqqmn3ssmyzetl6tq6lxrjdvt5dhxrtv4@g5q4zhk4sebs>
 <8c734f2d-59db-4815-bfc6-3823cf3ef37a@oss.qualcomm.com>
 <25f3e3c0-7796-4318-b479-a680b878528a@oss.qualcomm.com>
 <793dafa1-43bb-49c4-9e05-cfb597ba39c6@oss.qualcomm.com>
 <8a51bb87-ce81-4adc-92b3-9a077f124ff8@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <8a51bb87-ce81-4adc-92b3-9a077f124ff8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0oTPEjs9pCKV3IdaZnjy9bSNSgdahr2W
X-Proofpoint-ORIG-GUID: 0oTPEjs9pCKV3IdaZnjy9bSNSgdahr2W
X-Authority-Analysis: v=2.4 cv=Y8P1cxeN c=1 sm=1 tr=0 ts=695be2fb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JcPDDAWpA9Ur2UU+zoP9YA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=q7x9qeZvavHb9BQ_h_cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE0MiBTYWx0ZWRfX5WKhKGB5rLZ9
 5xfGbvEMpJjU32F8sw74PgrwVq0YszCsp7AsxCZo1on+5a/RUqZSDDgxPdqnNZ0ojdqxmxBV3St
 mEqiWhXsjNhIK3afhvtgVpcJCK5KAipAbwqViCGEJjYS+KrgCfWoZPY/rD92dFWIbIGdspnZgas
 3+HBtKmgZP4Sm00GaKK72Gyf6AC0tO8S6UXPDQWTivKwxp7uJFxVLRrgYiJ2TvPln9HAsQOwyRa
 frj8LF3hzEER/uUgTTddloi3ea2/NgC8SrZB8wpsfU01iQlNAUy3b5mhIFPm/CJj0pKCocsmvwU
 cYuGBAfLrGJB7mJP+K95+jTFwtmVdkgV7zHgJ+lrRL/Km8gunVpGoBs3334G484nQe/eAk3MI5I
 3NW1IIXm8V4TmvbWR9o7M7vcM/7YESKjPNqh4+rBfYVizg+QAJxNjHwO7xoV0CKKYy/vGlGpKcK
 SQaH56h2nXy2ovmncnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050142

Hi Dmitry,

On 12/31/2025 11:21 AM, Dmitry Baryshkov wrote:
> On 31/12/2025 07:49, Praveen Talari wrote:
>> Hi Dmitry,
>>
>> On 12/31/2025 8:30 AM, Dmitry Baryshkov wrote:
>>> On 31/12/2025 05:00, Praveen Talari wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 12/30/2025 11:53 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Nov 10, 2025 at 03:40:42PM +0530, Praveen Talari wrote:
>>>>>> The GENI serial driver currently handles power resource management
>>>>>> through calls to the statically defined geni_serial_resources_on() 
>>>>>> and
>>>>>> geni_serial_resources_off() functions. This approach reduces 
>>>>>> modularity
>>>>>> and limits support for platforms with diverse power management
>>>>>> mechanisms, including resource managed by firmware.
>>>>>>
>>>>>> Improve modularity and enable better integration with platform- 
>>>>>> specific
>>>>>> power management, introduce support for runtime PM. Use
>>>>>> pm_runtime_resume_and_get() and pm_runtime_put_sync() within the
>>>>>> qcom_geni_serial_pm() callback to control resource power state
>>>>>> transitions based on UART power state changes.
>>>>>>
>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>> ---
>>>>>>   drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++++++++++++--
>>>>>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>>>>>
>>>>>
>>>>> This breaks BT support on the Qualcomm RB2 platform. With this patch
>>>>> applied, I'm getting the following:
>>>>>
>>>>> root@qcom-armv8a:~# dmesg | grep tty\\\|hci0
>>>>> [    0.000000] Kernel command line:  ignore_loglevel 
>>>>> console=ttyMSM0,115200n8 earlycon root=PARTLABEL=rootfs rootwait 
>>>>> systemd.mask=pd-mapper.service -- 
>>>>> androidboot.bootdevice=4744000.sdhci androidboot.serialno=2b89b520 
>>>>> androidboot.baseband=apq 
>>>>> msm_drm.dsi_display0=qcom,mdss_dsi_ext_bridge_1080p:
>>>>> [    4.074354] 4a8c000.serial: ttyHS1 at MMIO 0x4a8c000 (irq = 140, 
>>>>> base_baud = 0) is a MSM
>>>>> [    4.099410] serial serial0: tty port ttyHS1 registered
>>>>> [    4.131200] Bluetooth: hci0: setting up wcn399x
>>>>> [    4.149847] 4a90000.serial: ttyMSM0 at MMIO 0x4a90000 (irq = 
>>>>> 142, base_baud = 0) is a MSM
>>>>> [    4.229099] printk: legacy console [ttyMSM0] enabled
>>>>> [    6.499519] Bluetooth: hci0: command 0xfc00 tx timeout
>>>>> [    6.514347] Bluetooth: hci0: Reading QCA version information 
>>>>> failed (-110)
>>>>> [    6.559933] Bluetooth: hci0: Retry BT power ON:0
>>>>> [    8.016330] systemd[1]: Created slice Slice /system/getty.
>>>>> [    8.066194] systemd[1]: Created slice Slice /system/serial-getty.
>>>>> [    8.148389] systemd[1]: Expecting device /dev/ttyMSM0...
>>>>> [    8.956804] Bluetooth: hci0: command 0xfc00 tx timeout
>>>>> [    8.962447] Bluetooth: hci0: Reading QCA version information 
>>>>> failed (-110)
>>>>> [    8.976917] Bluetooth: hci0: Retry BT power ON:1
>>>>> [   11.296715] Bluetooth: hci0: command 0xfc00 tx timeout
>>>>> [   11.302340] Bluetooth: hci0: Reading QCA version information 
>>>>> failed (-110)
>>>>> [   11.309534] Bluetooth: hci0: Retry BT power ON:2
>>>>> [   13.660078] Bluetooth: hci0: command 0xfc00 tx timeout
>>>>> [   13.665814] Bluetooth: hci0: Reading QCA version information 
>>>>> failed (-110)
>>>>
>>>> Sure, will check and update.
>>>>
>>>> If possible, can you share what is DT filename for RB2.
>>>
>>> qrb4210-rb2.dts
>>
>> Can you please try below change on target since i didn't get target yet?
> 
> Yes, I have this patch too. It didn't help.

As we discussed offline, On the RB2 target, Bluetooth fails during 
bootup but functions correctly once bootup is complete.

I suspect that GPIO configurations are being affected during the bootup 
process, possibly due to the wakeup registration sequence.

To address this, I have moved the wakeup registration process to occur 
before enabling PM runtime.

Could you please try below change and let me know result?

diff --git a/drivers/tty/serial/qcom_geni_serial.c 
b/drivers/tty/serial/qcom_geni_serial.c
index 6ce6528f5c10..46a9c71630d5 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1888,12 +1888,6 @@ static int qcom_geni_serial_probe(struct 
platform_device *pdev)
         if (ret)
                 goto error;

-       devm_pm_runtime_enable(port->se.dev);
-
-       ret = uart_add_one_port(drv, uport);
-       if (ret)
-               goto error;
-
         if (port->wakeup_irq > 0) {
                 device_init_wakeup(&pdev->dev, true);
                 ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
@@ -1906,6 +1900,12 @@ static int qcom_geni_serial_probe(struct 
platform_device *pdev)
                 }
         }

+       devm_pm_runtime_enable(port->se.dev);
+
+       ret = uart_add_one_port(drv, uport);
+       if (ret)
+               goto error;
+
         return 0;

Thanks,
Praveen Talari
> 
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/ 
>> boot/ dts/qcom/qrb4210-rb2.dts
>> index 0cd36c54632f..5f8613150bdd 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> @@ -694,7 +694,7 @@ sdc2_card_det_n: sd-card-det-n-state {
>>
>>   &uart3 {
>>          interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> -                             <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
>> +                             <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
>>          pinctrl-0 = <&uart3_default>;
>>          pinctrl-1 = <&uart3_sleep>;
>>          pinctrl-names = "default", "sleep";
>>
>> Thanks,
>> Praveen Talari
>>
>>>
>>>>
>>>> Earlier I had validated on RB1 and Kodiak.
>>>>
>>>> Thanks,
>>>> Praveen
>>>>
>>>>>
>>>>> After reverting the next and this patches, BT is back to normal:
>>>>>
>>>>> [    4.067201] 4a8c000.serial: ttyHS1 at MMIO 0x4a8c000 (irq = 140, 
>>>>> base_baud = 0) is a MSM
>>>>> [    4.082426] serial serial0: tty port ttyHS1 registered
>>>>> [    4.106122] 4a90000.serial: ttyMSM0 at MMIO 0x4a90000 (irq = 
>>>>> 142, base_baud = 0) is a MSM
>>>>> [    4.108647] Bluetooth: hci0: setting up wcn399x
>>>>> [    4.125371] printk: legacy console [ttyMSM0] enabled
>>>>> [    4.445205] Bluetooth: hci0: QCA Product ID   :0x0000000a
>>>>> [    4.450927] Bluetooth: hci0: QCA SOC Version  :0x40020150
>>>>> [    4.456470] Bluetooth: hci0: QCA ROM Version  :0x00000201
>>>>> [    4.462006] Bluetooth: hci0: QCA Patch Version:0x00000001
>>>>> [    4.509408] Bluetooth: hci0: QCA controller version 0x01500201
>>>>> [    4.515656] Bluetooth: hci0: QCA Downloading qca/apbtfw11.tlv
>>>>> [    5.488739] Bluetooth: hci0: QCA Downloading qca/apnv11.bin
>>>>> [    5.671740] Bluetooth: hci0: QCA setup on UART is completed
>>>>> [    7.993368] systemd[1]: Created slice Slice /system/getty.
>>>>> [    8.045612] systemd[1]: Created slice Slice /system/serial-getty.
>>>>> [    8.125418] systemd[1]: Expecting device /dev/ttyMSM0...
>>>>>
>>>>>
>>>
>>>
>>
> 
> 

