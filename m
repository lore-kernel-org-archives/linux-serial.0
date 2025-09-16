Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156A2C15AA
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033256; cv=none; b=Sa5kZ9stn/78s5DHgNNF6X6KH0e2w/e8vrNxNBL1qn7z6RdB8Av+b1y8u85K4XpWTRhTkhGTd7Wa6CPIe43dGf/gi7q+9IxBZhGknNYjfLPO6YuFDo/2i6XxeHgh1O3+toxRawqq8MLHwNrhL7pr8yvYZ33eJqNEquORALWO2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033256; c=relaxed/simple;
	bh=KHZk4EViggi3RhbubCzOPGVKUuWKgzEbtKwopsxMPrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0SgraG8gCJR6x8APx80NVKtnko621UrnP9TbNUVIgnhrxFQ+01sn1q94MWbMkwTBn9H3ZhGVdp51hwSitZU+/hvTAjrMyZLTuCN+OYHlXGYvszxFCzqzW+lzFdB8seKp8R0rIDSfc4DiyjMoyJ0/pkDVqw3luvdyj/XGLUmL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFhBTekM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFhBTekM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9oFhr003576
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 14:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rdEtDQ/KStUM2tmPeX6rUeKx
	5/Sj/ntciiL23PmicD8=; b=gFhBTekMdvNrezfAZwAcr/p6E31L6vSsqsUMpcOb
	ZAxpaI7Sst1ZDKIepI0F7xy6tjD7D6W5gTtdYU7WShbqHiSNT898ol6toLJVZJZq
	WBR+m5s8lH8K7+XW9bJXjAXUApheu0xbSIV7idTJWUTgu7xJWvn6FJF0NABVGorX
	CsVgkdKyrMCJrSItnJqLVSJP49bgJzdp8NVk+t76XBpTOHDIRhL8KHsLmDY0ShaS
	/Zuzn4kS6elJ7+YRVzRmmQy7B9AimGLG7J8+RLL4tGlG2a4R/dDyg863JOL8Sfam
	C0hK/gh8gTFlJaF/Ov4ThqkT76F4FsKA4tkfgDhtJIupKA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr9ffj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 14:34:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-76d3633c86dso95281826d6.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033252; x=1758638052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdEtDQ/KStUM2tmPeX6rUeKx5/Sj/ntciiL23PmicD8=;
        b=KmKl/5mIe6blDain7Jsv0htWweQZo6x5Cr9Stqp5IHOp9XFwrd9/aUceV7vfEkcm96
         S73O+89FJAse7UGlDEqfRow227Z6Jr+q5LlhOkWfVlz1XFdgMoGbQhfv1K86ZRrvNHHM
         EdRaC6aSbU8/2He3xBNcme7Uys01qUx3PGymAf61uJrvW3m+qNpgNqRSpuy6r4V5ljaf
         UhOekqlylkYsR4EVwUu1uXNNp8JCrhnng+ASmO6f1lzby5lU200AzWMeEayCbV2DiIke
         msCrA5TUpU9bv3pBGKjyHbpjdSXDKZeeVAkPI5Xaq3MZ4JzZAk4ZA7dJEhF6duUT7s+E
         9s9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPi6hgqXami6M7nLcoQHqinT3AcU7gyb7p1uHdIGzPJeOKRRXtb8sEB0lcdtF9zMB7VkTe6e4Ypp7X3iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4UoTLyQ7ZaUeKpYhqx3gOsyp7c3em9Uby3rz7GZpVQtLnE4m
	hVJOwGqKnsQVecmRNULidD4Miv5bp2MLuJkHPoI5QDTatpUxoSYHUQUa9/BOJGYCUKje4zbewWJ
	CleiTxGTPV23e1XikInM+qbp2Xe4yKFOLW3pWIwMCyUN16mbbrpg2dnwmFyNeP9l3zjI=
X-Gm-Gg: ASbGncuJAfitdGcIuDRrqSgpADloessXw5KrbcTz/cZSB0V8pnR+Cu+xerYnu5KiNkX
	lLJJYwBQD1V5dlnOtt750zkTp/GdVBy9StlV24T/sWTZZej/2IGhzfKUeVQKJl3foqozRTXPBuU
	bvQui7C0NXglfuKPirhLRRzxUgCt50GKJzJ56zUYi7hOz3hiLxWJYHPYukLoNtWeVNPRxHAH2Gn
	OVpHPlF7WWZBKPCOoXdNT4SGW1c5mWV7vthgDM8LLs/Hg/rzMi1JRMfE2ar3qaKrj/ORMT32RcT
	f18vGKxRr8YRnGiq2uzdBOB5wham3iiPJo5931+4uHUHnT7klgLqhAn3EFg40u3jzjiUCGEw6mY
	=
