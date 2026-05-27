Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62662383C7D
	for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898590; cv=none; b=FmMxUo3zBhnsKp3gkWpZvHW7z/uxkBLf1GdHFibD66h7F+fkavX8mHkXrrYzgidoET/5BNPtTeDVdUmexjojR7fqt30BZ9faLe2yjjZmGKSvjTDWw43UYdGdxrvSdZu+aQ0zW++eAWz/8JjuscX+no0X7CL7GKr4z5yryJXmy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898590; c=relaxed/simple;
	bh=Mc1Kh8665aZUJz5vqgXB2LELXwVyswL8Z7BlMPFGqqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAB0xUYwQI+sA/8SxfZHh+g2TJ57Qh67UEhtWz/Ocj8mOaO+epfPdVSAPG+/uuB9MzqC5FOlUGA/1737W4xi3r/d/Y6ELkAYcTFV2e6InymN/WS/jDdJfHpLVcbJ7uakBIWpZsXZnVwjdGShGfh8QML7VWxikiLMCicEvB0ZmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdfNcVkx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9ECvczy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdfNcVkx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9ECvczy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFNVLa3830810
	for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 16:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=; b=IdfNcVkxblBNl7Gv
	QBG0601oHKvgS/HB12PNTmtcewFojqCXlpHhShPsTLTni55SZLjEevZjZMGGgaWJ
	uLnCedSYEZY6C91Wby3zpVjhDRLj16jnN/uAwe/iJOT3SJYK8m2hL3uUvBAeO/ij
	WDKYLAbKgidVFevECp5dzv4jY9RO4o2yNCIs55NX1kNkhOTXg0HaPDAOoAOTHdf4
	5DLT6tisRhkwWtxtKHw4oeYZ6DOzR8iQpS+WIMctFveU/neLg14r4A/QJNtBEhv8
	7zW6kdqaJgFmx6s8nP6DK0sAhoISpoBK1cK+8P8lu+/D+guc7Hr7+h8WkNoObwT9
	fNaXcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edn17kdp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 16:16:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304c46babe7so1816729eec.0
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2026 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779898587; x=1780503387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=;
        b=D9ECvczyXj/RZkHTM4FtaxjUutNdh2yFt5eQ2KQCS0ACLYuSoWr/h3N1N9iVsIX+/C
         k/dWV2NLZj5MTscRVUld3IhYpRdDuvtr//aGhDQlYP9P+qny4F4dQfcbt9lHQW929Ter
         P5zsWpiq8h7uf0S0mUIL6xygY+8mgSDT1tAcIiZENb6vhJKM7oYT6XdEG6phjpgw+NLi
         QOiYj14TOmWdKZJ12ID6xrlELlzveGTiLas6Q11auFLbsVpI2/GvaBMFqHg1tC8m79dS
         bxHuJSqBWPosUveR/K+mQZlskWi7TBqlMDnamjlJsBdQlBH/pV0VTgsdHEFdoZWWxc+a
         jHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898587; x=1780503387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=;
        b=tCuwKVhOfuIf4V2+h806EadgOMQD4xw3kdQ/GIRogrK0oGjvyEpoIe6pVdq4FCSLIu
         i9gaR9j1FVCPZTkvh4d4mdhFBv9ay+A59ruJVT74MN1tvCult5/4cIDRLwR4eLrtjuE5
         B0fKPAPT0wziLm2/CFMHYQMbIBSHrYX8PFa8k+ToIbfBCwEkDIE+l17PdzJO/WLXFLYJ
         AXf1i36+GqUg+iaXBVXofTiflvk76TjD5ttjmCBFuObB1jBqQqcB9zPwcwJw94DTSI0u
         fUo39JpqbN1l4kpB2nOz2Gu1QBAm21T1ipUxyTVijSSDOeFfpXvblMCl7nJ5tVaWnxM6
         a9vg==
X-Forwarded-Encrypted: i=1; AFNElJ+Mlr0b5vWvsNxjtb8SCQC+XC2uO0SLWz0GtIA/A5YIYghn1Ue2aOxUi7YeKupoRtW47JuOHtwOdOweo5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6u9ZYSiNih4M9imrFHNih3TR/cxDb8NP71KxROAx8jvY6wQu
	zAAiO8yBqrLRPQCgChho2I4nx1GMy7uyhrJxXVFT+ekNXG++ZE3lfCH6clzJPzGZCYbZOMXFHKk
	tQmMfM0bACx+YhC2BsbOZ6Mbs591Hv0w2TN2b8Qbn/AJdtn6GqwJ4ES9TLL+iYZStvk0=
