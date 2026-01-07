Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45B21A92F
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768860; cv=none; b=ghjdENUiHqMIomnC1ai7TSQ8aeAqzZ5xliz+mB4rPXPaVvHngWVhCeS34u3I9Sz7/0uQexm3AJTN9PiKw5ZMeTamGhDIXT1KIqvxuk207aTcRSxUxc5gcEoJHhliks1CKYS7qSewv/QiuL/hRuKz5tOwR2+fvVyxM+jLOyLj+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768860; c=relaxed/simple;
	bh=+3PJ+TvkjZbDdpS25ePa6BK1DlVke0sYn8/aoLnxebI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKoFeSJdOZ74XvxwGJJ/lx1o/gMpGbYlTNWfP3LH4Hd3rzI1kajnn4dt6FJTtF1pMcuRHyZv6/YFSK+KVl4W0tkdbpwUqICIXp3v/1hzDGLrJsvMhA8irDxt+jfxSIWXv7WIoRPR6mmf/yvd6CPiEFhTLf1sYtwqMPzRy5oICrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lque+Mkk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KZNwN7yG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lque+Mkk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KZNwN7yG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60732WO34137369
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 06:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EcTepQ7R/++STU1aww2Izf8r
	4iZvEbkucPFrPVqCueU=; b=Lque+MkkbTXKbabVA4VtHF+4cUug/+l1M8e+sjRO
	DOYmNLC4npynaNey+DXlmKeEAr0DnhssJ7qSgGl0tLaUF+iUcbdQ4HgLo6Xz+gcg
	DQSMinT2+/l1hp/R0o712crhAp3eOdYlGT7EpZxSFDveLzlrP2B4Piws2OtG0kvM
	B9uf4xNJw4fU7WmOXICOl+Zy1yaOnTTQOxNapM00Sr1fj/NQi1IcvCWcpWGzLLGT
	CFey9bKS/Gbo4YWPhcbO3154eSOmVVXydcCKQSRZijjT7vqiFj/g+2Qn7fuHw1sb
	gR9fQJlbLZjVmDxAVLEpz0cBFX9+N52BWZOuFb8EWeHWqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66e27ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 06:54:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso628016a91.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Jan 2026 22:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767768858; x=1768373658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcTepQ7R/++STU1aww2Izf8r4iZvEbkucPFrPVqCueU=;
        b=KZNwN7yGEin4c0KzqXfkD5j7aV/9QiGlsrbyQoAv5vt3H6RDlYmLLvGdmykXKSbVsS
         f7M5mtopsH3UPw3iOEW6OHZye0Uu3kxQMexzDVHNO8xlX9pskwuIZqZPkgBz/LnjMx9k
         FDX5cPEXMZFE3vxZeE56a9zoBMm89eKqrhp6YyD+dStS9LoywVCwI8F3Hbbj8A9xVBQW
         Oa6xwK+ZANSzMTjnaZMnhTerMVnLFmgRlBoccSyJddgMlwTx6y+w5aSX+/K9KkMgsqkG
         nKJT5jFWzmJ/UG/pKY/evqcUCDiTlCAl7f0DZ+UBCbdXmqgaIOUPu05/ncIZdFrjZVNr
         Hv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768858; x=1768373658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcTepQ7R/++STU1aww2Izf8r4iZvEbkucPFrPVqCueU=;
        b=MxEVCCw/JmefpTujBjPVGy5Y/PjedBTnvU+4NaMqzLtXoDwuitDlXcobMIiAW7dZdo
         hJk7wZ17DLskuCuJMvbUS/Nak8RtAVFgkpZNsXMYLMqBWtdUQfVtGaU4SWQTYrMjZEcU
         dQF1LYae/u96uN8i7aP78zsEIuOFp/nXm7gyahAIRTXAWFroo7OXYWkOhjYvZVn5TWPA
         aathTZTBkWkB72KBLbdXWOxlESBVU19xCizNtiZWv9DY2RAIsBTqhm/PFLkZWO2eVbhE
         jK6U8YweEORVwEbUxt5lxcEGAJXCuzt4kDP/Xwm5VyLfSDiIUa5LaDB4AnP/adtFQIJq
         6qVg==