X-Received: by 2002:ad4:4ee9:0:b0:766:5890:c5a1 with SMTP id 6a1803df08f44-767c1f720edmr201816436d6.36.1758033252266;
        Tue, 16 Sep 2025 07:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0AsHCnMPE5I5ZbfHkkcpXKs4CoGvMSzsghgSkRELqsV8abvYm9Jk0hzQBm/9IJHBCDCvOA==
X-Received: by 2002:ad4:4ee9:0:b0:766:5890:c5a1 with SMTP id 6a1803df08f44-767c1f720edmr201815576d6.36.1758033251461;
        Tue, 16 Sep 2025 07:34:11 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm9889568f8f.33.2025.09.16.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:34:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 16 Sep 2025 16:34:08 +0200
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
        quic_shazhuss@quicinc.com, krzk@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMl1YGt91p1rAaG6@trex>
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
X-Proofpoint-ORIG-GUID: ACfHr9lApD746h08En84zFcgoHkAZffI
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c97565 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=3dTM7dEFXz68Hci4Ch8A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX7kaRnuEOSm6c
 PaMUVfTUWMpgtauatRQWEY9W6S8EV1HmkBxK8jsxcucjO5sfIMGPuV8u1yhA7CMsuZhDgJXw/8u
 aO0yHXnIXE7vU0V/+efxQ11Gr2a7ySfzA1IUEoRj1jC8f2d87k6UuQTIoZrvhyZuOqiwCR8CpAO
 BGH/c322n5UFqrZwnJ6lDs4aTAr/8Kl5rIpMMOSY9JSvqeaoyegKEZdURmSGdXOMF/IN3QNo0iT
 M1QJXPGG7ndMqtYVWofJt1Atpc3Cu2c4UEf/hjWtYtVw98y/nGMEVaJtbNVUZVojcjLnynoRzid
 N0+TmT5c4C9xIYAFPLLHb4lN/j8SrICOmAZ6yP7Q5euW30PCS3vBaJKHVmExYbDHwAYkGbBbJyP
 dRc5/6/z
