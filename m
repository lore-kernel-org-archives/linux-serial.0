Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52913259C98
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035229; cv=none; b=dMeQOPZbdRvgzYNWEiyinpF0Dm1i+E1o+lHwuprNwh/xVjY4tjXARXamniUSAheP4EmZ32Pi62S8ewY/x4Uawr/wK0HLc4d8s55ELBdZhk7qkjjmAR3c+Eobfk8DqfRkK8yzHtk4s3E/Z/+CfJEo2APg6rHb49pM2woCmmq9x+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035229; c=relaxed/simple;
	bh=zYBCqbg4hFbcYDRPtV6S9sC7TipiXrdnfebWryX347k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoR9Tm47+wGodMqoitsfF7zMZ27cRKRRk4rOqgFX3rPzC+NOX2HcTn5J46Qb7PctiaTaMG9lT2AmYdHnFerUwdE79+0VtTWDC1aq7ca2H1N0Tsmy8wSMgr+uvUrV8qM8f4pc6KabPPIveFsVrXPcxQfNGWmFtQLVns/ZZGi3iRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGpJkTyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGpJkTyp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAHxST019569
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 15:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFlHJcm0NEs/TTyIKVe+yzkGYyRx/SeQAW0+5i88u5c=; b=iGpJkTypJYYFsB0J
	qPfYcYaNEF1XaXAPDN58IfnNvjb3mmqeIDMtEB3ljni3rZ48yT6YNI822RypFxX2
	q6ZVaPHFm6xCTmsSzznBXsqInmXIxCcqozNWNX4o7ejXrJfqb2soa2uvDa7lg3WV
	d0y6o+CtuLCyEqp5XQhaRQyr7gYSlsESzuCWxTkBcq+m4Wmv5GPKPMmrSLJXFLwM
	ELudt1h2mjTGEkrnKUjr478TkrIq1UHkGd7kii8N1LT06Xl+jiquvyOuFjBsfeaT
	eHURngKx9mcLzhTRuqyWtkf6wE4flJ6xN661qouF6n5GyhKSqqRwgiq1isW4DE80
	F/YPZg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma997d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 15:07:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e0ddd918aso5542236d6.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 08:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035225; x=1758640025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFlHJcm0NEs/TTyIKVe+yzkGYyRx/SeQAW0+5i88u5c=;
        b=oA6ryb2b53ivnFqHUM70yPO9UhwbH2x40nZ2iII7xvyRX/BHJMcABzcLBb+EFTlrSw
         JuM3r34eiTWuc2S/gbQikC3pplvs81FlC0WkPJvzH7jBzgspIweUY/e7go2OxzgTEnxv
         w4PjY3iEv+mln7P//t9R4cZSpF/d3Ruu4fsKo7Nzy644+QzPihgoBpHdydHJ+4Czaez+
         JDXrU5xwWfTCGNtoepAvFgKlLwFk6BcmZ7A9Na53ax/fJAsmJjlrqlMgPNwf90rSkuCE
         DA30Mt4j1v7N61WyoEmflpEotljT71Sf4rGF+2t0/l8YKYYiREp5ILccc/ph2jQ7I2MB
         mUVw==
X-Forwarded-Encrypted: i=1; AJvYcCVmOna0WQ8fJ3BBz0QnfW7JXGt3yCQvN3F/B1JFs17qNkcZtNoHxUB8OEduB7yC1Fr0eMjQWhJoBS4Pnh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNy/6oWGvCGamx0PpN2bAl/ijmXqP5nMt9e83Ni/0L0PSm9xWJ
	dHQtY9zkTar53JeXOALPXVPmbhw4kZfzxxFmuPAfAN7yDscTUEYalSyk6jb3v3ptV9HrzydLUaX
	SFOJCGj2n9gXBLhYeZIkAimEzLBlIGHOLKod5V1UZJEbAJbXwgUK8FnoxZnPhgTzxCnQ=
