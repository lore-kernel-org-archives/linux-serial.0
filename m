Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA6328246
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794901; cv=none; b=SFTjixu2+/lQA0qyK9D3ab4HvDRRpyNbi6Espvy56PQeeDI/L33xDk5Wc2oE8PAnv4VOor+B0+sd89vggqP2PPG+cJcUYH6y1IFMf2Qd/I/V0OlYV5LTn+k7MSFOfsUeRCFlmOyIYmTRWvQn+SZq3VgyOGxq1nf9yon00p/k53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794901; c=relaxed/simple;
	bh=aUCtRXbaqhLdP8PIW7MMmYazfgZB3Ep36B3bliuTmQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTBLDhc2yjXMxb3TX8tKYBb7tsG8QOLBI0zQQjB7WiQxvQA5IOojXczaIuWzFW5t0PDroxeFjDgdnl8uAApIItOIm9XJPCDol7V7H3U/7A1bGMOK6SIgjDVBePWSN/Yux60hsndUkkEKmSfOo3IrM+OEdETZBtnGI3wWbSzOVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JI2U+wqC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gJ1KjV/S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JI2U+wqC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJ1KjV/S"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079ewNb2988925
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 14:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e/IXkgAHOqxTc8Sm3PgN43SHcMF+5VzPKwHvaU0kjnE=; b=JI2U+wqC/iFxxc8R
	L/iKo1Qrz+Ay5O8IESB0nb7pHECoJto3/EQwx91fcwaqPKoH7HOaIkgBeQKI8Sg0
	cA4oX9yzfRZOZ215PAxaeixWu25xJ3nw1QijlDh+sQlTldrvrym82klJzHFmC53M
	QiuL7/VRZyCn3kkxhCMUChWgU7YBzoa0otOfm8b1GNtU5U+Lq2ZmkNY7jCjvD5zj
	ZLMnObvvOZ0aMrzgVRy+vjVLwv4W0WQoSTKftN5qUNI103rxQSmJ8ZP8bOlC+PBj
	EyVkroFZ9qsATt08EBi/l71KDZHZteosKOt9TY0y0okvstN/SgYLE4JN3N7XnAiu
	qwdEEA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2nrrng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 14:08:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so1789297a12.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 06:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767794897; x=1768399697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/IXkgAHOqxTc8Sm3PgN43SHcMF+5VzPKwHvaU0kjnE=;
        b=gJ1KjV/S/EkJw2+xV6Zn+7J+xd7N0xxMCvKxvy4MV5C4U6BOlBQ4r8IQBAgtjd0yfJ
         7GVMV/HFPkzLDarqn0nq7bCMjuA/3LYyhSfk0oyHwfopgFkTbCNZ9dKKlw+QZS10U+q4
         hOuD9aLpfUZNiOa74Hkx5IuWHBZ0lDNa7Ktu8BkbFBJpOnvYDtcQbh6HYT5jnJK/WoX+
         E/W7H8CnOzgoNPOPlkCabhL5H2zNJkfhnrholemjb+48Uo+5FAZ+M7a0oHFArGzErxiO
         /fJmZ9BJUZebTCsw1vj4pzJ9/SwfPmfsgc8ziFkxBshXF9U6Pl532hyTgTg/LLcngjOs
         10Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794897; x=1768399697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/IXkgAHOqxTc8Sm3PgN43SHcMF+5VzPKwHvaU0kjnE=;
        b=PPKrJC78Bsn0Xb7uom/MLHu/VmeRGyEhsY6axgjYDVrIo+YMkVOqYBTUKRtI1ohYtZ
         o94ZrHuKLduf88xmJd/dXYadGcN3hsyS3Q+iF4hpShbqKs+zGKLbWRnCkDcoIuNCxceE
         d1a12s8LTaeHXYnaPaz1B4ZBtV3vSOeNSt8uJEwjdvCVASCTopRX4Bjmtn/uIrIOlnUm
         ubQQcSHvNB2dz7OD48NSCGIEqONWnZ15bicyhaKxanuaNfJz1q5Wbq6R7xd017WF6wwv
         TK+Qz5rfNqEVq7ORYR2ohcX1+0N5RV95Ac/ch4ovBhyz5zOjg00s9IvSYC253DadVqKy
         B5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp1UwYc1QIZvFfeBhSpVNi3vBCpz1aP6Hru1JzJOnSm62MPN1tvSZ7UEYmk9JSZ/2pkI5FyDfPNPuTRM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSlVSe4E9K82W3ONG4WL4emk40yWtJqidu/oPZ/C4JSrUuoaa
	9aAti22YP8PYFwyfdPQneu/Gipy0AkJgoTKwZIsu4AcTJ4SwfHU8Yb++OkbKp0/n/wT8BXKOfqM
	9pjm2R6Q8wtxrylwALtiSojHPKA5iZZx6Ww4IhzY28VqOpGxlr/9HygtKoTcX+hDfq9U=
