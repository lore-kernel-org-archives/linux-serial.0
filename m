Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBC3EEAED
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527167; cv=none; b=gi4wBVFxepA0BquTnzjSQZPlVBPHk6o8ppCl7ORYHi4O2VIV/njhspXmA0kMhUbjJFYeNRkKi/2aP9rV/Pfo9Wz5T63EOPBfYUT9oyeSOvdmsHz1pdivkbx/ZnTgLP59zPjEAswDK/fthU3k2ivBQUq+d1De1fF39kCNvfUE/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527167; c=relaxed/simple;
	bh=Y5prCy5+X71R7ukzr0TW8cLU1IZdPzDKmXZeqLxAJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qol3JjysOdfuMZHzDtSZmtlt3hr4JYfOFtyy9nHrNqKgzloFj1jtCRydUs0rcvdvYnXpERLVM3Q7rcRlz6r5xDyDAVbnxHhpO3WbFR68bw6hTR8KyAYp+iJKhQrDnWps+E2VceJLfr1isUEufn1ZOcX9SAuMRSCSVZa+5+PcMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I15gNtEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZMArD7cc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I15gNtEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMArD7cc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZIuk4116400
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=; b=I15gNtEgbJFa3B2j
	oF2UfjblXkO2+xaZprLAY3bykuh+O2oyNVvKV1GpUMmRtVtbnrce/zW/EcpVsnNb
	PO36+hgg7n4VQ7FH83Q9gZ4WU+xJr9dK750kVKL0RbDOpFuFzlOQLv6oEg2LDwoR
	V4fjnxOB2Wgwhe3gDVE9KDYMIElRUdimqWd80Dtx+iry1BhuDjMPxR1/KsAdMxeA
	nN/VkD0yd2NdxRzJX/tiszcOM8KqhkJJOCZUDkqS/t1ZwJkMY6y1L2EOOOrouEV2
	5k7y3T5w50GTHHGbVU3VWctL21bxGTv+lrCm2DI20Blc5p2PJyeqJgV9yesLoXgP
	iQlbUA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjrpnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1394c3ee7f2so6655333c88.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781527165; x=1782131965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=;
        b=ZMArD7cc+bViQJNq+abiNgFiBNPB1JZ2vsARTz4y5k2v29KblIOfg8y8FoLnz1oJv8
         lBrwiI+UdmDlcVIqtH2JewyFxs3mUhIdDDOYLKN0JdLXlTI2zXYI77caqWHKBsBbCjvd
         YYDBpLvb73kYTeUR0xhk3QKnzMDM53iIE9pLCCMCKD55GhWf/cxB2jmiymt/Y7crs7PO
         YoCcC0ep+ptwZ0YQLuz6QZOSE6g3DEigWCfc73gykA2GqYVai3LWj5H4dYTl5WUVisiG
         MburxA8QNw3EApmVGgSDCxf3pwnCuhAbFsQefto658RNyiyc+cxFcEeCMQSI3JEOoKBr
         Xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527165; x=1782131965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=;
        b=qDxHqC8QCiCFZcW1lrvZT/YZdH/0loIk9ozd1jN132zqs0o35bdsszKMTO5U8jiiIJ
         oBLHMl4c5aRNqZBBpn9AQFnPpTjt4WAJdFcuZ2sTvUq0clQsTuY7jT/+/lyNtmSyTDzB
         S5dOuqEPwjrLkcVPaifxdRiGVebt8S4bkWWTNYVAjCghgmO8ATh57GlDU7xsbUFm23C2
         +nUeJrzwUKjB4ZZe+BLdSyys0glyeXd/2We8J1H03dJgi3IGzzlFluHuZPBDaw8vzkHU
         aA3KM3vRlLfMGDB/FR873UGzFWGuOErAcvsXmUabFERMe/o7z3JbxaNsxtua/l/oUTrb
         ykLA==
X-Forwarded-Encrypted: i=1; AFNElJ9+rEg8BND/v79W3mz6ADLkYP6aUfSHt8AEmiW4kB+lAN9yI+6IydA34+r4SQZZ3RaSMJ8PmdBMz4Nydlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajKLj1oVRRBxgO550YWXIXexxpzulUY3OZzn+ber7wnCfDR5N
	fu4OHP9zrcdvQuHj7ytdsR4m4Ku4nB5ho0nHMkK5A2myzAgmPOYVRNch/Uo2ErkJ+xe/ZLyrkM/
	v3zvalUvClyOEtA6liVjqlPWS+VSVHm7DKgcAwnZaaGyrc0pJ0E08oOdcEUt1vehEN2A=
X-Gm-Gg: Acq92OH/XXWCkGmAeHl44Eijjuof9pG3O6z5gMcDPRfqyDWY/zgcYvNAlVG8kZ9yJVy
	2hIzyjdyyS7+usbC0KlTLCwBJlRytodAPhyBLFcOa+CwibZLmnEK7UfTq7GScElSuZGAcQH63s1
	T2/7eGHVOvqDYOpZxp2wBIvaAoEaA993lTazziXOYUQgKWW7ZywSKBsHIRaGeb3sBBQ7FFI6WM3
	+FJnn1Y/yMZMR7EVdle1YyJJy2IO5DoknrJO7J2fpBQww4po41pM+stbGB24k9ERxzxEdyd0W2O
	q6rWUmBuPJd+5wLUv9zPeS8kkZww4ofPcKxp3xk55HDX0JCZADXMoCUMbQ0PwrXH5ByhqWdf8Q+
	L7iW1ydayhdvxjKfA0JgKUoA5SM1wiV+tDikjmLAoXAE/p5PG62YlIA==
