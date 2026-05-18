Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E73481A81
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111662; cv=none; b=A7vujo8mve5Rd/hrbBaWYfKfWxhQQtw3a+5AJjRPkZSGJCkoOAYVTssyLj37McnsMmkOtLadWiNKEq0/dr+lLttm2lx7rkk3E/8dpuQFB2yzYj/9ejZqbEAwdUxeLUktXhkonnzRbHEclgguDnUjz89MfLPE/QPRx/bjUEQxqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111662; c=relaxed/simple;
	bh=57KBMhPoXOLrxYaodFJyU1hyz8hueBgCg9SK1L5VcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd33QiDijflqGI2TCBheLctrQmESGCVEE0hB/bObz8kGHnpE/xO+cDQnPz3JFJv+1YSCvHIexHIiI3fTbHwQZgpG56/fgKWwN3EKz4I5iwj7ZBMiDPiJ5sjdnFMD2ickY5G5copZtzAVd4nfUeS05zU3icyfhtudqtE/k1ipo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipCDmSMZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GHLtUSXg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipCDmSMZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GHLtUSXg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7cKrj352984
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=; b=ipCDmSMZ0QTQsv7p
	MysuYeWl//kp2UqxZi6cY+Mbe0riuRiadjv66PX3gcmpBG6+L4sSbpCGD58V1gLD
	37I/2ZyOh8HNdY8RI+NJI1gVrypvq8NVmpjnMNAlMCL9ntMw8ssKlMRijTfzlaYP
	kOyrmccQgOKtyX8+XRXLGCWuGmPjsGxrs3ixPB/l+EXt5VmFwlM7wg6qwVq4WL2W
	n12miacMVR7PtGfh7I6JZC9Tcf3G3RP2hJswpP2hZjeNbW0B4qSN3GUvytXohtvX
	lncKiEen+oY8ta7DzyF77V8GHS/kZMHlJwXPL/ooVKW24tXF7vTJLU5ZGiqlwhBO
	qxzNYw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xjahe9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 13:40:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e5c781193so6187911cf.0
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111658; x=1779716458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=;
        b=GHLtUSXgiejWTwQZEx7ZetDO8fmudWxP9TpcQ+6rSOj5/sNtoaJkXUehvDtLBl+8FL
         EAb7x7WIurwD4cAzrcf9MfxA4FbTIpcTmmUeIeYKxFWpIp0eRx1S7zjEWYFLW7iQJ0/9
         8RWMFJtLLSmvbd1jet6lWhwWzzt4g7ys0a5cb2ITylyZMLFRoTmyCOOH8wS4NYwmCOTG
         fS5k+NjZ6m0NQeleOaI7CMDgMqZ7DmwbVcQaPectTNY7sy2M+VIwe5e0VYeLQzTgcwNA
         EuHl5FHQN8u1PM8/OAGMIU0XRZ99rgankTg6Bn+K0E0kgVvYcv61Vn03SKA1nc3MY6T9
         4Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111658; x=1779716458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=;
        b=b9N6qU6ZXaTBUcyhjP0zA2yC4rrzyeCVB9zlvOfd6WoxJrD7lNPyJdce0t8GCWYwZ0
         CFOzHUGdVRKNdrsiy2YWQlY2AXrj/YfsDBfWA2FqqalXujsU3HkeOFKb9VuPveauhLDj
         2JH4KR3qOnf8K6q1zNfvBdmWOI/dNChVursKlGX1jOGW34DNdW7ZgD4oBB9sVIKHttmV
         6Cw29dzoFNccEUAqGHI0q/CVWvraeW/FSAnvDFXXP/RqtEqBtr8Fe7RuBloOz8O4xJyQ
         Uv7XxcXJYiR3CyXm83luZpsywF8G9F5PApmxMNB/pJT0PKTMvXE/qzB90ijmBCbJd263
         lMGg==
