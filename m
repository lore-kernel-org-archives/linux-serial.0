Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C21B3930;
	Thu,  5 Jun 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111229; cv=none; b=TbdEjkFecRjYtEwMsnGHNQBOpX6OX54TJtF6yqyjHwgR5dtfv78Bj/RDZZpHKelbkanAWtQXuzDyKzKHxcjxCR7WkVeoQGXT1qXVL3DCYy/zMexh+b37vpSYKRo6rV6Mhe9Pa1bF7SGQUyOi2BqcJudlS/625Jbt+1Df2fwdnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111229; c=relaxed/simple;
	bh=PQ8oJKn+wDAOWt+FQK/1/p76F8hS0x3RslUhMmOtWLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uLM+tEYUxqf7+apO/8d4DzQMjyc8cQIdgY9gYW69yIRmYczaOZ6/jMxWfbD2YYvOtBS8qsPLyg1kV5K9ktFgC7wMbaBlBuxNyu4UQ+UttgLXdHO8rRfJuuzsnrIZDu5T2AEXsmL91/7J24KF4LnA2Kvnj+LzETy5cy6xlrD+jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P/kRnII/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P/kRnII/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557rYGi007396;
	Thu, 5 Jun 2025 08:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3wLWCjM3LjpzCoxQQVkdh3UlKQDoh3jVUIb7/PyAWHU=; b=P/kRnII/Recy7Y5a
	jwobYoI6ingNrWcVDgCSaJEZFUdu8wYgCc+/xvY0IMZiZHuNOQawUPyVOjqywWYA
	2d7OWstGIs60u77Dd+OIQiVUf9DPBupEQO5tbZLavueoxHkXZChjxcCUwE7ENac/
	91jZhLg8ahR6oyd5MxFjt0TjB9Pq1cO5HX6SZLUqRAqProI4bVI31x0cmfwH17IH
	BCSST9ynT8TWdcAeuZKPbBy9X8EbkVv60UsO/pxS+1rzFcHP9lkOBCCshM+Mdqe2
	noDYJXamMpGEpONOJDiIjP9eROVSJ7kXBmBghyNEDYLwEgCjxmFqLahUknhFWFor
	wKza0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t0jks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:13:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5558DfZb030012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:13:41 GMT
Received: from [10.253.8.208] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 01:13:37 -0700
Message-ID: <c531923d-ddb7-4512-b0b3-ac0998167b75@quicinc.com>
Date: Thu, 5 Jun 2025 16:13:34 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: serdev: serdev-ttyport: Fix use-after-free in
 ttyport_close() due to uninitialized serport->tty
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulzhao@qti.qualcomm.com>, <quic_chejiang@quicinc.com>,
        <zaiyongc@qti.qualcomm.com>, <quic_zijuhu@quicinc.com>,
        <quic_mohamull@quicinc.com>,
        Panicker Harish <quic_pharish@quicinc.com>
References: <20250430111617.1151390-1-quic_cxin@quicinc.com>
 <2025043022-rumbling-guy-26fb@gregkh>
 <d388b471-482b-48ba-a504-694529535362@quicinc.com>
 <2025050851-splatter-thesaurus-f54e@gregkh>
 <38bf94e1-ebed-4d03-8ea0-4040009e8d31@quicinc.com>
 <8e171057-b3c3-4808-b49e-f04ffd310b31@quicinc.com>
 <2025052926-net-economist-a016@gregkh>
 <2025052957-jawless-superhero-09be@gregkh>
 <25361fe1-988d-41cc-a5f0-76773e41531a@quicinc.com>
 <2025053107-ancient-departed-a202@gregkh>
Content-Language: en-US
From: Xin Chen <quic_cxin@quicinc.com>
In-Reply-To: <2025053107-ancient-departed-a202@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=684151b6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=2vsLSQM2qi3k9njhwQwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3MSBTYWx0ZWRfX3khncYxEAafL
 dEpViInOc2FT8yROPW0mFhUvgisqjpE9Gqb//cx7RePK39jJylWO0+WCTwpKka14e0Rbwr1TzpU
 wFFDFqsyEC8kmgb2JF+7AWrH4eaecwWIw4RhD2bdS7FPB0q1XF9dtR9mAmEsQvtsNOdQ2ImlEko
 4H48EfLCi5nMSh9QlJKKlWuF9mAQuJYK+4SzGuT8JG2kv8r+UUfsaexfhP/WVr1je2xMbgqUd3e
 zeO/+DHyjdkqH+rZKi8tN8L/t+295atydIjHQWj+p8AW1XOi1xFc8Ibn9FLJ9BJZ9a7lf0xgxSL
 +EdcSI8KH9aHyDXEVvWdyJNz2I4xcFDP0GRqdH+6yr+rhELRqhZO4UZLr7ZCcUbLhzZcTGUc9HA
 8B6FTGFQ9Ajk+JHkuPPylu9vwVLuxFgVnkASpTKSqjn8JVX7IInoubTEiJGfZW6GZjGFEtNr