X-Gm-Gg: Acq92OGjEoomPV+ppn61GLR+LosbdsdV59EBCA9vEZfmoY8bFaz81yppUV4Svax2/LT
	kJZE5Ozgma9ZXj9rwoR17CoRqCLT6tzM8iaRYTbJfL3RZBpjyiGUIYORJOkgdgvgteBOadGDvWR
	00Nl5FecZFivpSF61+XUz4iBBANz+iF7TT4VXUUkHf6b6DWkmV/xPDOpBvGChmmi2RosBl4G1G9
	4Sj38BbulxW7qAwsog55yqpobQxdco41SVyeyMJv6b6AAim844NuEyOA2M0N1cwhupPPYsxAj+Q
	2tZ07XB6lJR8TWdZXKQ57Oam/8db7KEuvPaNzEJFGj1enL67Qy+X/yeyXmnMP1Zw+BOnJGW1kTk
	xTzQVvJltjceGC0HiX8vFM98/KKXeEJ8YeCqwNXJHdYRTdgT1KC1VTLI2dAMXDw8H
X-Received: by 2002:a05:7300:641a:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-30449144597mr12538888eec.34.1779898587486;
        Wed, 27 May 2026 09:16:27 -0700 (PDT)
X-Received: by 2002:a05:7300:641a:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-30449144597mr12538866eec.34.1779898586745;
        Wed, 27 May 2026 09:16:26 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.105.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304522547fesm13547748eec.21.2026.05.27.09.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:16:26 -0700 (PDT)
Message-ID: <cad163c4-2c5e-4c10-b434-d8bfe3fc0209@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:46:20 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-serial-v3-2-b4addb151376@oss.qualcomm.com>
 <2026052258-scrooge-friction-fe21@gregkh>
 <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>
 <2026052738-unexpired-diligence-10f8@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026052738-unexpired-diligence-10f8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MyBTYWx0ZWRfX8fvMIB2axsNx
 fgK03Ll2SGtmPCLQgoJq4kN/4ITQqSl6WSupiE5d3FfOV0exyr+HsWWHInpEJPLXd8U+pxhmmOQ
 E7UPsltE3iOEaPfqMI3ueNvKB+NMU8izFXCqcnna2EEz80fB90caqy7vQKJZn+7XyUP1Bfcz7ct
 drYDC5wC8PyoRjNihALk5WTRsuutqXjoAManLd8BTfuMJL32TbNt7P0rgKn89QFHsSxxUKsoJE+
 ikD2052JUe1nXlhO5Akp8F2YTrgwZ/EW1Q3e/p7F0loJ1RDmJK6TZV5kGeQxOksBE3QpD1H0fXg
 MFZR9tF/uNWQSQF9nFRs8Bal+1gAlZN/1NPGQrEaAAkMek7fTEdwVZRa1pDHWTv8ijYJ3mAotn/
 uonJzrDlVpwzQqJ5dkxITnqMsLW+tQ==
X-Authority-Analysis: v=2.4 cv=R6Uz39RX c=1 sm=1 tr=0 ts=6a1718dc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ExCzEAt1B76v0Cu087J+OQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dl6q9R0lG94mxgL4v_kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: pZGWzUVF3F_Qmu9UcVATQqW8PEfk3rka
X-Proofpoint-ORIG-GUID: pZGWzUVF3F_Qmu9UcVATQqW8PEfk3rka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270163

Hi

On 27-05-2026 13:47, Greg Kroah-Hartman wrote:
> On Tue, May 26, 2026 at 10:36:18AM +0530, Praveen Talari wrote:
>> Hi
>>
>> On 22-05-2026 15:17, Greg Kroah-Hartman wrote:
>>> On Mon, May 18, 2026 at 11:26:56PM +0530, Praveen Talari wrote:
>>>> Add tracing to the Qualcomm GENI serial driver to improve runtime
>>>> observability.
>>>>
>>>> Trace hooks are added at key points including termios and clock
>>>> configuration, manual control get/set, interrupt handling, and data
>>>> TX/RX paths.
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>> v2->v3:
>>>> - Updated commit text(removed example as it was available on cover
>>>>     letter).
>>>> ---
>>>>    drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
>>>>    1 file changed, 23 insertions(+), 4 deletions(-)
>>> This patch did not apply to my tree :(
>> Do you mean these patches are not applied cleanly?
> Yes.
>
>> If yes, i will push on linux-next tip.
> You mean rebase, right?

Yes, i have already posted V4.

  https://lore.kernel.org/all/20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com/


Thanks,

Praveen Talari

>
> thanks,
>
> greg k-h
