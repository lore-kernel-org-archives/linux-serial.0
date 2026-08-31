Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664F3C2798
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192004; cv=none; b=R1MaM9Ge7JNoxX97JBcDSVhgiO6BC/KClmjVH0JplZ5eRxRYkU1t9Rz7DACXEpUU5OgHpoK8I3JMXxP/4JSk54vWbC/GZjQRK+2Iq1dqE6Y7ZUsbyKvC3fKvQuFORFDEcMcC6zlJKq2bhnOHv70YAfii4GT0zHtGJkWDr6buFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192004; c=relaxed/simple;
	bh=C2HsrkAsY551zyQVjhc/uoCKFo+qO9kHWqJMqFvLm7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G86yZAx0HGnZ6nJFusvuo1+Y9bvRIFwXSeVyyaAR3zZRICNK/ehXcM2eCfIClQcakt2Tn87s+SuS049spEnkTXDjTEO24kSpeGaa1WZ39BPjPFavrpSSU4mmTV/832k0JrbXOfO/qyLPtOUyPAwNXvfUllPVE3t5dMJSNXf70mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WA9H4rr+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzbrXQr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WA9H4rr+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzbrXQr5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFqDlK4079252
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I76VLQrz2FsEqHBxgl+gJTgbNgwv1LFzl20Eqv99Pco=; b=WA9H4rr+fNwvKyra
	gGCUywkf0DtM+OjQMqc75kAqo6KISiN2lHaiZhc00deAZWFCVycXI9uXpsGZLfPc
	OEjJ/YMfKCOSO87Jk60/wjDWVAPvWdy4Eu1U5aBwZYlFq0GLyFU4yVjy0E+LzTwP
	bYsc5rgo1G9BsJbsP1/epknRev6ghsbqu3BO6oqKpezojq7Ob/UPRHcTW21JYN86
	ccrm9R+ykmX9lL4g3l31Xs71gd5LmFdKnR8YhjfjKG2wt26V3GMKA0e1YOJdF546
	3gu/V0JJvWJyIJd0sDL+Ey0pFBTho2bpEtvG1NHRacjdWTZfNUzoWyFxpS5IDVUk
	bVD6gg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9pwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 16:00:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1c62f0d60so6171598a12.1
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788192001; x=1788796801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I76VLQrz2FsEqHBxgl+gJTgbNgwv1LFzl20Eqv99Pco=;
        b=DzbrXQr5/AysCz/ydddu5uqDrp5Ijpjz3AF9eyMnPZ6uUI+YplU79TNfj4m1R/UMiz
         oPPNAb+59DCmjPuoy1YfmYy0elBnDeBCLdk2gVN/1GL9LCMaZjjsuOUIvRSmaToQbCGv
         4NQVhRkt2R3wffdqA6BtVBiYkA6rphI5duenc2rFKk7UTg7Uzm5aosuNaXPeGnIuwib8
         AsWvrxnSDbOv76Xuk+b54nOicxFd4ST8tSosJlTZa6/UOLjDT8HH0RgQ1AOdBtbIB+CE
         6xozRLWJ/dyiB23CbFk4dmMc5dZtVbPm6XIHLPKhMLENYpO4tLPntRjLw+NOdDWCVRj1
         nXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788192001; x=1788796801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I76VLQrz2FsEqHBxgl+gJTgbNgwv1LFzl20Eqv99Pco=;
        b=KoOQH8KKm9gCgAOzFbgsE0xkoEDPHfwTbC9j+sJb7vL17+5ucl02NQZ4Cm+pLMfv/b
         2O+LZ0NAAcXmrX3cpqJ+ENgdt2z1NJWRz2oW16poqj4uIDU3Bmh1WbNsVRWsOhv7KI3C
         SU3uNURzdGqQ0b/AytSsmOKdlejE4xGhSXTNBTh+1LvTYaPcX3AT+ODAm/q6J0bRKMSy
         5bnmQbaMgoB2MYs6qvqZBwaosM13qZmZrc/DQXLPqapzI/6zQ33CEZX/dIcBxNuTMtEY
         77paxM3CzsNpMjI3EefktBzqgnEXqDAsWZym2K4pxfXx5++eopWWZVTsP3MLuHDSZuph
         eFyg==
X-Forwarded-Encrypted: i=1; AHgh+RoYEQ3AQwdkRCTYVKGa6kg5uPlhAhqSN7nDnqb4TYh7egqLZyn72/L7Up+UEjOPMyutlTZh0XwNz6IhjQY=@vger.kernel.org
X-Gm-Message-State: AFuF++kUOfyIcI+hSuBLrs+YUzNpAkUDLchgCvL3xeW630vs3JQMx8k4
	m/TsnAp1zEHlyyHi2ZacOeg8K+jhGc6rJOOkkoG3P17sbBOETJGEnrZe+bZbU+HCShUL/lMJ0Fy
	KvGOEl44L5ut4B7C/0jQCftClExKI5PYpLolX8CVkTXJbdzVE1TZSbn9OV/B8210orkg=
