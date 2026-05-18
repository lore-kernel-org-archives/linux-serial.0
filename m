Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1073EBF06
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112101; cv=none; b=lA+cl3LrRoZiC1E5OsBj1IhnAy0cHrXhQcC4Wze4qTTKZWRUFm362nPp5drLZMVUH1tFqwfuPdqGydPv2tO55tOYN/v/obRi7rI4i9BKMHrfXA8wMTQ1hzmFZ/Fn3G9lZsPIlPDB1YjRUEsve0DbWOJwIp1s4NnwsrvBDqAMWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112101; c=relaxed/simple;
	bh=TsPTaLl4zd51BWfkw9BwNOjMimnL7v0jxxsg0D/DV0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeK6nNKCey6110Qa9WoQZak48jH2vD5bYAGtzs60cyOEkfYBqbhIHjcgHSrXrh2QVN5MQs8aLGGXsZn1TkrDj3I/mgmDC+6vCkzVav5eySuE59KCZubaeQwyS6KrqWZsNQMm2KPHEZc8k+fighXAw7DgeAz1wYkYkXLAUDKwkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gavHswAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FL3D02Co; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gavHswAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FL3D02Co"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBwQpd1252027
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=; b=gavHswAiwzXoxRxn
	rIOK7IzhysX5RfBgzYPgWnU6GzQxm+uLrW9rf9pVM4c8ncRjpCJbKckp5TfX2Xfn
	3q254r7zf7e/t04lnZ7pSjPE4Ep/Ep8pSxKl2INR5i57AIn4K/X2uKdEoVgj2VZQ
	G4hxOkUCdlPkMPziwXsgWALE6HGbnXaxVwRcoETNQPEyA3Q8HcX/WtXpZLJuLlSC
	U1pLJjiCIZ/VMIIuvL3B2eCcypIZmLxc78ki6NWpFAbUNVmAqI5dxwGHXXH1/do+
	mBzWvFUpe4tyGHQ4Wg3RfeSgHDRcx94TKVUpYNa/b+hXiRVVELBLtIWejVEv7U3u
	ChUC8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82c0gdr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:48:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d8c183c2eso15735601cf.0
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112099; x=1779716899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=;
        b=FL3D02CoSROZFPllDTFmXauRTzLxMXIz9YB+NrFjNnIpoMP2whiYj55xHPp8O4jycP
         1Y2CoYtSCKXi0N9DWL5noIfHlpNtQFr8mofYLqMhzCH7Be95FtfQhlpgmnbYrKv39LSo
         EKgrRUehEIU8HgQ8aexG9IUn/X4ka70wu5oH+0sVPjUhmcKaoTPYArOnJiflGjjLTn0p
         TEAsQvH46ed4wGaZLxSwBOTqwGX/9LHwLAtJKrmSxBDAqbMtpMq7lAjcrRa1WnTmqclr
         f58OetHs4YTZYqSvWX9kzaJJoN/0LgPYZIJVNlK3ZqwP8YLVW7Qleir1bjAQzKSCAuvx
         TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112099; x=1779716899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=;
        b=HuDi+BJCNoH+COsnQsgPtuJtcv6NE4EGBgnXkBBsCY+6mwLeQaEjf9M/pTFFXtY/sP
         TtNpNIsAn2yCV7Y8Z7g/CA58K5AL5+MEgNc7NXG7V6UOkX+uPs28X2Y5d1GBWBlyH0vI
         HAlyi8no3YqaxXDCKEQKcmsCXI3EpZobE5y+AuHgcngaogHzoZpDGmZ5xkeQIOClyLvv
         5XZHCGFRIu5xI85MzYCoFxPK5MyydIGCMUKBhc8EHHIkxg3LLpI9JxLEwsRD3L/ytQVw
         ih+U1JiZzBvg9o9Ala8fX6EQvFE1PVo6UfAXzcHb14yUD20iJnp/MaSjOWea+hKUHoVQ
         KEiw==
X-Forwarded-Encrypted: i=1; AFNElJ9uyXopykQPl/NDFXbSemeudYqsiyOTPrEE4HSrfT9z3IS9c/MWrmnYXGuFjslehB0PwGsj5JufvxTzewk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Wfm7YIZGwn42u2HiLE8TFNjCwP0/Ds4hO3QvVTgaGA3DW8vL
	XmNGfNsDc8xbPFjl2cpJ7wdPhVVqRhI5Dq9H7rnDZtwaFJfQ3naUbplmdg8gteaoBN1jM3n/mMm
	YZbBR5iHjHXSjDcci7T8PyaV+IOUsaEqy36VntxlAp5muRNhapON1o8MsajPCUKeX//8=
