Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955D399351
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288941; cv=none; b=WoblQ+J/vR9VRFZp0xDNhJh90dk4nev8N6Bp4qZp0QTTJW0F0Ly6E+McIYv/K4dSMpdEoLyJ6ITQ0pC7fljMTz0ymg24buS1d8ugO2G9IEhGbAzfmlbr5OsXMccs5rrAbQifuQyeGfOzsJJdB7eKiCr2/FJaogCxQxNnUpRkf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288941; c=relaxed/simple;
	bh=z8yjqyDFJNduyXmuCrbnCRgbSnzUlFAyk+u5Hegvyvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYiZHUORafbk34oJR4dTi3yLdqjZNenzukx/WprLyFeb5YLgdMhK0GTO0WCZbFU9x+MJ13Hydu2cn6fA0Pd4DqE4tTX33S7lcpyHe+S6xpCF19FM46bIU/MGxsnn/3GOIPjjKcjtJzoPnbc/Ppm1o3LyOsNwEx/LwebSVLPtcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+2K6kD4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yc2xtFVr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+2K6kD4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yc2xtFVr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68D7TjWT1160707
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 08:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tN1ZS5CXo0+mPTeqAfw6aDp+R3IyYEqFE7l6PNmXXZc=; b=H+2K6kD4ALIe3r6N
	2Q+lizcslTS/aKjRmP9sZakh/a7icmULNIwb/7PWHx1ED2JFPtCd1fmZRphbuqWN
	lRSx4ZhyiA0M8QblsKiVo/BxeWKMZYs4Wunhn9nB8jA/jf6F4bzNc5768Y1gX7wD
	0c6lOZG0nqL2dqqYia6LdKz6zd3LwafIEPvHGca2+7WFK35yj+P6Qn6FNRx5TZbc
	3vP0UaQ1mlOe2SEi2K56OqZbktsfICKlX3F3FbIZVZpzunVZcTPdPXWwE4QpHwyq
	tjktj0fXvJwO2hqOp4GzoAdytqSVrbVKo1n1xgKzekwE1T3nOWrrMocxk6W8Ffrp
	dzUiag==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d2vxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 08:42:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc489e7a701so3334877a12.2
        for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789288939; x=1789893739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tN1ZS5CXo0+mPTeqAfw6aDp+R3IyYEqFE7l6PNmXXZc=;
        b=Yc2xtFVr9FwEEmd2w+LDO9B9oqdxWVPRDk3KvT4Kb0EYLFmrqQDgpM9gseYqkJlvN4
         5/qb5G4gkDZSGqJroHYF+tuY3chi/FZlbQGrOCymT6t16JrWQ7jWxGq7eDsR8j4Dw3oe
         sncomwvPi5T0dq9dAGIuCNe4WVDCUlgX0Q40c1SYMghvfLULseYR6Bn6CFEz/T6ozjAC
         9QglDzlf2orzVmqFrJ5/jfLPdcYcTsw6oK2gfGLL6faA7lqVXbguga3Ia/J/JdQOdWOT
         pGZ+/EutSFr5gHGxGSQ3EivtSoC4DJ8XftQ0J3OtRCAbjoDd5ukrGYtsRcFaVWzA4KRd
         mOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288939; x=1789893739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tN1ZS5CXo0+mPTeqAfw6aDp+R3IyYEqFE7l6PNmXXZc=;
        b=K6Sz2152/lHEY+ZbyweglrDZKk7hJ0P5kWpDfH6cM1fg60Go3p+rk7rKTnwSgNEn/J
         ZjQna/tj5qZZcHMXe+hbNXWS5MJtVKDMvlYpHJxtmYq2dgFwnhfv/xe+fLZiudccw8QP
         vp/AKHNGvqSsIYqGyF7sPgca3p4RZ/jEPMJ+jr16hCc3s5eHbZ8mf64CvRakqx6V3Yoi
         z0LjHxi1zxoDo4T5MHMevRb7r/Ad3qaMYBL7e6b7lwMhd08+KDtK4rO1HuCS11afWTsf
         a8hlM6S5Up2GRgFHRVrGqlhuLssgJyuo+7HAU4nGISrpY29kcn9iwp9qF4eRZP1qTZ7D
         jezw==
X-Forwarded-Encrypted: i=1; AKwUvBzOsgddZoW++ef1cMX+iQuRmLlvgneX7DpG05TGd/S+wo4D8cLWylrvLVnlnAQG/bTRK73Lvb00AMGt6Es=@vger.kernel.org
X-Gm-Message-State: AFuF++m7njPNX/vTlQMG2HT0P+tPWLcSvORlYCgpMyxb7gKBLK9nUqSv
	JMAOSk8aY+kO72X4KTW955Cu/HBTOCcQlXc/wWZ5g3DX+c00iOvM+LOxk8Obr2XZj/ktOnJ1aCS
	lq2rkatNmJ7oRkUY2IXN16MlL3o73CT5C9KRwFXiTOQlT0LdA/VPl0LmLceoljtANdqc=
