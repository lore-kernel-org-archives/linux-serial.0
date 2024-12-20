Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A02165FC;
	Fri, 20 Dec 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705456; cv=none; b=uiitHJgR74PjighOeec9cczM/OQ7gwOuKvbfhKyvf328015AOYzYqsWiwsltG9zuM3kkUuTfVb3K9PrZ0iGL9bOo088lLZ9gSB1jNs8nLMifKE5VySGIunzPyTU23D+dvFUSlxYMZjJq0e51496FLQrZ84E1NJjd42sPV8W+7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705456; c=relaxed/simple;
	bh=NFK/DQp+TWh9e6c94PYSUD270ZCKUN9x8V2lXf7N4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAituvQesbuynETq5KOiXI/wOOxy6AOgzPyq1eTAz7jUXc+GBLE16TxmpKOYZ4tBEw+T67UvlxMLmW4Sq9u7BmAa4YbBI0UPLE/F5wP53E9mYhc/qeD5it2lfWEDhE6hFBHmlmRwVGiudOBNo6cO+2fsSDwmKfr/fSbRyOzUxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WY+9kbFF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WY+9kbFF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKBd68f026228;
	Fri, 20 Dec 2024 14:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HMbldCwsm/JgDl09VqdU2YKXv6+BfYpGjPxPz3lsumo=; b=WY+9kbFF+pi0SBRG
	7sMuhVTKKkrbPoTF9ST6DqxmIVbnInYYUDkX03/yj9Ecgcwq35+fxQV1hc40mWYK
	YdOMxgYgQwR3nglvF2uOx2xMZsz4f+EXZSfU3rlSIQnooEQAUazh3rgwqJpQZ22S
	RMwWrExH0pEbpLn4B18aY5f5fTdxWJiyidRIHFstYSIbTUDCtnsaa/QFyGd0nHa+
	syraNyg9+kqNWgj/G4YYFKJ//zHv3K+ZJPHflsJgzSlaGOoQr6L1mzPd8IrORT/q
	dLfuze2zsej8+DT0hX1QGyYm8trXcNcGUS3e/nECkk0NVhTkhiu+RwKQXNeDvSBG
	6tPAOg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n7vg0dn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 14:37:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKEbTw8003870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 14:37:29 GMT
Received: from [10.253.72.41] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 20 Dec
 2024 06:37:26 -0800
Message-ID: <5bb2eb8f-0219-4ba2-9822-dc06316b22e9@quicinc.com>
Date: Fri, 20 Dec 2024 22:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Call cpu_relax() in registers
 polling busy loops
To: Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Zhongqiu
 Han" <quic_zhonhan@quicinc.com>
References: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
 <99b481f1-7e0d-4c78-8099-6a6466f6a87a@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <99b481f1-7e0d-4c78-8099-6a6466f6a87a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JI7kWEw2oMZP1IBHTnJtcWz7XEnxcblA
X-Proofpoint-ORIG-GUID: JI7kWEw2oMZP1IBHTnJtcWz7XEnxcblA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200120

On 12/20/2024 3:16 PM, Jiri Slaby wrote:
> On 19. 12. 24, 13:42, Zhongqiu Han wrote:
>> It is considered good practice to call cpu_relax() in busy loops, see
>> Documentation/process/volatile-considered-harmful.rst. This can lower CPU
>> power consumption or yield to a hyperthreaded twin processor, or serve as
>> a compiler barrier. In addition, if something goes wrong in the busy loop
>> at least it can prevent things from getting worse.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   drivers/tty/mips_ejtag_fdc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
>> index afbf7738c7c4..b17ead1e9698 100644
>> --- a/drivers/tty/mips_ejtag_fdc.c
>> +++ b/drivers/tty/mips_ejtag_fdc.c
>> @@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct 
>> console *c, const char *s,
>>           /* Busy wait until there's space in fifo */
>>           while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>> -            ;
>> +            cpu_relax();
>>           __raw_writel(word.word, regs + REG_FDTX(c->index));
>>       }
>>   out:
>> @@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
>>       /* Busy wait until there's space in fifo */
>>       while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
>> -        ;
>> +        cpu_relax();
> 
> Can this instead be switched to read_poll_timeout_atomic() or alike? 
> Those already contain cpu_relax(), of course...
> 
> thanks,

Hi Jiri,
Thanks a lot for the review!

yeah, maybe we can consider read_poll_timeout_atomic() or alike.

The implementation of read_poll_timeout_atomic() provides a precise
customization of the address busy read poll behavior by calling udelay()
and cpu_relax(), and using a timeout threshold. However, in this case,
it seems we might not need to customize the poll behavior. Since
udelay() only consumes CPU cycles, perhaps cpu_relax() is sufficient?
And if it times out, we still need to keep retrying until the data is
read. My initial thought was to call cpu_relax() to save power or act as
a memory barrier. As I mentioned before in my email to Greg, certain
MIPS-based architectures, such as Loongson-3, should requirecpu_relax().
Thanks~




-- 
Thx and BRs,
Zhongqiu Han
