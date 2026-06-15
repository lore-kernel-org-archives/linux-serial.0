Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07603DA7FD
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517394; cv=none; b=Vtq/BXyrlsQ8WjDv7a7EaHdd2KhUa4BUbuKLA/ubgkhtWNZUwiXccDSgKQa/pbXuKHJvCxchxxXClprGJOZYT/WpMj1nS3xvxDJaYRGO+PX2YuVF5zWhVbF54A92XpyjuE1HIBuze1DRn4hcEi7POi+CqM/B+Xg8SDX+SdUzIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517394; c=relaxed/simple;
	bh=Ao1e+0tZyZu1bvnvdgxqH4FbrPUDA+TCNJkjlZ61SFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdQ3F1mks01LTfAGrYGgKZILdvq7+/kPKmiDSPzMfxe592FI4Xytoj/JstthAkzEImQPnC4GmYer/LE0Swfncp2KOcpe70BuDscIuH8+xuYf2xZOQzlu76hCc0K5TMUYbeX56Xolp9JlZq6ZJVK3z0n/U4NYWFDlMXjbQpiFSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqdE4nP+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqJ4O9EP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqdE4nP+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqJ4O9EP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F9Tp7A3704159
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 09:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cmNRQTJCMSzHPTRP5qMJhNPRDkvbUhMzAgHeE8nbLk=; b=aqdE4nP+lCo2PquQ
	URPEaj/oHQ5rKstMbsLUfzuKxL0CsEjA4F2eEC6iiW+pMLmzvNAkjJs+iJpV+5VY
	Ztk9xudT8ms/V8X8UJmPKTo8pzalUbfT8kCuwFShDoFFpQPIW2AlXyn8TTTpn9b6
	JtupX9mrkf7LeshubvvSoRLnfX5U76izzZtstdLLKRz23eWVG5xHaak8E0VPcicW
	/if8SPX0zwxHCIBKq4nAk6X9E3XsCvjT5fV97uWod7FkJz6CKvFDefIk4Cyo5T86
	vhkvRoDUQs1cgwPxopC1yOM2ttm6KLSNtfLdiCeh3sP++uReXn156u4Ct+aaRKbO
	NwNUoA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjr343-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 09:56:32 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1365060ac82so2191506c88.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781517392; x=1782122192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cmNRQTJCMSzHPTRP5qMJhNPRDkvbUhMzAgHeE8nbLk=;
        b=UqJ4O9EPZizYeUNYr/dFAldneNTTlZPEdcnyv/WGNuSA5bJBGJ++v4brIwzXE5c9AD
         J+q9vgDDJGcE8ssb6zCcUau98eCCO+9pTyr1LloJb1k+/54e7rJ/6yQZP0F+6SblYnaP
         zgt1SEB4Shf1OjPM6Ij8NhPy2zko5Gpexm+3ljhNBI8RV7XbqmMWu/lDAZkm3cWbkeeL
         lNpFps8kZ/EQoe2WsyVaaTOcq1iBsF1hj6ydXH2GKw8iFgtmZ4dwoDoU6zON9Hw/5vaK
         uJExK1ieiH+DBC6vruCQbqMJFV1FvHpdqy2nTnYpMsgGBVNYu0v0t6RnWLHQk5J5b57D
         v/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517392; x=1782122192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cmNRQTJCMSzHPTRP5qMJhNPRDkvbUhMzAgHeE8nbLk=;
        b=bGuRpdDaeUCw8aMSB4wbnNEgu3NmnqWQnOy7dK6dncyNnIyku3xuJZmWNkmy/iuH40
         V8e5O8Eh5RAl8HECcjElkagFTjTpe/rnqmVef56IrqmkPuJR0imPXfLK39QcE+gNpnvt
         5YwHKW4fZ2qZ3w2zjtSfpEpR/M27LpqZEdfx0G4qZDzUhfCkd/g7IOWmu9iZwcMFmnGT
         e9t4nCSw6yKNQFRr7B3q0soVC3xpBL5xQNS1zucjds0Xdern/Z1Ted9RuslBCSGHeWle
         sNDAHa7xwoyN879OobqqGKyg2Z9HOXhGY604py4Zu68jXMhPAEVjTeR3M9n9snlIM6mx
         yI2w==
X-Forwarded-Encrypted: i=1; AFNElJ9EC9/j5JwympOErSM0XV1XPmOY6QpdXvvs7QczGiGLTle5RdtDAKcyZq5vIaS+sBlSRmRiTRVuM4U9Iz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/CACVBZqlqsgDFZV+mNQLhFDytAgmpe8GrkkmspFVeT8+gT5
	GfRDz6XRIX8+v5HQxNUIfkgTNOj3tMMcbpmF/XVc10XODbSDTBBNh7dWSvd6zkikwtjpHzsdYwT
	2d1Cr7Gjj9YntOZ+WhEccyIE/7SJu45W346LUBCG80pAGf/nWV5FR5s7LGuH4UC+u9/0=
