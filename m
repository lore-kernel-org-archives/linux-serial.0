Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D02E719D
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581233; cv=none; b=dm0uWcONWNdETAoffMdbPBozoIxazffc9txvQSzk3I8a1Nba/QgwzgP8MbBYqDmqOyW6obiJp1Ip5/gjHizhwXLQjOtlat6URySsfSpvfl2XVUZEm0B7WokGV9kqUgnteEx0DSlLAGafNluEhSJra3fq2WySShMVLdzX50mKYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581233; c=relaxed/simple;
	bh=J6JRpUa9Jqmrc9CHAa6uRObdOcP9b5K+xnoxoo1FkLc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rwnL65UH2gDo+onGWiANOros9P9nECX5rywsn3QvxRe6ospNf/iQ3CBTEUTjQJBnX7vC6+e9ln9TCdU23se9BNy/gW5ZJPkGnehqX7XpTyLJ8+Uz5N8x29bj4b91bEV7tnEo3zwTmY0r77WJikWw7Xb1V/TNGtL+AljeNHvlQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAtk0Sbg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAtk0Sbg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo244422f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757581229; x=1758186029; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ZvTScnMNr1AH24k1ntK2IoMlTzS54Np2T1I7lMRD8=;
        b=SAtk0SbgQqiUJg+ThigAiE8SIs6mOT4y5KlfJA5OmPJUVZhF5SZwdIqBddLK/cGNjD
         Xxm92cvhzt2Bo+BI3PMED/ARr4IEmk2QoWf1fDQLInWNfNVJFHe+vdVisds1tNAxoQKA
         eJD4oIXB/2qesXwqgGWdksheDBBVyU+QZT50scOmsP9Uq+H93YuX9WUdmAZfFvXPETry
         7K63u0u78Vz+EotORKAjgfiD5DMETQlifv2WX1vD+5+QAqrfYjEpWhuVgfhsfpMDa6ci
         l4Up6dH+3eiv3y4tZ6JPt3v2yN01TSQ3VDLussoRhtWpi4pk13COwXiiFCZt/kK+2vvM
         d68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581229; x=1758186029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z7ZvTScnMNr1AH24k1ntK2IoMlTzS54Np2T1I7lMRD8=;
        b=m8EfHYaEKQEHHaYdlppUfgDZxji1wgn02eLiF2AQTFVYO2AAQ9vDFO9iV8P/BQf5Mx
         exynEWCQhxv++jq1GDTYnQpenOvi0GfOE2oUycklfL8ClyuCgYUEfenLnEuoJmOr0TTm
         Wts3FV+eobI/3vwvIvApNRc7PDj34wtfEPNp35FjM9BtUot1olg1hk3zG451y5jybO/z
         9S/CTVDxvhaCTIXPYD3ejMwTtcKGieG0YGV0yoHH3LBcTMFmpPyfaWYaSh4Si2zCuGJ8
         TyTDPSikRa/ountnnhmaZB1jcLMitNq3yz1jJ+LNbUatHeACuZ/yW0uASjpXr78DOpIo
         4W/A==
X-Forwarded-Encrypted: i=1; AJvYcCVq5pBB3NPX9fMpgiLHWcrvOH/7EesUJmNd8wAKQgI1EbgCozKIB9uDTH1wRVB8cXLD4Nbegy3xlYcvXZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwngo8YObscJPkIxBB89cReYnu/8Ws9AzyRaOGcc418Z4QAzdg
	PvU5dK51gcLn5vrIXRX6bzfUqOgbrks8VbzoDcytxypjjikKWNE3akRuHGBlqX14wdM=