X-Received: by 2002:a05:7022:ba1:b0:12d:f0e8:9696 with SMTP id a92af1059eb24-1386f237657mr5141969c88.4.1781527164597;
        Mon, 15 Jun 2026 05:39:24 -0700 (PDT)
X-Received: by 2002:a05:7022:ba1:b0:12d:f0e8:9696 with SMTP id a92af1059eb24-1386f237657mr5141931c88.4.1781527163931;
        Mon, 15 Jun 2026 05:39:23 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.111.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8f9927sm9787181c88.1.2026.06.15.05.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:39:23 -0700 (PDT)
Message-ID: <945821ea-5065-4e20-a1f9-32f7c9adb66a@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 18:09:17 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
References: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
 <20260526-add-tracepoints-for-qcom-geni-serial-v4-1-e94fbaec0232@oss.qualcomm.com>
 <20260529101422.18dda2ae@fedora>
 <688f0529-44ea-4cdf-bb0f-6c42cb3fa07e@oss.qualcomm.com>
 <2026061536-skirmish-nuptials-8fd6@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026061536-skirmish-nuptials-8fd6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfX0oqS9aq+bvWD
 sOBmTw9JsrQ1m/o9zDq4ZTkWPNYg4HSrFe5IB3Q8WsWv13ELzjfm1p5RSFOyJVEq0o9Gyg4Smrj
 ioGLXQ7o2gICQ/pCUCm4nC6W+a/EkXfqaqx6s4YBaW5f0FRjiG9BnWDNLNpyE5qWOznjBi7AcQA
 yu5gRKekUOMmugNmo7CyH7kIQncfdIi+LejKFiXem1/e8whK2FFD8RvOueO4SsO4MhDGtaDxHKX
 5s7bbz9jl8Vtp2SaCk6VBq3wHv7C3yVVEBmgYURDPtEQGmk90B0jokqIcp6W8sNVW5Z5PM9b/1D
 5m79hiUqDFPZ9a8YcitdzemAsVqg8LxCqmUiqqaZPNcr+NAbSsJ1L0nZ83p8Sp5paZW6/QuWmMN
 NvWSLBZZJmyILsY+3eEmru9m/HaKaV7VYJWWgVceCCxGDD3hBGgYBYm4OXT7L4fZd+O0puPbYqZ
 f90IoLpiRuV6jwXQrfg==
X-Proofpoint-ORIG-GUID: 0Hx-Pod8kxEbFoco0ckXB1vBHaqXFgFz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfX9KnjkXxbkPcQ
 j/CWUhAB6sLVNc+jj581JvMMqe4Isp+Ai9U+rFyZSUJGcoPYPyUgRsbw63BJ1DZbStFn+9BBtSU
 WljIy495q/Xu/HxMpc6CVKPvKW5YSa8=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a2ff27d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=f811rhDWPubbsD7ecTZfYg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=77qTbivRXhmBWYv1PLEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 0Hx-Pod8kxEbFoco0ckXB1vBHaqXFgFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150133

Hi

On 15-06-2026 16:12, Greg Kroah-Hartman wrote:
> On Mon, Jun 15, 2026 at 03:26:25PM +0530, Praveen Talari wrote:
>> HI Steven,
>>
>> On 29-05-2026 19:44, Steven Rostedt wrote:
>>> On Tue, 26 May 2026 23:07:39 +0530
>>> Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
>>>
>>>> +DECLARE_EVENT_CLASS(geni_serial_data,
>>>> +		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>>>> +		    TP_ARGS(dev, buf, len),
>>>> +
>>>> +		    TP_STRUCT__entry(__string(name, dev_name(dev))
>>>> +				     __field(unsigned int, len)
>>>> +				     __dynamic_array(u8, data, len)
>>>> +		    ),
>>>> +
>>>> +		    TP_fast_assign(__assign_str(name);
>>>> +				   __entry->len = len;
>>>> +				   memcpy(__get_dynamic_array(data), buf, len);
>>>> +		    ),
>>>> +
>>>> +		    TP_printk("%s: len=%u data=%s",
>>>> +			      __get_str(name), __entry->len,
>>>> +			      __print_hex(__get_dynamic_array(data), __entry->len))
>>>> +);
>>> No need to save the length of the dynamic array in __entry->len because
>>> it's already saved in the metadata of the dynamic array that is stored
>>> on the buffer. Instead you can have:
>>>
>>> DECLARE_EVENT_CLASS(geni_serial_data,
>>> 		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>>> 		    TP_ARGS(dev, buf, len),
>>>
>>> 		    TP_STRUCT__entry(__string(name, dev_name(dev))
>>> 				     __dynamic_array(u8, data, len)
>>> 		    ),
>>>
>>> 		    TP_fast_assign(__assign_str(name);
>>> 				   memcpy(__get_dynamic_array(data), buf, len);
>>> 		    ),
>>>
>>> 		    TP_printk("%s: len=%u data=%s",
>>> 			      __get_str(name), __entry->len,
>>> 			      __print_hex(__get_dynamic_array(data),
>>> 					__get_dynamic_array_len(data)))
>>> );
>>>
>>> That will save you 4 bytes per event on the ring buffer. And a few
>>> cycles not having to store the redundant information.
>> This patch has already been accepted and is available in linux-next.
> Great, can you send a fixup for it?  Or want me to revert this instead?

can i add fix patch in same series by removing original patch(0/1)?


Thanks,

Praveen Talari

>
> thanks,
>
> greg k-h