X-Forwarded-Encrypted: i=1; AFNElJ+yh5LSCJZRxtt4x+4NIdcHo69Lv8kD68NLjowA98QAfJ3aiPfPYKllniHZN3CgtANBvdZjowPQ4qN3lrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZX7ZwT+btI/6H/4C041Y/xLRht19GJWO48goafZnDFshs9pv
	AA3uiowqxaEAlloNP9frYcO9x6cai/tZwaxNUsOatKj2yRyj/gmSZUfZ/wUV8LczmiUP73chxXe
	5nod5nFsp0MWEtxdOGMaTVf1SmZIXCciWEJV+BeshXuna3lbPyx1AeYcerJq3VYjyAFBxBSPk1z
	k=
X-Gm-Gg: Acq92OHf8MgLouZFK4uEI/80mlOuOFd/nnazm0Q0tNQKQBNAJFJszN2vTTxPPLFStUh
	Wf8cIvJNN+rxePsF16kOerbpu7R2RgWSryl7QTzkzjY4XHqtxmyzlHssvil0psaHwCv5n9LBK35
	Y5OhDU8+WJ8tDKCc74rFm20C5f/p/0CntvDr0A+GAHPv1I2iOhkvQtYWJKRJxQh1ZNEgcvQrM2F
	8jjlCfzhc+FIfTRVjUb0kRgQklN0h/pC7TkD9S/zh1Exj3MA39bfVzgdXNRwrHOVESrHodRLPRg
	SntKdYEJ/fpdHLg1qzaJJVurYqQ7/iadORGEAE4OnmbD/Vq1qlLitaDAspCxZkX71UOipbMt+d6
	i5LnXim2OffJQmfTCXFyH9ENrojFAY0A5hHdlWcGx1DEsvRqpdHMQujGyVhaCKONqMXST9tmas4
	0eaNI=
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr134986121cf.3.1779111658607;
        Mon, 18 May 2026 06:40:58 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr134985831cf.3.1779111658077;
        Mon, 18 May 2026 06:40:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68311660f49sm5146434a12.15.2026.05.18.06.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:40:57 -0700 (PDT)
Message-ID: <21a1b097-be34-445c-b113-e9c9c70d7b87@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:40:54 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzMyBTYWx0ZWRfX89uCWCnmreEQ
 vPZ9vPWmnRSs5jZk7MIJllAMq3a565SIiDoOvbuAK6ibntEEhXZgmzcpO9YRM/1IMYsWNGcuXRH
 xR9HrrlZXQZZxDmsH4h6XyXp/gYXG8xm+EaHWSu5iS+tajzMdSco43UEtlLQCusZN9wx5lMwesh
 cf9sa2VHGkoPbm7emDpwMwl87VkQxJLqmk7AiznKVm/6gA9Jc2nuD5trya3DqDEFBPqwr0oLUTQ
 c3yQwfsJPAQq7vtpoc5s1aqIuCPou1g2xGx8T6lK8oN3hy7p5O2yY3SLbnOCQ53qoTBgcJV9+hd
 7PxXDYoowwfZXcr7jwUuDutCnKM/XQcH1K7XUATkS0rTQpFllsl7FQXWdi/iTpT0OO7MUyW+LeY
 l957QW/5K2NnGZXcqCC7Ez1QGJQ51QO2abUvFuHxJPdw6zgSd05Ovn6byARyYTtFrgTs7WDlkKD
 DaNBdbZOVUbcopNzXRA==
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a0b16eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FDeQY5eERw5HgavBjtEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: VeoZx_Lsdetl9o1_bnKqyey05jYjhupJ
X-Proofpoint-GUID: VeoZx_Lsdetl9o1_bnKqyey05jYjhupJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180133

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

[...]

> +DEFINE_EVENT(geni_serial_data, geni_serial_tx_data,
> +
> +	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
> +
> +	TP_ARGS(dev, buf, len)
> +
> +);
> +
> +DEFINE_EVENT(geni_serial_data, geni_serial_rx_data,
> +
> +	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
> +
> +	TP_ARGS(dev, buf, len)
> +
> +);

stray \ns above

otherwise lgtm

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