X-Gm-Gg: AY/fxX74eciIgxigkeEj/zRn9MCYcbXgFS8Sg/Ar6A2gb7tC5aRrDqctuSvyBXbxbRX
	p42CN6A2Gngm644u4g+12ywYDEuXyNe3/C/3EbUYwrkW5WSsVul2GsgKJOmIm28iN4Y2LaEpRKU
	PzQ5VGytLXC47wu1UeHS7LhnvLbpCzfldfWj1i6vVJy85EyZaZsS1t6mfJ5InaHxL6C8Nr7oH3d
	OrBZXxs8bof/Kx8BdeIENFLLSlxjkIJ4IiHVurQyakcNEnlEQaHWjzRJkB9h0q6osYP/RkSoOF6
	TUWRPaePj7hYKmjSBtWoHYcG35mgwzRv+PqeXxVeUckaD+XrLw1YRpl3pycT0zVUKF6E0ECaLfH
	PQDpzHFQ5MMbhm1K7R7yatKMvGsBcUHFFmkhVTzii
X-Received: by 2002:a05:6a00:4147:b0:7f6:4a1f:68a9 with SMTP id d2e1a72fcca58-81b7f104474mr2377010b3a.23.1767794897400;
        Wed, 07 Jan 2026 06:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrMqnbFrD/Ogjw6q/skADffcb23oZB8dneueWX+1jX467c2sCRc7k7ahqEDUlcFmFEg60wnQ==
X-Received: by 2002:a05:6a00:4147:b0:7f6:4a1f:68a9 with SMTP id d2e1a72fcca58-81b7f104474mr2376978b3a.23.1767794896804;
        Wed, 07 Jan 2026 06:08:16 -0800 (PST)
