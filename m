Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1C380FDB
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560916; cv=none; b=WGxEvP9VJ5LaxOThLmzHzvmIdGmsLvooiOYyezFq0GPXUlJWiiMD71IbSflac9+f7WRH9XUYfdO8dWD9u12kQEGf/C56TGVZUNc7MQz3u7TTlpXHTdRbyunC7LMwlmUKzXO+1eDKs1sv8VWq85s7QeYJV0171HmIxeBuXikGH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560916; c=relaxed/simple;
	bh=qon5+tBKMLNrN97LO9LX0bmDnUJ8nxENRNPjztMOxg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eABYePm3vY0fatrOTFSGj4wJH1E5EqlPmXqDck8uwosvfr37MU5Rd2Jjv3Wq+T27d3W4wttnbrXlYVo/BYbTQqdWdRtPDwyYLdsByV2V+JeiVFgjG/cohbs7WRwQHRmhMaSghd55cqMP3XNFBWZGr0r92uOMOUUN8+YHmajI5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjFr+s/8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFkLa0tl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjFr+s/8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFkLa0tl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713QLHN1920173
	for <linux-serial@vger.kernel.org>; Sat, 1 Aug 2026 05:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mY0UGI11NNthD5CS4ozr4z0G3LKZv8YYZjZmVFMsJMc=; b=VjFr+s/8svWzRqFF
	ZcOK7vLQPTWvmn/2aK71UsrxsBOAxUyESFqCWM83ykBwX5tz0h9XiesZjjQA0rJn
	kPLjdEBzS2ZbZOsiISs4bR5oHyleZ9tM197qqOSTlXR6B1ZqYesapxK+rx42V9bA
	/ZGVpGBbXt60KpEFUYteTZqdHIgmk5NXw3GS+SW/L92dRNPJUcDw4ypYHZ5OLqvB
	UNeQrweFgqEwCP/08nsBGtyTjbjjHXTwkKyS58KTWEuSw7bOVU1d+2HMG56LO3d4
	Sj/ey3GM5O6AQvlj0dL0LafuVxxICsnix1egXuNBMlZ/DSVYJ7/tjzSzHSZnWGfZ
	Pwq5pw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vt871s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 01 Aug 2026 05:08:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1174202a12.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785560912; x=1786165712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY0UGI11NNthD5CS4ozr4z0G3LKZv8YYZjZmVFMsJMc=;
        b=JFkLa0tlqF2Y3nbFst9CPRJFcUoHzJSgNxQozOvPsX41axZWUgkjzpl3maWKIHiVZw
         pjwIMWjF5WIcOzHKMdIRaHzgQxBvqpVU7TMNC1D4Jkj1PBYK6Jnv12fAun0VRZv0GWz+
         /IeGMywzNWU3ERI1hdXxwgfWSuYPU9QbKFL6sk2nzNAUHY8CyZLDVfLRRXKPNg60IcLM
         PQoqJj/sebhzEzhxwK+ESVhVWBlVloREms2N16q7FFYdczqxtX7Pp6OvBoK+7WXlqXoV
         1I/1HdvPQGpQtQXx3fXdFPbjUCdmZJ6bk/i0DLFFUDrWMDExKMZJsZhG+6bd97fK+xK7
         kQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785560912; x=1786165712;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mY0UGI11NNthD5CS4ozr4z0G3LKZv8YYZjZmVFMsJMc=;
        b=Ib/D9EjFm4GPDlgqJPaJwX3iBfM6MivoGZVDjfVAvPCgjYqhJwcpyhU0WYGJM48uNN
         X8tlXcZVDBmJja85zGXkKyhXEui+WUO7PjWqUGun3chdVk5daW1k+mvgOO6eZZSjZwwp
         NwGV313iHtduI6dw0L/IbLBQzME9vuSfycpSC5OKlTz/zjkTAlu8DT2H4Wfzr/KJ+j1f
         Yoqb/94zS+9WDI98fCpVB8Xr4rtso5PfrhAswhTfaku8aTNlQExU+uY2tAKP1qGTDnXX
         pIOPezFfhbjK+OoIRlJ2aUvdWg3GEOBEKbDyypoSshURZvsBralfwLjwqeEPV4qE/xOg
         X8VA==
X-Forwarded-Encrypted: i=1; AHgh+RojoZR/4qCygF2sh0s8Wm7PcSDYIDFiNjf6J3oexOqoBMaEGSCAadt5sLlvxONQWBmNdLawbFOT59DJQNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZol6aWT4AIwLlAApKbIrMzITC9QUGteK6G+dvgAS4GtqSS64
	Ez4Ez8syKSDBh2ckB4bFC/uWeUJiAEFNjNE9aPfk5LZl+umqPlUZnvef+fm+AMOmLBZ1+BeHFxJ
	NajJASA7mRHKfbn5yLH7GrXaWAgUapzXD0zHAFWBB7urQk5t9x9UVXpjXhucWOQEa6aI=