X-Gm-Gg: ASbGncsJxhg/ovpu3PiT02GirztHZXSlzmqDXeIFfl6q1RQWQrMoNK50FRL1nUkfwRi
	GcJj7y+I8Uc9OzlecM2nd0ejiNaqj9y846jIPOsfjWaZ7l6WpHmid5J7Xi9ntgmGzD6FCdz0YHy
	1ujgCHSHOcswRT7hxg2ZD2+TxGTlQblRf+5691ri5kfy3aHyo87hyLwlLJ/xLSRX4G1zPRtTKAx
	wj5cxp2Ts5LhvAsB8LecZKsM1Wu7J1zy0lvaglbvIpoa/S5T/yb+kbyUEgbiIDWgocGHaWSP6NL
	fr3XWXJN2HQpvmYHptmu+TUpqXRn1y/OPuTNHJTVhHqcmGv8AGiiHNJaJDlNuyMlNRLcsJBl1jo
	/T+2tuIiLnLspt2ANeCnmpYKd4opkmBPDwQ008w==
X-Google-Smtp-Source: AGHT+IEda48Vss7lyCEE2CSJvlNkx7dZSmRvauNmjJVS6GUI4lzbwbGCwGqB58JM6Y7mIk1wW74mpQ==
X-Received: by 2002:a05:6000:3101:b0:3e4:f194:2886 with SMTP id ffacd0b85a97d-3e642cadca2mr15196494f8f.19.1757581229312;
        Thu, 11 Sep 2025 02:00:29 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:8a3c:25ae:f06c:6781])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd9fasm1619656f8f.35.2025.09.11.02.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 10:00:27 +0100
Message-Id: <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
Cc: <psodagud@quicinc.com>, <djaggi@quicinc.com>,
 <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
 <quic_arandive@quicinc.com>, <quic_mnaresh@quicinc.com>,
 <quic_shazhuss@quicinc.com>, <krzk@kernel.org>
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Bryan
 O'Donoghue" <bryan.odonoghue@linaro.org>, "Praveen Talari"
 <quic_ptalari@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
In-Reply-To: <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>

Hi Praveen,

On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
> Hi Alexy,
>
> Thank you for update.
>
> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>=20
>> (adding Krzysztof to c/c)
>>=20
>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>> A deadlock is observed in the qcom_geni_serial driver during runtime
>>>> resume. This occurs when the pinctrl subsystem reconfigures device pin=
s
>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>> leading to system instability.
>>>>
>>>> The critical call trace leading to the deadlock is:
>>>>
>>>>      Call trace:
>>>>      __switch_to+0xe0/0x120
>>>>      __schedule+0x39c/0x978
>>>>      schedule+0x5c/0xf8
>>>>      __synchronize_irq+0x88/0xb4
>>>>      disable_irq+0x3c/0x4c
>>>>      msm_pinmux_set_mux+0x508/0x644
>>>>      pinmux_enable_setting+0x190/0x2dc
>>>>      pinctrl_commit_state+0x13c/0x208
>>>>      pinctrl_pm_select_default_state+0x4c/0xa4
>>>>      geni_se_resources_on+0xe8/0x154
>>>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>      pm_generic_runtime_resume+0x2c/0x44
>>>>      __genpd_runtime_resume+0x30/0x80
>>>>      genpd_runtime_resume+0x114/0x29c
>>>>      __rpm_callback+0x48/0x1d8
>>>>      rpm_callback+0x6c/0x78
>>>>      rpm_resume+0x530/0x750
>>>>      __pm_runtime_resume+0x50/0x94
>>>>      handle_threaded_wake_irq+0x30/0x94
>>>>      irq_thread_fn+0x2c/xa8
>>>>      irq_thread+0x160/x248
>>>>      kthread+0x110/x114
>>>>      ret_from_fork+0x10/x20
>>>>
>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>> runtime suspend/resume callbacks. In the runtime resume callback, call
>>>> disable_irq_wake() before enabling resources. This preemptively
>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>> interrupt management calls to proceed without conflict. An error path
>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>
>>>> Conversely, in runtime suspend, call enable_irq_wake() after resources
>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>> source only once the device has fully entered its low-power state. An
>>>> error path handles disabling the wakeup IRQ if the suspend operation
>>>> fails.
>>>>
>>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial =
driver")
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>
>>> You forgot:
>>>
>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>
>>> Also, not sure where this change will go, via Greg or Jiri, but ideally
>>> this should be picked for current -rc cycle since regression is
>>> introduced during latest merge window.
>>>
>>> I also would like to test it on qrb2210 rb1 where this regression is
>>> reproduciable.
>>=20
>> It doesn't seem that it fixes the regression on RB1 board:
>>=20
>>   INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
>>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
>>   task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:2  =
    task_flags:0x4208060 flags:0x00000010