X-Gm-Gg: AYBFou0Q2HOzAiH1vLGS1U5l9IEzwEhMVxfgzbWyn54PwsvpZ7kAjXQwKiixO8B5+bB
	PrEfeDlbOT1sTjG3/Fcjo8RVWA6z/J0jhTrJ691E4302ZOArJkOq7UU4hcYAA/JqHMNteW4bk/C
	CjyerViF7WTKu9B1TD02/D4+s6wUnDa+aj8bTFhmjLgSp0RZnVx+4HNtuaxPJGy1VIr2uOh6Lxb
	l9X3/VWAZEDAmUtMBG15TXbQKnpN1khBV+w7SCH4PDihFcEWQTvRLCDVPzIqVIbuXiHd6L4xn/m
	n3HxenoBzxDSVIzIzJgDqo7KmPcjCNQuzwifljeKRDkyivhtC9GZ8Vl+3p20OYATNv4HHBuAN3J
	VlUMSxsNVjCvnekTQCDdfIqkfkKheDSPaiNk=
X-Received: by 2002:a05:6a21:6f88:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3daed3197ddmr25056448637.13.1789288938746;
        Sun, 13 Sep 2026 01:42:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f88:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3daed3197ddmr25056055637.13.1789288933893;
        Sun, 13 Sep 2026 01:42:13 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.229.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm32943918c88.12.2026.09.13.01.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 01:42:13 -0700 (PDT)
Message-ID: <44c570d4-cf44-40b0-b86c-3c207a2183ce@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 14:12:08 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <bc2112d9-4085-42be-807a-2242a1c510fb@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <bc2112d9-4085-42be-807a-2242a1c510fb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDEyMSBTYWx0ZWRfX3IqmxnbTNH/5
 y1CSwNJXzVsysK3LPJXX/uFyzx3lxX698yU+eOFk6CO52x5gm0NOFvt5e124dcDOOLHhCtmwm6x
 ZNYWZceORtB6WNTDYJ8E5W6xCdmZ6l4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDEyMSBTYWx0ZWRfX9RuVnnE8+BBY
 IWqOXyFkyKOYMhezuek4Cp3YelNHwLYsSNM25x6T4ioY77zh2+QIkwmP9ss9xHkSmZ6w2w8Ss3I
 gNf2af8NzjjOOpgEZCAT3qLFdodLhEqfA1PDBvuEUOziMlXsSxFamwvWk2u3/daI1QdWHggiFkl
 PkV3p9W0QogpIhMSxFUVR9FsiSCYT+6nvh7H34LpLv2nc6P5BAVoeV5oD18jJRSIJRHXD9dPRuE
 EnB/EuxpyETNn9YJzN2kWitwDpiFlUd6iWF+w0ZHqcmHkNpRpEQYJfEACvIBdwrJ75sH2JvjBa+
 Sr8W/KttSVoClBsrxRij+4wY81UN1O/geE4mbjAEGQNICU5E4VteTLYGK7F+0vfY0PcUPIFCA5u
 UmxzuWH/lgPeM5m5Q/B+BViVpRZL/LxPhBZ37gQItFXVygS6QJnLQx8i5BwzY6mjBBGTbYbCPrU
 hI49HTMChvPavJA0njA==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa661eb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=dz9MANpua1BkWfJUa9OfoA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=30WRip7FDacWLqpXgTQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 0rgHNUPXbDYYTIPV4_yWusU01PrgZUcQ
X-Proofpoint-GUID: 0rgHNUPXbDYYTIPV4_yWusU01PrgZUcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130121



On 9/9/2026 5:12 PM, Konrad Dybcio wrote:
> On 9/8/26 9:05 PM, Viken Dadhaniya wrote:
>> The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
>> rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
>> values are several orders of magnitude too small. For example, the
>> 50 MHz threshold is represented by 2500 rather than 25000000 Bps.
> 
> [...]
> 
>>  /*
>> - * Define bandwidth thresholds that cause the underlying Core 2X interconnect
>> - * clock to run at the named frequency. These baseline values are recommended
>> - * by the hardware team, and are not dynamically scaled with GENI bandwidth
>> - * beyond basic on/off.
>> + * ICC bandwidth values in Bps for the GENI_TO_CORE ("qup-core") path.
>> + * Convert them with Bps_to_icc() before setting avg_bw. The QUP ICC provider
>> + * maps each threshold to the Core 2X rate named by the macro suffix.
>> + *
>> + * These values are core clock votes, not GENI transfer bandwidths.
>>   */
>> -#define CORE_2X_19_2_MHZ		960
>> -#define CORE_2X_50_MHZ			2500
>> -#define CORE_2X_100_MHZ			5000
>> -#define CORE_2X_150_MHZ			7500
>> -#define CORE_2X_200_MHZ			10000
>> -#define CORE_2X_236_MHZ			16383
>> +#define CORE_2X_19_2_MHZ		9600000
>> +#define CORE_2X_50_MHZ			25000000
>> +#define CORE_2X_100_MHZ			50000000
>> +#define CORE_2X_150_MHZ			75000000
>> +#define CORE_2X_200_MHZ			100000000
>> +#define CORE_2X_236_MHZ			118000000
> 
> Today, even with patch 2 applied, many of these rates are unused.
> Are we going to?
> 
> Is there any logic we could apply to derive them?

These represent QUP Core 2X clock-rate levels for GENI clients, not
protocol bandwidth. Currently only the 19.2 and 50 MHz levels are used;
there is no planned user for the higher levels. I’ll drop the unused
definitions.

> 
> Konrad