X-Gm-Gg: ASbGncvj7VgSRji8VmdFQuZPTrKhWf+i740xEzYCUzrovmfVpll2dJ0Q20wzAZFf3Xn
	lHDvnjaE58e+Owkx+d85JonmGtbOeoy+3RKUozbnKnlVS7f7KMOwWRxpLzaOMWve67OCMs4lVBl
	O550sfsaAbrsnok5tRaUWpiyPNCHln53IhTDWfaCl/maR9XUnHDzxmZKDZQm32qeGAb8tA4EKsi
	XGsVGbEdLPfLxu0tq4tMlXfznASAMRQHqX2LHVFuZC+UaMQDK0C1oIO5JkMcLpuSh3pti16WAsy
	ZBvhjYznacImW7IA0JHjiDh//9ePUM9Vn/rNWocjf+pKL94R7sQDD+ablFTxZ3V8OzL8+ppuDx8
	=
X-Received: by 2002:ac8:5952:0:b0:4b4:989a:a292 with SMTP id d75a77b69052e-4b77cfbb938mr189532211cf.26.1758035224550;
        Tue, 16 Sep 2025 08:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4swe9zBBtQqq7Swph0ODOiJLcS9vfrieWkyGPzeKphOyP7/QWRsp5/edjNCn6yFXoDZAl3g==