>>   Workqueue: async async_run_entry_fn
>>   Call trace:
>>    __switch_to+0xf0/0x1c0 (T)
>>    __schedule+0x358/0x99c
>>    schedule+0x34/0x11c
>>    rpm_resume+0x17c/0x6a0
>>    rpm_resume+0x2c4/0x6a0
>>    rpm_resume+0x2c4/0x6a0
>>    rpm_resume+0x2c4/0x6a0
>>    __pm_runtime_resume+0x50/0x9c
>>    __driver_probe_device+0x58/0x120
>>    driver_probe_device+0x3c/0x154
>>    __driver_attach_async_helper+0x4c/0xc0
>>    async_run_entry_fn+0x34/0xe0
>>    process_one_work+0x148/0x284
>>    worker_thread+0x2c4/0x3e0
>>    kthread+0x12c/0x210
>>    ret_from_fork+0x10/0x20
>>   INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
>>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messa=
ge.
>>   task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:2  =
    task_flags:0x208040 flags:0x00000010
>>   Call trace:
>>    __switch_to+0xf0/0x1c0 (T)
>>    __schedule+0x358/0x99c
>>    schedule+0x34/0x11c
>>    __synchronize_irq+0x90/0xcc
>>    disable_irq+0x3c/0x4c
>>    msm_pinmux_set_mux+0x3b4/0x45c
>>    pinmux_enable_setting+0x1fc/0x2d8
>>    pinctrl_commit_state+0xa0/0x260
>>    pinctrl_pm_select_default_state+0x4c/0xa0
>>    geni_se_resources_on+0xe8/0x154
>>    geni_serial_resource_state+0x8c/0xbc
>>    qcom_geni_serial_runtime_resume+0x3c/0x88
>>    pm_generic_runtime_resume+0x2c/0x44
>>    __rpm_callback+0x48/0x1e0
>>    rpm_callback+0x74/0x80
>>    rpm_resume+0x3bc/0x6a0
>>    __pm_runtime_resume+0x50/0x9c
>>    handle_threaded_wake_irq+0x30/0x80
>>    irq_thread_fn+0x2c/0xb0
>>    irq_thread+0x170/0x334
>>    kthread+0x12c/0x210
>>    ret_from_fork+0x10/0x20
>
> I can see call stack is mostly similar for yours and mine but not=20
> completely at initial calls.
>
> Yours dump:
>  >    qcom_geni_serial_runtime_resume+0x3c/0x88
>  >    pm_generic_runtime_resume+0x2c/0x44
>  >    __rpm_callback+0x48/0x1e0
>  >    rpm_callback+0x74/0x80
>  >    rpm_resume+0x3bc/0x6a0
>  >    __pm_runtime_resume+0x50/0x9c
>  >    handle_threaded_wake_irq+0x30/0x80
>
> Mine:
>  >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>  >>>      pm_generic_runtime_resume+0x2c/0x44
>  >>>      __genpd_runtime_resume+0x30/0x80
>  >>>      genpd_runtime_resume+0x114/0x29c
>  >>>      __rpm_callback+0x48/0x1d8
>  >>>      rpm_callback+0x6c/0x78
>  >>>      rpm_resume+0x530/0x750
>
>
> Can you please share what is DT file for this Board if possible?
> is there any usecase enabled on this SE instance?

Well, yeah, sorry, I didn't really compared backtraces line to line and
behaviour was exactly the same. I thought that the purpose was to fix
the regression reported earlier.

RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.

The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
it is worth checking it as well.
For testing here I didn't use anything extra (the only change was wifi fix
from Loic); I tested -master and linux-next usually.

If you can tell me what is SE instance I may be able to answer. But
as far as I know it is not a part of any infrastructure or CI machinery.
I just boot the board and see if it works, if it does then I rebuild and
test my changes (audio).

Best regards,
Alexey

