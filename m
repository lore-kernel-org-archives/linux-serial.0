Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DA2737F8
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770571; cv=none; b=KFKRW2OOq/ikfIRZDpGcuxsMWgz+FLTf8TzIs4HNW9HBSUs9RTEM6kIUowjS3RIYpXcO9Qq9mfjDldrWxVUmFTR5RBGfwoF7lx66WKgPd3RFwiZMrxHpJdNVIy77EcAYZ8zL/X8lmxbU5CsdDwtlknFPhTmyM8ytYE/SAaZxMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770571; c=relaxed/simple;
	bh=0s5ogU8Ny3BDFLf2wTMWEaevVMGi4VfIETTjQfVCaYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGfu8NTM6FwytYguzolOHHlLcy9b3Mv9Vj0vkHj5oj4l4pn21JiGTQNBA85OTCz1SsBOpGeVxmtV5HAsirBu3LOc4wR8ijm28A69QqWfUf7pD1oGo1T0GlCHDpxrqARUb17CIzISy8MYDAwEvpZKqaRrKEIQkhAN+aAW8P01MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uh1riQky; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8xyRfwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uh1riQky";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8xyRfwO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60735rNx364733
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 07:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=92GOvSiSagmOah1XPds7iS/X
	gOGbNOfvvHXLtuXx0iw=; b=Uh1riQkyjL0TZYimzBwPjHxSEK6xzQAOpYCF9hG+
	OrT5CVZm6CwiA6OIwQlqMVXCAflYsoUUduTbt/XvsHLoWmgf3eHcZo+LjZnptkdv
	JNHiW3ZJdmiUwQyDFwMe816gosqgNJwbjEwEAlxAGYrKmdR452BXqoInpmLGG0MI
	27TI+EgBvaZgwQKTVb6W+qnaPj06VVznpVhvN96snSGYDHcsn20jA/LnjUFb4+ca
	6ABiH7ltNiU3oQ2Vgf3U0/MOpVoyUP05OEtFwnTuJDvL/V6twW6GwWMez9Ne2Vw/
	pgTsLlwjswJ0NyeIP4bCZMGgrMskKCEq+uVdRlzpJVJhpg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh660ta30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 07:22:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so3750268a91.3
        for <linux-serial@vger.kernel.org>; Tue, 06 Jan 2026 23:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767770568; x=1768375368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92GOvSiSagmOah1XPds7iS/XgOGbNOfvvHXLtuXx0iw=;
        b=J8xyRfwONQMtDdZwA7JAYEs1UdsKhQ9L9LGq8+YFfVAZD2zX6KgOrAb5KDF6Ftnw87
         6M0I5qr1l+reCQmc8eiRPpG8z1va6cKV91OOaxBNS6pgRvUhThGqRdh7DmiSNm9+tsDg
         n406HThCffL/5ogs3pwc/SITpUmBtBdK+Pz6qqQygO7cFN4XA0oEV4YIWbkE6bCmxby7
         Is8IV3PYDlhXRjWx/LZdbFwdKg9068nbUeuxJLSqfBZbUPl6hgUdOQ1LyWdrCkcYfpv/
         wHiqci3BdmII7GAXl5D5zEpmVxFMfcSUOhRfdVDyD0XP5TfTKoM3wMUP0GKfCbnr8kCI
         8Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770568; x=1768375368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92GOvSiSagmOah1XPds7iS/XgOGbNOfvvHXLtuXx0iw=;
        b=qdkZzGwTG2EUDFGxsi75iocNxJtReBDLeeOAO9P8PNIriLh4z+vOY0DuXo7PUvmpoA
         FsOx2IOyN/qeHBMD7pTH9DEyTiLPqdnBHekEv8YHGzs9Qth+FqyP7u3FcVqzwcvzst10
         HN7I8g6DKXokwKGgs8ty3E8Kfrwya2BHwpLgbIvilti4k5LtrJ/RZ1c0NZUyt+3ZYepN
         S1+FIaZUqunTEzztpQnRkMnG1jqW+7BOynF4ADESiZkI0M+34jcIrQV2l3XAVdpxEanE
         5na1MImOCpa16sF+ZHgyvzkk9YQQuEC3CDo/2Ci5H1/5JKB+dsSVMZ63iMJkcYcSWQA1
         r9lA==
X-Forwarded-Encrypted: i=1; AJvYcCX9E5swLkTuEcMSVIPPYC4ciL84OZeVoM4uDJrFrKd2/17mlFB2wqwCKVroIg1BiazQPc6xOv/50WH91gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GLYh6RC3TiN8MI/vgvP6enD1ISwZ+i2B0l+QL61zvsX3KF+7
	ELCk5zHmY9MzaYW8lNBzQkHtAj/iJbSzjE5Kq5d+q6PDFISJARPst5NKUn+BfCbIDoLhO3CkLH+
	1afyLU2AtPaiv9+cKZ6D1KiYXPUheIO5/dfve43L8eYY3uqOfFJbHQJrUB9fv+R3gXj3Aif3J0O
	hFLgEiPP54c91tcXwhCgKYpZ79SlYADalIWrL1iSxpUA==
