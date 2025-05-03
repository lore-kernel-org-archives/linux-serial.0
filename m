Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287B2566
	for <linux-serial@vger.kernel.org>; Sat,  3 May 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746271064; cv=none; b=jGKmj90QWAB9yguF3OIxOjfqrG53pwQL6zpOz9PAW0QE/P2kFGd2nlXpi21dLmowElsUg04YGnsePYg9mTT0vToL8+tU+kQEOWAi/pkZOBu52NbwBS6umzPZfDnnFAhRkdP54O/eV8xCGzja+Ptq/eA4YxjLITJRF8sqTGXfsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746271064; c=relaxed/simple;
	bh=osPDfcecZqVOsBKtOG/9K12hOUEbQ3zRaBPBK4271XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoxpkrXOap6GdHL7mCS4pUSYdUvanXS1hXTni9BQ3M7kqfsUGpriBPs03JwqybsIE1OrAVL1SoqNomtTf9SVIK78p8ywhYzX2hvL0hLGa05LdG7sBHX/xU7brZJDQxVU3/VEv9UGLc4QP84OUFOh6eR6cOgBILsMKMTkNN7Df/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pAG4AY+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAG4AY+F"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5435XBBd012517
	for <linux-serial@vger.kernel.org>; Sat, 3 May 2025 11:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyCrKhEc3d77syMYDxLeKe5vR94keERW1gwgMtjT8+Q=; b=pAG4AY+FuNhNdA6F
	hAXgDOJwRW6pD8F9mWi8SqhV0bW4f0SZA1GnbxWMyjaoUky4PkcaPm1Kmu+1eJ+c
	gRQv2lgFjXWBVH/pQOvbXu3vOp9dZglbOUTx9vDTzWIjbigFSnqeTL14AUVPNbOL
	2s7hU7kNpwPowHiQnRJh2eUqVegJUaCIeS0hkyB6OUiwFLVv3Rswk+O0KJKVskjd
	1IH6qtijqeJfZjVruXBnng5KlMrIWE5OQnG9zqdHJNYOxbGV8/QH3KH6qabkSNSr
	8ng9iSmaLmaBVA7x0PzYzR3enCtHa6j3Xl1CAOzePuNc+JCe0ZVBjEK6TgmFoUHS
	LaQIMw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dd3n0cc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 03 May 2025 11:17:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ecf6a05e9dso2120796d6.2
        for <linux-serial@vger.kernel.org>; Sat, 03 May 2025 04:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746271049; x=1746875849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyCrKhEc3d77syMYDxLeKe5vR94keERW1gwgMtjT8+Q=;
        b=EVgyzOlE+TlhSYA8w2x8AeTsdIezYjMvp7r8dJFVa1UBBRPJZbrOYfSn8qI8hvBTPh
         WkkY06/tVh5iU4w1V4EwYlYBwW9UVNVxe4LB5S7ZlDyUCFOitk4uYP7i7oxONvoZLQ4V
         AHON6woVET0Bg9JCKrjSWU44kOcVVLQ6BdZQzIctHotsoWRWzrDc96T2XJ7KwLeFMjxG
         4l5LdvI81HcJYKYEXffOYcEjf4L7u3G+Xcn4JE4Va7W88nM0mBJNnbIvTzZG3yWpqHk8
         oDEXAXKawz5QqBMPXIOSU3XBDOCmvoeco+MAH7GnrNkDinZ61o52mAH35TrqRDwMObRF
         c7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6HsJZXq+bjKYDmmhIjb2JosZ/dlIy1y4vdlF1/8ZLch4k2NsBHJa2NDa+/+Hm5CWbW18TeseYdQjPtyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhowUDszZosDOc405Gc1EVZOKjQsbBkUeGu1smqCVpNW0fHW/d
	Ti0aA3jCJeTfVUBL2APbRHHCdC4h8OWScp74TXjmY8Aq8DD7M+ugko7mbAi2JgY1mlv4DeXnaj+
	zKozp5EF6amgaodYir3hT+cPEtVuEyn/Hh5dQpCxnrstb2sU70fDHI1PyvEdZ2kE=