X-Gm-Gg: Acq92OEbV7GX0Wsp0VNO/jOyg637bdchWym4ywsWJ2p4D0Q7nMBIIrC6/cle8nkRaPR
	nk/ZOgZEsU6wmQ5/ozJJ3BBv9FcCQ7tLyHRLioBMLecwu7qVxQZPaDHZON31pvZE/UcNpL//oSI
	RwZ7xPMZ9u1kGartZrkIVhsEOrT4vEbTI2MIZEJevHO+8JLf6sFaWw1JwNeZiOmuzHLzqiMixMX
	KUgiTgfTXdvT7VSNZgAXFDBzQoqO7KwU5kJSECxcAo/PyAHbkZSBJZfdxmtenfV9ENIvGmUgW/3
	NlYvpSA7BXYe5NqmhHrWTyf0s+yN62o2L7ePnHZipa6zk1D2nBqiDWOvf/Sg9KCI2w+EJh+hrTZ
	rme5Wbm8BOpF2bhU0K+CJPSTKxrjoWGga/GANyYslz3rqrwmGx4q7yyRuYOAy7PmUo6uWzmvWF6
	PpzHo=
X-Received: by 2002:ac8:5945:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-51659ffa7abmr160058261cf.2.1779112098408;
        Mon, 18 May 2026 06:48:18 -0700 (PDT)
X-Received: by 2002:ac8:5945:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-51659ffa7abmr160057791cf.2.1779112097727;
        Mon, 18 May 2026 06:48:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e2d75bsm561146166b.45.2026.05.18.06.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:48:16 -0700 (PDT)
Message-ID: <f8ce8518-8a4d-4ad4-a948-70e133c91b05@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:48:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNSBTYWx0ZWRfX3uRADbBDn2eM
 mlP0g+wnOlID46ZKkXLhtSdweL9Zabe6UBNAuNvMfAWMOf29hlk/nV6WAsh1Jyksyn28CjCfI64
 TmHbmcpIFs1yxIij9KVe9hbxGfRHm5kQZ/kQuUThaVFbgQRKG7pOdJm91WkUtDz3nRzvLQYJv9s
 Mjgp1KnAatndCKB9Gyo8Hb31A1I1vmg8rKVm+WJetK3mL7PBBnY7MgHNDFV1bojFXj0K3hHDgiT
 GNWteJY9qxHJCeFAj3ACx7yIXsiDS8Jfi6JqOHBNhdmOWn797j3LRvOljxMJ9JMuJiH1jACgGuU
 +bt3PWPq7Qs/gEsTbAWFRrtomDIWMmuRHtf75vw952N/qXEPwzCIN2G+e/7SaEknvNzyuqjUDZc
 nIEFqtGG9tcrX+eK0cDWIKThmyC0JQqJtBmnxrvzxkpWA5seVq6rOLS7I+uvwp/cuVbBn4/BB3E
 EwAN7XXodsOYOruBDQQ==
X-Authority-Analysis: v=2.4 cv=A5Jc+aWG c=1 sm=1 tr=0 ts=6a0b18a3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zro_ik8Ip6B-mArceiMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: cj-wRhMM-4c9ZIn1l9CyY8FP2YRsap_U
X-Proofpoint-ORIG-GUID: cj-wRhMM-4c9ZIn1l9CyY8FP2YRsap_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180135

On 5/12/26 7:14 PM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI serial driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover UART termios configuration, clock setup, modem
> control state, interrupt status, and TX/RX data, making it easier to
> diagnose communication issues in the field.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> - Removed multiple TX/RX trace events, instead used
>   DECLARE_EVENT_CLASS and DEFINE_EVENT.
> ---
>  include/trace/events/qcom_geni_serial.h | 172 ++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
> new file mode 100644
> index 000000000000..5e23827881d0
> --- /dev/null
> +++ b/include/trace/events/qcom_geni_serial.h

Oh, I only noticed now that this isn't in a subsystem/driver-
local directory.. I suppose it's up to the other maintainers
whether they like that

Konrad
