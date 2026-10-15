Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AF271A94
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036714; cv=none; b=g1XtHuvT8tsQlEUJlLpu/fh2buWNwMe2imOm7D+XVCZ2nBTMwEl+TfLbrWxA/qidKGK1B2rEAu2tiolWCZrMe09ok7KvjvSYTk3unVpyfw3XJPGXpbLRmtv+LOpLzCEDqvFZIbd/u4Ez2upPh6oISfdrmTNu64VJkvZYEiNY0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036714; c=relaxed/simple;
	bh=nguePDkbSX8CdLrI5jeCiApYYmALGzarrJu+OM9Fqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf5FoDD4BCiaKw9x7y07Q8yd08B0WqYuaB1hfoXg+mypO5BxuXnXaIIXeNyn2Czf1RltpJjlxi2p0h6JCQBtI1wz+mm31zs0Xwh2NOjZBfJ0jaGbLv42cbqK1fstTocEIYsQkssMmMW0f+28ilX+OHGK6MH7xN178Iuk/gk+o4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7kG2EMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZ+62dYM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7kG2EMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZ+62dYM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F2AmFC843758
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 03:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=; b=a7kG2EMKtNc3ppFV
	ogttzL9XW4vzOAZkDYPt2ffRra6tQRSjZqEc5ss7PKoRXS3+CC1neU11bs5H+wJJ
	hv0t6JzmuVAVNBJMNpYtXtmAHgvs0ZLgHPfCtsrwNzyRUiFaFgblwJe1V3XC0PN6
	5e+BVu6dTNcrxA0F6uGaN2XuN3U1OMcoMCDwscp9ZABI6fTaQcSDKunlFPDiWZXz
	U7uPDBBOcvNuwLLzE9W3WPH5sc8IN6Vq+iPqdYETcyY7IVg5T/j0sSvSx/BEH4d5
	1QpW/a0vbZDFtNGyLXbtAzN3PEPir4XiS13YiIp+WaDrZsNUxAmRnoE9UN1eiaua
	Q34uFg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wsykf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 03:58:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so19031077c88.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792036711; x=1792641511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=bZ+62dYM1MkDW+yNCtwXnFmU0rRsmt+hOm2R86MsgwR1TaaWRYEqHLXkUEj5D3aFrZ
         b3UFjMCJyjGE2cziPtAYBuZFBczQlt76fBuDeXTPYGDswpoWy8u9tNWx4PNLOHIutaLG
         XarRFDMreyQPNY2MoG6slsLkyR3XPUovtr2rNzNW2yHaGGm9+5c/4DLoXwRy7RIJoYmM
         emdfwIpgVNEitVE84sUW0rhyUf7MwauLw9oxMWv6gf1QHNSVYSrgqALoLbgkR6brV2/e
         MYgV0o0NSChJi9SPbwCVNVpqL2thU+hPlrsfudKNBwm52Qz0ei8dSYQu4a1tc/Fv19ix
         v0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792036711; x=1792641511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=CUGBntByA/ASFnJzOTK4a+bz3oaV40ZRQF3vbJnjM+xcYPf91HEusNocAqet3+EtuK
         8aCpdi3bOgUvcfaRuk4Q8KU8jXz7eG0mFlPrIfF5ZSSD/jX69ygyNK70fhomXTi/MisN
         K06Mv05m8C8m2VTgMq0R90n6Hwt17ZpHowd/Y5F3Y8S9uYsO9M0cPFEELCtg8Gwl2kOM
         cH7ciKi+CDl34n7X2+EanKlv4TvzvCHNF8v6fjtM3V9TWfE6IZh905ZUg6wladeHjws/
         AlttAeMXxdCMa9YWbNrhChmtYC10khxEeGPwze0NxpfFs/9yTJ0yVy6S8P7qd9paYm9p
         7uhQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8XId/k3uaRi57gZHf9FLsR4JlHs8SpTvQ79rx1zvVk2ClIAHfJvtW3Qs6bcV2j3Osm4G2v850KMqMZqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzOO+8M/rILgYgQe13AOe+XG6QeM/NF3PPJPRk03ABvRCkVhbU
	7X863WXfIl5/VJF3UTWfwSavkKq84C+kOQYUk//YCWgMOY1rfUfxUJHknzSL8U+BGriY6i2dXK5
	d7y6+ZpLxQOxzLjbZfduBtH+V9ryLxTL8r/HhGHDQrfBg9cWAUwVTAoG9sssW6XchkLI=
