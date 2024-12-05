Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689021D5AE
	for <linux-serial@vger.kernel.org>; Thu,  5 Dec 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414349; cv=none; b=Ta4hRWeHMh6g9H6mSCG3iaCWjGja7Yzhb56sCAmrGmevj6E8jjkouMukErvmHg+jQVhuUYkLWVqX9PftLWXiY1FWtUeleZxyCTQ1EULbHG8M9crT7Eng364TogUq6ztuyELe0W+RTDsOyQDu5xwoYjxwPrLGB6Vnn76LnGHiNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414349; c=relaxed/simple;
	bh=xx6bzW93qYug9NUFOUEItSLZ3A3+XlADGHoEE8dk5AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKCG+anOb0PsZg53KlqDZeHHhjla3CPs/ZJSpoF+6w2wdjX6r9pUrBuJoc6EM7lwZRiVlTjVILsoR/DscNCbkXBTAyqu/xRONTK9MnGaaOFkfsz1Gx9b/MDdeSfwxvEQ868LayXUzkoAKv7MCTKw8r6YsWoUYDvrQK1uW/c2XGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oy51uELB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oy51uELB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56uk69006572
	for <linux-serial@vger.kernel.org>; Thu, 5 Dec 2024 15:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yszwgFsqvwEaF88/m9YMRCU6cVZhMmNKsZobuMzE7pU=; b=oy51uELBg3N//5P+
	FvBJWUd9FQzJUs4jZIfd9zQOvRiPEQtEVM1V7O0xRlESA0al6hcrmjIwgqpN0QYA
	HreH6qfGR1p9Nh0nRN7ihB0iZwtZ7E1L0yxd8ynqbBtzF5HVy4DQCrKZVqHL2zrv
	eGoQLtdT2op/1PLsYd8NZIS0ULwy2r7Tdn/zAdz7Ix8cR/J8Kd8Z+gk2gC3EdAR5
	8DpWAkxSmh5EWBHzUx59zbAbBru5ZC6cMva+O0OXY/2nkL0xhLeOy8KevXFT8VIA
	lWwRjLwYIlYRNfKhBi9DfDdhkARSjeRTDpWz+GH0CPHXVNl4ZI04eOPh//dDsLBl
	5uv3vQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3er4a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 05 Dec 2024 15:59:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4667cab5e1bso2703721cf.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Dec 2024 07:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414345; x=1734019145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yszwgFsqvwEaF88/m9YMRCU6cVZhMmNKsZobuMzE7pU=;
        b=aASx8JWEmrqQcvYJrTZj/Fgua4euYfzhbBnPclVY4M7Br6w6LjWdWC/4s6hnXLjKia
         6STo1jHwg3LYY2oERMT5oqYChkvt/j/ttH0p703cPwHxGY6e7T4W70X5NJYbGczAPvnx
         j3hoz4ZG9lEsr1vEUZIkAej8CtyNPg2XYHn29aaDwv8JDPsEJ8wl0qnuDGSjFk3A6qr0
         BxVCdIvkF1VoVOgT7tAJvXWcVd6lxz9UW4TeAWMrLZqG2m7o0tytOz2J2OsqKobpeEda
         Lw87l8PIi7L0TQ1Y5WodA7+WOXXoZ2sHjztEt0Vanx79GzSf1R8xRfh98/n9rEY+4TMD
         Je/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6DMxe7mRkHkp9Au8vi23m3lid5NRmiUkCfXd8ir0rpIDBvgHmQCXbgsYDgTN2OeKS14ziZepg3n0SP1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfm/0iEV0XcTKXo/+dUVJRElMZxu7wsSG3S/D+zMj6OZELbPD
	eJFm8+10zZpbx3s6hA54ogGdR97gbURiNAOhpQZd3m3GFS7QidVjVR8Yw6QVFfxwAG2pzWw/5m1
	jELlt8J/LOTBAUbchuZIX7tGgjIJsMNL9OWuWgpr0StmKQ7WP090uw2HwS/1rBm8=
