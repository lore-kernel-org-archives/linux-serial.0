Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A691322C83
	for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946324; cv=none; b=FuhEYAFoshGYSHQCwai2alTTH3Wg0Tt4+9Q/kg5KpNyWHX5zfVK46AulcYGucSuKK8EBuUgoz5/wT/N1c1yMoy3nZ2CYzETdyvDRJhNvQvOS76rgkmuuB8cGNrZLsVTZEt7IPu0SYRRko8NeDEREpGuvbOFe1WKAZpDPMqkApLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946324; c=relaxed/simple;
	bh=VRJmU+3Z0Ji8Ytd0OifcCVdCAJW+EyU4ZhcjTZpgSu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFMQk4p2kA2yCXo7vOD28bxxXnz1cKtuSx98XBWibAT55Pz9qOcldW7qyCI2nr5tHn3YX6JlTtUzsEvQmeaOQxgzu8xIpmIyoNxZcGIKPkWKHvGf4t0/lKg0I9hJcLXk60sHYrXvxTgj9ov+F7QF9T7okskYZx9uo+CCjO1COko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inVdlhlZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inVdlhlZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEL7Q6006312
	for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 14:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5izw87yptpP/XObnBkQgmPZEGVfJ4L4P4qGMCF58Bqo=; b=inVdlhlZoch48y8V
	Dbp9UOiLvMHxY/9sFGJLiWkCr2t8Nyw3UJVUzEWIQkESk2YE6G7kO8KnNw+pP5mu
	aAhC3dXqJ1AIsWUn8bKLOPsZqjRxkn0/bbEzBIgiVO75vozJHOsgpl6fnw1slG6Q
	ceIAH3IL6Ik9xAm5DJbU0sbK/ixCHyVlxxkBipNaHmDXe++e7WHY3+94epXirbnv
	ycbgsSqiJz9n079R/wDzOCTbAMBz9b7sRstcymiy52enDxHDpPWvdxbtw0lOfYQm
	XpW06RtZTJ40PJ7vv7ZtjGxNZwqNg5LEPbe5T5VpZNc17udvOUTBrw1dXWIgkxcJ
	fxW1Vg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chd63v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 14:25:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so45468755ad.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 07:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946321; x=1758551121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5izw87yptpP/XObnBkQgmPZEGVfJ4L4P4qGMCF58Bqo=;
        b=kL+GT0TpwOiCTWW0fMGEsOGka42q5S1VOzUw81YkFwqD1KH88+FGtNpn083cxLU35a
         pG7piJQSyV2MdjpeLiLRnq8iZaPSUu0ZQbcmzT8+dri/v2te+9VmadK0RBiKZ0NN7v9W
         0M2pTTxJ/fUy46HaM8i5sVXqFoFcshzc0tKEyH1y0vxte585RT16LUu7DFSQvHD2O7r7
         ZYgsTHunFMmxXYqsKTg+jpQ6kOIplla9hNbMZCon57qyNrIg9ib/VYMI9Y+A5OkGAFg/
         hFK+4ftN4776xxjrfHTlf1MH8JCQf9Lw7qdiuNHS9XBfhld0lgdGFFlbUgcp8LbXeTx/
         FNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUVzCmVr7O0NyJTbfDiG3POBNqNP3lSAY8+wkJhlom3FWj1GQGcofCikMf2TyxcXGFYNc7Uog5IqNN8jg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweulcrDOp/sY7tWJTEmxCgSBzw+v1J08+yIRlgUceTbfW6kT/m
	RyQsQ3wMycLQKU3e/Tps3mkNW4erlvQn8zJn5KM7VTi9xSZEv2zk3UfCYfB7JTADa0vRSvyJU8R
	aTqhlX3nE14S30fsgaJqosML2+FX2Y2nQibh9L+SgTb0+hs0ueUbHLXjY/o8TjKunEik=
