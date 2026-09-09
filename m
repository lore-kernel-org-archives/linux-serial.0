Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FF5476DF
	for <linux-serial@vger.kernel.org>; Wed,  9 Sep 2026 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954157; cv=none; b=HT/l7w/xFDHYzqTOqrF2lMwQuFQFwFcRdeiSe8MDoNWkfy+AKcyLOqnpCLcuCKQ84GSkYCY+gPdBgah/ufdV6fGAAFmKIqBYceszIrZDsaaj2eGqNVHfXMSUo8GtC/Vju7pNRu78tnuykVe42SGF/h1ZryQQUIp3BhgVX/8zv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954157; c=relaxed/simple;
	bh=dPrJAeYgm38j4+vkp++72DejL21/ff9Rh8+g+/KYRwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR7vTj3LiOM0+aULUoBvRUc8memYqQBZ8BSvHh3Vl79ZdVI5m6q150B8LKL2WEh8Cbyy7tnLlhSA+jEsEragU+CjBYyZo4LUJ7KVOm5kR4SMBTeyAvVKstaW3ISL1U3FKQK2/dgooUc0zt8LrUl0nCtuWVXgiihoxCVoEPtLpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKu7SAHP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCK/VcY6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKu7SAHP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCK/VcY6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUAAN1843015
	for <linux-serial@vger.kernel.org>; Wed, 9 Sep 2026 11:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	epxMbI0y6nHSNagsiwEyeMZgg6Krl3r4f6apObxAlN8=; b=YKu7SAHPz3RYBeFl
	/1BsREYL5SGOwU6weWgn+RLtfyq5LvtZau0EvG/v7yUkGJKEpBuTL3i9nmX1bnnG
	aq6nBBLLCMfyiOidx3AursUXVTrTuaK0hwFGp3/KfucGIyBhDLr45Iz0D1P4Va6k
	zQHO6vgFnW/MGm1KZVFvB8xPeFEVf1L5lLU04LO5Fv06PFtJJeyC1Hxd3C0YAllE
	ERd36xX86aNgtHe78EY3gHVqLRW+HH9RcO4mjJRsf27UD3iLv587XDs7cDqeq5WL
	ymj0xLhoRhE5NPbonHipubSWMHqdXRgQglL9yHtbXu16Qb15Xp4RyFZ8KwYBUMXu
	q9I2ZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqja249-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2026 11:42:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930bd2bfc45so76423885a.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Sep 2026 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954154; x=1789558954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epxMbI0y6nHSNagsiwEyeMZgg6Krl3r4f6apObxAlN8=;
        b=iCK/VcY6EogpoKs6FPTBj614Cgqb/MuAE44L8GYQBsQ41/m+P1rDfvkcqwEdmaDPU1
         Pz+JCkKXkDA4714QFEwiuXzvJTJDozKqOZQmE1DF4lIikP2d5rvVMnreDj8jZYrYzpAc
         p+YWba61ECloEl6oQ1HQ/S/B6/IysbkC1E0uU5ZGWeEQrML64/L4bwAdr25PhcHfEgLF
         A2+eABZnayE0BleVSUhYQMaWFFlVqpfFXUVWLtr+iEcVwxGLr0eHIk4NCkhHrvjmRWmW
         Oa7cNz6rh1GBIGaeED/ex2gwYVyDP2CBxlcH4WJR4wWGEV5/k0C7Ezz7GGAt96cuddoK
         6LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954154; x=1789558954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epxMbI0y6nHSNagsiwEyeMZgg6Krl3r4f6apObxAlN8=;
        b=ZltvcQrhdDaY8JLVvB6SGH5LttnvXyZxxTQAtXbHFpYbH0fbkQKecV+Zy2ewhclL6+
         fPjHHFOTdjxEPBkqEV3l3QsjquNyTE98tdlb/qRYqpR1CACM1qJlgzH4N8r4j2pOaEYK
         mJSrSK1L7fOFIhUWN09D8U28uU6dTKB2ydAIU9Lr/5ZFOtL1pP/4YrwJ9pqERf6QuNL1
         EXpiixqz3JOoBQaeJdjWmSM9ukajWw8yrfcod8NYliH9RWUIPVc36vKFIPFmYpqewXxb
         Vjwq9d84AlnQ5cUjPAAaxmf8zw37oVFywn+3EM3NP1M8sZ0CsGMm1la4Gr8LPKCY553f
         zxYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbgwwdD9MzdxzOpaoOH9NmxlE4ttTSqDQYnMyev2UxUvl7Z8BqQTcNxft2vyhtGYfw27IbTJNljbN9qbE=@vger.kernel.org
X-Gm-Message-State: AFuF++n+Oqk3EJ69rU3vgPP+vPyq2MBbPlaBhf9WivbfnELDAoFbIbkw
	/JkwZddm7lwD9LzhzVcG5uj63aWqq2IUOT2UyA7K5xkcJ8pfE40ci7EDA7uHDuPaak1/tOZUADk
	w9qrcKhOHBpsZI1zX3ioaM0tG3hx6EBqOZVfuWqTwCRBjtQ+sKw8wKXwnKsD4KELB4rs=
