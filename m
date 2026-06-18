Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CD3264E7
	for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772922; cv=none; b=f2Xl775DsxzruNlsTzgwqBX+ex3y5Hqb+oft5I/9XxFTr8UEiuRCCOKNVqNHvbpAYgfVYONk2+0l18K/yJh/oSNcQIH9o/kHGvX1jUmZlNmT8JFX0SVkkF0EDZOeMcDaI+qLLxVqAeyVxYgoACAzmNeHN7y/xpRd4ycFutyj8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772922; c=relaxed/simple;
	bh=lnICbhLhzotstOZ8ZJozhEPKb2XQoYhegRFC/4ln0HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRY5N+xeWsT1YjSY4gZ0HfclRFlzTF5VSiloHnLES6wam4SHHpSmnk6wX3GDinx80EQOqKV/XUWdebqLDmVp7a4n7zgJmZXWlzVQvW7kevs588dSE/mFdwsj3frNYCeQ31H0d4XZB+f/35wY7leLpf32RorHBJdjDdX3idBlub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwG4iIMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iBnEonaQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwG4iIMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBnEonaQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8G1kR1157459
	for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 08:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=; b=XwG4iIMKJeZ2D+Hz
	CKfKP+DHGqgj+Ue79HLYNl9b1uAnxAyVTsqGpS+ZYY6H6+hAsJiLGFM1ZFPc5Tbb
	NBfO2vCD0dAsDs7w6wuEArzY3SV/QITueh556KeyMZJ5l3JLmZ1Ql96dKdNatZSK
	old3Go6fSNOhonoI9JnR/xj55iXWG3df+alv/cfHEMNdz/eUDMprOoqR46iaKgOs
	FNc8bX++hZjuU3fRdeKOFz00+ZhtMAwMAHBHmLmOi2+eDybolD2/04eErECuIYsz
	e3/5kuiLxcKNk8mkXCWywCZHHUlJpeJ+cHEHlgwIFbSHdohakIet0i+2JmNZ9QJv
	U11AfQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a2mca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 08:55:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8d37bc61dc2so1690116d6.2
        for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781772919; x=1782377719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=;
        b=iBnEonaQR2w4BB3skIo30HZlN0FbjN/C8fuZh6UbSyus8eiCMIDjZtZYsA4dqfwJUH
         U7QSnmAnGvBlNVCl9zKhl2kTswQKNgR+/rV6qKymwgg4cg4S0re80mjqe76XDRzNAD2w
         OLZbZGIGy2tY08dPoaSjaI4k/oWmyVvVh0X92m4WCDJ9VrcTbbYizmquZfFS8tqTMJUh
         jE6PgnsudZRnc1d2lDHKsNN+Um6mvQ1v840n5Dhrmm4enBlPIjYtuRB9osDygL95U3kQ
         w2R8nEAOG0vo2P8tdcDj+zHbIMHA3UMCKG3torfhH1f+gf4DyF8MCvZRVBXjHkvA+UmH
         wEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772919; x=1782377719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=;
        b=rKrW4y4p4D2t6jq1NyYZlRCk/gkAoP2CaekqodXu9qdPQaAsdla6N3A4gkVBKh28Y2
         g+qk/mi+vkWMub8RibII9HquZyWATo4CB9wPjGtsAPjZp0wuA1t0I23Pc619bdO4DliI
         hz2i6kxViRcag+NNL86gzvNUOtu3JJHwdtiquqJVUvA4qfWitckSDMlF7zEjr/lnW0cr
         hUDvKYXe8iivJlZXFoR4VANm0CgEFYXX+9IsRHvJB59F5W5xHwDUTo/48v2RhmLkKf9c
         CL2wcdJFPbf49VreLu8aS6i1iKVgkpqz9+f5lwtSNII/S2Dt/SYY0Qgw+HmCwpuqzyWn
         DQsg==
X-Forwarded-Encrypted: i=1; AFNElJ/E3+nZ+5DFxq3kFK6XwNH9uIAHHjgND2NOliVBYQJNEFG39dpKn1FCHz8n9PgxKoRjlSZYAoILLWQQso8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwfNfv0VlT/GfOvGf81GQqIJ17pI1eiWpWy64pL6ULd/4ZQjH
	RvRdWAG1MATY8tuUz63ewx7UprSHl/IWn7er7wqd6PMX6VNywTbtiMpAD+h6orZzpsiSuF+AClL
	RTI2DTWvvxvaWMGFhqUOQWqwlPafB8fEvZnhoMs8UHhGG9Fq34Vt9h3JwoSPfQX/oiBA=