X-Proofpoint-GUID: ACfHr9lApD746h08En84zFcgoHkAZffI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On 11/09/25 10:00:27, Alexey Klimov wrote:
> Hi Praveen,
> 
> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
> > Hi Alexy,
> >
> > Thank you for update.
> >
> > On 9/10/2025 1:35 AM, Alexey Klimov wrote:
> >> 
> >> (adding Krzysztof to c/c)
> >> 
> >> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
> >>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
> >>>> A deadlock is observed in the qcom_geni_serial driver during runtime
> >>>> resume. This occurs when the pinctrl subsystem reconfigures device pins
> >>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
> >>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
> >>>> __synchronize_irq(), conflicting with the active wakeup state and
> >>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
> >>>> leading to system instability.
> >>>>
> >>>> The critical call trace leading to the deadlock is:
> >>>>
> >>>>      Call trace:
> >>>>      __switch_to+0xe0/0x120
> >>>>      __schedule+0x39c/0x978
> >>>>      schedule+0x5c/0xf8
> >>>>      __synchronize_irq+0x88/0xb4
> >>>>      disable_irq+0x3c/0x4c
> >>>>      msm_pinmux_set_mux+0x508/0x644
> >>>>      pinmux_enable_setting+0x190/0x2dc
> >>>>      pinctrl_commit_state+0x13c/0x208
> >>>>      pinctrl_pm_select_default_state+0x4c/0xa4
> >>>>      geni_se_resources_on+0xe8/0x154
> >>>>      qcom_geni_serial_runtime_resume+0x4c/0x88
> >>>>      pm_generic_runtime_resume+0x2c/0x44
> >>>>      __genpd_runtime_resume+0x30/0x80
> >>>>      genpd_runtime_resume+0x114/0x29c
> >>>>      __rpm_callback+0x48/0x1d8
> >>>>      rpm_callback+0x6c/0x78
> >>>>      rpm_resume+0x530/0x750
> >>>>      __pm_runtime_resume+0x50/0x94
> >>>>      handle_threaded_wake_irq+0x30/0x94
> >>>>      irq_thread_fn+0x2c/xa8
> >>>>      irq_thread+0x160/x248
> >>>>      kthread+0x110/x114
> >>>>      ret_from_fork+0x10/x20
> >>>>
> >>>> To resolve this, explicitly manage the wakeup IRQ state within the
> >>>> runtime suspend/resume callbacks. In the runtime resume callback, call
> >>>> disable_irq_wake() before enabling resources. This preemptively
> >>>> removes the "wakeup" capability from the IRQ, allowing subsequent
> >>>> interrupt management calls to proceed without conflict. An error path
> >>>> re-enables the wakeup IRQ if resource enablement fails.
> >>>>
> >>>> Conversely, in runtime suspend, call enable_irq_wake() after resources
> >>>> are disabled. This ensures the interrupt is configured as a wakeup
> >>>> source only once the device has fully entered its low-power state. An
> >>>> error path handles disabling the wakeup IRQ if the suspend operation
> >>>> fails.
> >>>>
> >>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> >>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> >>>
> >>> You forgot:
> >>>
> >>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> >>>
> >>> Also, not sure where this change will go, via Greg or Jiri, but ideally
> >>> this should be picked for current -rc cycle since regression is
> >>> introduced during latest merge window.
> >>>
> >>> I also would like to test it on qrb2210 rb1 where this regression is
> >>> reproduciable.
> >> 
> >> It doesn't seem that it fixes the regression on RB1 board:
> >> 
> >>   INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
> >>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
> >>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>   task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:2      task_flags:0x4208060 flags:0x00000010
> >>   Workqueue: async async_run_entry_fn
> >>   Call trace:
> >>    __switch_to+0xf0/0x1c0 (T)
> >>    __schedule+0x358/0x99c
> >>    schedule+0x34/0x11c
> >>    rpm_resume+0x17c/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    __pm_runtime_resume+0x50/0x9c
> >>    __driver_probe_device+0x58/0x120
> >>    driver_probe_device+0x3c/0x154
> >>    __driver_attach_async_helper+0x4c/0xc0
> >>    async_run_entry_fn+0x34/0xe0
> >>    process_one_work+0x148/0x284
> >>    worker_thread+0x2c4/0x3e0
> >>    kthread+0x12c/0x210
> >>    ret_from_fork+0x10/0x20
> >>   INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
> >>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
> >>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>   task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:2      task_flags:0x208040 flags:0x00000010
> >>   Call trace:
> >>    __switch_to+0xf0/0x1c0 (T)
> >>    __schedule+0x358/0x99c
> >>    schedule+0x34/0x11c
> >>    __synchronize_irq+0x90/0xcc
> >>    disable_irq+0x3c/0x4c
> >>    msm_pinmux_set_mux+0x3b4/0x45c
> >>    pinmux_enable_setting+0x1fc/0x2d8
> >>    pinctrl_commit_state+0xa0/0x260
> >>    pinctrl_pm_select_default_state+0x4c/0xa0
> >>    geni_se_resources_on+0xe8/0x154
> >>    geni_serial_resource_state+0x8c/0xbc
> >>    qcom_geni_serial_runtime_resume+0x3c/0x88
> >>    pm_generic_runtime_resume+0x2c/0x44
> >>    __rpm_callback+0x48/0x1e0
> >>    rpm_callback+0x74/0x80
> >>    rpm_resume+0x3bc/0x6a0
> >>    __pm_runtime_resume+0x50/0x9c
> >>    handle_threaded_wake_irq+0x30/0x80
> >>    irq_thread_fn+0x2c/0xb0
> >>    irq_thread+0x170/0x334
> >>    kthread+0x12c/0x210
> >>    ret_from_fork+0x10/0x20
> >
> > I can see call stack is mostly similar for yours and mine but not 
> > completely at initial calls.
> >
> > Yours dump:
> >  >    qcom_geni_serial_runtime_resume+0x3c/0x88
> >  >    pm_generic_runtime_resume+0x2c/0x44
> >  >    __rpm_callback+0x48/0x1e0
> >  >    rpm_callback+0x74/0x80
> >  >    rpm_resume+0x3bc/0x6a0
> >  >    __pm_runtime_resume+0x50/0x9c
> >  >    handle_threaded_wake_irq+0x30/0x80
> >
> > Mine:
> >  >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
> >  >>>      pm_generic_runtime_resume+0x2c/0x44
> >  >>>      __genpd_runtime_resume+0x30/0x80
> >  >>>      genpd_runtime_resume+0x114/0x29c
> >  >>>      __rpm_callback+0x48/0x1d8
> >  >>>      rpm_callback+0x6c/0x78
> >  >>>      rpm_resume+0x530/0x750
> >
> >
> > Can you please share what is DT file for this Board if possible?
> > is there any usecase enabled on this SE instance?
> 
> Well, yeah, sorry, I didn't really compared backtraces line to line and
> behaviour was exactly the same. I thought that the purpose was to fix
> the regression reported earlier.
> 
> RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.
> 
> The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
> it is worth checking it as well.
> For testing here I didn't use anything extra (the only change was wifi fix
> from Loic); I tested -master and linux-next usually.
> 
> If you can tell me what is SE instance I may be able to answer. But
> as far as I know it is not a part of any infrastructure or CI machinery.
> I just boot the board and see if it works, if it does then I rebuild and
> test my changes (audio).
> 
> Best regards,
> Alexey
> 

will there be a fix any time soon Praveen? reverting "serial: qcom-geni:
Enable PM runtime for serial driver" does fix the problem on RB1.

Otherwise I suggest that we revert this commit on linux-next.
