Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CB224D6
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413276; cv=none; b=C9IByboeaFtkB4MomJdjk5rlfLDgFr5PcoEkzYvIdhpCeBkfSGcl5Bo4s0qk+vAi2he++kH7ckxDbdBMoOdRWsJXzEzu/SUaUlL2VMTDqMh8qqxFAOPudE6WPCVsaYgdepRUKNFbZBBeaZ+MN4aNm+LxQ38GfonDuPeoGIY1cco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413276; c=relaxed/simple;
	bh=wd9BuDyfY2g+YcmDFO0GJF3WmdKVfVi8IfjkUW9YZzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1pcB6R0e146aFcnibhEfRxWBpxgNdxmt4twxhgARWWEDmw9cHp4ifQYic/QlOTh+o+KxAx8zS9DKA4ej61Rmt9po2eYUVzh6rheFvbuINEk+7JG9C7cclonhAmA0xYSxPqnIf13io9f2JMfve3kQT1Fkxj7LXwpUHxD0EMgbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jebbOYq2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jebbOYq2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAIN1X008439
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 13:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xPikF6CHMtboH8wVgZUcnmTj+ScLp41cXAhI3chWQ6s=; b=jebbOYq2L4NxvuWT
	OgGT6NlsvwUlxEMsseGJeXf+uSDT3Phwfeia/pLvt2f9Mnd3upe0+fLHgPZxcmYs
	cSyStGCmznyp94Ooi/KJGUQXCvp4rv/3pmWuXf2Z4yLlAvoZqHOXUdUnOcIBckFf
	QAMokAIUHz7BXCsvvbKnS195TQ1Uzbpk2Ua2wF4j1BKE3djSoH3htCccvH9nzC25
	g4E7BSfqA7CoIQvAGQemCJrVKhA3dQJb+cavut9Zp+vK54xBguiVItxHrop4Rf6t
	Cd4mng7hAS2DtGBoB5+xU1iTO/pqAKxjQkj76N0GNGSWPCWAB4BMFsf4nhzpv3BR
	65supg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5a6mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 13:01:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c545ac340aso37935185a.1
        for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 06:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745413272; x=1746018072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPikF6CHMtboH8wVgZUcnmTj+ScLp41cXAhI3chWQ6s=;
        b=Pi0xLiK+2fMg1U6BeHxpRrxgDaGzZoNo7l1DsUIdMCIxGWFmKd5lX62j7LPjUk1Urq
         XZi9Hc7hMzA8km2Z/VZIuNqxITYzI7cfJfZmhT7nrrSEjHjZj41rx5w16amQEybgrjwf
         fEHd3gIyArxTwPMHZV2YmGhJdJrUgzd2CgtTkUInwR6xFFTb6/5K9jtdVnQwdLxmnkwq
         Xy2Sbjgznsr+W5GwtIHZOIHH6epj7957t/CcwHTDQwIRel0xbXlNNEO/GbfBj08dv3lg
         jpbEIXRF6xw3LU/JvFq0rcl/ErkYFCqRAm3Iky+EtTi7uoX4xv1nhCLcLWgI1gA4H45L
         hRAA==
X-Forwarded-Encrypted: i=1; AJvYcCU/8V5UPCxE8SxJ0ZcWQs0MJ/6bkrtFbR3uh0tKc0eRtovi525KcpnFT5Jsn4OgH4we/ucCwqdsH+1oUdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYo9lWfmBWrndPm/W9WAvm0lNadpFcj5GGRzpgQP+9sIYdGEXj
	5T/aIaHTF6CIiccAWWsjv1DldnE2Df+fHadquR6BHa2hgIIKMErXfcetrX+pvpoY/r1hERHOBod
	1hVRbM8ZTjOD5V5B3AAjC0LIuC9H9z2mYhYGyBbGxfFF6skdFcJMjTXjvGAP5Rwg=
