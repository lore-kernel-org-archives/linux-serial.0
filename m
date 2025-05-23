Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2627466;
	Fri, 23 May 2025 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747968766; cv=none; b=MRooTbzKX8GlivpP1aiVGolInDS89jqoGy/kvdtp9ELU1oKTvHAjTEcuGzRzPA/0tZ/kSk1T13oHSMhQC+xnGwEXV2XsFktQi3jn52BEBpW0HB4zjUD3SirjaMiWICqpgIcF1OhAa8GYD5SN2yu7x+TU8Ssf7RX3Jpz/+5HOucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747968766; c=relaxed/simple;
	bh=RMZSHyGq8lLP5R/e5mbMKL+hRBJ17vHYbXM+BXDmcB8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DnVVHirIbJ4BOUB9iMXf8E41rNUSAKBd1l1hK8j8pAMJ1HtKywdQJTqHzqkmmdCR4r/1FBUZTuhFq05YboJX/rC4NM+R+aNMikYW752D+ks9Ykd+2bJkOs092OK3tIfsiY9JqLB+KOPVahVxbOQ8Rdq1giIzeDKawb26bmAgDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z7EEbjuD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z7EEbjuD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MIA2b2025025;
	Fri, 23 May 2025 02:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZKOEpOnXCkx//rWtBuQbetdixfQvhhL4O3NFDgntfg0=; b=Z7EEbjuDiARDzaqp
	+MoPHM3eyzWVEhwLgca0jk0MncOOPcMJYBJ1spMYsDpXV9SDjcSLm0Gbe3NGXU7u
	cImPAAzC2YKgdL4kKOUpHK1b0scN0N2wVyRNlL4BoXIi6qWJs18c22lSyAyFBbJr
	/C2JSmYD40nF/u1Eu+REyHhVDhv11cd9wl7+cJpj4zr0jx+Rm6N2tPqwHRtP1gRI
	wn6FmaNW5AC2It5bmt5LvWG9xq1CL3PiPlKiujbC5Nl/layIaIZuuGuaZBT9mCcJ
	ySmnxl88CZ1oS5EW0JUsQdI+3kfSjlAO7/Ra9KmkiZoZsj67k0JQr1uZJUS0UAsl
	tXGMhA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf707uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 02:52:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54N2qWQb031983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 02:52:32 GMT
Received: from [10.253.8.154] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 19:52:29 -0700
Message-ID: <8e171057-b3c3-4808-b49e-f04ffd310b31@quicinc.com>
Date: Fri, 23 May 2025 10:52:27 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: serdev: serdev-ttyport: Fix use-after-free in
 ttyport_close() due to uninitialized serport->tty
From: Xin Chen <quic_cxin@quicinc.com>
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
Content-Language: en-US
In-Reply-To: <38bf94e1-ebed-4d03-8ea0-4040009e8d31@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MeW7e1yphHbr84ng-NDw_-BhoCDClvYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAyNCBTYWx0ZWRfX+dTMXtCyVZqZ
 SgyP15MPIn5nPIkYZRuxwCadsL9eJYiKgLUOUs/3leOVBNWkbXnXsI19wXmZrbFH/edUVcl1TT1
 Tvy+TGh9Of+mWZZx3Wi3T33460W5msaolnMrh2CIEIU2zk6M3wyx6flWoF2jB94FB9tG9lLvgNS
 iZ8jcB4nk6m8V9msSQCfHj2w7awJ5+SHtD42hQiF0S14cg0qqddF6brEI3tK3XT6cVjejdg9Epm
 O3DYylBupyGW2D2PqUydnkuZ6N/vrThINun1ami+cBezqGhVSUUpq1rGrMB6XEz6u5m2MY2M/k1
 zszUIIhUMo4S6CWKjeIJUI2EEah4mEQP5yktEc2C6b40BupYqXajQ8uAhx7SlhXms+2ZfhxApEI
 fcSOCEnkcfckF4Va7f9jfl1pIZAjEiPUpeJnVShreNCh3e+nHvf95zj8rwPYcuRQz75anVms
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682fe2f1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=_eFTLsDQhpw06QD9osAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MeW7e1yphHbr84ng-NDw_-BhoCDClvYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=877
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230024



On 5/14/2025 5:14 PM, Xin Chen wrote:
> 
> 
> On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
>> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
>>>
>>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
>>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>>>>  {
>>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>>>>  	struct tty_struct *tty = serport->tty;
>>>>> +	if (!tty) {
>>>>> +		dev_err(&ctrl->dev, "tty is null\n");
>>>>> +		return;
>>>>> +	}
>>>>
>>>> What prevents tty from going NULL right after you just checked this?
>>>
>>> First sorry for reply so late for I have a long statutory holidays.
>>> Maybe I don't get your point. From my side, there is nothing to prevent it.
>>> Check here is to avoid code go on if tty is NULL.
>>
>> Yes, but the problem is, serport->tty could change to be NULL right
>> after you check it, so you have not removed the real race that can
>> happen here.  There is no lock, so by adding this check you are only
>> reducing the risk of the problem happening, not actually fixing the
>> issue so that it will never happen.
>>
>> Please fix it so that this can never happen.
>>
> 
> Actually I have never thought the race condition issue since the crash I met is
> not caused by race condition. It's caused due to Bluetooth driver call
> ttyport_close() after ttyport_open() failed. This two action happen one after
> another in one thread and it seems impossible to have race condition. And with
> my fix the crash doesn't happen again in several test of same case.
> 
> Let me introduce the complete process for you:
>   1) hci_dev_open_sync()->
> hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
> here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
> serdev_device_close() to close tty normally. And then call serdev_device_open()
> to retry.
>   2) serdev_device_open() fails due to tty_init_dev() fails, then tty gets
> released, which means this time the tty has been freed succesfully.
>   3) Return back to upper func  hci_dev_open_sync(),
> hdev->close()(hci_uart_close) is called. And hci_uart_close calls
> hci_uart_flush() and serdev_device_close(). serdev_device_close() tries to close
> tty again, it's calltrace is serdev_device_close()->ttyport_close()->tty_lock(),
> tty_unlock(), tty_release_struct(). The four funcs hci_uart_flush(), tty_lock(),
> tty_unlock(), tty_release_struct() read tty pointer's value, which is invalid
> and causes crash.
> 

Hi Greg, could you please take some time to review my reply?
Thanks very much!
