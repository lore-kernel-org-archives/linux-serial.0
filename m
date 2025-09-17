Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E871258ED7
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079585; cv=none; b=o6l887TOxmxirxcZrVbrzf6/9aARpB3QacISuqfxHPc2pfuiLGLZBFwGHociq/pi/EArYsEoiNii++xlelMTKJT6m9xVTndKEUMsBkNQQukb/2+rkq/fHyrSSxpzvYpTS9q66+b1Qzj6amQP9D01UDx9OREp8kiS02QXQxZ5hF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079585; c=relaxed/simple;
	bh=8ts0F0K+Jc0lwgkQ/xSNE7ECANa/vNb5ZeLpV9g8uWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEOZPttVQvI2h2iuBCDRlWfS3ztTL7NaB7tNpknKoRfri33Vv+PnbXzrsd+CgCMg20o9Iv8lmQHwX2HlvLoMxaEbM+x3nr3w1cdc8dsL/jjSG+/RYzVNE5P01nWY9q732xaiquKdt01wuq+TUuSSvM00uwSxWzbWknGlOmTs7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFbCT5Ae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFbCT5Ae"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLc4OW024415
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 03:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D5Ze7fBfF5bOpW6nOK7lzrEeHW+SnZky8WuncUBAOwc=; b=gFbCT5AeCRUdBBGv
	tavMaaYdL3ZCkhRk6bXBiqC9F5Pjt/vWaEQUVlFlmrn0zzKHDaMXqsruzNiHORR7
	XCJz2fEEgFsVQoeiIjBvbjka/VxuV06fuh1CfD8bHbI/Ovv2rn9zBX165s5zgD0L
	LDwVhlCQ5uBx812XeKUcx/HixfYI1yiJbvUqD8v+Z1aHI3awA7HRh29SmGZdrGEe
	Aj409MEPJMS/89nW0jVUtc+hCpV7rDU8Eng3CCBKLlLtxb36Ww4qp4Bg1AQwgMPh
	LurbBqJmeH30XKQusx+Daskw7Lee/m1u8EE9xRK+kSiY/jxVi/DMtr8zo4Qq0A0N
	9/J6EQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxygqxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 03:26:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25177b75e38so73087885ad.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 20:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079582; x=1758684382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Ze7fBfF5bOpW6nOK7lzrEeHW+SnZky8WuncUBAOwc=;
        b=oxhnczidlVl7Z44Bybr9xbFWf/u7TRemESq/lxjNcIhwTO8De3kaz7hA8nxOJV4HB3
         zRgMmNhka38wEpjiY0IX6g2x/CsgEpbDkuBw4fvnjB37KLHgYowbde/EFOoozrSHM3I/
         iSYVbUqyRTbGHa5FvtxSuD5j5oXXEHlvPgSFRfizE01LCrhYQOQFFW6oGlr0bi+3C34P
         tJHTjY3XPQazgG1Vy0msgo2zn8Us2e3dN/Te1Nk7kvi+ijrlNfuk1hbMSXCOMoVaykD6
         CbDgBeYW/ntizznvdPfW8feqTDXWjiNjRG8qzxLfuiWYzNLVFsyof7ch/MvSeuoG7Kiw
         +CKg==
X-Forwarded-Encrypted: i=1; AJvYcCXu0dhnfOrcHgzMMFV4uZvsh/ULnNtU6vsnPddjeG8aq+vYwyyG+osC440LhhITYGzmwH6Dq7mgmb63C3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdhDSTq3hU9RXW01fCxWgFD6JGK9+f5xiTUw/t8G0nX0NuaN6
	ozno1wedeSglW4L87sKcVfUvubLe6e3oDzS9B3IC5rIR2bfoCtt8stnqMp6CTGTsbpECJsyF9lu
	g7Ah2/9eOH4K1BTcBGzk8XJo6MM6AXqz79xuUw6JGJleKFYYOEuFmmiwh/BOuOChQAoU=
X-Gm-Gg: ASbGncvJgsw91vHkvKamOuxnzioDTKYQjxx/wERKHRBsewKMd6vqtZ5vnt7kcbV3kGs
	0gaL4sCJN2gvG5HapJ594/X+Xs6qMH+bM7cy+AJ5gkJdO9fP90IsX8ynyqB8v6kBuTp3lzGpyQS
	d5nAFP45wq7yFXut72oFodsqtyv1P+cMiYxRAfwgCk71jfuYwm9Vb3ansutUrWcKr4OolcauLMY
	HPx12pVESgPyrYar3FwNmFWzu+ZGZOoTv1N05L6jUPbzATMMKOYTz3DU9WXqTr2h2pL/L4tGkRh
	fpts6TdJIPcnLf7QSw4mnF4/vdgRUx1dJ7BNl7NCWja5LFAh/wRz5Rx84ca2/4l99MALc98j