X-Gm-Gg: Acq92OHm2Y2CAi4SVkxLz0u5H8arBMLSfsUfQau+5puSTvYxYoE7t0h19Ya3apcsU+U
	AD5oOMqRPGbRulzOFhVxHeDDpvcZ6ewJrp/JmMCWLENylE5fVMTP4uFJxqik0XL5xdNOnxV5bVn
	88J2oXirOaRA1yTT+c5nY9bHvZcvb50ezIx45Hrs2Ei9gyWJgtT8Ux3OgjPIstY+Yw/tFhuBHVW
	ckCqDbGXrrBVLt1RHyrzrnlktEy0H7qwbGXtQc1talif9E3wLJUj1FvMYvYSSzTXvaCftGwfiyO
	MTs6SD3gFikjUqCzZm0wu45MuFwLPvSDEEa7J/LaCMgpvkkOhBtADF1H6ZtfAEb0lTJesatLak3
	6ShkQbbwsqKXjyKtt47f/MIFMajKE8apBNqu+/oHZOfJlPK39J2VGwQ==
X-Received: by 2002:a05:7022:6095:b0:138:5049:cb88 with SMTP id a92af1059eb24-1385049ccc0mr4361550c88.8.1781517391995;
        Mon, 15 Jun 2026 02:56:31 -0700 (PDT)
X-Received: by 2002:a05:7022:6095:b0:138:5049:cb88 with SMTP id a92af1059eb24-1385049ccc0mr4361539c88.8.1781517391360;
        Mon, 15 Jun 2026 02:56:31 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.111.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8f9889sm9435686c88.3.2026.06.15.02.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:56:30 -0700 (PDT)
Message-ID: <688f0529-44ea-4cdf-bb0f-6c42cb3fa07e@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 15:26:25 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
References: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
 <20260526-add-tracepoints-for-qcom-geni-serial-v4-1-e94fbaec0232@oss.qualcomm.com>
 <20260529101422.18dda2ae@fedora>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260529101422.18dda2ae@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEwNCBTYWx0ZWRfXzBQtfFWOmB1V
 jbQ98THE7bN2wE+99VQjCnujhECKxytzRXEAxMf0I5GBkkFOeqGYqXizC8El4jMqEzbmN/WYRYx
 VKaxaLYSYKuW7fGXH8qFj/mG8tM8JpLFKzQ7s4TrpCLKF7c37ts+oLq/mHyu/PxyHyWXDZgMPMD
 LS5jSz1+RFILQZNoDrN35ERuEhp+4ivin2onocQ2qsMAP+/iKNKgq3XyrI5HK75Euzd5wVbrZXn
 ERHXUsi30DdDYlM/wYJCwYlPhdRxVFXidEpHLvmgjrupKpRgBkDruI6B+tu5/Q7xaHZt9eC+u2N
 w+nSdkZshox2FxoIKpoIvZITsn6fNxjZVNnEkENT25zRBRTh0pAuednagzo16Y+x+DJJ0h6eJEd
 sONv44m5kNcqEYUqhNhUQGobprfiwFS9D/mqbQwN0QdDQ0jUr9SKJR/47wT6kHYUA26XrXkSQJV
 4NB4KzuXMYPgouFYNug==
X-Proofpoint-ORIG-GUID: YuawPcDfGLUCXlwCfU2odGt9sOFmKBNk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEwNCBTYWx0ZWRfX7ol+sYh2xtvf
 CJzXSDcuTk3cd3N3xBPF1Aj7vkkfe1Hcs+rX8cQswPRbL7SHsb6RpI4799+y24GqM5rzBBtX+JV
 pIKFfR5WZOnFbKfOgAL2+ZkXTK4KTO8=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a2fcc50 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=f811rhDWPubbsD7ecTZfYg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QHbzznkLyNFsLEHLBrIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: YuawPcDfGLUCXlwCfU2odGt9sOFmKBNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150104

HI Steven,

On 29-05-2026 19:44, Steven Rostedt wrote:
> On Tue, 26 May 2026 23:07:39 +0530
> Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
>
>> +DECLARE_EVENT_CLASS(geni_serial_data,
>> +		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>> +		    TP_ARGS(dev, buf, len),
>> +
>> +		    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +				     __field(unsigned int, len)
>> +				     __dynamic_array(u8, data, len)
>> +		    ),
>> +
>> +		    TP_fast_assign(__assign_str(name);
>> +				   __entry->len = len;
>> +				   memcpy(__get_dynamic_array(data), buf, len);
>> +		    ),
>> +
>> +		    TP_printk("%s: len=%u data=%s",
>> +			      __get_str(name), __entry->len,
>> +			      __print_hex(__get_dynamic_array(data), __entry->len))
>> +);
> No need to save the length of the dynamic array in __entry->len because
> it's already saved in the metadata of the dynamic array that is stored
> on the buffer. Instead you can have:
>
> DECLARE_EVENT_CLASS(geni_serial_data,
> 		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
> 		    TP_ARGS(dev, buf, len),
>
> 		    TP_STRUCT__entry(__string(name, dev_name(dev))
> 				     __dynamic_array(u8, data, len)
> 		    ),
>
> 		    TP_fast_assign(__assign_str(name);
> 				   memcpy(__get_dynamic_array(data), buf, len);
> 		    ),
>
> 		    TP_printk("%s: len=%u data=%s",
> 			      __get_str(name), __entry->len,
> 			      __print_hex(__get_dynamic_array(data),
> 					__get_dynamic_array_len(data)))
> );
>
> That will save you 4 bytes per event on the ring buffer. And a few
> cycles not having to store the redundant information.

This patch has already been accepted and is available in linux-next.


Thanks,
Praveen Talari

>
> -- Steve
