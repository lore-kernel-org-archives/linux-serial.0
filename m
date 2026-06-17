Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D63AA518
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697575; cv=none; b=ICG/YjvWvKLyqXRheWOVa66gEcjZcClc1xMnV+qzx3fmvYlO3izq8W+1QAdqAub3sAn2JM9UjHVYYOKRj833ELkwiNE8epWxMes5BtBs26fav6R53aPzXRRNnz7v0NZzTFN+RsvhuQWlfHPNPfp2Y2UiHHhcX+7ZH8HtTmgYdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697575; c=relaxed/simple;
	bh=bsBdAJSSfzQdXVnZgwbkNcPQGRwa1KT8A24+fq9mJ4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkR/W95vJqQ438JgykL/WF9/XJywFD9iUIa1afU5tca287sNWRkI0yT5ZEGmQsFhdQG/s0JZ7XH0892QQku7r9CPyNR+bSgZEpKdcXb6fXDsVCQuD2AvSp8GmbFPWqijxMWYxf6BOXz9GbN1suoOePB7I2BLT1OoA1BS+auGeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3jMZgcC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CSyog5W6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3jMZgcC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSyog5W6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8VZpI2190769
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yZ1B3IAw4oJQ2vLZXJ7tczm7eJQgSGAReWX6mfVUAoM=; b=C3jMZgcCDWKJE643
	x6sF0cE80c4MWoghm9kWbc8QoKIkvfQRWoUvHV+xOYs8MRmxSfzm2xPkxFIamvwN
	4lmD/18DfMFxlWb1mA7b0h15Vt/fuwDUoGMXbkpvt8TdQJEvm6OorFTluv6zl+jm
	TP4xTzqIrpt+RRq0cZ7bdmiS3YSpcROONCC+m4u+YFW+NixiGyiqlGw8u7vm3TU0
	9uHrSh1AMxdipsMmuO6Akrq4HfVM7imqrKwysGInSPBXp6i9dbxVg5eiOkzZyLMZ
	hbEJyAea5gb0upvUDUXzVcDujvVsq2hJflZ7kAnCDbOGBbSnLlCYWDPS7qLRpoCR
	tMl5ug==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesk0fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:59:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915b6b63056so1098835185a.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781697572; x=1782302372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZ1B3IAw4oJQ2vLZXJ7tczm7eJQgSGAReWX6mfVUAoM=;
        b=CSyog5W63gL9Mvh1uewcAubpni6klVnyWlI4LPDlXHFgQTN45X85jcfKrTta88DzDf
         71xz2QbrCUpEtwTzBzgSbLrnt/VP5gXnSecZ+frL/zcbtrZGD6XfVESxNvRwAmZvFQiv
         mXDdMgXrRK02Yu3Wij4bopc0a5eAXskMneuxcln9fgB6BS9oyZkm3baRdow2ryW3rD6W
         zuft2TUSJ0mjKqsampp9RLzrjAN6ZA8+IhzBprlYT+/rZX3Vy5ZijGETCvK+621k8FdE
         9lXnu3q5sv8ZcFwcAfZXQFO2lxSc/xvamRzMYwoN6t6eEETvbp0w520FbDQuOTd2Hs4u
         1i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697572; x=1782302372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ1B3IAw4oJQ2vLZXJ7tczm7eJQgSGAReWX6mfVUAoM=;
        b=M/r1vDmw42c0g29MOP7fuXxjdz/cV4vrndikrT3exUd2gP8PSnxE+dVAZybmIDGdra
         qHS9GtLyN6LKYEU+DUHi2amc8ckf9nY0VJ6uFv4t3aQwQCDZz+n3iTjWBwesPjFwy73R
         vZA8uD3fqOzWImkXnmYOkrwsyX5sRijduxFg7y0giSPBEgNtFWNoalPy1SZPtGUE0yTH
         klvzc5tAmw7tztBl7RUREDIZuhWs0ehfKPEAJsiqdhy9l+ND1b+w+E2k/Nh09xAXtQ85
         QVSGfxOvzQWnmnfRIgabFDCAAQIS3TCkiCw11lPyiLkQw70A0jbFMB7KsPoGcidjJhHo
         p8Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+orbqlkvPTBGovMSlp5qfMb3yShsPdVtgdLryvY+wucFv7LPtVwlgL4/aS4cpxvPI8nGQZa1Daw7hQsTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLDMLgnHkQu9EKePVHAy0GkDbWdp15DifkcjKXxYZjVoXKtE/
	kaWUdDpjyPHyMoOdfKkdL42vkrqefg64eCbhkWfcYHhphsevRrDungeP2L6tafkW5VI075LEhZ7
	jA7Ab1ztrapLoysK4P4bC8R72DWdBVcK2gSZyKJ2XckgsUJ9aV4UEzPqgAUNn0LQyAl6cKNNq1Z
	4=
X-Gm-Gg: Acq92OGo6pnOGfIvuOj9VFx+bgWp1I8oAy6NvSbMn2ctftdWmYMljSlSPc/daLBXQky
	cA5P0D0JR9twOQvolJLTcATFjnsEKYaXx7M7ORABvGo3rCgj7JU6tjxHTeLduWzQgYwxJqifYnj
	L8oweOUUbX3DaDO/7FoheoYS/kaoNa2JcCeOvCnVJ4MfLOPy/piHSTUKDiVm6E0vKuo+q8XIZqs
	3BiSXJLa+kWrfTUVUa8Bi2HEniBjtP3RVlsJxzD/HZJTpiZy2h48DJsKfKUhhQhm/GrX9RCcCJp
	KgBkiVCZZ4gHT69506b1vI8i3BctiVatIw1Jvtx5uMhtoSzFhFlLLW0ZsxWCjD1GfXmtqdKxMGR
	cteSIS7JAlU8NgU2j425+7yTjjci2gmay1JUyMch62jcLEaVoaoCJGdoT10+U5Q==