X-Gm-Gg: AY/fxX4z+g2gu4FQqmlOiY0BYakq890x5lc79B66srJpro7EI7yaU2jkYYvs5col6pO
	bPPS/farGKOmrQSrmCxaRMUoaxpS9qUA0zgiRiUy/138k+9zBKqf5cYp5xRpBwSpP/ap7D1ZVey
	4atPhz0UFiVOYjvC80aywCNMUXaF8w9YR4WeJwP6saoHnjxhbwhb4ykJ8SKzmNsRum+BjrgTrUP
	WfIL/y3
X-Received: by 2002:a17:90b:524c:b0:341:8ae5:fde5 with SMTP id 98e67ed59e1d1-34f68c4d71cmr1601848a91.18.1767770568193;
        Tue, 06 Jan 2026 23:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbklJFAR7CqffhtOd8lNYB1tmIhVU8vocv50mwZhpy3yHsHFyX1O1WbF11aHVp1CHGw2hWWc/72hVmhAdvqkU=
X-Received: by 2002:a17:90b:524c:b0:341:8ae5:fde5 with SMTP id
 98e67ed59e1d1-34f68c4d71cmr1601824a91.18.1767770567654; Tue, 06 Jan 2026
 23:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
 <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com> <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
In-Reply-To: <be79091d-3b2d-41bd-9303-2c8a64dde9c4@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 09:22:36 +0200
X-Gm-Features: AQt7F2oaorDosUmrR28h8cVfXVCANqFJ2_dE2kQiemlkxgxhdIevX-lBDHVeAug
Message-ID: <CAO9ioeW=7z=LchdOOfdtujCGJ5Yb3BxeLA_w=ktYQjgpyv2RaQ@mail.gmail.com>
Subject: Re: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2 platform
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        bryan.odonoghue@linaro.org, andersson@kernel.org, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=MNptWcZl c=1 sm=1 tr=0 ts=695e09c9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=G_Ql_pMG0pO6KvxD_4sA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: cVNf1mWSMVL02mXsmWsMnmytrz3Se68w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1OCBTYWx0ZWRfX4wKMuG/gdJKn
 css/zyT+in+Qv3hxzhqTKfrpmpDyeIYRxDBRMAr7Upmg3v3OYG/HLguR0SmsBaIH+7KxTxAhDBT
 AWVcYVOhJ8J68ijcOA3Z+/+sfy6CN019id43cuaMOhPf5pk7Pf+1U6/Jp0a7nLoPGE1OqGGT6DK
 2D6REZSGdBbLWOmT6Ys9BtXYi9u+CFX2CRJfOZkAnEcHMV6E7kT+GKx2SQeW5eZF15acV8JTKQ+
 lhUXCQnKs/OuLe+DmDUJy2i7eJslPxPmr2Sh2oEieEqni44wUHbHxlhSdQzpwNA4eVRQTpqSBX4
 XZjCUeg1n0VIPzGoCENJmx/dIIdVwPi0+kD9c6ko/66pICByNVNuKR5emrD1bodtSygR2AO1UKb
 kayUvOygkKkRFYwDMRtcJfbBaYhRXbLfmEEfo4Mt+J1txVrSg6RqvbzKEI/yy4UhK7vdGj8CXvN
 x3XDVNwmN6oSDYetr5Q==
X-Proofpoint-GUID: cVNf1mWSMVL02mXsmWsMnmytrz3Se68w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070058

On Wed, 7 Jan 2026 at 09:06, Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Hi Dmistry,
>
> On 1/7/2026 12:24 PM, Dmitry Baryshkov wrote:
> > On Wed, 7 Jan 2026 at 08:48, Praveen Talari
> > <praveen.talari@oss.qualcomm.com> wrote:
> >>
> >> A regression in linux-next causes Bluetooth functionality to fail during
> >
> > linux-next is an ephemeral thing. Please reference the exact commit.
> >
> >> bootup on the RB2 platform, preventing proper BT initialization. However,
> >> BT works correctly after bootup completes.
> >>
> >> The issue occurs when runtime PM is enabled and uart_add_one_port() is
> >> called before wakeup IRQ setup. The uart_add_one_port() call activates the
> >> device through runtime PM, which configures GPIOs to their default state.
> >> When wakeup IRQ registration happens afterward, it conflicts with these
> >> GPIO settings, causing state corruption that breaks Bluetooth
> >> functionality.
> >
> > How does it "conflict with GPIO settings", what is "state corruption"?
>
> I mean the issue occurs because the GPIO state is being altered during
> the wakeup source registration process..

Altered how?

>
> Thanks,
> Praveen Talari
> >
> >
> >>
> >> Fix this by moving runtime PM enablement and uart_add_one_port() after
> >> wakeup IRQ registration, ensuring proper initialization order.
> >>
> >> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> Closes:
> >> https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
> >> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
> >> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> >> ---
> >>   drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >
> > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> >
>


-- 
With best wishes
Dmitry
