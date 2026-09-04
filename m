Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE4366553
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512487; cv=none; b=mkDwQ0kyVdSDpE3kkm39iZNa06NebrzlICXcg77/W7PS3LF4BFYORfJT3sa9vDFbmDsbfHoIXwOsqLYqlx0LGUl7lIlrapus1MeLgKgoVpZPsFNK2TJuAu+TJyHv2eqBJkIsBX+M/rLJpMleoEGNLSFgrnqWYrSX/G3KuAYN4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512487; c=relaxed/simple;
	bh=z8mUeY8jdDe+OPla++cCBqYJoVtldQxpArBHUi5E2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALy+Mxmt7ewsUqKVntZnGPFbwwu+S0QmKI4A78cR9YwRTaKx7Ka4Vg3ZOlBaR4kzpZtO8ljpfxJXbfow3krwgJhhlZO3iG4RgmOis9sp31N4Nq4M58Y9zd4E0QyZMojhXP4rBydMX/cATQ4pLHyqToPQIYGbfkFBkBqxW+nXVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdPDAK05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBhOSDB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdPDAK05";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBhOSDB8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mnvJ2351556
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 09:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=; b=jdPDAK053fGQzOXD
	4cj+xPyScRRHFDeNL8zcHzs4mOeJur0khdg/RqOwN2LWNkaAIBRuQ66CDy9SNfUz
	cdjxEZOdcuoo5xTcBheqPhDXrE3G5fga5X8nlO191lDpsOMTqPXi6oWY2jljfKQV
	59dl4zlsOQKAGJaFwidGakLayrYMXJrPbLTGEjifEYBP7lgmaCOAlYeIx9GCaBDf
	M2HQZMn55+SmjevbfDJp9azLFpkl/eyqSfKf8dsWQyuZeGef6wUQhnewV2I6jRla
	FTBgBvCfz4S00/OEhRxPpzd4j/JAyFQY6vx5JFZwoS0qJnO2TdcU0HCQ3mRYVUjR
	lvuEAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp1fh0re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 09:01:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ea38b1e7eso1984421cf.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512469; x=1789117269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=QBhOSDB8lo6bge+DCDfeiHrVM3sOSlH3kqz/P13gL8NurK61xFei5bbILuU5+kCB3a
         HMuo8xfm6vu62yaXy99Q2EzMEN17Jl6BqBXBliwKiK5YHcEbMBsKim8/hO/0fLC8czUY
         V7cko+I/GHTDzh0aTA8wyJOBZGTC2sKct13hFtlHGPIZhsFVEGrsFcCOzra7m3nvKEU5
         H2TeuKSNP03m41L3Mb1lp+PrUwJfVNFynnTrnaTGu2hvkVLJzeJMv2q4ak8AHWXCYid6
         Soshfdw4gGGdrbNcwN8p08KQ25FQ6E3bET9rqHYItl1N3y+LI1odM/49RIoDs8yTkoMv
         IwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512469; x=1789117269;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=GZQnUedkQ8RCYy+HazEjHpy+dA+TbZcQrddH3WKn5RrDVVZYj5b2G2hJ/AtCO2VYE+
         nY91K2+pUEkxyHGSyYlmZh+3vEwkaB5IrMLpIHUR40/1/3fzOk+ZNJlAnuLGAgVT30Tq
         hb3qcht4mN2xUFp05hPDktS83zqiFBiCUnLfHIX13cUdnCGfJKRA7dux6RGAOiK78+lA
         jL+8sq7O4pxiP2woBVRZtCpMGZ6qDRgXGnNEe0Q4+a2yQJY+km1Q3IcvcvO8LIjAsHjr
         OHCwnlhYYS94D5wGtnZveS2mXIOr48UA5ZOZbpNJHVfDv7rdkkDu6ztxYp2kxvpQWlTq
         lfbA==