X-Gm-Gg: ASbGnctE0k4mHNHoJsFYMGvJKk/5unj9Rl9BcfHbVdfzyoqGsBiUdaX571JkZ4rsKwo
	C5Yt5lO8LEjH6o//tIMMKerYUV7CNbU55dmTp0SF6lRFwZfzuJzOmtysjuI6mJrB7TmZvbY81Kf
	9DZxCpxXA6Ae6Xn6opAMp4HhOkWqqrLQLap7fanpIlyf2BYULTc5cT+1eJCbicu7S4F237Vqm48
	gsW6ukIFyUigqdI82fS6lRoe8tw47zhf4y2RsniQmiVtg/GIZ2hSpHWZnSMnKJEmxHb3ew6x3aO
	86nFJbHdfLKwlm2aRXTYPAk6QbDHN2/7kNtvWpsi56/SDJ5hx8Z14bNOdKybJIyVI+0gCQY=
X-Received: by 2002:a17:902:f788:b0:267:99bf:6724 with SMTP id d9443c01a7336-26799bf6b55mr27468065ad.31.1757946321015;
        Mon, 15 Sep 2025 07:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVopEJxZmQBHqpYtqqiv3HdtWoLiJQP97ogG4ITqijKQjfqCkXb3yEbY1lb5VyRKyTIFWuAQ==
X-Received: by 2002:a17:902:f788:b0:267:99bf:6724 with SMTP id d9443c01a7336-26799bf6b55mr27467245ad.31.1757946320335;
        Mon, 15 Sep 2025 07:25:20 -0700 (PDT)