Received: from [192.168.1.2] ([49.204.107.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa19242sm5174447b3a.7.2026.01.07.06.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:08:16 -0800 (PST)
Message-ID: <db421081-7e23-4088-91fc-8d6aa83931aa@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 19:38:10 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2
 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
 <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
 <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
 <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
 <36d8fb98-562a-43dc-8b47-b4f6d29475f1@oss.qualcomm.com>
 <c0fd52a2-56a8-47cc-ad40-8c14c269445b@oss.qualcomm.com>
 <741df2ea-03fd-4af2-9a98-20d68658edcb@oss.qualcomm.com>
 <xrghvkbjc6cd6uk7qyvxylgr3veqsfbrjr7palmqqzhfvknb57@h4wvly7zzwa2>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <xrghvkbjc6cd6uk7qyvxylgr3veqsfbrjr7palmqqzhfvknb57@h4wvly7zzwa2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwOSBTYWx0ZWRfX2yTOY+BArn+X
 8lHKzX67RvzKP5+XfNvZTE4wU87tp0duH+AZcxnWnZeoYE76QNh8kUUXihDF2SBfeej+mW/AIGU
 OVM/nlXf96aTqeD0GVssy6ORoydzVvIm87LL6vx+ayKG6qUlWTZFx2E7Vozy3D9WM+VSLD8lU6d
 wLBFMIwThSB6uq3+9eYk6T/Qcc0faZxNjiDNf3FbbCFLtTygtgqfopLgUDtfBDWgfAhYh3IGX3Z
 3JUs4OR2iLBMDYRMcD5+SpzQChky4RRtf2qelQLXjhRf7wvLj3sm4hpkpbcAjmjorW86/NB7xRm
 CaWkjy9Uay6qn913CA7feIVA7mo8nPpTlDstFql1BZGJfuAx1NQ+RLmT63cMSdPmYrgmLuo2Uky
 XGicxQznSysbQKsG1NZSqXFvoPU3sMWcu5PkGc2OSzx+3QC67xhMIjkSX4ygY/ZyQHp+wnoF/Dc
 19El8GeOsbUcshhlUxg==
X-Authority-Analysis: v=2.4 cv=CYEFJbrl c=1 sm=1 tr=0 ts=695e68d2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=+gEgXnvjvgnLECGlQBulyQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TCUISvXNB3W53Fu2B-YA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: rHDOfn9efUUALUkEwayauvD0uDxVkCsW
X-Proofpoint-ORIG-GUID: rHDOfn9efUUALUkEwayauvD0uDxVkCsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070109

Hi Dmistry,

On 1/7/2026 5:05 PM, Dmitry Baryshkov wrote:
> On Wed, Jan 07, 2026 at 04:28:22PM +0530, Praveen Talari wrote:
>> Hi Konrad,
>>
>> On 1/7/2026 4:16 PM, Konrad Dybcio wrote:
>>> On 1/7/26 10:24 AM, Praveen Talari wrote:
>>>> Hi
>>>>
>>>> On 1/7/2026 12:52 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, 7 Jan 2026 at 09:06, Praveen Talari
>>>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Hi Dmistry,
>>>>>>
>>>>>> On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
>>>>>>> On Wed, 7 Jan 2026 at 08:48, Praveen Talari
>>>>>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> A regression in linux-next causes Bluetooth functionality to fail during
>>>>>>>
>>>>>>> linux-next is an ephemeral thing. Please reference the exact commit.
>>>>>>>
>>>>>>>> bootup on the RB2 platform, preventing proper BT initialization. However,
>>>>>>>> BT works correctly after bootup completes.
>>>>>>>>
>>>>>>>> The issue occurs when runtime PM is enabled and uart_add_one_port() is
>>>>>>>> called before wakeup IRQ setup. The uart_add_one_port() call activates the
>>>>>>>> device through runtime PM, which configures GPIOs to their default state.
>>>>>>>> When wakeup IRQ registration happens afterward, it conflicts with these
>>>>>>>> GPIO settings, causing state corruption that breaks Bluetooth
>>>>>>>> functionality.
>>>>>>>
>>>>>>> How does it "conflict with GPIO settings", what is "state corruption"?
>>>>>>
>>>>>> I mean the issue occurs because the GPIO state is being altered during
>>>>>> the wakeup source registration process..
>>>>>
>>>>> Altered how?
>>>>
>>>> During the runtime resume of devices, GPIOs are configured to QUP mode. However, when registering the wakeup IRQ using dev_pm_set_dedicated_wake_irq(), these GPIOs are reset back to FUNC mode, which impacts the RX GPIO and leads to Bluetooth failures
>>>
>>> "QUP mode" and "FUNC mode" are tough to swallow even for an insider.. How
>>> about:
>>>
>>> "qup_x" and "gpio" pinmux functions
>>
>> Yes, you are right. I am talking about "qup_x" and "gpio" pinmux functions
> 
> => commit message, please.

I hope the commit text below should be appropriate

serial: qcom-geni: Fix BT failure regression on RB2 platform

A regression in 6.19-rc1 causes Bluetooth functionality to fail during 
bootup on the RB2 platform, preventing proper BT initialization. 
However, BT works correctly after bootup completes.

The issue occurs when runtime PM is enabled and uart_add_one_port() is
called before wakeup IRQ setup. The uart_add_one_port() call activates
the device through runtime PM, which configures GPIOs to the "qup_x"
pinmux function during runtime resume. When wakeup IRQ registration
happens afterward using dev_pm_set_dedicated_wake_irq(), these GPIOs
are reset back to the "gpio" pinmux function, which impacts the RX GPIO
and leads to Bluetooth failures.

Fix this by ensuring wakeup IRQ setup is completed before calling
uart_add_one_port() to prevent the pinmux function conflict.

Thanks,
Praveen

> 
>>
>> Thanks,
>> Praveen Talari
>>>
>>> ?
>>>
>>> Konrad
>>
> 