X-Gm-Gg: Acq92OGRtS99d2HjQao/n1GhbqU+7vv0rgR7Z6JtP5uuFWfXm0u/UeG9VRFTMQS/zz2
	JUIhiePngNpmK/Ef6GW47yiiQ7WqDKKuFh2fVE4NhGDE8O/6MkU2d4RD/xn9FNQjBDCmzeSxsg3
	n4Ijs3ZImJQ+4NRO2LY2GBAhL+NrJdVrlfbYZxdt54UpN9Qg9jRrjEFPIz7cHjbeQDCUCqLrpet
	QU6hk4wj/vNH+d4IqjlnVclHN1lcAsSow7QU/mYFAeJmpS1OdzBT8e2IdNnyC574NMG8VlkS0EV
	p5k+u6CujWiqmQJ3aMD+JtEAOey5jcKWQ8+65yr+g5DDNDhZ3TevkFONV1nn5scb+JMphzjymgW
	Hje44wuVntvy8KWg0WjrSipKSNc5NnaS2sFk=
X-Received: by 2002:a05:620a:19a7:b0:8f3:5988:f97c with SMTP id af79cd13be357-91dbb8439b9mr682170585a.3.1781772918879;
        Thu, 18 Jun 2026 01:55:18 -0700 (PDT)
X-Received: by 2002:a05:620a:19a7:b0:8f3:5988:f97c with SMTP id af79cd13be357-91dbb8439b9mr682167685a.3.1781772918343;
        Thu, 18 Jun 2026 01:55:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm407481066b.51.2026.06.18.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:55:17 -0700 (PDT)
Message-ID: <9bd02660-c6d4-4c3f-bea3-95b87eaf57fe@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] serial: qcom-geni: trace: Drop redundant len field
 from geni_serial_data
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
 <20260615-add-tracepoints-for-qcom-geni-serial-v5-1-2efa4c97e0e2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-1-2efa4c97e0e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33b277 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=FD2fNTgVWL2COFQd-LoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX7cjt9p+tOz1K
 wkPr7++PZYWgqOlvpARn8UIRVi0c1KK5AQXh0F5fab3lrHyx71mRWG2grueEmZnuEvdCRwWvpcD
 Ev2E/iiAQ2CiT6xUTaAih9GCrq/WTnw=
X-Proofpoint-GUID: lWs-DAo9Wy8QgbT7SjlhzrqJT_XTxXtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX0RDaG5dDjVgi
 zoiPEXeMNhc6AIYHwC1EXgBlasPgFthlTxMUQLSjk4y5QyJIjJbSPpL3Rh5wqnxDbh9cUhN6qRv
 EOIhUnzCP7r6lehUYQ9WcQt+NrmFkWw2/uarjt0mx05ERrpc+OW3bWMvwdfHkGPjEHnEH7thFYE
 Gu0sn130orvbJZdZJFH93MSu5I8mCfZ4nTU2k0u/143ZB2lO0Gg3LJqiT8desXyA/v48tWQwrW4
 RVAO6JbyOTNDipqNmzMtKwxr19nZEXIAoPX0yzTjomFdMM8VeemJVU9HpxPUaUa2FobBZc1MlAK
 9GN+TlTjMO4sAOrJSDCzw2T9apLrHrvYLdK1GHGuYpBLunPF3sTPtjM9nZ5Za0ooEPDXuB7a2va
 Vp8KcCrDdZHj+ZHinsrzkyLBCAIz2I+bmcU07BdLT1dP8pnboFL1t2pC5fL1esFTvNkjgs/A2q+
 OExQSMc9gTun4rijyPg==
X-Proofpoint-ORIG-GUID: lWs-DAo9Wy8QgbT7SjlhzrqJT_XTxXtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180081

On 6/15/26 4:16 PM, Praveen Talari wrote:
> The dynamic array stored in the ring buffer already carries its own
> length in the array metadata. There is no need to also store it as a
> separate scalar field in the entry struct.
> 
> Drop __field(unsigned int, len) and the corresponding __entry->len
> assignment, and use __get_dynamic_array_len(data) in the TP_printk for
> both the len=%u format argument and the __print_hex() size argument.
> This saves 4 bytes per event on the ring buffer.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