X-Gm-Gg: AR+sD12zIk/i+wk1fuAmqeCandUQjJu+VaBRYx2cBlmXmEKuZ4xG7haAAXtro+SDcWd
	livRZjG0CC0h2Q1BmUvYwUc+HsLpzf+IsmAcvtfXLsKMIgWVe0GKQiPZdliW2pRuFcEL9HVr8nW
	6X8WjieFi3aE/bnljnCtD7lOP+liB4hGKVyQlQkm4UjI2aJ4BWKJAIQTVe0DcNY74Bt5Q5z/3zU
	3B+9jYdlFOn56UH/4cfyoTT4fSAhYp7442wquHiWTtuIGe1TiQCvmJ6i3Aucq+Z3DbuFQS0JIJW
	QTTHDRXH/Pg0o8b2jirxGLrvwrFkiJV0/Doc0993/MAx2oQQ4yL8JzK0ajp8Ztwxo0YB2VaBLqU
	mbw+Joc0vrI2ubPq/B5LI+JoDBoUR48PC
X-Received: by 2002:a05:6300:6705:b0:3c3:c687:a3b9 with SMTP id adf61e73a8af0-3c92a8588a3mr2355557637.48.1785560911734;
        Fri, 31 Jul 2026 22:08:31 -0700 (PDT)
X-Received: by 2002:a05:6300:6705:b0:3c3:c687:a3b9 with SMTP id adf61e73a8af0-3c92a8588a3mr2355527637.48.1785560911149;
        Fri, 31 Jul 2026 22:08:31 -0700 (PDT)
Received: from [192.168.0.2] ([49.204.107.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm11188579eec.9.2026.07.31.22.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 22:08:30 -0700 (PDT)
Message-ID: <a8c5f8b2-4120-4559-9219-0e871d6a7707@oss.qualcomm.com>
Date: Sat, 1 Aug 2026 10:38:30 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] serial: qcom-geni: Reuse common GENI framework
 helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com
References: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>
 <2026073053-gracious-creole-cbaa@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026073053-gracious-creole-cbaa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAzMSBTYWx0ZWRfXy/jd++lswru+
 6WG0hWtDe1MWlsWaPiW8Cv0Yzr/DaPzU6m+ryrhZf14UeK2kxk8ABjmr+5PQB5ZjG7qZkHhqEWJ
 xbNysEq923Vu62F8BPd7GN1/CtFPpdQ=
X-Proofpoint-ORIG-GUID: XrpYOtmANDb9ibYthwNLwfYlgLdcHbm1
X-Proofpoint-GUID: XrpYOtmANDb9ibYthwNLwfYlgLdcHbm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAzMSBTYWx0ZWRfX2t98tFuwtvws
 QqSoNCjeSt9/abCuwrtnLA4c/xnrsm2yANJd+ArNa2sXeDs45saqnqRQ8qc/29JD6R2My5wTeF5
 XPUzZNGi0+SnHKk5a5olQ/oIxrwmoURhSmDxxeIdI2J1MdFjoDbD4IEgk9bOHU6GxKth1WRddiT
 6NQdKaeChBiyh6vPwsrmcA5Ke06cEWn7OkO3h5CbTd5HFJcxAO/zM+yR3biNvgkNbRZZMWH6M3F
 Yu+gAPb0SStsRvmUiovwYsIS1f7SvQGl0UOKfrwgcYkwFf+cp3byvRUvIuJ/d/UF+Y3JKF7uC86
 6KHm4LsiDvILUHAaT0jfAWUtfebI8tD4DEIadHiQTWtY9Ksk+eX1875scH1g4UKTqQOQDUgYMvC
 FuNFSi/+pb50YZG73UvQAe6gItHguutyWj+5qPVPG2EdMvsLqasmLWJkhYhxgMpxMduapNXv1Uz
 L644Evc4QSOTFJNi73A==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6d7f50 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=tDmmJO7lUO4YOopqcJwm4Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wh9H0PgVFRr8XisvLDwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010031

HI Greg

On 30-07-2026 20:30, Greg Kroah-Hartman wrote:
> On Mon, Jul 20, 2026 at 08:37:48PM +0530, Praveen Talari wrote:
>> The Serial driver currently maintains several helpers that duplicate
>> functionality already available in the GENI core, including resource
>> initialisation, power-domain attachment, runtime PM resource
>> management, and perf-level selection.
>>
>> Replace these with common GENI helper APIs for resource initialization,
>> runtime PM resource management, and performance-level configuration.  This
>> reduces code duplication and centralizes GENI resource handling.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> Praveen Talari (3):
>>        serial: qcom-geni: Use common GENI resource initialisation helpers
>>        serial: qcom-geni: Use resources helper APIs in runtime PM functions
>>        serial: qcom-geni: Use geni_se_set_perf_level() for baud rate perf level
>>
>>   drivers/tty/serial/qcom_geni_serial.c | 204 ++++++----------------------------
>>   1 file changed, 34 insertions(+), 170 deletions(-)
>> ---
>> base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
>> change-id: 20260720-reuse_common_geni_framework_helpers-787081bd61a7
>>
>> Best regards,
>> --
>> Praveen Talari <praveen.talari@oss.qualcomm.com>
>>
> Doesn't apply to my tty-testing branch now, perhaps because I took your
> other patch for this driver?

Will rebase on tip and push next version.

thanks,

Praveen Talari

>
> thanks,
>
> greg k-h
