Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F03A7F4C
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512410; cv=none; b=bsjzAC1JKMBtvWeZE16N+I7lMvBSIfjSn7eK1WF6nJnUqFVJlD3uzFuAl1TaSww1GVa/QC3xLf6xJWNe3KGitTWD+xJUvBewQmeZ5g76yhIPwNEMEAgAins7WmSTnwU8DmKtXcYOjP+A7SxPDyhNstorDTAB5ZmfcRgmZ8KfVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512410; c=relaxed/simple;
	bh=TwdMkfkku+7xLhkQkYda0UxtIy+OV/r23+7AedMhDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoRXPGNADg/bWt7eEZZ533j4jNDzMIWNcnTFS2/NCeKL2725UoqjmWwWNO4y3fH1mtP1O2DmRK09C86c2p9VItfZpv2ZZXpl3YMWNWJeixUVWE6eaNOy+td17k7TRI8v7U3vTtQG5u/JEY/wyE7F+ouHg0EkEd/ogSilsQ271y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgwQcusi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/Hdw7uz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgwQcusi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/Hdw7uz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847meaw3234504
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 09:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=; b=RgwQcusiD+sBqz0F
	jF2XOTgx2pvLO5qTcCp/KU57VdohSxr1FqohE1cUY2tk70/TPuqmFfLaMLktqg5G
	p4MqrQnqlWaHEFJUah4LmnpDevNJ2eLS/gnd0y1pFcnONHPfRtNjZQIVvRymxVSY
	v4R5GIk+wNf0LXbGizShkEWD5YmrmXmp0Xbd1PHNjPXeDphndDl8Ddm1kU8w8OZB
	/YZ6QQtzCG95q1v9KMPEviI16gYbWaZVyfLdO+kisFMjX9kKo1Ks5eGMfFdUZiSs
	rUPqZPmbNa63fw8kXGxpLCAHsjUTGkR52R5Qo/+UoO25SToQqlmkMr/Y2+Ue1T1w
	ifDMYw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r0yut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 09:00:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494b1e35cso14411085a.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512407; x=1789117207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=G/Hdw7uzC9kSxjTUpKvoU1GE4jK/dz2XRkpC78NI5vjF3hhQlTy2ZTG3xPq8smfCa2
         LrWRf+IGlXm6a1tAzfz+Zd1Tw7SXd1S0A54gB3vUChiPRnqpvrJRiOynY93pO8VdjjLf
         IzEEJ29csUX2/cqsiciEgyIsl1xqKLcdMbybvACo/G0DROHxBuY/LUWrC4kmcJafjEHD
         NiOm+7wAYTIa/wLjNyUQ6O4fv+kVOZeoXeW0VtfH9rKH8Q9D6UtJQyvYmeYfZF7W4vMV
         VHBj9m1H4AM4UtkNpZ/nckOtgOyDqyrjjLwroLvfNxzMdmHtU9zt8huLFAmsek3Q62nz
         4OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512407; x=1789117207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=KHmRpmYk08Mwt4VuO4tk3LlRmLuJ+g9B/2wKebGgQhd4AE8ElBLcTdcXT6Xn6dR2It
         DCtnmZ9emIT04yfKhQsC+m2RJUcpjHySSuD47MKw3mnaChzzOHU7MJp79vl2t800GYEQ
         Bj18t1LetICU7YFZZY+UwP/OiATnefCogDbyhU1l/9Za3VuyHT/Le66PGYIVp/JpXJVE
         A8GwMDQMxR5kYakK2WTBUaBWOANcFH/3reLjOnsX47v30KhKYFwaozGQknYSzrMb8LKG
         wPklGbfEH8fjIhzOjKp7X7Mlgsglv/upCn4htvHNU5NDsZ5eZ8bu7JT2zTRuqJ5xK0AT
         6hTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy68JjfQgfxXc35djxqKZptsKWNeGZ9sGNaH90/OIIMZPwYIfoEV4kbaDWZXTo6VOo3hXgtJHQKgl7tsHs=@vger.kernel.org
