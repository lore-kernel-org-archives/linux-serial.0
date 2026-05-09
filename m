Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB41A6828
	for <linux-serial@vger.kernel.org>; Sat,  9 May 2026 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289560; cv=none; b=XKGE3POdwNTR/ZaAtnTcFjdy5TG+DuW6QjNyYhgI21+TlnkBJ+fWPCavrT4mUupmLzzf3ovK2o7zINOUn6Cc6fAiElwY4gbAtO+64xBI2ZGu2PgDt0H8bk5hLeUVarzavY5wGNCJuumYo9HksUFDXP6tMX30K1clb9d3YaX+APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289560; c=relaxed/simple;
	bh=akDT+lYONcbq4fIHNXiYeOOokqqF1TABlkQo5wHmVvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdbE6w8a632Xtdq0Mtuz+Tm9+IMGr4/BLPK499qT2tUuffspLNDoQ3CwoDXLfFAJwXxPs1+Ria60ZxvjWwe0op/kC87K7pn7wj862+DpERtNbDvpJsME+9j3Ul1nAxRjQjdgRVIu/ukwzWYvoR0Q+sQzvg9VGa608h0K8+ZlqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/NuR0Uf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RMCxCkkT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/NuR0Uf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMCxCkkT"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648K1OpM852412
	for <linux-serial@vger.kernel.org>; Sat, 9 May 2026 01:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=; b=L/NuR0UfsTpy473e
	mAveDI6EKxjmjbtZuaXprazRlbgBrvz/5j5arv9uRawLTF5kSWSzOo6SXuuB50bT
	lNGPlrHs4PoHvuksBjwNsLsRcJUKwSEd4mtP/hNIemwk7V9G6ABPDYM5hqqRNTmf
	/OoBi6aL+p1P9iGbFmr8LJ8pn8fWEcTMmRwySDXfEKqkTwmnR8Jb0mQCgeSU7DZV
	qQWuc+O4vsQ3paK/LEkKBOZblEsSSlLX4XbrFfsUhwq+ISENWluwmSDvyJiHvvAy
	EHZupNChhLpZHf29TghBTpaJ6wwDcNHzUssdxAU8EXx1UM2GSyFYwj8gaKmEsW/l
	KWKlIA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptjfp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 09 May 2026 01:19:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso2014035eec.0
        for <linux-serial@vger.kernel.org>; Fri, 08 May 2026 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778289557; x=1778894357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=;
        b=RMCxCkkT3L7FEPRWmUhymlQ1Y7914etXW83vhGXwiYHcK/p4evSLa+0uwZBwBmo9TK
         zlieESMHaB0nIULgBaYdV5bEx/1gt6r/053sxPf7gok/qEwGQj73TDvnvx5tD7KglhpV
         iaR87TB9H71/XleBQunt6cfXOULvcC91ZHNqdFoxJx3f+YFAnHGYs/+fE/a/NUhPnZzD
         +20Gx8tj9ix1MPKZND6Y0nNNqa3pqliuy+mPIFKGkhR5S575HTXU1lSGhqZePCCPFgW9
         6fByGpYErAPP7N3nyeI60DDOsxuJYjZcTAdZrmo5zPOEZvT0SyCqye8SQ0PdY9+z1W9g
         Ik9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778289557; x=1778894357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=;
        b=LAz2ZcpYchYBMIcdEuD9OYdNFWtGFAJuw+TvAsrU5KwLdJ3DweqNjn1xDE2h8y3igm
         necHMj4I8SFU2BuFI4mUhbl+jy7cPjpkHDVxMWd6fz6fml81G/XDgtRpMqK1NWX3nJqs
         Pa1hh5s5luYS7VO+XsbH5d49H+tWGXVJQIQ0U39nYc+SF0XHVnkv1Aj1BpBM33zi4oe3
         J2WWAZgonavApr9hBPv1wewqY5iG+m0SLeOK+DIEK9zT/cq6qQXgEOno/bzJ92TRXI8t
         vpH+Gffa5f26FWomimZj7Hv+CzJfXvHn4rjweTYjjHq0ofYbmdiSMSdyEeZQhaE9voo5
         +Lxw==
X-Forwarded-Encrypted: i=1; AFNElJ83/45zd0frGGLU6Z0yvQ93oZm7kf5UHOn/hsadZU4TjLvcXQCXsi10jDePKRfmEsEDlIH+c2X+65GzJ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJTlog6AB71266e3B13gjox0IU3Uao3WH6eLPBNnMSQCd3y4W
	UJcSd9jr76SFEVilhE0ik4Tgd8bx5AL7G1YgbU+b2dJYdTij9t+9d+TjIscgGOtoTEHHh1Ukvq4
	9QJ/L4TDStUHdxLac+abj9WjJcEXO12ayUbqBEysmw3dtO1R7i6o7UA6NDft0J10xbVE=
