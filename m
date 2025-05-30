Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC538B;
	Fri, 30 May 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592693; cv=none; b=N/p9uNQqo24+N15t8ippfqF6bnhqBy+xEs/q4l2VX+GqbonDmD4yFuFCyvfDnJbAi3BKdybQ9D6EtrUlqWWpx/L5LiQV9ZmKUkZla/8BiZQG/kNTpYsWjNq8ftXJMgkiR1BN9l4L5VJ1+xTsatgUJdaf8jRPqw7E80D033ip5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592693; c=relaxed/simple;
	bh=nljyD7oGpKi/pB343Z0SDcbWcB4VlyF/oMtqy5oonPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F2Gz3EDDiuW42Z88QeXxW3P3ArRe9tT8enkkR2mjQzGKzDZayl6Ww45i6tlgRcnHt4Z0VbIhigbnGgxUYm4ww0RinlhPgGdkGRcQfbOz+bb4kI0w+2XNfJrE6WsqE6lYZAZNCdyl1fFLDtDHlhj6rRX+9AM5+Awk8qsNiz6GwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k0vN59jV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k0vN59jV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U05iW9011696;
	Fri, 30 May 2025 08:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BfwfesnKPE1k+zYrC748qyklIi19iAGRhf67EVTHwB4=; b=k0vN59jVEZ2nbzFw
	r7QTiqjZxQa3AoxU8Ooq8eoojJpQrT1PZ9GGZ4tGjo6epvB7VA/NqId0k3B0zlrK
	izjbiTsMCUDtLhh/NsTHibM3gkIWusIWJe92PD+G2WUP+hEZK7+ySUN2HRXewz96
	ItE9XTJABMa88pGsMw0hUURBQCkCWgwOAkcbveEChJlBewiagjkCURT/6ER3C5Wr
	rLswk/ZtmmqTk9ihJu6H6+tITRIevRHZ9KI2zQg4DMGQOD5EU4eiDQ9fhbuAlTvy
	H1iyUcq7sVimnWbYE/x6xT5CelqswJrFUvL7xperBN6pIiYb1OcnXH1MogRc5lDm
	+55SCA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g98bqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 08:11:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54U8BPJp008217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 08:11:25 GMT
Received: from [10.253.39.138] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 May
 2025 01:11:22 -0700
Message-ID: <7d656b7e-3e7b-4357-80c3-24ab597bdcee@quicinc.com>
Date: Fri, 30 May 2025 16:11:20 +0800
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
Content-Language: en-US
From: Xin Chen <quic_cxin@quicinc.com>
In-Reply-To: <2025052926-net-economist-a016@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6839682e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=X2qtyJaRkhN_4_ZcoJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rQSImzhdcu1SUdpJ9GWlwqoTkByhVxb1
X-Proofpoint-GUID: rQSImzhdcu1SUdpJ9GWlwqoTkByhVxb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA2NyBTYWx0ZWRfX/eDViJL2BQbB
 9Hd/Ul7RBQz8n4zgD0jN36oM+Womc/u9Z3sXov7wqhrhz1sGkeDB+Cfssl0t92cVWmw5OA22JiQ
 /+3AWMin4M3lU1sdl2xKylEnWobjgqL5pQYUYlP+q8qhjjhKUg6auPBhn3p6gj4mHywPDO+a1Mb
 0B9R7/QZP3iIwrYx6OblsU7HpyTIX1g1YVGWxpB7alL/P0IGUg2YjeDCu0BQH5OvTV6G/LbAfuy
 D8bd0KDFocBs9RWaa4QWNjbpAL25YTV6y9rOP6vjphnhyznwW+IsW3Ohp3UqFujU3euCQEanHRh
 9PIpMH2TmdBDkOJduONdCeaOuNV2GycDzJF2Sgs29X+rE34GO544mhg5Dt9Chat4pZ11vR/5Qcm
 Plrd9kR98ARFQhxHJVPOAwyUScgF4gFzriZLajWqFPsJUT32hjne2Nl1l5yQVIW4uGMKk4Z+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_03,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300067



On 5/29/2025 5:07 PM, Greg Kroah-Hartman wrote:
> On Fri, May 23, 2025 at 10:52:27AM +0800, Xin Chen wrote:
>>
>>
>> On 5/14/2025 5:14 PM, Xin Chen wrote:
>>>
>>>
>>> On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
>>>> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
>>>>>
>>>>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>>>>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>>>>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>>>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>>>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>>>>>>  {
>>>>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>>>>>>  	struct tty_struct *tty = serport->tty;
>>>>>>> +	if (!tty) {
>>>>>>> +		dev_err(&ctrl->dev, "tty is null\n");
>>>>>>> +		return;
>>>>>>> +	}
>>>>>>
>>>>>> What prevents tty from going NULL right after you just checked this?
>>>>>
>>>>> First sorry for reply so late for I have a long statutory holidays.
>>>>> Maybe I don't get your point. From my side, there is nothing to prevent it.
>>>>> Check here is to avoid code go on if tty is NULL.
>>>>
>>>> Yes, but the problem is, serport->tty could change to be NULL right
>>>> after you check it, so you have not removed the real race that can
>>>> happen here.  There is no lock, so by adding this check you are only
>>>> reducing the risk of the problem happening, not actually fixing the
>>>> issue so that it will never happen.
>>>>
>>>> Please fix it so that this can never happen.
>>>>
>>>
>>> Actually I have never thought the race condition issue since the crash I met is
>>> not caused by race condition. It's caused due to Bluetooth driver call
>>> ttyport_close() after ttyport_open() failed. This two action happen one after
>>> another in one thread and it seems impossible to have race condition. And with
>>> my fix the crash doesn't happen again in several test of same case.
>>>
>>> Let me introduce the complete process for you:
>>>   1) hci_dev_open_sync()->
>>> hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
>>> here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
>>> serdev_device_close() to close tty normally. And then call serdev_device_open()
>>> to retry.
>>>   2) serdev_device_open() fails due to tty_init_dev() fails, then tty gets
>>> released, which means this time the tty has been freed succesfully.
>>>   3) Return back to upper func  hci_dev_open_sync(),
>>> hdev->close()(hci_uart_close) is called. And hci_uart_close calls
>>> hci_uart_flush() and serdev_device_close(). serdev_device_close() tries to close
>>> tty again, it's calltrace is serdev_device_close()->ttyport_close()->tty_lock(),
>>> tty_unlock(), tty_release_struct(). The four funcs hci_uart_flush(), tty_lock(),
>>> tty_unlock(), tty_release_struct() read tty pointer's value, which is invalid
>>> and causes crash.
>>>
>>
>> Hi Greg, could you please take some time to review my reply?
> 
> I am not disputing the fact that there is a bug here, I'm just saying
> that you can't test for a value and then act on it without a lock
> protecting that action because the value can be changed right after you
> test for it.
> 
> You might not see this in your testing, as you have narrowed the window
> that the value can change, but you have not solved the issue properly,
> right?
> 
> thanks,
> 
> greg k-h

From my analysis, I think there is only one thread operating the tty of
Bluetooth. So the case of tty changed after check will not happen.

Thanks,
Xin
