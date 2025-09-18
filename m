Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C52D94BB
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180355; cv=none; b=kaoGaHOIu2Funf7a2oSLO4us3S3A+jJQRG/aNenO3Al5N73Z0k+nmLrT9OGzoqrMy1RyLaLwRnl9giHiJx2ZOfTMhuaNCjWWqKuIN4UNWGbJUIerM107PFzRinxgIo4xBlED5rwI/UGbEydtjeCRd6lpNEV0QZc5VRocmwdUXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180355; c=relaxed/simple;
	bh=45P+u1tAv3iIaIuLoskmjiVZLMeXMtR6uk2qfhZEw8g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlYBs/K9brlR2mNdV3go5/sQK+2IhYE4SsheO0N/xPUm+o9ONOgg+ZfaDrzu+thCVsxkmE9+AveR31Cj+AulvUpNW8o51srjVPWq8UVSzawBcmh/8WwKVnnb6pdLy0JbyjxYmXvj/9Sxou8QSnOoYh40u8rd/pIluCYIhPqGDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XongnQpY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XongnQpY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I0oef3003563
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 07:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgWSHIxJ74v4zLjsbadVyxzqod/mpaz3qAfwUznSiDQ=; b=XongnQpYkvgKvGVn
	VrnFIzKfWLlxMzav2ddn1gCVtt9Sm97uJ+egvupvTqanEq8wS7JR6IArYo6fR+eQ
	cVAb0pjcFDQfyKAhAnoy9ai0SA6KxCVB9jIvKm3tTtFeRJNOIMnng1jJlqPNybJW
	Blhi462XecdgtTCATGaNjAWHmFTnoZ+1fnfSbwDuUA7sI3Jh8521ycaOZs3P/by6
	/yZoKpRDd1tc4E5RI8eVomU0SX6jAxsqbPNlxsFd0H7YqCCcptDUP0MKeyjtC4me
	kzscr/EvrYgOpM2ywukseYup8MmBrwz1i2INr/5brPR/Rb1psu+jyabLcXrZT1yt
	/gkn8g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgtwyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 07:25:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-718cb6230afso11932456d6.0
        for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180352; x=1758785152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgWSHIxJ74v4zLjsbadVyxzqod/mpaz3qAfwUznSiDQ=;
        b=RlAMBAUn6lKxmCAoZcSnsJajMx3F8qnlsVGyDUCRXlycRy57E9NEh3lACF2SX2eAW2
         XZSwCnEq4wHCd4Mqjh7gsTu+S+4yIQZtrMEoWhiza1IQbhzRJnyd35OPLzK+FaAJwUpv
         T3oQrCU7DHwkvLb8Qq8vAPawE1fSnin35uzN12mvl5EyR6TOuEtZ/kBs89GMrnJtxU5Z
         eIrBPYT3wrZ7cYJ57VJP7tVaG8trLPy0wQHof+50qmLxf0V/jdNarLultFfa3RYQLrA+
         jT2wECWi0i6U4wMqENFXnlOim0jioN64zKyYDRNqHd6k5l2Wxz2CQpppukVnnVlbTi68
         sGnA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ls26XHZRWIhnoR8BCuOSe5kK+HSNEaokx2ZkqwntASeWl3FXmvfABdyjgft+kipQXEvWq/XXcqqzXvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXEa5ApriGdlnrbYJaolzT7O1HOn1CxMFC4CdvT6yVQz8MOUQ
	BFDwiZ1Xga2su95Rljgmq5F/3PR99g2d/nQX8hqoyOgB5cafHb8OuJzI07pG9Pa6XrxuTRGWIiI
	C09/A3lVlH54O/5PnarZKVQA1z/xqP6iwSrlRKX8CwolVo15krZ4DXU+C95FPUBTWl/c=
X-Gm-Gg: ASbGncud6DTmQy2Qe+jyDkB+7PxSrh0IDX6ovBsE37gLcIRXRfO28b5IYH4rmZuSj59
	u/zMwpTeUvgJ3JzHYNV+nPT8XTUgQqpBN0gQPPYrsbQhnc8vUyYbRmnWIL+7Iril/koCMC9I0ZI
	pfqmIH9E9Xbrk/HdT4VioQTUjMSgaMODRAVgCR7aVO3dWvv7gK2wzRpz8f0BtQPLe17hshi9jKA
	yiYN2z3nu1qbtVh+FkT3DNBl2HS2RX54/Mz+cq/K9G3M/KkPjf1ed9YpkNPXsQYmrP4VJfvYeFH
	0abk9HGF/EGO6zSN7tsOVLpsPtP62lWt5yWaqI46Ox5l7mv8fWAlwY3C748koko6M4nBUOqN/VA
	=