X-Gm-Gg: AeBDietPktDT4IMFul2TWbB728DWXz4Vj/FVTTNeLkQyKnTm5FSUGDqdsN1uoApSARX
	edM9dyIc/c6UTYsIB0RIVdgUYTYjW/JvumrzVumEXsBvZBla/hihPw0+yBzvuGo+v3NgqjsfgB/
	chBuvgcLsd0uNTrsD6chncGdnW1G5jJroGflPq7FGiShMSmQ6XfaSzpZZ/lnr01swIBYGnzcV67
	QYzoncFabjFrzw/o/YD8kZndA9EAmtfOwcHvInj0lvsCpr3Bitg6cZ+02D67C6BgNxS7CicwKY+
	t7lOzox6DYoWdQAZ9hqvxTrsNw+rpEW2e75AdATtfggPED9OFR+RXfFuTZE+Hi1bxuYRKu2Uvaz
	7eCWeAuONj2rcTV3K7+ImEnHj8mJZ+bEjn3nssH6l+fWph7ym3XgKtA==
X-Received: by 2002:a05:701a:c94e:b0:119:e569:f86d with SMTP id a92af1059eb24-1323ae991aamr4128641c88.10.1778289556629;
        Fri, 08 May 2026 18:19:16 -0700 (PDT)
X-Received: by 2002:a05:701a:c94e:b0:119:e569:f86d with SMTP id a92af1059eb24-1323ae991aamr4128628c88.10.1778289555965;
        Fri, 08 May 2026 18:19:15 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fd00sm5674706c88.8.2026.05.08.18.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 18:19:15 -0700 (PDT)
Message-ID: <2e694c95-83af-4548-b453-19904d24d924@oss.qualcomm.com>
Date: Sat, 9 May 2026 06:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-serial-v1-1-544b22612e08@oss.qualcomm.com>
 <20260508132543.4f100ae0@gandalf.local.home>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260508132543.4f100ae0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3j4APSnWbkWRhXvResKNWQmbD5k9-9kr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAxMSBTYWx0ZWRfX9vibzL2SAnSK
 MFb5gpccc4rU6Lfb2dH6NzobkuxBSZgBgYTdisZIgWH9aWW6XaxUliqm2yYGKNZhpO19/dZGNHk
 AIg8Gm9fwPo6emEPK6rYOVK20l1ggP1NOQQ9ZDAyZ408iSBCliEvx0q34uQLKiADVGMLsi55qvh
 MPFq46HJ8w6LVXe5eUFV6+vj36HO07igaVQAsFeT7Ejtc5bBvkHkYInqQGtaXTJ7dufsJ03BsiG
 mOtOFI4KzgT5jtFWZKvHOEkbMFxLKRHnOG5olcnEjhD95RhPRcPAX7wH98Y7eARNniIRQ/8FA6l
 4lrBgfie0d4Z8GMmH/UAJKn8vNCteIEgiXDb1prMrO6PNlFznJ2GrtunHKOcdNtBTwy6Dv8uOjP
 oAc7Oz87g97HhUJdYf32kfbSgcmHxE3kMJTcPhua98i9DM6J8zUg83pIgFwAz7Nr45uFWE7XeCF
 aH3XTGF488daHVf+yrg==
X-Proofpoint-GUID: 3j4APSnWbkWRhXvResKNWQmbD5k9-9kr
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe8b95 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_ZtuFXLZ6xHUn8lUtBkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090011


On 08-05-2026 22:55, Steven Rostedt wrote:
> On Wed, 06 May 2026 22:54:44 +0530
> Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
>
>> +TRACE_EVENT(geni_serial_tx_data,
>> +	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>> +	    TP_ARGS(dev, buf, len),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(unsigned int, len)
>> +			     __dynamic_array(u8, data, len)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->len = len;
>> +			   memcpy(__get_dynamic_array(data), buf, len);
>> +	    ),
>> +
>> +	    TP_printk("%s: tx_len=%u data=%s",
>> +		      __get_str(name), __entry->len,
>> +		      __print_hex(__get_dynamic_array(data), __entry->len))
>> +);
>> +
>> +TRACE_EVENT(geni_serial_rx_data,
>> +	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>> +	    TP_ARGS(dev, buf, len),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(unsigned int, len)
>> +			     __dynamic_array(u8, data, len)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->len = len;
>> +			   memcpy(__get_dynamic_array(data), buf, len);
>> +	    ),
>> +
>> +	    TP_printk("%s: rx_len=%u data=%s",
> Do you really need to say "tx_len" and "rx_len", could it just be "len" and
> have the name of the tracepoint show what it is?
Sure. I will review and update next patch.
>
> Each TRACE_EVENT() is really just a:
>
>    DECLARE_EVENT_CLASS() followed by a DEFINE_EVENT()
>
> underneath.
>
> And each TRACE_EVENT() costs around 5K in size, where most of that is in
> the DECLARE_EVENT_CLASS() portion. Thus, you can save some memory by using
> DECLARE_EVENT_CLASS() and then define the above two events with
> DEFINE_EVENT().

Thank you for suggestion and will update in next patch.

Thanks,

Praveen Talari

>
> -- Steve
>
>
>> +		      __get_str(name), __entry->len,
>> +		      __print_hex(__get_dynamic_array(data), __entry->len))
>> +);
>> +