X-Forwarded-Encrypted: i=1; AJvYcCWqRx0YZyD+GbWJCXjzDufdo0+KRYUL18YcHt8Ek8nVcJyN34sBJZoE9dqW5ylaf+Ri9doc8m5elH04ztc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZpuM1rjEUOkhzZlCC6MbHeYFqO7SSyIxmAXeOeGbGpU/xOEd
	aMJ6QwbSqZlmYvJ17K3uR1nSeM4n7b6tm0V2nEfA9a/kCmvgFoNBOtZ47lDxI2LDAAAvXQp4Mz5
	3VotgqLz8kuHOA1UMtAk6PeH0Hz5/sA5xQtOD4CUXuxIyP7rZYnULtVvbEQOI3PjlWufeMbWLNs
	OhT3vNJNeWQeuuQlZNQvyVYnerdyRfhKLdi6XFp3a7LQ==
X-Gm-Gg: AY/fxX6pjkfaB3gHCaCcwq75qZpRihFO5jI4yalR9lVlexueWrKeNC1fNk/NI43HB3e
	cvN790YuYlzkwtBNorOQ+4nfnNDD5715MSnS/060RNIcoSCqh711vDFgeexBiCVIi8RbSuBf5lb
	dKgWQ6Wu8/pbxLls1X1LEpKznb/cI6vWrKB/WFid5yASA+174cqet7zlilfg33IrJe5GWN8opQT
	5hU+rre
X-Received: by 2002:a17:90b:1f86:b0:343:87b3:6fbb with SMTP id 98e67ed59e1d1-34f5f84acf9mr4461774a91.8.1767768857875;
        Tue, 06 Jan 2026 22:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvp9rgoGp/DdjkGp8TXqU2OEkbcr3GMWgOUCniDzfxMSGtqc065zOax+ZWSCwtQybEbmLDVBB8Dvc6r1qbkxg=
X-Received: by 2002:a17:90b:1f86:b0:343:87b3:6fbb with SMTP id
 98e67ed59e1d1-34f5f84acf9mr4461754a91.8.1767768857387; Tue, 06 Jan 2026
 22:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 08:54:05 +0200
X-Gm-Features: AQt7F2qMdhOkuVyNuxoT7JRRqkGmym5R-u3pIRQndUuycMVtwUwVBV684s7xs7E
Message-ID: <CAO9ioeUsLwOs2RqGPcbeuOpHg4zuwwsstjJnTCH4-oRL=ss6kQ@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1NCBTYWx0ZWRfX1vGX95fffTsM
 NgNvXQLPfH7U43AZ8t8INOqbwWilrsl85N7yxkJ6V4u32u+ClAxG886i8i09QsgrC8stUMwActp
 FwQfjRBr3yMrQOLN66TfEuoCjjFMuFUKkLtP4LD7gz6ljJ+9/gM/8++JgAJJbJaJnXXzR6XGZzv
 KVlO1GsnIBT80fVkb68QjESMSa+z1Pok8p3BPyo7HSa1rHKRV8abNChvhzlS5SazPXwZZWnyqKA
 KwBFDyscsGO5vw/7gPq4/KLFhsExz6mb5t19n9K2AeCYxjrP7fqEm/TDvc8LcuRqvwQ2scxj9uB
 a/a79Zl7qpOU3K4DFgVJ95wEXBe7dS3wGZ3qfwnm2KuY61zK8YX6dZCI+Vq8/quh7D3KH1AbY0u
 MjuI8t/1AhfYWlzn3MKEv1hiabcxGg9ZFBDLe2eJeuohfV1tQCG2WBWwPQhOvtz7MsW97q0cVFR
 s0Y3e5W4lATqoE/7s1A==
X-Proofpoint-GUID: BHZmnxHgI9vTK_pnWbJTi2pRlPehwdFV
X-Proofpoint-ORIG-GUID: BHZmnxHgI9vTK_pnWbJTi2pRlPehwdFV
X-Authority-Analysis: v=2.4 cv=evHSD4pX c=1 sm=1 tr=0 ts=695e031a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=R9UZfdiCTnRQo2W2rQ0A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070054

On Wed, 7 Jan 2026 at 08:48, Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> A regression in linux-next causes Bluetooth functionality to fail during

linux-next is an ephemeral thing. Please reference the exact commit.

> bootup on the RB2 platform, preventing proper BT initialization. However,
> BT works correctly after bootup completes.
>
> The issue occurs when runtime PM is enabled and uart_add_one_port() is
> called before wakeup IRQ setup. The uart_add_one_port() call activates the
> device through runtime PM, which configures GPIOs to their default state.
> When wakeup IRQ registration happens afterward, it conflicts with these
> GPIO settings, causing state corruption that breaks Bluetooth
> functionality.

How does it "conflict with GPIO settings", what is "state corruption"?


>
> Fix this by moving runtime PM enablement and uart_add_one_port() after
> wakeup IRQ registration, ensuring proper initialization order.
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Closes:
> https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
> Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