X-Received: by 2002:a05:620a:2907:b0:915:7f9e:a407 with SMTP id af79cd13be357-91d879a3ef8mr560664185a.0.1781697572334;
        Wed, 17 Jun 2026 04:59:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2907:b0:915:7f9e:a407 with SMTP id af79cd13be357-91d879a3ef8mr560660385a.0.1781697571741;
        Wed, 17 Jun 2026 04:59:31 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ebe3sm124137425e9.11.2026.06.17.04.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:59:31 -0700 (PDT)
Message-ID: <6b6651b2-cd06-482d-b075-79266874d2a6@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 13:59:30 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Revert "drivers: convert sbd_duart.map_guard from
 atomic_t to refcount_t"
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605241628110.1450@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2605241628110.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfX4FTBipf2ry6/
 Gcem5HJ/tEjQQNbItUJIe+lGB3WVzvPHis2mBcakwKJ0hqtZ8myKZWvuxzmC2FfPdDNnx+udJCq
 MzGs0v5U13rx2k5lwnjwpcgxSChQBOnOvmOzySq13Ugf73u9WvyseIMI2l1LTugvOmJpaNohaPT
 BTtmOAqtpoY+rnz8nZROXVxg+xPxjW4/HIsH3vrvDzECLYdpf82+V7LV4If0E84qbm6GVrg6FAN
 l7xgiGksajvR/WZYE//lv8DP5i62bc2ZZqtoeD2jTxu9yCNwBxJAC/rSm7uXzi73b4fEr+5cXxj
 04L8GjGIHvVrFWwfHLqkjhTsqQCb6/mDfI0P+88B5mu4EFqMzvtks8TibEwq7wAzmKL+KWmqtPa
 uHCsF76p3F5PNsjTmRxJhRpmyrjajmFWuxDI3fqEYvD4aJoFlRZLoA6sCl3dbNYNDcOxJaPbCMh
 V4amW7uWgs6PSvVYTRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfX0cqjZzCQnnIu
 pSACDYNSSje2K1Gi29vsfzFUtMj7KMX/W7ndTzHZZUseHcmSS2ntUCeqoSxez1uKu3tj9xNW9LH
 sSSyr+uS7bl7S1aPhFzrsl7mt/m/nBc=
X-Proofpoint-ORIG-GUID: YhQeJlEogLZ09JCNVyVwrrnp6cS66yN-
X-Proofpoint-GUID: YhQeJlEogLZ09JCNVyVwrrnp6cS66yN-
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a328c25 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170114

On 25/5/26 01:12, Maciej W. Rozycki wrote:
> Revert commit 22a33651a56f ("drivers: convert sbd_duart.map_guard from
> atomic_t to refcount_t"), which broke perfectly valid code:
> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 1 PID: 1 at lib/refcount.c:114 sbd_request_port+0x54/0x140
>    refcount_t: increment on 0; use-after-free.
>    CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc2+ #34
>    Stack : 0000000014001fe0 0000000000000000 ffffffff80830000 0000000000000000
>            ffffffff8127bc7a ffffffff8016fe08 ffffffff808d0000 ffffffff808d0000
>            ffffffff807aa828 ffffffff80822337 ffffffff808ce188 a8000001860b0000
>            0000000000000001 0000000000000001 00000000000001c8 ffffffff808a3090
>            00000000000000bb ffffffff801b09d4 a80000018609bb68 ffffffff801231cc
>            ffffffff812a0000 ffffffff80171388 0000000000001000 ffffffff807aa828
>            0000000000000001 0000000000000001 0000000000000000 0000000000000000
>            0000000000000000 a80000018609bab0 0000000000000000 ffffffff803c47cc
>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>            ffffffff807cb648 ffffffff8010bff8 0000000014001fe1 ffffffff803c47cc
>            ...
>    Call Trace:
>    [<ffffffff8010bff8>] show_stack+0x28/0x88
>    [<ffffffff803c47cc>] dump_stack+0x8c/0xc0
>    [<ffffffff801aff5c>] __warn+0xe0/0x114
>    [<ffffffff801233f0>] warn_slowpath_fmt+0x40/0x50
>    [<ffffffff80455bcc>] sbd_request_port+0x54/0x140
>    [<ffffffff804563a4>] sbd_config_port+0x2c/0x68
>    ---[ end trace f666d696412caa3e ]---
> 
> (report at the offending commit) -- sbd_request_port() is called twice
> per DUART instance, to reserve a resource holding the control register
> block shared between the two channels, so there's no slightest chance
> for an overflow.  Also this doesn't stop the driver from working and
> it's just the reservation that is missing as a result, i.e.:
> 
> 10060100-100601ff : sb1250-duart
> 10060200-100602ff : sb1250-duart
> 
> as from the offending change, vs:
> 
> 10060100-100601ff : sb1250-duart
> 10060200-100602ff : sb1250-duart
> 10060300-100603ff : sb1250-duart
> 
> beforehand, which is surely why the breakage has gone so long unnoticed.
> 
> "If it ain't broke, don't fix it," so just revert the broken commit.
> 
> Fixes: 22a33651a56f ("drivers: convert sbd_duart.map_guard from atomic_t to refcount_t")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> No change from v1 (4/4),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2604130416440.29980@angie.orcam.me.uk/>.
> ---
>   drivers/tty/serial/sb1250-duart.c |   20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
