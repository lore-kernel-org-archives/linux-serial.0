Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB772C2AA2
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005437; cv=none; b=a3iO2sktiZGYCR2vEAJM+Mz4vs8hAbxV/fiC9IrX7vyxVVm8tqD97IgRlmVyx9dq81Waiy2V6xNv8wrHobwj/GecULpzea1pvnTgIRAyTDpk3Zmmjplo73RZ2TSBCNiTqbHX0cPPFpq0GZ4dCn/C7EAlBt8aRBb4KcvH/cbPDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005437; c=relaxed/simple;
	bh=OF3Z6JTpqwAGp4ALlt70tBmxILbTLbh7N6+wFvceDHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X71nG2J8pdv3mmnqJJBklNfFMDBayEuvJImZJeajccbnDZ6h6BOpjPHglf/p1zarHhc0ECruZ2RNs0WEqk/u17IH+E12KTdaS6xQGwuTMl/amFWglFCvn7q/wh74dwyZYHAfAy5W7Um3IadrH0jJ3yyLcVSiNDHkLq/RMOROAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=URQ3lxZ+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="URQ3lxZ+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pfTN013874
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 06:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iWG4oHvP3QY8AxCWdjd0av4Ag/aQ5pK2Kf0g8jhrl6g=; b=URQ3lxZ+OBq0ooi7
	eghWbYZFhc1n30hDWC7XNKqmDpPQnvg3O9d2pWNqNGzrYrLZwnd5AshDLpO+lX4i
	eueXFXfHpFYz9FvA5vfqf+tbrnZLvxozEd2VTIIGhIJx5FiqncV+veRxK4yY+Y/X
	zEX8bq0tJkS2/viaL/es1IvWIHXp9WDrt0esL+Hn8DOGe0uMwukSZTbAKkkIAYwh
	TOtnGKiE23qcSawtHGxL0QLNFtbY1yCWyiNjJcFQihIsvWLuHlZDZv5uYhAqx4bi
	Zjq+qMz5MmZXQ0mq6i92nWpv9NRWdllufB1EtGltejy2DLSmbQc46v6cX5X7pKT5
	3GIU3w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5arv9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 06:50:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso163531a91.0
        for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 23:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758005433; x=1758610233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWG4oHvP3QY8AxCWdjd0av4Ag/aQ5pK2Kf0g8jhrl6g=;
        b=XedzQnAmhCoqxMaQMrAXhH4M9IIrjCN7ZshameEgKyA2D5sl5BDeOux+xv+klQf+cl
         UsrrBUItdPZpG9HFe8GA5szQoZM2dTIBF9eipMCIy5yEdDi85dJE5xBHq4Y1ntZyM6gw
         FlzKRJQP0L6TCnfpDfoqQFSp1+y6zXGoTDnl3YgOShynz3tO6wkRuX6asZYnVAvUAAmP
         rclUFwMhZav8WW6znNBJqjppSZOOkSqyDdRsSbbJ3HPjqfFMadShxgU+v9fD3padKtH0
         HBJXyRjr6MwxONfxlx3ZEdXhbRREBG5dUpnV2/IOdC1mwLvkv1CoFuOFcUXjFGTpvRHe
         +3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW7dY+4uDLsoFt3Im44+Fg/OHzuncU8tdJL5sOdLBcwpum9BqmxiRRPW1fthNPqbpdUMyueG/FEUAD/NeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIm84s2Yc3OmakUbHUFUHVBXs6WNTXXUOBqUu33RCit/M2K9s
	b1t1P8qwQOlMCEdTws4E6epBcIgXJHEhjkv5OPaQZ5QfXAHTz/JMiHy584gX/T587qam8UPE4GK
	q/CYsBv2l4EXJebXqVmrkLhek9EAxgkyg0k17o/yw96PHLsTEfQvX/w7c7EDLvzkzOYo=