X-Gm-Message-State: AFuF++mwdFPVeryXLhGqBsGeILqDcR3PWh+hO4B03pmJfw7VybryR7nh
	ATpV212+PfJPzA2jc3I6dR/cAlIBULpSRZy0XdmzFPnFXpGE3ZA5EaIoTmB+/CeEVYSQqnquVge
	fUQB5KB3Iv1hJvgIukOujkMYHf3xjdNf95JkvhBVnsk+XdJr17JpJjZG//2WDBYa0s6E=
X-Gm-Gg: AYBFou2LM0MwY/HX2dCSwqeEe3dnjel829et4pCFc5L/aYaSdx6GATY8LU9P6VIguZw
	nbMd0SCsH++vZtQPFs70t3FM4EgARwU1IaTU8zGfqR0MugRxku+kyseCTYBRXGo0M7kupIbtEJL
	KRV8lmWZdOJ239/B8Usn5EecGPRyTLopanR3Oo1aOSZMwTVQGYEgbufsVzMClvhylujGVXga/5P
	SPPilgz3GBJvA0XK0fEY4lTzkEiWYWKblY9L7BO1JJNqruO8QKK2yTlmFBXJ6Jfe28eZ2IvioUT
	GWwVhvZpNvDUeF/G8xXjLK6AvCRTyBMb/bC1rYIP/A2AzCeMJMgsW39udC0k8gmnsWHWKGp8IIS
	T1wPnEvPO8W8z+i/OasqLQw==
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285929685a.5.1788512406321;
        Fri, 04 Sep 2026 02:00:06 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285923885a.5.1788512405649;
        Fri, 04 Sep 2026 02:00:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20c0fsm895767a12.30.2026.09.04.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:00:03 -0700 (PDT)
Message-ID: <0f5494c7-c3c1-4668-a09f-d8c43d1c58b9@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX1sY/IGq3v28F
 xGYuqsXLPXcO6u/DG/VveUmfC8+gAOC8ALW/PxJJxNQKwaCJXnj5jtKLLZl1pCjko9GAb4IXtfF
 uS4Vj06l9gbJenkPyjt+eaUtOz5fYsg=
X-Proofpoint-ORIG-GUID: E4HHNwb6sKP4ofBAXQPlNtaFgEjQ9sjp
X-Proofpoint-GUID: E4HHNwb6sKP4ofBAXQPlNtaFgEjQ9sjp
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a8897 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tfn4aQiUfrmVOWBwnpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfXznHJ8+bmQlKh
 VkFcaS2AbUNpMHzWOtB8RJXcChxbDcnvm1vDClgBWOva+4zi0C5xH2dukE4YeSdgjQ4q+ArIIAG
 2I7qBqGRKqgutQ4Kwv28bLBvZlgXbVMoqZ/XKKpqztF4JX6JzUneAD6XnujeOBRmt/UjzrfBIPT
 8CfkyLnECoo/eqNAwBEjXYO0rt0wMSKUEyCZl1FVTPTOz+PRLwUIKpXk0lICz38bh0MlIxLr4rZ
 aseug2syISFNjsvSxRsKiIyz7dP91rnrsjbt87beOkbAA6iivDGgfyBVZLMmt1SWX55nuo9Frpu
 wuJbtoBjsEjnu3EC1PHvRKse8vDRZAYhj79TSRcvMZWapKjQaMS/d49YwYGZR/zrgzaIkII1fUs
 /5C0GwJLfo12HuNvk2EsJUTc7J6g/PTJxjEVHDhCIkUIdWzjNRy3n/cVYNPd5THLR/ZNlpZvHj1
 FhfC4rXmoSoNVRlqi3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 9/4/26 9:56 AM, Ulf Hansson wrote:
> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:

[...]

> So geni_se_clk_freq_match() is used by two consumer drivers today,
> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
> 
> Beyond the $subject series, there will be even more consumer drivers
> that call these platform specific functions. As I said above, I don't
> think this is moving things in the right direction.
> 
> If this can't be solved with generic frameworks (clocks and OPP),
> please clarify why so we can figure out a better way forward.

The way I read it, isn't geni_se_clk_freq_match() more or less
dev_pm_opp_find_freq_exact() called in a loop with an increasing
divider?

Konrad