X-Received: by 2002:a17:902:f548:b0:267:a5df:9b07 with SMTP id d9443c01a7336-268118b95c2mr8163655ad.12.1758079582144;
        Tue, 16 Sep 2025 20:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqu8JXr3DLXFVqyhAiPyWwY3CsgpScBJki2HbdMSZofPzvbaZpZpPop/u36XjzDnXudTckuQ==
X-Received: by 2002:a17:902:f548:b0:267:a5df:9b07 with SMTP id d9443c01a7336-268118b95c2mr8163265ad.12.1758079581517;
        Tue, 16 Sep 2025 20:26:21 -0700 (PDT)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267de22b719sm28237545ad.85.2025.09.16.20.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:26:21 -0700 (PDT)
Message-ID: <7f0e6f0b-942f-4903-bee6-9c8f6ab5ec36@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 08:56:14 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com, krzk@kernel.org
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
 <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
 <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
 <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
 <aMl2hOYTjBuCo4AM@trex> <aMl9Fbuyq7hdXvQC@trex>
 <DCUE5AXJ99BG.150SRQMY7EJG6@linaro.org>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <DCUE5AXJ99BG.150SRQMY7EJG6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68ca2a5f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=3zEiWGLsQ94HuRbx9vcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QydfIcaderxty1eiiW0GxJkS2W3sm0t0
X-Proofpoint-ORIG-GUID: QydfIcaderxty1eiiW0GxJkS2W3sm0t0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9C3NfqsacFWR
 rn1jqQAo2CsAYHuUBiksI8jmRv4UtpRwqkhkv+B1yVcHf4t6optFQe0Y0PskayfsWZHP/n0x3MH
 QE9v6MoqCL/8AFjQgTGkCHjE4i41GMUW8b2ezPgddusuPfsRi8PbuAw8N2OrDKBaQFF5jmJFip5
 1oLKhEBhzeXyAw4aUuso6BVxQ5LY6aqtDmTOU34A0KULs95HVjXxxvuDc9ybVFpc7sYlw76nG9f
 GVP38mv4dZPr/WCB4gCKAdP4UBvikmc2rGicwOb/lpF6xBKGC5tX8TpJdQ8MwMUov2enef1VtdR
 Xql02On9P6V0GI/8/ITY7MuGFm6xJ+plN1/gmb3sZLS2uSScejYy34GoqIa/OmGznPoetchf5Hr
 MFDJ3LSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Alexey,