X-Gm-Gg: ASbGncuVRZR9hQtMFQ7hCzAckQarum7JTz7INLVj1UMGrCjtavhIfAwli+KAdWwRpRd
	gJa2FHSIReDuidQlzZgF1JjxAh0/6W1H+PtKbiMsJjJyh7MW37WDxLRps6A2xoWDwJJVZmzZjm8
	D8Nhi7WxIHri4NT0lRLw3VBjGA2TU8FlyV2n5m4moBCUlRLXiEcXJ3pRaJ8kzfkZW9kFB5zZbv4
	iglvGIQf1OY5cdRPFKI/Jlr596V6Y3p93kSCd/tTsWN/Fl5OYioQ6LuAhAPo7iHEs2jjdE8fvST
	Y58lRfCpC6vIXeNz4eoLdt2+0lwqD4qCwJai9A+bzkf/7Tt8yBA/3kyY8oWmovrORbUfbGil
X-Received: by 2002:a17:90b:17cc:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-32de4fba10dmr17377594a91.37.1758005432764;
        Mon, 15 Sep 2025 23:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCY/ewJDGDES+dHaJGhTd3hFYC1q7+f3lDzEWsOFX38BUWzF4eqA/fft1uMJlKaXz92ameA==
X-Received: by 2002:a17:90b:17cc:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-32de4fba10dmr17377555a91.37.1758005432070;
        Mon, 15 Sep 2025 23:50:32 -0700 (PDT)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54dd63d5e5sm1323688a12.4.2025.09.15.23.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 23:50:31 -0700 (PDT)
Message-ID: <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 12:20:25 +0530
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Tq4-oKYo922yHVe5I4pPf_745q6iC6wm
X-Proofpoint-ORIG-GUID: Tq4-oKYo922yHVe5I4pPf_745q6iC6wm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX9D4dQ7/rvupb
 OY1IcnqRT+IbSE6E3lbZosL3NzGtxRGKkoJf4xIkv8UBPKV4fLg5RKnhByPtWraoRMxFDvcmdjt
 P5otpu8AYVh9Sq0XyDMjNKs167enifdZqGqX4IgCnfeGzZ4j2SfMqTzXeFa0NsqRyF8shHU2CoB
 JpokB1XKwpH7FtyqmzxIbFIS1dlHg+A5iLWGwG4t5c2HV7yfW7xiLeVp4lhLEYpZ1JU83dhrhUz
 B3XPIo2Cvy5p5p1u8GQYmGNt7fScSnfndClHmnUYegM89vDlGqaKWjXTYgQm85vy6fb4BfTjsZn
 xPT84j2Vvyx6SHbO88ZeQknX4V/g4B4obK6hQOzX55JKyz8sjVsxuBdyOEsGAO3as3ULZqSwyj+
 bkSMXzGA
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c908ba cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=USV9S7RF8LqPzhi85t0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

Hi Alexey

Thank you for your support.