X-Gm-Gg: ASbGncv3HNZcWiQHyVtsdds+wVM/0N42eP/K8Q0ebaQrsJpYP7XP/0T8JrLEaU2C0MY
	c3TWoEmdDs5exwl/lZKInbGfVQFCBF78kJON7XE4yoG1B9PAJP7G/hOd162lfwPmJdIeImADncm
	Rv/YSOcgEmyAz3DSca395X/mqTtn78qCUpCULxqsZdnMn+1ksxzVjCzak33L2PWxZjdHhtwLV/V
	0mcbh8j24N39i7NpFdnUJirkfXy2WUOBO0DHKEPIR/xvt7DC11Y0W4T3ZHn8Aw2RSq/9yjhU37n
	NvA39320bsVorUtQQ+ikeSv4QDZ2ZldzeIseJb4PycxFBr7B4XlrXkMElQwpRDmWcs8=
X-Received: by 2002:a05:622a:2cd:b0:474:efa8:3607 with SMTP id d75a77b69052e-48c30d83db9mr29110391cf.1.1746271049032;
        Sat, 03 May 2025 04:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsRcL4YTCQDoV6ZBGi3Z/iVL1bqcsqXiphj3Oul4isaynD9De8sYSJHbL7Ynpk4VynGPsXYQ==
X-Received: by 2002:a05:622a:2cd:b0:474:efa8:3607 with SMTP id d75a77b69052e-48c30d83db9mr29110181cf.1.1746271048650;
        Sat, 03 May 2025 04:17:28 -0700 (PDT)
Received: from [192.168.65.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c024asm178441566b.117.2025.05.03.04.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 04:17:28 -0700 (PDT)
Message-ID: <c55d718f-00fa-442a-b67b-9a678556a2a7@oss.qualcomm.com>
Date: Sat, 3 May 2025 13:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] soc: qcom: geni-se: Add support to load QUP SE
 Firmware via Linux subsystem
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        broonie@kernel.or, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250303124349.3474185-1-quic_vdadhani@quicinc.com>
 <20250303124349.3474185-7-quic_vdadhani@quicinc.com>
 <2kmnhxj3je366livo67btpbmjiyeyx4q23of42ng4co6xngemj@kitsdtqepgce>
 <e0916f4b-d2be-46a7-889f-2eebd12b74d0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e0916f4b-d2be-46a7-889f-2eebd12b74d0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDEwMSBTYWx0ZWRfX8C3ZgY5iVibj
 Zw3JT8v5x5LBtydffmOG9Q+VrSTGEuuzm5G5WspCYrzpPxlvL7c8/H3PiubJ6U9xEX9fRVG0q4p
 lEf0CKz8hzFRiFwsRr/aNCoJB0fSXhCvD8LKbDlHUTVVJUdlQZHzc+xrz8XSgebw6wt8AyeuST4
 951GG3+QNYaEoW2ygYJA+bNUtZk2BzRfD1Hl/MKuKl9F5BwBUK0PISp3/KabIGwFIfCCJsvxdoL
 IpAX5422ByJS79GJ0nITxpCX+I3HeNB2pFPtVVvcZcM26zfXy4ORbljeGLjbyBWTyX0ZZzS0pQp
 1ZjfXTpS1yWyxWoQaMy971H/T+fT3prjknb2E/zZowvs8THtumvNSMDIHczWthfIxnAl4+HBYmm
 Cl7xY48ZI7lFEDMJSusnmmjTH5+jf8O05uIdsrb+FohUxwEDgQdGmW00ZGfvEOty6wC7CWts
X-Proofpoint-GUID: 5pnsAZVy1DYGtBsAJbe78d4FaXk7TzZ2
X-Proofpoint-ORIG-GUID: 5pnsAZVy1DYGtBsAJbe78d4FaXk7TzZ2
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6815fb55 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=dnXBaztP67eYbQVX14EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505030101

On 5/3/25 1:11 PM, Viken Dadhaniya wrote:
> 
> 
> On 3/6/2025 4:57 AM, Bjorn Andersson wrote:
>> On Mon, Mar 03, 2025 at 06:13:46PM +0530, Viken Dadhaniya wrote:
>>> Load the firmware to QUP SE based on the 'firmware-name' property specified

[...]

>>> +    u32 magic;
>>
>> What endian is that u32? Please be specific.
> 
> I didn't understand your comment. Could you please help me understand what is required here?

External data can be of different endianness than the running OS.
This should either be __le32 or __be32.

Konrad