X-Gm-Gg: AYBFou0od4/QMIodN3ZMb1yrC7Iq3ur3OE2M+UmnY+25RYQoMO5gp8svRBKo3mTYfQ5
	r3sZzCOBP2ieg0KWevN4Ui1Z848ZOMS5W4gX/CHDxlxHdrVWSCVpmPCTfqxvLxvNjudi0HZgD/d
	Bd9GOxsYm5HI55YDJ6/FuUbUwRtf+vynyrxYl9RlokKAthnmoMezRHSNhE61fSrtizOmCkmlSHy
	n5qvs9vv7tRWI6lXGYdC2s+pqVAVgtbHRWPnOzZver/2M/He7736MmUZz1OA/VMkzvR9SIe0oKU
	EYV9aEOF3c2mpMmg0gt1oCtHDUkk541qzVa/4tsxI7b+M/WgVFp8w5J9Z30h4kNP8qHS6OtjM2R
	fdMuPzQtvPKhP1DmR2vmoI2N5fQUXIw==
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12450016c88.37.1792036710707;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12449972c88.37.1792036710046;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm41853429eec.11.2026.10.14.20.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 20:58:29 -0700 (PDT)
Message-ID: <666e2768-28a8-4bb7-8c15-457ad20970a8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 09:28:22 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
 <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX2E3w1rjOiBeo
 /Q74HsHhn2fRVL2N/70x0M2p0olRj7acYzvXJ7EbBU5xOMAVSZR86GFYaGF7quJS2MpQ3k1L3yt
 ttOtg151mR1KsRNtBScHzWc+assmZAQ=
X-Proofpoint-ORIG-GUID: LGNZGHw2cOtkO7qj0-sEs7Od7hH4WCsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX5/jHRS1PZioq
 lIevR1kqeiHDEqOJY0kfkCIQYR+x/3MnQqKRCuruHt1qduBFBx4jSUaTndmEdw3dU+V2+theUXf
 NXhbVNYlLbF+CoNoBU4ykFG0/G1E4W8SxRqSlSedFrqnvsRPdcxriPrW0C96tH/mkiCUG7CSWQx
 3qG9Jz4eYmRuACnVuRtZqBPeruT80UX4gWu3CUbQSEIR2My9Ly1JXj0TZQ8t+ka4UxZqOLyui3J
 116k5I6RWDR5vW5DQHYU4xyn6ONHOgKP2va9Q6IqUQu7qsrt75YJruQs/qMAstPwToo5TgS5ZCz
 8cQxPJj+i62OdB6vfurfUs+hrN1mKrgCX1tscxGd+L9yaHORAyAa8gYTvhsmz+Xl5pW/nuzIfwz
 0IMmX8Shd+l5dLhrzwazJoIR8t4gBWSymcFgPpyJ50nOj9S9YdIBQibuo5GbUwnGM5VxzHg+/3g
 n2kuZFUdr8w2LTWzQFg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad04f67 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ip-HRx4nHBnhdLLshUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: LGNZGHw2cOtkO7qj0-sEs7Od7hH4WCsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150015

Hi Mukesh

On 08-10-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 8/27/2026 11:29 PM, Praveen Talari wrote:
>
> [...]> @@ -2039,15 +2041,19 @@ static void 
> qcom_geni_serial_remove(struct platform_device *pdev)
>>   static int __maybe_unused qcom_geni_serial_runtime_suspend(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> +    int ret;
>>   -    return port->dev_data->power_off ?
>> -           port->dev_data->power_off(&port->se) : 0;
>> +    ret = port->dev_data->power_off ?
>> +          port->dev_data->power_off(&port->se) : 0;
>> +    if (ret)
>> +        return ret;
>> +
>> +    return geni_se_set_rate(&port->se, 0);
> Is there any register access happening as part of this 
> geni_se_set_rate() ? i was searching but could not see after seeing 
> set_rate() callback removed.>   }

No, there is no SE register access as part of geni_se_set_rate(), nor is 
there SE register access immediately after it.

Thanks,

Praveen Talari

>>     static int __maybe_unused qcom_geni_serial_runtime_resume(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> -    struct uart_port *uport = &port->uport;
>>       int ret;
>>         if (port->dev_data->power_on) {
>> @@ -2056,8 +2062,8 @@ static int __maybe_unused 
>> qcom_geni_serial_runtime_resume(struct device *dev)
>>               return ret;
>>       }
>>   -    if (port->se.has_opp && port->clk_rate)
>> -        return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>> +    if (port->clk_rate)
>> +        return geni_se_set_rate(&port->se, port->clk_rate);
>>         return 0;
>>   }
> [...]
