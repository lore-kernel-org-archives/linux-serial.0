Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514A1361;
	Thu, 26 Dec 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220325; cv=none; b=MZPKKrrqopvKnF74Oi1Ct4SB4igDSiFYUummkbiknch+MXmxXvIEm2xZr08Nugf2AbnVmNkDv37YNmBOr+luXa+S2M0nenDFjfeaYPWcOW3N2LUrMemZtEnT3o7nmfSQcyObvjwcpHmR8dKCe3uzMvpBzztDAgT0CTbBI874I3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220325; c=relaxed/simple;
	bh=WYke9+vLr6vfJ3rn/cjhIdid/DzARTS6PvTjk395DNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDKrmgpjkXeWyB1gE/2B8ZVjPWb/GrdovPbDrpNdcGnF1OJS5bXy4ogie+zwjZQxNIKd1s1iOs2GbKO8/WU5oSNHkJHSzFxfQybMHkdaQ5+3dJfpcVm1gN7tXCvm9Jm1khoO86hLlAHUaQTak43bdX8uZgLZVpaUB4mqRBtN+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kOKrFGSC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kOKrFGSC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ88eAD010707;
	Thu, 26 Dec 2024 13:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3KXw8WGBI6QW5i0g5MDRf3Se/LD8G7Qa5+z7cpb4ShI=; b=kOKrFGSC4zNARbSf
	WyitBAagefF9sryXJkkRcsb3f4IT24KUn+9Wp0c0cVZHVSUnpLfr/80CQT7KWyl7
	2Y8OOD8vdaDD8ShKPswn3m6KgCUX2exJ9mvCQWUTqXqExi0N+TbOmWnN2ZVNYQnU
	i1A3QIJj8sfjrKJvp1FNXV3ZrntOn8z1gzwT+Xbh+5mWzEjePeFYc/7VVnA7+bxH
	U3BAPrcb2HVF2FfRO4NA1m8VkCyOwklZk2mK93vxmdyPXb5jJmW7r21B6vKt7ol1
	qclUD6uT2dopyLX1NmcLkUugJ97Cv8HANCQq63gtEckOb0mG1iGC4K/BYq4H1L4q
	L9/oqQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43s3cf9xen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 13:38:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BQDccKM012126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 13:38:38 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Dec
 2024 05:38:37 -0800
Message-ID: <77a51ad7-c002-470e-ad6b-13bb7312811d@quicinc.com>
Date: Thu, 26 Dec 2024 21:38:29 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Call cpu_relax() in registers
 polling busy loops
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
 <2024121943-spearmint-yard-4cab@gregkh>
 <edfed594-a22a-4cd1-90d2-2b9f9f878f73@quicinc.com>
 <2024122019-blame-multitask-8d83@gregkh>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <2024122019-blame-multitask-8d83@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qpVdWdrL_bRcnm6DS1jO65RKDIBsSGTb
X-Proofpoint-ORIG-GUID: qpVdWdrL_bRcnm6DS1jO65RKDIBsSGTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=892 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412260120

On 12/20/2024 11:06 PM, Greg KH wrote:
> On Fri, Dec 20, 2024 at 09:46:27PM +0800, Zhongqiu Han wrote:
>> On 12/19/2024 9:28 PM, Greg KH wrote:
>>> On Thu, Dec 19, 2024 at 08:42:54PM +0800, Zhongqiu Han wrote:
>>>> It is considered good practice to call cpu_relax() in busy loops, see
>>>> Documentation/process/volatile-considered-harmful.rst. This can lower CPU
>>>> power consumption or yield to a hyperthreaded twin processor, or serve as
>>>> a compiler barrier. In addition, if something goes wrong in the busy loop
>>>> at least it can prevent things from getting worse.
>>>>
>>>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>>>> ---
>>>>    drivers/tty/mips_ejtag_fdc.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
>>>> index afbf7738c7c4..b17ead1e9698 100644
>>>> --- a/drivers/tty/mips_ejtag_fdc.c
>>>> +++ b/drivers/tty/mips_ejtag_fdc.c
>>>> @@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
>>>>    		/* Busy wait until there's space in fifo */
>>>>    		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>>>> -			;
>>>> +			cpu_relax();
>>>>    		__raw_writel(word.word, regs + REG_FDTX(c->index));
>>>>    	}
>>>>    out:
>>>> @@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
>>>>    	/* Busy wait until there's space in fifo */
>>>>    	while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>>>> -		;
>>>> +		cpu_relax();
>>>
>>> How did you test this?  Are you _sure_ it is needed at all?  I think you
>>> just made these loops take a lot longer than before :(
>>>
>>> Have you had problems with these tight loops doing anything bad to your
>>> system?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>> Thanks a lot for the review~
>>
>> Perhaps I should submit an RFC patch and explain the situation, as I
>> don't have a MIPS device for testing. Indeed, the cpu_relax()
>> implementation for MIPS is a memory barrier, which, compared to busy
>> waiting, doesn't save power and can make loops slower than before.
>> However, according to its definition file, for certain MIPS-based
>> architectures like Loongarch-3, it can help force the Loongson-3 SFB
>> (Store-Fill-Buffer) flush to avoid pending writes. Below is the
>> implementation of cpu_relax() for the MIPS architecture and its
>> comments.
>>
>> -----------------------------------------------------------------
>> arch/mips/include/asm/vdso/processor.h
>>
>> #ifdef CONFIG_CPU_LOONGSON64
>> /*
>>   * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely
>>   * when a tight read loop is executed, because reads take priority over
>>   * writes & the hardware (incorrectly) doesn't ensure that writes will
>>   * eventually occur.
>>   *
>>   * Since spin loops of any kind should have a cpu_relax() in them, force
>>   * an SFB flush from cpu_relax() such that any pending writes will
>>   * become visible as expected.
>>   */
>> #define cpu_relax()	smp_mb()
>> #else
>> #define cpu_relax()	barrier()
>> #endif
>> ----------------------------------------------------------------
>>
>> Based on this, cpu_relax() should be needed here? :)
> 
> I don't know, please test and let us know!
> 
> Without testing of this on real hardware, we can't take this change for
> obvious reasons.

Hi Greg,
Sorry for the delay reply.

Sure, I will conduct comparative testing if I have the mips device in
the future, or other developers are also welcome to participate in the
testing.

> 
> thanks,
> 
> greg k-h


-- 
Thx and BRs,
Zhongqiu Han
