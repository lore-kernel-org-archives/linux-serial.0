Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357B32470E
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511793; cv=none; b=SBpF1SMhK8pcgmr479t5Yj/QSOlz6OmkVLKQ7VCWAUMs9rXAJ7u8QV0374xcMf42iH0KRRCAnmAIBQbwLmHP6iXmbw1UvfGEFlTYKN1/Py/WTbtIUHhYDt0IglagmbvmKZQ3A+s4lzODMtnuTlI7aYJOTySTEgdgMYAZC/o+rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511793; c=relaxed/simple;
	bh=i5WV/wG5Dqysz3kgPy8ahQVJUTCnfA7qqWTM0oCKVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1pmQTNgOnUmhlSqpDlwZuDpr3q8eoqnJH0cUGkRTd6JK05xliaGHqQ8GzB05MPQKzjLhmSTnyd2Xt+ipa0NSwFbLKauwSv5lGLLGh+tt8e75Lks/Ml4sIRsm3eIzRP++FXOdQeprNu+qlH6mzLlExgmJBO3UF26BCT623EmgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3rY66/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJC0pqY0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rY66/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJC0pqY0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mgWW2945695
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 08:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=; b=L3rY66/ZPsUMtp1m
	yZ5+t8eehR1pILzku+yzJTRv9c8fPHtBIRhJAtktnQcepeykDJVJPP9dFR2egT22
	WMOXcRbe7Va+vtP5a2Tw5XvojiVIYPLjk+2ee/Q+6MSvITBw/WKAjdD3LvXvVF26
	LHt+lhPazQ0+TsN/VttyPFw27t8eLdEf22Tlki6wwUyZl3ujIeNXuPW7NsMR+17k
	RBztDGxY7tL+s/J3A3kCF348jxqh5vXyDwFaa4WQ+fHJXk80JFxJ/g66dtXvCviO
	mvoG7dfdtvdRnFPa8nMAyyN5Din8JuJqzFYNdbhOwTPy2doKvYdhxWwtaGTwxuOy
	WGtymA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd0paf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 08:49:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930bd2bfc45so13754185a.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511790; x=1789116590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=ZJC0pqY03lNzU1bS5U2QmJ43xCEZkGhJoFLhlCtmUuci2T5nrM5Syaim0tOEgEyL9y
         h5PgqpWtQH99ohsps2z4Dz7LISjT4Av18GH9g0LX8rMMQQ8dKtEOgWtUZOeRCDOW53jo
         8Gn73ejHn5YZUMspBhEzZHQUeO6+A+ltWCKwCdYtkZREvoZ3LXHuqzbvLUfAMKWKd1Rj
         HPG4TpV5P6Cn6pRsgIwDAJU8u/kCj2Dlf9z2jA2tMQ2bxNVewzIUYLjrEsY9u4v6f4/5
         WMKY3s1mlItWGdffdfNn6Whbui2hIT83V8fTfFcxh9QKcA5EHd12N/snvqzdA/CieXdi
         i/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511790; x=1789116590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=TnE20wK1QRKZ1ywIAfnZc671ejV+dxZ8DAtN1FRoEDiGQ9XaPcGRq2v09Hroj7ldwj
         u2uL0IKEaWHcaHzvDQT6G42UAjt0fHlz8YecQLMdS4fo3BBWhGKAohpx6aGbGhcPoodH
         GK3rHmXT6sS7o3aX+OLulqnhV1FqXCAGDP0Q/2pSRAD9VEfrGEuh8Pho27OJA7i5PBGd
         LXJGrgPBh3m59dx0zXJS5MCBUwgBDNg+pg4V2H6eYOehgjQ1o9HQ5x84sxOTWiByI2tW
         NsONXL9olxCxFU2EDy6uiweC8eNXw7+3RgNSWQ8/rhdM0o2jcD//AikdhS/gl+RdVCOo
         r/uQ==
X-Forwarded-Encrypted: i=1; AKwUvByqKWIYVpuZis8m5WkUoBM7Je+skIPNKVu78sj7OKm/q4t+KE8O1Y7RLS6bZh5qq44kP9wGDuE6tPTww/w=@vger.kernel.org
X-Gm-Message-State: AFuF++k1M2PD/QX5Lz53Ey9S1ZPBibe0zT04eqgMcp88Y1HkzIFUcANG
	MILec8wwjNAUJyqzYeeUfECUdP4soaAIye7+HypkKYxwK2ftQ5S/rcMzpPnCEmB9Lnu66g20DvB
	s0iCyEcu1lh3GaOtqKLdgxhtWlsy5MJ9rO2IetKwfjNIpp5sfSndn2YWmdenuxMsW2gc=
X-Gm-Gg: AYBFou0EOPUWPuw+0tBA9K1bYWIFTvpTfzSaTVplCRCZkiK8fi1QAb66fkMvXWQU+SI
	q3+rJJXEdBYWynmCM5e8gQPIyFb/F6+Ecc6dzJMqRcimr2JDefIaDoJcaHgpFANhW3NqSFHzjFX
	hTV8E7JCSJBIDCpC6M0u34kFNeGiTM8GiARMoIRAUYqJfrFm6DRp0LnpHWDYVW3LYNGnDjPeUZR
	w+Z3b/kyqpJ5h7u0VvqyHkx+p/CFWFXqIUoy2twSIqBfXp5naNMyjaKYHbsauZCGxt1e2Kddqlo
	t17VRLDfefgMRZ5yoMW6dlyWLg3UKys3aK51dOLfu9AcM0jBqBp26bhDy9sG1edT9carDkkZdHz
	Cb2zDs44Jbt17A9Hra1lIGg==
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146196885a.6.1788511789703;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146194685a.6.1788511789302;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6a1dsm867795a12.7.2026.09.04.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:49:47 -0700 (PDT)
Message-ID: <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JsAAx9X2EvzqdDF0q0JWP8fTs4kfv085
X-Proofpoint-ORIG-GUID: JsAAx9X2EvzqdDF0q0JWP8fTs4kfv085
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX+gFKorhbr0LT
 56GBm7a1GxHrRNBB4LiAaFNHlGRSyXBSYXxeXIlc99Ln8XFB81fissUG2IIbCss3BMVuyKuqOsZ
 UE1uPxQnil88TGcEyRc+zAtB1R/09Hs=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9a862e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX6GVouOkz9ha1
 4O7irq4D7m9NU9GI4mgn0HUJupO1vyLJ3ZqWbnSF3SPWNDCum2TZux7wYGhejEaNxDQhMEeE3uY
 Dd75KKZuAuFbrOFD6hBOTofNBkyOw5v8PCzNjg+Cbp7CprbVNOKLHVYM6Aw0zv92xG1c3t3maoJ
 A5yXo103SK4U5rmVIPbl10x87a5cfJWUsCqVtkT7lemt7uzpQYDNfnARRRh8gV4noLSeCHh6WtW
 358f1Ie3TWMe9NteHcaj0KuO+8IU8ewhtG90Pnl/ncV1HoXlZFzh5JbDy3N/HPvaRqALAluSKKW
 uxWScTGAzu5h7z7NOhLX5RzVAWPIdGqPZO4F4JnoYj+NSz5hVY9Xomu2rdzZsPT5aPUiCnqoDET
 SyMmuetnjFsfhpLAbxFn9WOawryO2iZJ1mA90I1UuWly2LcdOxmUenDI+W7AyWWxxJVgg0+coHe
 ICoV1YcLHdqL02o3nFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040080

On 8/27/26 7:59 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.

I believe the opposite was the original intent behind creating
these helpers..

> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.

That is, on the other hand, a valid reason

Konrad