X-Proofpoint-GUID: zvBQ0NIrQvHro7dNCiI8F1B2KFjsaRCK
X-Proofpoint-ORIG-GUID: zvBQ0NIrQvHro7dNCiI8F1B2KFjsaRCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050071



On 5/31/2025 3:20 PM, Greg Kroah-Hartman wrote:
> On Fri, May 30, 2025 at 04:34:49PM +0800, Xin Chen wrote:
>>
>>
>> On 5/29/2025 5:41 PM, Greg Kroah-Hartman wrote:
>>> On Thu, May 29, 2025 at 11:07:25AM +0200, Greg Kroah-Hartman wrote:
>>>> On Fri, May 23, 2025 at 10:52:27AM +0800, Xin Chen wrote:
>>>>>
>>>>>
>>>>> On 5/14/2025 5:14 PM, Xin Chen wrote:
>>>>>>
>>>>>>
>>>>>> On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
>>>>>>>>
>>>>>>>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>>>>>>>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>>>>>>>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>>>>>>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>>>>>>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>>>>>>>>>  {
>>>>>>>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>>>>>>>>>  	struct tty_struct *tty = serport->tty;
>>>>>>>>>> +	if (!tty) {
>>>>>>>>>> +		dev_err(&ctrl->dev, "tty is null\n");
>>>>>>>>>> +		return;
>>>>>>>>>> +	}
>>>>>>>>>
>>>>>>>>> What prevents tty from going NULL right after you just checked this?
>>>>>>>>
>>>>>>>> First sorry for reply so late for I have a long statutory holidays.
>>>>>>>> Maybe I don't get your point. From my side, there is nothing to prevent it.
>>>>>>>> Check here is to avoid code go on if tty is NULL.
>>>>>>>
>>>>>>> Yes, but the problem is, serport->tty could change to be NULL right
>>>>>>> after you check it, so you have not removed the real race that can
>>>>>>> happen here.  There is no lock, so by adding this check you are only
>>>>>>> reducing the risk of the problem happening, not actually fixing the
>>>>>>> issue so that it will never happen.
>>>>>>>
>>>>>>> Please fix it so that this can never happen.
>>>>>>>
>>>>>>
>>>>>> Actually I have never thought the race condition issue since the crash I met is
>>>>>> not caused by race condition. It's caused due to Bluetooth driver call
>>>>>> ttyport_close() after ttyport_open() failed. This two action happen one after
>>>>>> another in one thread and it seems impossible to have race condition. And with
>>>>>> my fix the crash doesn't happen again in several test of same case.
>>>>>>
>>>>>> Let me introduce the complete process for you:
>>>>>>   1) hci_dev_open_sync()->
>>>>>> hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
>>>>>> here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
>>>>>> serdev_device_close() to close tty normally. And then call serdev_device_open()
>>>>>> to retry.
>>>
>>> Wait, what?  Why is qca_read_soc_version() failing?  
>>
>> Actually I have not root cause why qca_read_soc_version() fails of
>> __hci_cmd_sync_ev(). It may be relative to FW issue.
> 
> Please start there, don't you want to know why things are failing?
> 
>>> Why are you retrying multiple times until either you run out of attempts?  
>>
>> This is a retry mechanism. I find the reason in the change commit message
>> "Currently driver only retries to download FW if FW downloading
>> is failed. Sometimes observed command timeout for version request
>> command, if this happen on some platforms during boot time, then
>> a reboot is needed to turn ON BT. Instead to avoid a reboot, now
>> extended retry logic for version request command too."
>>
>>> Why are you closing the port and then opening it again right away? 
>>
>> This is a retry mechanism as above said. Do you mean there should be a gap
>> between close and open? The change owner maybe don't think about this issue.
> 
> Why are you calling close/open at all?  Why does that do anything?
> Doesn't that feel wrong?
> 
> Again, please root-cause the failure, don't try to paper over it by
> loads of looping and odd open/close attempts that are not understood and
> seem to actually cause other types of crashes :)
> 
>>> What close/open pair seems totally unnecessary, why do that at all?
>>>
>>> If I read that function qca_setup(), it can NEVER detect if a failure
>>> really happened (i.e. if it does run out of retries, you just plow on
>>> and keep going and keep on registering things and THEN return an error
>>> for some reason.
>>>
>>> In other words, the error handling in qca_setup() is very suspect, why
>>> not fix all of that up first?
>>>
>>
>> qca_read_soc_version() in qca_setup() can detect whether the hci_dev is set up
>> successfully. If if fails then a failure happens.
>> You mean I should fix why qca_read_soc_version() fails?
> 
> Yes, why wouldn't you want to do that?
> 

Yeah you are right. I will try to root cause the qca read version issue and fix
it first. Thanks very much!

Xin

