Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E46215F62;
	Fri, 20 Dec 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702408; cv=none; b=oAkJW94n80KIvsGLm1aZd0E9RT+LkZ34QHylCPAcDZirM72QCdu5g+FxxhmBTLSXEnEasC1udZU5xhrMdLsw1rWI9xgMwdHGBNc19XDHy4vDZ7VPqPjMOUeyj0eC3om6sIVy3W/0X76g3+P/0j7CnUZRfhPaxQgagDWsOieKgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702408; c=relaxed/simple;
	bh=uIb9KoBymGYGHvSesl1ZaEHicnyD6fag+eyAX+iNPUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nY/yEzl4APLykGS/R+6UUz7XxWtBbxCqSqx5PB5SwoR+V/433NNjjGd4Ft5XWhptD2VklN8W9Nrhp2Tt/nSNnNAykzHOrQhWlKEkfcJmnxmU3SpsTUd1wOqmb1LwtfXfj8IyQnnjSU56pg+C0nrPsnQf3dd3LIidX7q7hWRkgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9n9TqZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9n9TqZG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKD3ea4019153;
	Fri, 20 Dec 2024 13:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8V/1DURlMaWFY2xlQkFdT5cm5T9y2CG6cfJCqICLL4=; b=k9n9TqZGa+9VWxc6
	DI6HHyOGq8GY5CJLdXmG7U0HpoGwKFm6hh03VUeaWlNWyzBi1CQ3IUCZlOw0zLEs
	BcAAzPDhgMqW3lyPr7AISwaK8ihntXZyF6Av4oZSoA6YBlSC6zl3NRsJpva6kd2M
	sJs7G3Hy4LjS8q+Sqkoh1gmt7LvsWyhvbGbyLsc+YUO/x/tk/+t05lmqlBGFWXkF
	2aqQjFv2ftjoNU09WxaAa6o1b+yYVy1jZzh6xLyjx3xXw1z9dUUKDcVaWqSNgLKz
	QGmT+VO/DvRmJrMKxg4I4YQCuQngRZfYuT64IhPXo4yvNTAWMP+T45i36hzCaez8
	YJfh/w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n94tg3gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 13:46:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKDkguB028645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 13:46:42 GMT
Received: from [10.253.72.41] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 20 Dec
 2024 05:46:40 -0800
Message-ID: <edfed594-a22a-4cd1-90d2-2b9f9f878f73@quicinc.com>
Date: Fri, 20 Dec 2024 21:46:27 +0800
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
        <linux-serial@vger.kernel.org>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>
References: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
 <2024121943-spearmint-yard-4cab@gregkh>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <2024121943-spearmint-yard-4cab@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CqxEmQb2atmRKUjVSwxPAeI2Wpj3l_0f
X-Proofpoint-ORIG-GUID: CqxEmQb2atmRKUjVSwxPAeI2Wpj3l_0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=961 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200114

On 12/19/2024 9:28 PM, Greg KH wrote:
> On Thu, Dec 19, 2024 at 08:42:54PM +0800, Zhongqiu Han wrote:
>> It is considered good practice to call cpu_relax() in busy loops, see
>> Documentation/process/volatile-considered-harmful.rst. This can lower CPU
>> power consumption or yield to a hyperthreaded twin processor, or serve as
>> a compiler barrier. In addition, if something goes wrong in the busy loop
>> at least it can prevent things from getting worse.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   drivers/tty/mips_ejtag_fdc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
>> index afbf7738c7c4..b17ead1e9698 100644
>> --- a/drivers/tty/mips_ejtag_fdc.c
>> +++ b/drivers/tty/mips_ejtag_fdc.c
>> @@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
>>   
>>   		/* Busy wait until there's space in fifo */
>>   		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>> -			;
>> +			cpu_relax();
>>   		__raw_writel(word.word, regs + REG_FDTX(c->index));
>>   	}
>>   out:
>> @@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
>>   
>>   	/* Busy wait until there's space in fifo */
>>   	while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>> -		;
>> +		cpu_relax();
> 
> How did you test this?  Are you _sure_ it is needed at all?  I think you
> just made these loops take a lot longer than before :(
> 
> Have you had problems with these tight loops doing anything bad to your
> system?
> 
> thanks,
> 
> greg k-h

Hi Greg,
Thanks a lot for the review~

Perhaps I should submit an RFC patch and explain the situation, as I
don't have a MIPS device for testing. Indeed, the cpu_relax()
implementation for MIPS is a memory barrier, which, compared to busy
waiting, doesn't save power and can make loops slower than before.
However, according to its definition file, for certain MIPS-based
architectures like Loongarch-3, it can help force the Loongson-3 SFB
(Store-Fill-Buffer) flush to avoid pending writes. Below is the
implementation of cpu_relax() for the MIPS architecture and its
comments.

-----------------------------------------------------------------
arch/mips/include/asm/vdso/processor.h

#ifdef CONFIG_CPU_LOONGSON64
/*
  * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely
  * when a tight read loop is executed, because reads take priority over
  * writes & the hardware (incorrectly) doesn't ensure that writes will
  * eventually occur.
  *
  * Since spin loops of any kind should have a cpu_relax() in them, force
  * an SFB flush from cpu_relax() such that any pending writes will
  * become visible as expected.
  */
#define cpu_relax()	smp_mb()
#else
#define cpu_relax()	barrier()
#endif
----------------------------------------------------------------

Based on this, cpu_relax() should be needed here? :)

Thank you~


-- 
Thx and BRs,
Zhongqiu Han