X-Gm-Gg: ASbGncv9unM5oTRpUXdf3+ZOEwuXcblhIIkdnmNNNA9Qj1w18JjMTTZOzP/J5B8p9Kb
	GYNkIxdpD2IZTsTu2tGcjg6kVP/6rEu8mZvKSiFFb8X36FaGEaI8NSVEpNgyCUKdP2sWYHtBgJ0
	692hW7/5z5mdt1HCTHnoeGbdnBUYI6TCmDdE1gvrdgQBguLy1vz0enPh/xs8RRWHopjZ1Cyb/s+
	fIax9fbsSly9t5JPGCSJD4KNtXJbWDqyMfvKJTG53cLbkJXMjde0uCmOmoFVQ4nt9anyNm3Onyn
	ZVmOzGp3hFlgkgvGp6KBBNXvt4XTr0I=
X-Received: by 2002:a05:622a:a:b0:462:fb65:cbb5 with SMTP id d75a77b69052e-4670c75dc63mr66201741cf.16.1733414345316;
        Thu, 05 Dec 2024 07:59:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdcQYLx+GQCSQcULNKkIdrTlHsmQZvRQx/a32/wYnjknMOOl++SdYS334Mh6nI8mZ+tkelig==
X-Received: by 2002:a05:622a:a:b0:462:fb65:cbb5 with SMTP id d75a77b69052e-4670c75dc63mr66201661cf.16.1733414344903;
        Thu, 05 Dec 2024 07:59:04 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608b7dsm951356a12.45.2024.12.05.07.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 07:59:04 -0800 (PST)
Message-ID: <9d5e5b8b-aeaf-4ec8-b34a-8edeaec20037@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 16:59:00 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add support to load QUP SE firmware from
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: =quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wHFnlzG_9LtykPNXDWTxfV9UXmMNz-Jc
X-Proofpoint-ORIG-GUID: wHFnlzG_9LtykPNXDWTxfV9UXmMNz-Jc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050116

On 4.12.2024 4:03 PM, Viken Dadhaniya wrote:
> In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
> hardware has traditionally been managed by TrustZone (TZ). This setup
> handled Serial Engines(SE) assignments and access control permissions,
> ensuring a high level of security but limiting flexibility and
> accessibility.
>  
> This limitation poses a significant challenge for developers who need more
> flexibility to enable any protocol on any of the SEs within the QUP
> hardware.
>  
> To address this, we are introducing a change that opens the firmware
> loading mechanism to the Linux environment. This enhancement increases
> flexibility and allows for more streamlined and efficient management. We
> can now handle SE assignments and access control permissions directly
> within Linux, eliminating the dependency on TZ.
>  
> We propose an alternative method for firmware loading and SE
> ownership/transfer mode configuration based on device tree configuration.
> This method does not rely on other execution environments, making it
> accessible to all developers.
>  
> For SEs used prior to the kernel, their firmware will be loaded by the
> respective image drivers (e.g., Debug UART, Secure or trusted SE).
> Additionally, the GSI firmware, which is common to all SEs per QUPV3 core,
> will not be loaded by Linux driver but TZ only. At the kernel level, only
> the SE protocol driver should load the respective protocol firmware.

I think this is a great opportunity to rethink the SE node in general.

Currently, for each supported protocol, we create a new node that
differs in (possibly) interconnects and pinctrl states. These are really
defined per-SE however and we can programmatically determine which ones
are relevant.

With the growing number of protocols supported, we would have to add
20+ nodes in some cases for each one of them. I think a good one would
look like:

geni_se10: serial-engine@abcdef {
	compatible = "qcom,geni-se";

	reg
	clocks
	power-domains
	interconnects
	...

	status

	geni_se10_i2c: i2c {
		// i2c-controller.yaml
	};

	geni_se10_spi: spi {
		// spi-controller.yaml
	};

	...
}

Or maybe even get rid of the subnodes and restrict that to a single
se-protocol = <SE_PROTOCOL_xyz> property, if the bindings folks agree.

We could extend the DMA APIs to dynamically determine the protocol
ID and get rid of hardcoding it.

And then we could spawn an instance of the spi, i2c, etc. driver from
the GENI SE driver.

Konrad