On 9/15/2025 7:55 PM, Praveen Talari wrote:
> Hi Alexey,
> 
> On 9/15/2025 3:09 PM, Alexey Klimov wrote:
>> (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not 
>> delivered)
>>
>> Hi Praveen,
>>
>> On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
>>> Hi Alexey,
>>>
>>> Really appreciate you waiting!
>>>
>>> On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>>>> Hi Praveen,
>>>>
>>>> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>>>>> Hi Alexy,
>>>>>
>>>>> Thank you for update.
>>>>>
>>>>> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>>>>>
>>>>>> (adding Krzysztof to c/c)
>>>>>>
>>>>>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>>>>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>>>>>> A deadlock is observed in the qcom_geni_serial driver during 
>>>>>>>> runtime
>>>>>>>> resume. This occurs when the pinctrl subsystem reconfigures 
>>>>>>>> device pins
>>>>>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>>>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>>>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>>>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>>>>>> leading to system instability.
>>>>>>>>
>>>>>>>> The critical call trace leading to the deadlock is:
>>>>>>>>
>>>>>>>>        Call trace:
>>>>>>>>        __switch_to+0xe0/0x120
>>>>>>>>        __schedule+0x39c/0x978
>>>>>>>>        schedule+0x5c/0xf8
>>>>>>>>        __synchronize_irq+0x88/0xb4
>>>>>>>>        disable_irq+0x3c/0x4c
>>>>>>>>        msm_pinmux_set_mux+0x508/0x644
>>>>>>>>        pinmux_enable_setting+0x190/0x2dc
>>>>>>>>        pinctrl_commit_state+0x13c/0x208
>>>>>>>>        pinctrl_pm_select_default_state+0x4c/0xa4
>>>>>>>>        geni_se_resources_on+0xe8/0x154
>>>>>>>>        qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>>>>        pm_generic_runtime_resume+0x2c/0x44
>>>>>>>>        __genpd_runtime_resume+0x30/0x80
>>>>>>>>        genpd_runtime_resume+0x114/0x29c
>>>>>>>>        __rpm_callback+0x48/0x1d8
>>>>>>>>        rpm_callback+0x6c/0x78
>>>>>>>>        rpm_resume+0x530/0x750
>>>>>>>>        __pm_runtime_resume+0x50/0x94
>>>>>>>>        handle_threaded_wake_irq+0x30/0x94
>>>>>>>>        irq_thread_fn+0x2c/xa8
>>>>>>>>        irq_thread+0x160/x248
>>>>>>>>        kthread+0x110/x114
>>>>>>>>        ret_from_fork+0x10/x20
>>>>>>>>
>>>>>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>>>>>> runtime suspend/resume callbacks. In the runtime resume 
>>>>>>>> callback, call
>>>>>>>> disable_irq_wake() before enabling resources. This preemptively
>>>>>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>>>>>> interrupt management calls to proceed without conflict. An error 
>>>>>>>> path
>>>>>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>>>>>
>>>>>>>> Conversely, in runtime suspend, call enable_irq_wake() after 
>>>>>>>> resources
>>>>>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>>>>>> source only once the device has fully entered its low-power 
>>>>>>>> state. An
>>>>>>>> error path handles disabling the wakeup IRQ if the suspend 
>>>>>>>> operation
>>>>>>>> fails.
>>>>>>>>
>>>>>>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for 
>>>>>>>> serial driver")
>>>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>>>
>>>>>>> You forgot:
>>>>>>>
>>>>>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>>>
>>>>>>> Also, not sure where this change will go, via Greg or Jiri, but 
>>>>>>> ideally
>>>>>>> this should be picked for current -rc cycle since regression is
>>>>>>> introduced during latest merge window.
>>>>>>>
>>>>>>> I also would like to test it on qrb2210 rb1 where this regression is
>>>>>>> reproduciable.