X-Gm-Gg: AYBFou3Vhd78GNo1k524Z0SkM4in/jJ26HQ5oRJwd3ggFpYxGOaObOx+ax59A3Nhshk
	93XGYRIe92PW+Ef61OYph/+ugO/XMiUZu+FaAHgwdC5plL09bp5bZkzC8N+XISyOeglTZjSa+cv
	PtX+8jGwjx4mycA1V/tagt5NbUD5swyxQDiGLsxQjqUI/oxFTJzpvlFROt/adsaHmB+Y3fRW+3q
	g9sOLwm6et46xxC8imOcIkaqlF0ithPjjuo/PUdqZ6Wwwp5IFY97vOSD9FSCOxczYTboyanCG4A
	HkqQbPDCzXVeJa/OMRve2Nk/b1asRLzgRjFInSE8tI1awaQuzQpN7t913ZTJ/QPT49IYpCXA6E2
	in4B8WOuHbdIkFvDKOqd/Mg==
X-Received: by 2002:a05:6214:1251:b0:910:39a3:c5b4 with SMTP id 6a1803df08f44-910475e31ecmr313455446d6.0.1788954154197;
        Wed, 09 Sep 2026 04:42:34 -0700 (PDT)
X-Received: by 2002:a05:6214:1251:b0:910:39a3:c5b4 with SMTP id 6a1803df08f44-910475e31ecmr313455126d6.0.1788954153796;
        Wed, 09 Sep 2026 04:42:33 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5768c2sm739578366b.39.2026.09.09.04.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:42:31 -0700 (PDT)
Message-ID: <bc2112d9-4085-42be-807a-2242a1c510fb@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke
 <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
 <20260909-correct-icc-bandwidth-vote-constants-v1-1-fbebf6b3c341@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-1-fbebf6b3c341@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SVJSLtxkOE9c-MVjfne2FzQtDArPeeYE
X-Proofpoint-GUID: SVJSLtxkOE9c-MVjfne2FzQtDArPeeYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfXyQj7SMs1AEHA
 fNzlK0KTylF+OHs+v/8qxG4LQPQhMPbCJe6VEoh7912mULWMQnDmhfVaRtxYCiH9zU5Q7mRQNFl
 /6EWA3rLBG7ZpK1AuEJrWXFUHa+N2W9AZUI+0XMxV+kH6knKqTd41vWKGTvOneDxxooHaqhO1Xy
 LYFOQNX3Tq0+dY1fRZiXprHRNKY9rd8XO4gCnCm/4FJNib0DTjvdrvlLlOGo3W7D4U/s6/RJUAC
 1v/NHBzNEPM2ObT5SaP374oH30QqQtJOx72gYOyPA0+jF6sgIFXl+uhUrNMjfj1jesyqnd95ysA
 +le3bwQkKc/ezHrQJi8+mYeklgnncqkD9QPbIUaTMavvYgAv+BP3qZZi4DVLn9rdSoOUU0Hqq9U
 5liEF/cufkdmnF7S6kBXqCrO8B4oEne2QI6aSjODHkfik2RYLCOjljP68Rjs/ujnDftJkhTQ+Dz
 VUPjGe5HoAY1KYorA6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfXxy7haidI4Aqi
 5Sk2RehqJOEv2aRUHUtwVSoCmBkrcZXmNB6x0GyltotHjGgag2jsjcgOk2P1/Ud3YRlNzAdPGZ3
 RUhTIEUuJz5A1L3T7is/FAWz1QDHlQA=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa1462b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FQoka4uyCIFQdJF29asA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090131

On 9/8/26 9:05 PM, Viken Dadhaniya wrote:
> The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
> rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
> values are several orders of magnitude too small. For example, the
> 50 MHz threshold is represented by 2500 rather than 25000000 Bps.

[...]

>  /*
> - * Define bandwidth thresholds that cause the underlying Core 2X interconnect
> - * clock to run at the named frequency. These baseline values are recommended
> - * by the hardware team, and are not dynamically scaled with GENI bandwidth
> - * beyond basic on/off.
> + * ICC bandwidth values in Bps for the GENI_TO_CORE ("qup-core") path.
> + * Convert them with Bps_to_icc() before setting avg_bw. The QUP ICC provider
> + * maps each threshold to the Core 2X rate named by the macro suffix.
> + *
> + * These values are core clock votes, not GENI transfer bandwidths.
>   */
> -#define CORE_2X_19_2_MHZ		960
> -#define CORE_2X_50_MHZ			2500
> -#define CORE_2X_100_MHZ			5000
> -#define CORE_2X_150_MHZ			7500
> -#define CORE_2X_200_MHZ			10000
> -#define CORE_2X_236_MHZ			16383
> +#define CORE_2X_19_2_MHZ		9600000
> +#define CORE_2X_50_MHZ			25000000
> +#define CORE_2X_100_MHZ			50000000
> +#define CORE_2X_150_MHZ			75000000
> +#define CORE_2X_200_MHZ			100000000
> +#define CORE_2X_236_MHZ			118000000

Today, even with patch 2 applied, many of these rates are unused.
Are we going to?

Is there any logic we could apply to derive them?

Konrad