X-Gm-Gg: AR+sD12oLahSf1aRYdsR9RW+JAiKSrNCoTcqnpiGLkhHb4w1f6Ge7XBIPRKordmOdiL
	x7+QjjHGsFIUuYX1cezsYGm1fqOF3xbIfsr2RlN/iO/Ymn/B9Rq+eP//810Myow1lMNLos6VDYl
	7EnlYR0NkYr8plWsUTSA2JAzjtKzzEPJ+6K7bURuEwi+xIWA5fGEU8oPkQha2T8yP/d4N2HAV6Q
	MZSAc3J+wf4sHLCRb+DExZjHn3xFz/+zoGUyoUlonyd4k6Ex3BZCC8qzY/iYYm4Trok+sg1R0Fp
	u8KGIHhpXjEhdLhNADlTVNdI9wyR0tUuY8gTbPRauMPO5cdcPiKsCFK0k5PFMJl2reW5eahjW22
	JIUbha+gErzX2xEzx59Fk74b4lUwwjfe79A==
X-Received: by 2002:a05:6a21:4593:b0:3d2:2afa:d85 with SMTP id adf61e73a8af0-3d7af82fb8amr2661672637.13.1788192000733;
        Mon, 31 Aug 2026 09:00:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:4593:b0:3d2:2afa:d85 with SMTP id adf61e73a8af0-3d7af82fb8amr2661610637.13.1788192000244;
        Mon, 31 Aug 2026 09:00:00 -0700 (PDT)
Received: from [192.168.0.102] ([183.83.143.92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm31401770eec.28.2026.08.31.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 08:59:58 -0700 (PDT)
Message-ID: <5be318fd-5413-4d6e-a8c0-f1b1eb35393a@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 21:29:54 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
 <5bb31efb-3855-41e7-b011-1a5a94fee59f@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <5bb31efb-3855-41e7-b011-1a5a94fee59f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oB19oRCFYuH9yWkDkMsaRUanI9y5yvSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzOCBTYWx0ZWRfXylTqsjkvKngz
 rCKmpQjiwlOs66H/gUvX3a189NU0S0J4xmcOgLT05zS6I+2jMeKRZAHA9igxlHHFTWYWhZb9b4b
 j+yBn59qrr0w6Id5Vkqlhh8AoWDxiDQWIIhtvcCDJM9zFTY0NhOD05+BG5XCbd2Ttg+dZHrgqeZ
 jKCzoZuTLh+gZzazZWG2ubl0NLLRQy5vMIIlccMKJ4qhvfEX3ib39ZY4Ri4L94kkCvaJjex1IBO
 XF/8r9Wet/jpg0SrCc228P2pCurgTApZ2uwYmfwViS8mPF+z1K1VIotqmKQorAuvhus18jKsoi2
 gCA7S+x/ZP5K77j+n6lxtSPs3NsGI+fm5xHLLMvbdla2eWz+1oVvClv+QMP0TIe5y8D6+T/CKnf
 nshu834FN/PJd8hOD7IQMkR3lb4POlOmMV6jy1x0Nw2lgTHC0d3zC8PIi1bSDypI2kgwNZnsEJt
 OP+NIT/DqlQ6BHYrrcg==
X-Proofpoint-GUID: oB19oRCFYuH9yWkDkMsaRUanI9y5yvSx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzOCBTYWx0ZWRfX6DpcfZkzqybq
 MjQDtKS3SicjrENTxQXdCEfIYjW+yNfYZFjs9tglo2FgZLvQ9l9y4Hj55JHjzaNn1JZATHV150n
 t/xjM3TdZEwDR4UT4RuN/pu0qSwv3GM=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95a501 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=XkslMnuk+fwelqvQqm66dA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=t_IBPTLT0seuTEbNzfsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310138



On 8/31/2026 5:08 PM, Konrad Dybcio wrote:
> On 8/31/26 1:12 PM, Aniket Randive wrote:
>> The console port uses a fixed line number and is not allocated from
>> port_ida. However, qcom_geni_serial_remove() unconditionally frees the
>> line number for all ports, including the console port.
>>
>> Skip ida_free() for console ports so that only IDs allocated from
>> port_ida are returned.
>>
>> Also release allocated IDs from the common probe error path. Currently,
>> IDs are freed only on the wake-IRQ failure path, causing leaks when
>> probe fails after a successful allocation. Move the ida_free() call to
>> the common error path and guard it for console ports.
>>
>> Route resources_init() failures through the common error path so the
>> allocated line number is released correctly.
>>
>> Allocate the port structure before calling ida_alloc_range() in
>> get_port_from_line(). This prevents IDs from being left allocated when
>> memory allocation fails.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Route port->dev_data->resources_init() failures through the common
>> error path so allocated line numbers are not leaked.
> 
> I asked GPT what it thinks again and this time it found that this
> will cause a double calling of dev_pm_domain_detach_list(), which
> will mess up the refcounting..
> 
> I think the fix here is to drop the manual detaches since the common
> helper uses a devres-managed version of attach.
> 

Thanks for catching this.

Looking closer, this appears to be a separate issue from the port_ida 
fixes in this patch. The dev_pm_domain_detach_list() problem already 
exists in the current error path and is not introduced by this change.

Since this involves power-domain cleanup rather than port_ida handling, 
I'd prefer to address it in a separate follow-up patch to keep this fix 
focused and easier to review.

Is it OK to keep this patch limited to the port_ida fixes and handle the 
power-domain cleanup separately?

Thanks,
Aniket

> Konrad