X-Gm-Gg: ASbGnct6pfgjOQ2cUS+1aM6nnLqEzc9Cpm/d9uCOVnC5lkKSNX8ell0XNtF90t598tc
	rruw5W4b6/yPZDK1t77+miPjKuuOx8qvKc88kQT25w7WQ+jz5wXd1fElnl27wGr1Bls72J17B5T
	Ku+6Ugb+osfMgJwYK82d/PtG2zLXfwU4iTh6bp1+Kxayk2y4/J3puaI7KKkZQ+/OAAenjF+yicc
	4X8NZKd87rPQFHSJiER5R/hZ48vX5MZgKYFyJlNM/PiIgBFlkxM1IEkktfQ9J/CSagilx0Ky8B4
	m7OaZcJNGrcv16Aqjk7rTM/tI2TOoJnCzzqCOOPUcg3lqk7ucGUCay0oSXQX+C/T0JM=
X-Received: by 2002:a05:620a:2584:b0:7c7:a574:c0ac with SMTP id af79cd13be357-7c94d234d2bmr199585585a.3.1745413271774;
        Wed, 23 Apr 2025 06:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvC0BBlTo+m5g1Fq3RkWdluOAVAwUmBFljOPIeXR01i5VEzyjJw3LAtEQjfmCHpr6YmNfHig==
X-Received: by 2002:a05:620a:2584:b0:7c7:a574:c0ac with SMTP id af79cd13be357-7c94d234d2bmr199580785a.3.1745413271071;
        Wed, 23 Apr 2025 06:01:11 -0700 (PDT)
Received: from [192.168.65.183] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc72fsm809912366b.101.2025.04.23.06.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:01:10 -0700 (PDT)
Message-ID: <6662b275-6b8e-40be-b62f-c17ae8e63dfa@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 15:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Enable QUPs and Serial on SA8255p Qualcomm
 platforms
To: Praveen Talari <quic_ptalari@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250418151235.27787-1-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MSBTYWx0ZWRfX1eByWRJ1MoIr GhMsD7hRc0EDqvPsWemPbLCy1ypBMVONNf4qr5ffbY8kLW5UnT5682Gj91VuNxOaHly9v1aK0FO MxFgKRkxmvHCK9K8TpmZ7fZ/wy9U6V4wXkmXzxdKlq2WxEfq/qYig8xoWgA51e/V79kW8sZE2Lf
 WtJ3rsUWelVLr+LVPBg4w1wG5Hvl/M8bXjXwT5tQEg0XcpPIVwxMXS5zNKbytYve1y9D4yB2kyE EtPBtQErd0clrOtG8U6UZNDyNqJ1sPeAQxgaVcnzbz6ZP0DtP1ltg154WulSYKWV6tx6jj/PnrO A98bjyy8kH34JSaUcoTqUnoEWtovqxd+WN5iHf0KwX8JdcUU7HTVuRD6oFRXvBX9t6bwd2hEWg9
 F9kqjrIOItcZHx7rNee5ohXUlzC0KwZka0yfOPtwe/497K2y1pQ0UrR1tyW2qXqchViy5d0h
X-Proofpoint-GUID: PvPHVz7V6_0lTqsk2Y8FYLUfbXA9cPjN
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6808e498 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=TM_zcG2lH5YfWnRg5aMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: PvPHVz7V6_0lTqsk2Y8FYLUfbXA9cPjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230091

On 4/18/25 5:12 PM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM. The device
> drivers request resources operations over SCMI using power and
> performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
> 
> The SCMI performance protocol manages UART baud rates, with each baud
> rate represented by a performance level. Drivers use the
> dev_pm_opp_set_level() API to request the desired baud rate by
> specifying the performance level.
> 
> The QUP drivers are SCMI clients, with clocks, interconnects, pinctrl
> and power-domains abstracted by a SCMI server.

So I recently started working on abstracting away power controls from
the SE protocol drivers into a single place, among other improvements

A snapshot of this work is available here

https://github.com/quic-kdybcio/linux/commits/topic/single_node_genise/

(not yet 100% ready..)

I think it'd make sense to get it done first, so that we can condense
most of your changes in the common driver, where we'd swap out the clock
handling for perf level setting instead

Konrad