Since I don't have this board, could you kindly validate the new change 
and run a quick test on your end?

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c 
b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83eb075b6bfa..3d6601dc6fcc 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev 
*pctldev,
          */
         if (d && i != gpio_func &&
             !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
-               disable_irq(irq);
+               disable_irq_nosync(irq);

         raw_spin_lock_irqsave(&pctrl->lock, flags);

Thanks,
Praveen Talari

>>>>>>
>>>>>> It doesn't seem that it fixes the regression on RB1 board:
>>>>>>
>>>>>>     INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
>>>>>>           Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
>>>>>> this message.
>>>>>>     task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    
>>>>>> ppid:2      task_flags:0x4208060 flags:0x00000010
>>>>>>     Workqueue: async async_run_entry_fn
>>>>>>     Call trace:
>>>>>>      __switch_to+0xf0/0x1c0 (T)
>>>>>>      __schedule+0x358/0x99c
>>>>>>      schedule+0x34/0x11c
>>>>>>      rpm_resume+0x17c/0x6a0
>>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>>      __pm_runtime_resume+0x50/0x9c
>>>>>>      __driver_probe_device+0x58/0x120
>>>>>>      driver_probe_device+0x3c/0x154
>>>>>>      __driver_attach_async_helper+0x4c/0xc0
>>>>>>      async_run_entry_fn+0x34/0xe0
>>>>>>      process_one_work+0x148/0x284
>>>>>>      worker_thread+0x2c4/0x3e0
>>>>>>      kthread+0x12c/0x210
>>>>>>      ret_from_fork+0x10/0x20
>>>>>>     INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
>>>>>>           Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
>>>>>> this message.
>>>>>>     task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    
>>>>>> ppid:2      task_flags:0x208040 flags:0x00000010
>>>>>>     Call trace:
>>>>>>      __switch_to+0xf0/0x1c0 (T)
>>>>>>      __schedule+0x358/0x99c
>>>>>>      schedule+0x34/0x11c
>>>>>>      __synchronize_irq+0x90/0xcc
>>>>>>      disable_irq+0x3c/0x4c
>>>>>>      msm_pinmux_set_mux+0x3b4/0x45c
>>>>>>      pinmux_enable_setting+0x1fc/0x2d8
>>>>>>      pinctrl_commit_state+0xa0/0x260
>>>>>>      pinctrl_pm_select_default_state+0x4c/0xa0
>>>>>>      geni_se_resources_on+0xe8/0x154
>>>>>>      geni_serial_resource_state+0x8c/0xbc
>>>>>>      qcom_geni_serial_runtime_resume+0x3c/0x88
>>>>>>      pm_generic_runtime_resume+0x2c/0x44
>>>>>>      __rpm_callback+0x48/0x1e0
>>>>>>      rpm_callback+0x74/0x80
>>>>>>      rpm_resume+0x3bc/0x6a0
>>>>>>      __pm_runtime_resume+0x50/0x9c
>>>>>>      handle_threaded_wake_irq+0x30/0x80
>>>>>>      irq_thread_fn+0x2c/0xb0
>>>>>>      irq_thread+0x170/0x334
>>>>>>      kthread+0x12c/0x210
>>>>>>      ret_from_fork+0x10/0x20
>>>>>
>>>>> I can see call stack is mostly similar for yours and mine but not
>>>>> completely at initial calls.
>>>>>
>>>>> Yours dump:
>>>>>    >    qcom_geni_serial_runtime_resume+0x3c/0x88
>>>>>    >    pm_generic_runtime_resume+0x2c/0x44
>>>>>    >    __rpm_callback+0x48/0x1e0
>>>>>    >    rpm_callback+0x74/0x80
>>>>>    >    rpm_resume+0x3bc/0x6a0
>>>>>    >    __pm_runtime_resume+0x50/0x9c
>>>>>    >    handle_threaded_wake_irq+0x30/0x80
>>>>>
>>>>> Mine:
>>>>>    >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>    >>>      pm_generic_runtime_resume+0x2c/0x44
>>>>>    >>>      __genpd_runtime_resume+0x30/0x80
>>>>>    >>>      genpd_runtime_resume+0x114/0x29c
>>>>>    >>>      __rpm_callback+0x48/0x1d8
>>>>>    >>>      rpm_callback+0x6c/0x78
>>>>>    >>>      rpm_resume+0x530/0x750
>>>>>
>>>>>
>>>>> Can you please share what is DT file for this Board if possible?
>>>>> is there any usecase enabled on this SE instance?
>>>>
>>>> Well, yeah, sorry, I didn't really compared backtraces line to line and
>>>> behaviour was exactly the same. I thought that the purpose was to fix
>>>> the regression reported earlier.
>>>>
>>>> RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.
>>>>
>>>> The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
>>>> it is worth checking it as well.
>>>> For testing here I didn't use anything extra (the only change was 
>>>> wifi fix
>>>> from Loic); I tested -master and linux-next usually.
>>>>
>>>> If you can tell me what is SE instance I may be able to answer. But
>>>> as far as I know it is not a part of any infrastructure or CI 
>>>> machinery.
>>>> I just boot the board and see if it works, if it does then I rebuild 
>>>> and
>>>> test my changes (audio).
>>>
>>> I'm actively working on this and experimenting various scenarios with
>>> wakeup. I’ll share the updated patch as soon as possible.
>>>
>>> Should we include fix in V2 or new version(V1) if the fix originates
>>> from a different subsystem(pinctrol)?
>>
>> Wait, I am a bit lost. Are there two regresssions? And is this patch only
>> targets one of the them?
> I am simulated on different target(SC7280) and it is same issue only.
>> Are there two fixes now for different problems?
> The problem is same.
>> If they are not related (independent) then I'd split it but it not 
>> something
>> exceptional -- just standard rules should apply.
> I am fixing from this issue from pinctrol subsystem.
> 
> Please guide me on this.
> Should we include fix in V2 or new version(V1) if the fix originates
> from a different subsystem(pinctrol)?
> 
> Thanks,
> Praveen
>>
>> Thanks,
>> Alexey