X-Received: by 2002:ac8:5952:0:b0:4b4:989a:a292 with SMTP id d75a77b69052e-4b77cfbb938mr189531181cf.26.1758035223679;
        Tue, 16 Sep 2025 08:07:03 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156abecsm225260475e9.4.2025.09.16.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:07:03 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 16 Sep 2025 17:07:01 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com, krzk@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMl9Fbuyq7hdXvQC@trex>
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
 <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
 <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
 <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
 <aMl2hOYTjBuCo4AM@trex>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMl2hOYTjBuCo4AM@trex>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX7iCRUPvFeVF/
 eeezGIAIYhGO6CGBmUZ3+ZzrX5KKnXxofaErNka/vFGItm94yFz+liVIh01qQHcFkwqbdvMMY/2
 vySWyjQdY5shxZV4wEWw+hKNHjgw++PN0Qf1jHfxgRAmG85lE3EyXySNoogRCi7X4zA+FQ+qTkU
 m/t6tVJk3BCh79WKy0/tAHsj9EJn9Qtjx8DUhaw3M5lslTc27tHRpt1UBBCeHmuTLEkE0j6N+sQ
 pNodEJF7DtTf4jAX6gW6vkrU/8ItJA6KuISp6DrJ8o1mAu0+Y8GoPVj58E0ezwPtPg0N+20Mo1/
 TdkMt8HgM8Li5BDQH1LoO74IapKprPsgpet6+kSUvRdoC+uUIC3LBqWDG1TqNznryYfIBsi8eG1
 OlW4qKZd
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c97d1a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=o8Ad3ZvNeqkkIsAbXqoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jh40nGXZF1mJTnSfAB6UOliTjPdnJGTN
X-Proofpoint-GUID: jh40nGXZF1mJTnSfAB6UOliTjPdnJGTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On 16/09/25 16:39:00, Jorge Ramirez wrote:
> On 16/09/25 12:20:25, Praveen Talari wrote:
> > Hi Alexey
> > 
> > Thank you for your support.
> > 
> > On 9/15/2025 7:55 PM, Praveen Talari wrote:
> > > Hi Alexey,
> > > 
> > > On 9/15/2025 3:09 PM, Alexey Klimov wrote:
> > > > (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not
> > > > delivered)
> > > > 
> > > > Hi Praveen,
> > > > 
> > > > On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
> > > > > Hi Alexey,
> > > > > 
> > > > > Really appreciate you waiting!
> > > > > 
> > > > > On 9/11/2025 2:30 PM, Alexey Klimov wrote:
> > > > > > Hi Praveen,
> > > > > > 
> > > > > > On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
> > > > > > > Hi Alexy,
> > > > > > > 
> > > > > > > Thank you for update.
> > > > > > > 
> > > > > > > On 9/10/2025 1:35 AM, Alexey Klimov wrote:
> > > > > > > > 
> > > > > > > > (adding Krzysztof to c/c)
> > > > > > > > 
> > > > > > > > On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
> > > > > > > > > On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
> > > > > > > > > > A deadlock is observed in the
> > > > > > > > > > qcom_geni_serial driver during runtime
> > > > > > > > > > resume. This occurs when the pinctrl
> > > > > > > > > > subsystem reconfigures device pins
> > > > > > > > > > via msm_pinmux_set_mux() while the serial device's interrupt is an
> > > > > > > > > > active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
> > > > > > > > > > __synchronize_irq(), conflicting with the active wakeup state and
> > > > > > > > > > causing the IRQ thread to enter an uninterruptible (D-state) sleep,
> > > > > > > > > > leading to system instability.
> > > > > > > > > > 
> > > > > > > > > > The critical call trace leading to the deadlock is:
> > > > > > > > > > 
> > > > > > > > > >        Call trace:
> > > > > > > > > >        __switch_to+0xe0/0x120
> > > > > > > > > >        __schedule+0x39c/0x978
> > > > > > > > > >        schedule+0x5c/0xf8
> > > > > > > > > >        __synchronize_irq+0x88/0xb4
> > > > > > > > > >        disable_irq+0x3c/0x4c
> > > > > > > > > >        msm_pinmux_set_mux+0x508/0x644
> > > > > > > > > >        pinmux_enable_setting+0x190/0x2dc
> > > > > > > > > >        pinctrl_commit_state+0x13c/0x208
> > > > > > > > > >        pinctrl_pm_select_default_state+0x4c/0xa4
> > > > > > > > > >        geni_se_resources_on+0xe8/0x154
> > > > > > > > > >        qcom_geni_serial_runtime_resume+0x4c/0x88
> > > > > > > > > >        pm_generic_runtime_resume+0x2c/0x44
> > > > > > > > > >        __genpd_runtime_resume+0x30/0x80
> > > > > > > > > >        genpd_runtime_resume+0x114/0x29c
> > > > > > > > > >        __rpm_callback+0x48/0x1d8
> > > > > > > > > >        rpm_callback+0x6c/0x78
> > > > > > > > > >        rpm_resume+0x530/0x750
> > > > > > > > > >        __pm_runtime_resume+0x50/0x94
> > > > > > > > > >        handle_threaded_wake_irq+0x30/0x94
> > > > > > > > > >        irq_thread_fn+0x2c/xa8
> > > > > > > > > >        irq_thread+0x160/x248
> > > > > > > > > >        kthread+0x110/x114
> > > > > > > > > >        ret_from_fork+0x10/x20
> > > > > > > > > > 
> > > > > > > > > > To resolve this, explicitly manage the wakeup IRQ state within the
> > > > > > > > > > runtime suspend/resume callbacks. In the
> > > > > > > > > > runtime resume callback, call
> > > > > > > > > > disable_irq_wake() before enabling resources. This preemptively
> > > > > > > > > > removes the "wakeup" capability from the IRQ, allowing subsequent
> > > > > > > > > > interrupt management calls to proceed
> > > > > > > > > > without conflict. An error path
> > > > > > > > > > re-enables the wakeup IRQ if resource enablement fails.
> > > > > > > > > > 
> > > > > > > > > > Conversely, in runtime suspend, call
> > > > > > > > > > enable_irq_wake() after resources
> > > > > > > > > > are disabled. This ensures the interrupt is configured as a wakeup
> > > > > > > > > > source only once the device has fully
> > > > > > > > > > entered its low-power state. An
> > > > > > > > > > error path handles disabling the wakeup IRQ
> > > > > > > > > > if the suspend operation
> > > > > > > > > > fails.
> > > > > > > > > > 
> > > > > > > > > > Fixes: 1afa70632c39 ("serial: qcom-geni:
> > > > > > > > > > Enable PM runtime for serial driver")
> > > > > > > > > > Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> > > > > > > > > 
> > > > > > > > > You forgot:
> > > > > > > > > 
> > > > > > > > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > > > > > > > 
> > > > > > > > > Also, not sure where this change will go, via
> > > > > > > > > Greg or Jiri, but ideally
> > > > > > > > > this should be picked for current -rc cycle since regression is
> > > > > > > > > introduced during latest merge window.
> > > > > > > > > 
> > > > > > > > > I also would like to test it on qrb2210 rb1 where this regression is
> > > > > > > > > reproduciable.
> > 
> > Since I don't have this board, could you kindly validate the new change and
> > run a quick test on your end?
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
> > b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 83eb075b6bfa..3d6601dc6fcc 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev
> > *pctldev,
> >          */
> >         if (d && i != gpio_func &&
> >             !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
> > -               disable_irq(irq);
> > +               disable_irq_nosync(irq);
> > 
> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> 
> 
> sorry Praveen, didnt see this proposal. testing on my end as well.
> 

just tested on my end and all modules load - deadlocked before this
update so there is progress (now we can load the network driver)

I can see however irq/92 (threaded) stuck in D-state inside runtime pm

root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                                                                                                                              
[  498.247349] sysrq: Show Blocked State
[  498.251190] task:irq/92-4a8c000. state:D stack:0     pid:80
tgid:80    ppid:2      task_flags:0x208040 flags:0x00000010
[  498.262334] Call trace:
[  498.264812]  __switch_to+0xf0/0x1c0 (T)  
[  498.268777]  __schedule+0x110/0x9bc


with irq92 being:
92: 199870  0  0   0  msmgpio  11 Level     4a8c000.serial:wakeup

this log changes over time but it is alwas irq/92:

root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                                                                                                   [90/66818]
[  613.019101] sysrq: Show Blocked State                                                                                                                              
[  613.023055] task:irq/92-4a8c000. state:D stack:0     pid:80    tgid:80    ppid:2      task_flags:0x208040 flags:0x00000010                                         
[  613.034189] Call trace:                                                                                                                                            
[  613.036770]  __switch_to+0xf0/0x1c0 (T)                                                                                                                            
[  613.040779]  __schedule+0x35c/0x9bc                                                                                                                                
[  613.044412]  schedule+0x34/0x110                                                                                                                                   
[  613.047782]  rpm_resume+0x17c/0x690                                                                                                                                
[  613.051359]  __pm_runtime_resume+0x4c/0x98                                                                                                                         
[  613.055556]  handle_threaded_wake_irq+0x30/0x80                                                                                                                    
[  613.060168]  irq_thread_fn+0x28/0xa8                                                                                                                               
[  613.063864]  irq_thread+0x178/0x338                                                                                                                                
[  613.067434]  kthread+0x12c/0x210                                                                                                                                   
[  613.070735]  ret_from_fork+0x10/0x20                                                                                                                               
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                                                                                                             
[  617.586960] sysrq: Show Blocked State                                                              
[  617.590771] task:irq/92-4a8c000. state:D stack:0     pid:80    tgid:80    ppid:2      task_flags:0x208040 flags:0x00000010                                        
[  617.601906] Call trace:                                                                            
[  617.604442]  __switch_to+0xf0/0x1c0 (T)                                                            
[  617.608408]  __schedule+0x35c/0x9bc                                                                
[  617.612074]  0x766c7362                                                                            
root@qrb2210-rb1-core-kit:~#                                                                          
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                           
[  619.656937] sysrq: Show Blocked State                                                                                                                              
[  619.660847] task:irq/92-4a8c000. state:D stack:0     pid:80    tgid:80    ppid:2      task_flags:0x208040 flags:0x00000010
[  619.672009] Call trace:                                                                                                                                            
[  619.674531]  __switch_to+0xf0/0x1c0 (T)                                                                                                                            
[  619.678508]  __schedule+0x35c/0x9bc                                                                                                                                
[  619.682102]  schedule+0x34/0x110                                                                                                                                   
[  619.685488]  schedule_timeout+0x80/0x104                                                                                                                           
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                           
[  624.786811] sysrq: Show Blocked State                                                                                                                              
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~#                                                                                                                                          
root@qrb2210-rb1-core-kit:~# echo w > /proc/sysrq-trigger                           
[  630.546744] sysrq: Show Blocked State                                                                                                                              
[  630.550593] task:irq/92-4a8c000. state:D stack:0     pid:80    tgid:80    ppid:2      task_flags:0x208040 flags:0x00000010
[  630.561724] Call trace:                                                                                                                                            
[  630.564219]  __switch_to+0xf0/0x1c0 (T)                                                                                                                            
[  630.568138]  __schedule+0x35c/0x9bc                                                                                                                                
[  630.571729]  0x766c7362                                                                                                                                            
root@qrb2210-rb1-core-kit:~#