Received: from [192.168.1.7] ([49.204.104.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26263a76cd4sm64322145ad.31.2025.09.15.07.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:25:19 -0700 (PDT)
Message-ID: <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 19:55:14 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c821d2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Z2XpV/0q3vK5biEotBnTqQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=05CQPNOUvAP4fS3p7jwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WiEQNjUXGTWMZcBLCXgR7CBkhQZEOR4X
X-Proofpoint-GUID: WiEQNjUXGTWMZcBLCXgR7CBkhQZEOR4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX/UNSYQIZwXDn
 OUIqJDFPR4imBIn03aJ06iUZoObKy8c3LLrmPP2jCjUwSUynUdKX0Pq+gwfC8yAstrNFnAT8EuG
 83igEJGRkvNZm7qIa2B/8NEek1qXU5DJHuNiTyr21V8TQDKGaAc5p6gz3ZmKUzXiLuy3W9MBjVy
 V5DP/R9uuPsUjCAg5zxU2Tt2wTrsM96rngUGPp5D4Zpca5f3JXIStUc7OhhHgss5JbPjVLDT4hq
 ixEisFDTGI9DBR8jCVSY0s0ZLfWmRiOv6e5lx4Au3Dp+MLhvGnOgdYYITVVFk2KLZZwTU2ATVjo
 91gI8VjQK139y172mx4NTbIxIIfdgo+qsAXUiBjdPJ9Na/yUWkVUAzzNjk6g70b6mK/oQA1HPmc
 dgZ2qztB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

Hi Alexey,

On 9/15/2025 3:09 PM, Alexey Klimov wrote:
> (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not delivered)
> 
> Hi Praveen,
> 
> On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
>> Hi Alexey,
>>
>> Really appreciate you waiting!
>>
>> On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>>> Hi Praveen,
>>>
>>> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>>>> Hi Alexy,
>>>>
>>>> Thank you for update.
>>>>
>>>> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>>>>
>>>>> (adding Krzysztof to c/c)
>>>>>
>>>>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>>>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>>>>> A deadlock is observed in the qcom_geni_serial driver during runtime
>>>>>>> resume. This occurs when the pinctrl subsystem reconfigures device pins
>>>>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>>>>> leading to system instability.
>>>>>>>
>>>>>>> The critical call trace leading to the deadlock is:
>>>>>>>
>>>>>>>        Call trace:
>>>>>>>        __switch_to+0xe0/0x120
>>>>>>>        __schedule+0x39c/0x978
>>>>>>>        schedule+0x5c/0xf8
>>>>>>>        __synchronize_irq+0x88/0xb4
>>>>>>>        disable_irq+0x3c/0x4c
>>>>>>>        msm_pinmux_set_mux+0x508/0x644
>>>>>>>        pinmux_enable_setting+0x190/0x2dc
>>>>>>>        pinctrl_commit_state+0x13c/0x208
>>>>>>>        pinctrl_pm_select_default_state+0x4c/0xa4
>>>>>>>        geni_se_resources_on+0xe8/0x154
>>>>>>>        qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>>>        pm_generic_runtime_resume+0x2c/0x44
>>>>>>>        __genpd_runtime_resume+0x30/0x80
>>>>>>>        genpd_runtime_resume+0x114/0x29c
>>>>>>>        __rpm_callback+0x48/0x1d8
>>>>>>>        rpm_callback+0x6c/0x78
>>>>>>>        rpm_resume+0x530/0x750
>>>>>>>        __pm_runtime_resume+0x50/0x94
>>>>>>>        handle_threaded_wake_irq+0x30/0x94
>>>>>>>        irq_thread_fn+0x2c/xa8
>>>>>>>        irq_thread+0x160/x248
>>>>>>>        kthread+0x110/x114
>>>>>>>        ret_from_fork+0x10/x20
>>>>>>>
>>>>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>>>>> runtime suspend/resume callbacks. In the runtime resume callback, call
>>>>>>> disable_irq_wake() before enabling resources. This preemptively
>>>>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>>>>> interrupt management calls to proceed without conflict. An error path
>>>>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>>>>
>>>>>>> Conversely, in runtime suspend, call enable_irq_wake() after resources
>>>>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>>>>> source only once the device has fully entered its low-power state. An
>>>>>>> error path handles disabling the wakeup IRQ if the suspend operation
>>>>>>> fails.
>>>>>>>
>>>>>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
>>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>>
>>>>>> You forgot:
>>>>>>
>>>>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>>
>>>>>> Also, not sure where this change will go, via Greg or Jiri, but ideally
>>>>>> this should be picked for current -rc cycle since regression is
>>>>>> introduced during latest merge window.
>>>>>>
>>>>>> I also would like to test it on qrb2210 rb1 where this regression is
>>>>>> reproduciable.
>>>>>
>>>>> It doesn't seem that it fixes the regression on RB1 board:
>>>>>
>>>>>     INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
>>>>>           Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>     task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:2      task_flags:0x4208060 flags:0x00000010
>>>>>     Workqueue: async async_run_entry_fn
>>>>>     Call trace:
>>>>>      __switch_to+0xf0/0x1c0 (T)
>>>>>      __schedule+0x358/0x99c
>>>>>      schedule+0x34/0x11c
>>>>>      rpm_resume+0x17c/0x6a0
>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>      rpm_resume+0x2c4/0x6a0
>>>>>      __pm_runtime_resume+0x50/0x9c
>>>>>      __driver_probe_device+0x58/0x120
>>>>>      driver_probe_device+0x3c/0x154
>>>>>      __driver_attach_async_helper+0x4c/0xc0
>>>>>      async_run_entry_fn+0x34/0xe0
>>>>>      process_one_work+0x148/0x284
>>>>>      worker_thread+0x2c4/0x3e0
>>>>>      kthread+0x12c/0x210
>>>>>      ret_from_fork+0x10/0x20
>>>>>     INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
>>>>>           Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>>>>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>     task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:2      task_flags:0x208040 flags:0x00000010
>>>>>     Call trace:
>>>>>      __switch_to+0xf0/0x1c0 (T)
>>>>>      __schedule+0x358/0x99c
>>>>>      schedule+0x34/0x11c
>>>>>      __synchronize_irq+0x90/0xcc
>>>>>      disable_irq+0x3c/0x4c
>>>>>      msm_pinmux_set_mux+0x3b4/0x45c
>>>>>      pinmux_enable_setting+0x1fc/0x2d8
>>>>>      pinctrl_commit_state+0xa0/0x260
>>>>>      pinctrl_pm_select_default_state+0x4c/0xa0
>>>>>      geni_se_resources_on+0xe8/0x154
>>>>>      geni_serial_resource_state+0x8c/0xbc
>>>>>      qcom_geni_serial_runtime_resume+0x3c/0x88
>>>>>      pm_generic_runtime_resume+0x2c/0x44
>>>>>      __rpm_callback+0x48/0x1e0
>>>>>      rpm_callback+0x74/0x80
>>>>>      rpm_resume+0x3bc/0x6a0
>>>>>      __pm_runtime_resume+0x50/0x9c
>>>>>      handle_threaded_wake_irq+0x30/0x80
>>>>>      irq_thread_fn+0x2c/0xb0
>>>>>      irq_thread+0x170/0x334
>>>>>      kthread+0x12c/0x210
>>>>>      ret_from_fork+0x10/0x20
>>>>
>>>> I can see call stack is mostly similar for yours and mine but not
>>>> completely at initial calls.
>>>>
>>>> Yours dump:
>>>>    >    qcom_geni_serial_runtime_resume+0x3c/0x88
>>>>    >    pm_generic_runtime_resume+0x2c/0x44
>>>>    >    __rpm_callback+0x48/0x1e0
>>>>    >    rpm_callback+0x74/0x80
>>>>    >    rpm_resume+0x3bc/0x6a0
>>>>    >    __pm_runtime_resume+0x50/0x9c
>>>>    >    handle_threaded_wake_irq+0x30/0x80
>>>>
>>>> Mine:
>>>>    >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>    >>>      pm_generic_runtime_resume+0x2c/0x44
>>>>    >>>      __genpd_runtime_resume+0x30/0x80
>>>>    >>>      genpd_runtime_resume+0x114/0x29c
>>>>    >>>      __rpm_callback+0x48/0x1d8
>>>>    >>>      rpm_callback+0x6c/0x78
>>>>    >>>      rpm_resume+0x530/0x750
>>>>
>>>>
>>>> Can you please share what is DT file for this Board if possible?
>>>> is there any usecase enabled on this SE instance?
>>>
>>> Well, yeah, sorry, I didn't really compared backtraces line to line and
>>> behaviour was exactly the same. I thought that the purpose was to fix
>>> the regression reported earlier.
>>>
>>> RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.
>>>
>>> The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
>>> it is worth checking it as well.
>>> For testing here I didn't use anything extra (the only change was wifi fix
>>> from Loic); I tested -master and linux-next usually.
>>>
>>> If you can tell me what is SE instance I may be able to answer. But
>>> as far as I know it is not a part of any infrastructure or CI machinery.
>>> I just boot the board and see if it works, if it does then I rebuild and
>>> test my changes (audio).
>>
>> I'm actively working on this and experimenting various scenarios with
>> wakeup. I’ll share the updated patch as soon as possible.
>>
>> Should we include fix in V2 or new version(V1) if the fix originates
>> from a different subsystem(pinctrol)?
> 
> Wait, I am a bit lost. Are there two regresssions? And is this patch only
> targets one of the them?
I am simulated on different target(SC7280) and it is same issue only.
> Are there two fixes now for different problems?
The problem is same.
> If they are not related (independent) then I'd split it but it not something
> exceptional -- just standard rules should apply.
I am fixing from this issue from pinctrol subsystem.

Please guide me on this.
Should we include fix in V2 or new version(V1) if the fix originates
from a different subsystem(pinctrol)?

Thanks,
Praveen
> 
> Thanks,
> Alexey