X-Received: by 2002:a05:6214:c22:b0:792:d0c5:7155 with SMTP id 6a1803df08f44-792d0c574efmr21812686d6.18.1758180351836;
        Thu, 18 Sep 2025 00:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNAnAVp347GePapB/xQ1YAYCNvzrXi3Zwnb7APYVakX2+Y/D3TUU0hrhQldlXBUl+I3q+K5A==
X-Received: by 2002:a05:6214:c22:b0:792:d0c5:7155 with SMTP id 6a1803df08f44-792d0c574efmr21812416d6.18.1758180351169;
        Thu, 18 Sep 2025 00:25:51 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f339sm30217505e9.14.2025.09.18.00.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:25:50 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 18 Sep 2025 09:25:48 +0200
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com,
        quic_cchiluve@quicinc.com
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMuz/C1iT8JtjXbQ@trex>
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
 <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oNM3su-TUhrSXxrBSe0n-zM1-v5apBpS
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cbb400 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=6bHfGmxriAW5vq4Uz9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oNM3su-TUhrSXxrBSe0n-zM1-v5apBpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX+5l7AcEaQnDg
 wO2zw+b+3aTBE2Jn0ID/xzEtMcFSzU4vBirBLb29854lpZSEBPrZYFCDIfIMb3RGjoBCZUrIxOt
 zp1z69ykM9tgobArXacK07Z6sllWEfNvgCkcIFcr13PUKM7Gy0ZasfLPEN7UQ3CdsFYHjUVu9Lh
 GQvIPS7MulLccYwKVCFt5Swn6958EvzS98JWqCsUBZA+/clIX8A0dj5jIdjdV/Uv+TOY9Suwwhr
 sp2HiPesovF3XVaIh/yRF88K8S+hpj1l1unsk6R6tLLu3jEqC8yHAv/iPS8ipoBHufH2KfJofHs
 vWXvOxfun4G60I7DEmY6fcARpvc8ARPeU7DFNnm9eRYaZqtuSsABHL/YckTWSoYlESNHvIwPkpa
 jwsamTNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

On 18/09/25 09:25:53, Praveen Talari wrote:
> Hi Krzysztof,
> 
> On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> > On 18/09/2025 03:51, Praveen Talari wrote:
> > > A stall was observed in disable_irq() during
> > > pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
> > > while the UART port was not yet active. This led to a hang in
> > > __synchronize_irq(), as shown in the following trace:
> > > 
> > > Call trace:
> > >      __switch_to+0xe0/0x120
> > >      __schedule+0x39c/0x978
> > >      schedule+0x5c/0xf8
> > >      __synchronize_irq+0x88/0xb4
> > >      disable_irq+0x3c/0x4c
> > >      msm_pinmux_set_mux+0x508/0x644
> > >      pinmux_enable_setting+0x190/0x2dc
> > >      pinctrl_commit_state+0x13c/0x208
> > >      pinctrl_pm_select_default_state+0x4c/0xa4
> > >      geni_se_resources_on+0xe8/0x154
> > >      qcom_geni_serial_runtime_resume+0x4c/0x88
> > >      pm_generic_runtime_resume+0x2c/0x44
> > >      __genpd_runtime_resume+0x30/0x80
> > >      genpd_runtime_resume+0x114/0x29c
> > >      __rpm_callback+0x48/0x1d8
> > >      rpm_callback+0x6c/0x78
> > >      rpm_resume+0x530/0x750
> > >      __pm_runtime_resume+0x50/0x94
> > >      handle_threaded_wake_irq+0x30/0x94
> > >      irq_thread_fn+0x2c/0xa8
> > >      irq_thread+0x160/0x248
> > >      kthread+0x110/0x114
> > >      ret_from_fork+0x10/0x20
> > > 
> > > To fix this, wakeup IRQ setup is moved from probe to UART startup,
> > > ensuring it is only configured when the port is active. Correspondingly,
> > > the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
> > > disable during pinctrl setup and prevents the observed stall. The probe
> > > and remove pathsare simplified by removing redundant wakeup IRQ handling.
> > > 
> > > Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
> > > Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> > 
> > Where did you receive this tag for this patch exactly?
> 
> Since Jorge was involved in validating the change, I’ve added him under the
> Tested-by tag.
> 
> Please correct me if I’m not supposed to add this tag myself.

let's test a bit further Praveen - we need to validate/trace the wake
path on a real scenairo to make sure it is not cpu intensive (although I
suspect the 2% was due to the storm you described more than to the code
path itself)

I can then provide the tested-by on the list.