On 9/16/2025 10:42 PM, Alexey Klimov wrote:
> Hi Praveen,
> 
> On Tue Sep 16, 2025 at 4:07 PM BST, Jorge Ramirez wrote:
>> On 16/09/25 16:39:00, Jorge Ramirez wrote:
>>> On 16/09/25 12:20:25, Praveen Talari wrote:
>>>> Hi Alexey
>>>>
>>>> Thank you for your support.
>>>>
>>>> On 9/15/2025 7:55 PM, Praveen Talari wrote:
>>>>> Hi Alexey,
>>>>>
>>>>> On 9/15/2025 3:09 PM, Alexey Klimov wrote:
>>>>>> (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not
>>>>>> delivered)
>>>>>>
>>>>>> Hi Praveen,
>>>>>>
>>>>>> On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
>>>>>>> Hi Alexey,
>>>>>>>
>>>>>>> Really appreciate you waiting!
>>>>>>>
>>>>>>> On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>>>>>>>> Hi Praveen,
>>>>>>>>
>>>>>>>> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>>>>>>>>> Hi Alexy,
>>>>>>>>>
>>>>>>>>> Thank you for update.
>>>>>>>>>
>>>>>>>>> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>>>>>>>>>
>>>>>>>>>> (adding Krzysztof to c/c)
>>>>>>>>>>
>>>>>>>>>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>>>>>>>>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>>>>>>>>>> A deadlock is observed in the
>>>>>>>>>>>> qcom_geni_serial driver during runtime
>>>>>>>>>>>> resume. This occurs when the pinctrl
>>>>>>>>>>>> subsystem reconfigures device pins
>>>>>>>>>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>>>>>>>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>>>>>>>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>>>>>>>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>>>>>>>>>> leading to system instability.
>>>>>>>>>>>>
>>>>>>>>>>>> The critical call trace leading to the deadlock is:
>>>>>>>>>>>>
>>>>>>>>>>>>         Call trace:
>>>>>>>>>>>>         __switch_to+0xe0/0x120
>>>>>>>>>>>>         __schedule+0x39c/0x978
>>>>>>>>>>>>         schedule+0x5c/0xf8
>>>>>>>>>>>>         __synchronize_irq+0x88/0xb4
>>>>>>>>>>>>         disable_irq+0x3c/0x4c
>>>>>>>>>>>>         msm_pinmux_set_mux+0x508/0x644
>>>>>>>>>>>>         pinmux_enable_setting+0x190/0x2dc
>>>>>>>>>>>>         pinctrl_commit_state+0x13c/0x208
>>>>>>>>>>>>         pinctrl_pm_select_default_state+0x4c/0xa4
>>>>>>>>>>>>         geni_se_resources_on+0xe8/0x154
>>>>>>>>>>>>         qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>>>>>>>>         pm_generic_runtime_resume+0x2c/0x44
>>>>>>>>>>>>         __genpd_runtime_resume+0x30/0x80
>>>>>>>>>>>>         genpd_runtime_resume+0x114/0x29c
>>>>>>>>>>>>         __rpm_callback+0x48/0x1d8
>>>>>>>>>>>>         rpm_callback+0x6c/0x78
>>>>>>>>>>>>         rpm_resume+0x530/0x750
>>>>>>>>>>>>         __pm_runtime_resume+0x50/0x94
>>>>>>>>>>>>         handle_threaded_wake_irq+0x30/0x94
>>>>>>>>>>>>         irq_thread_fn+0x2c/xa8
>>>>>>>>>>>>         irq_thread+0x160/x248
>>>>>>>>>>>>         kthread+0x110/x114
>>>>>>>>>>>>         ret_from_fork+0x10/x20
>>>>>>>>>>>>
>>>>>>>>>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>>>>>>>>>> runtime suspend/resume callbacks. In the
>>>>>>>>>>>> runtime resume callback, call
>>>>>>>>>>>> disable_irq_wake() before enabling resources. This preemptively
>>>>>>>>>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>>>>>>>>>> interrupt management calls to proceed
>>>>>>>>>>>> without conflict. An error path
>>>>>>>>>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>>>>>>>>>
>>>>>>>>>>>> Conversely, in runtime suspend, call
>>>>>>>>>>>> enable_irq_wake() after resources
>>>>>>>>>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>>>>>>>>>> source only once the device has fully
>>>>>>>>>>>> entered its low-power state. An
>>>>>>>>>>>> error path handles disabling the wakeup IRQ
>>>>>>>>>>>> if the suspend operation
>>>>>>>>>>>> fails.
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 1afa70632c39 ("serial: qcom-geni:
>>>>>>>>>>>> Enable PM runtime for serial driver")
>>>>>>>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>>>>>>>
>>>>>>>>>>> You forgot:
>>>>>>>>>>>
>>>>>>>>>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> Also, not sure where this change will go, via
>>>>>>>>>>> Greg or Jiri, but ideally
>>>>>>>>>>> this should be picked for current -rc cycle since regression is
>>>>>>>>>>> introduced during latest merge window.
>>>>>>>>>>>
>>>>>>>>>>> I also would like to test it on qrb2210 rb1 where this regression is
>>>>>>>>>>> reproduciable.
>>>>
>>>> Since I don't have this board, could you kindly validate the new change and
>>>> run a quick test on your end?
>>>>
>>>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> b/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> index 83eb075b6bfa..3d6601dc6fcc 100644
>>>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> @@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev
>>>> *pctldev,
>>>>           */
>>>>          if (d && i != gpio_func &&
>>>>              !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
>>>> -               disable_irq(irq);
>>>> +               disable_irq_nosync(irq);
>>>>
>>>>          raw_spin_lock_irqsave(&pctrl->lock, flags);
>>>
>>>
>>> sorry Praveen, didnt see this proposal. testing on my end as well.
>>>
>>
>> just tested on my end and all modules load - deadlocked before this
>> update so there is progress (now we can load the network driver)
> 
> Is it supposed to be orginal patch here plus disable_irq_nosync()?

Only this disable_irq_nosync() change from pinctrol subsystem.

Thanks,
Praveen Talari
> Meaning changes for qcom_geni_serial_runtime_{suspend,resume}
> + disable_irq_nosync() in msm_pinmux_set_mux()?

No, only disable_irq_nosync() in msm_pinmux_set_mux().
> 
> It seems to work here but let me know few more runs.
> 
> Best regards,
> Alexey
> 
> 
> 