X-Forwarded-Encrypted: i=1; AKwUvBxzPv3boo+gnnQusutkUZ7i/j00X6YoOBSeRNS+d8Mf2NBAPZQATpu3eYH05P/KgmfsZq7VKBnRGt9JTxI=@vger.kernel.org
X-Gm-Message-State: AFuF++mD9X5aWkR0phqZF2zTkH4Q/WY/7NQ8OsvmWi4/DqJjFgAd3JMD
	eExHp3qTzy78ZfdS2cIVYzU2InRrPfxbWerikSadDgs6FFF1LMqtCPmmGFQbYAPlN7UaUkCjvR+
	ZyMn8OwAQ2kldfhL9hqCdqwgTXZrpgmI4iV3/bj+9gFIn3m9OVMUp+/fyQuBt3A0srcw=
X-Gm-Gg: AYBFou3rZEV81Gkeuea2XmZHzj3uWAit03JLQajq92gVs72Buk0hCh2vm15gU3o+3Pz
	qe6ZsKhfGqEZpDIUScNn09FxwOQGDaMY5FeQtb5sCjyn2NIqf+d10jn8/+JD+zmtzip//pSs1Nn
	L1EbOWZnfTWuisNK/hSHe3FIzXV3xeSvjJ4vCLal/qhpmNx/WWigRaUyasfK4OVVVzomu/tiR0Y
	HHiPCANjfARBTV6enKBTZzPr5K6J03KspfBRAwEsbvWgy/ov5i5vF9gTb7ed1g5DaqqRm3dZ7jQ
	L0MEZS+yu6FoH0KRC+SAMueljDHAwYkw+4KVHak2gVopXrLbmW9m3ItjDLJA3sqlmHAo2f3Cbju
	iJbV8OP/bQ+i99kGkpq33cQ==
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341379685a.1.1788512469267;
        Fri, 04 Sep 2026 02:01:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341372085a.1.1788512468661;
        Fri, 04 Sep 2026 02:01:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm76155866b.40.2026.09.04.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:01:07 -0700 (PDT)
Message-ID: <b245d6c2-825c-403e-ac73-d569820895e4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:01:05 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F+xnsKhN c=1 sm=1 tr=0 ts=6a9a88e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 4X34j9GdYEAUMS6b_iW8e7Qzw4l1EQ5X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX4vX+I4YDpR2j
 3kf81SRrPxK6XZ1hlO1rGrm4ca7IiS2L41iOP19oCigJT/oD9XSO3FYmUvZPlQPU9P7XVa1hSJE
 FxWXO3Aasj/bnAZEetu3O6iZ35uMONA=
X-Proofpoint-GUID: 4X34j9GdYEAUMS6b_iW8e7Qzw4l1EQ5X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfXz9DFJCRk/dws
 OikbwzmrSVpuuldrDvu0IWwiUL5tabRhSLXPkM1BBkCMucYGBKiuZfCgwQ5C3JNF0HlPSLutlVQ
 Kl//a3Cu5udSNDzk50sGvlSf4UFuahqrpLGE8WZEgsagGdnjRIy96450YucZVNgmNsQGVSnQAPd
 eiQUK4Jb0FVfiFNjEpVrzQBTqnX6DFB4hH878eMnoolVGcuBAGJNLzSZJ22o0ItK0yfSNqlL5qb
 MeaFEAeLg0mC1eIBvmwCiGxj4ihOOTERoO7UzDjeA+TMH5PDGJPpk7IoVn8uyPn9S51fKgL0b8P
 MzDwGkN8GTgquTNEyEEL43J8LkwOtKe9I4QXy9jN9hfpZJ1wFWSWqUifftB9L+IbXIATZA40jni
 ewP01qCvQ85t8P+cD4/nDmkzWyKzCidFkmr0W4CcTD5Y6QOZtOgSmSHoqtgppGt0LrZWMFD5pSG
 +E2GKqCLrhWjWtCt7QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 8/27/26 7:59 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]


> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;

For !se->has_opp, this silently does nothing, which presumably
may have bad consequences if the caller is unaware

Konrad
