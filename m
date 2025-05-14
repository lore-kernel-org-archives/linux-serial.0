Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56A21B9E7;
	Wed, 14 May 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214056; cv=none; b=WDzL/Ip59y65cMOaEbSUWGONjzK8lSoEdsHrEgW+cFoBdRqASoyO2hhGRXo2ymaSILCJcNDT4N7xpgJwtwOjxybvlZXl2ABXXaITW6fXUGLpCSG/6atEowPKIJ9x0aBZhfCa1hWrFq+d6pQtJNJ74HngUjmAlmSAnlJNkhPxz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214056; c=relaxed/simple;
	bh=zqbpr1/pmEwXyeTCn/N+XUxN2P/HcKgvmsCSU107Kms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mU193zevbnAXfkHcPFslIniE59Mq7i7drV5HF7wmthbG4yewh18BK9zCrHdALJOyJ67TUK+4h8Ype5xwbYz2L5HNhArOSXSCcz8x2zcgwcSjYmDoMi0ZJEze6sOneNiqr4tgFv51BEQpkjzlvhRt60YOqiZZ7fG4U/9NWMf8DQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iGha87tN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iGha87tN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8Gru1016770;
	Wed, 14 May 2025 09:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3zUiP6IGnNCzK66tqCkthGESqX/+EF8UayPwSJbE2I=; b=iGha87tNgMJ07ecN
	dm+ElJDjdr54p/8EF7jnDMDLFj6nM5eMqF7McozJXkTBIGYjA6Vd79R70MyjygCA
	YDJxgQAS/IdCwfmnnyOFf50JnLArWwsso5iFbPb+4+xUjl1KzDLduHSVQmNNa2MA
	3gUanvUb3qSyUE32dzxDtKrcAnJP+Pt7AgA1GVPYGTHySxpfHDPt1MXuwO8jlrKD
	QEqC7MVEd+n8CaLqRJo7Wno2ymCg2GkYpioddGBTQ8+BYN+ZTgFZrBhGxXhlp7BS
	JQqNg4LgQQWBtzTeZrs0mRtAcTKnJks7LFhrge6AbUcN1inI1v1x4n0P7TN2sQma
	l1Xaag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmt4ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 09:14:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54E9EAkZ008832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 09:14:10 GMT
Received: from [10.239.105.44] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 02:14:07 -0700
Message-ID: <38bf94e1-ebed-4d03-8ea0-4040009e8d31@quicinc.com>
Date: Wed, 14 May 2025 17:14:04 +0800
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
Content-Language: en-US
From: Xin Chen <quic_cxin@quicinc.com>
In-Reply-To: <2025050851-splatter-thesaurus-f54e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lEqEWXYHHo7jUVR5aXmMi69kvT4mu4c1
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=68245ee2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=_VqJUKEpYW178Kr0VN0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lEqEWXYHHo7jUVR5aXmMi69kvT4mu4c1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4MCBTYWx0ZWRfX9882ezAd70Oi
 UWom0AbIgqDOHR6vQdIrDQ3mt7lNxjvycj+6pBqBryjV6ll1d79XYFvDtX6Jw5mrfA9W+UkyswC
 yPCbY3u/fLAFhS3VnOPf7zNSyNLOdLbFvJ9ZXOZwMKuqF5pifZhgBbTvuo+hgYBy0NM3nOFBhRF
 0nGgAMYssF737L7pqCd874hrZijSserHVV+OgIO8Cs3uCDs0dgFwEolCBLAHX+/73sdZoovPOqT
 wlpCAaMqD5HOP/WB/P+NJ+Nx0G6CpPAhFpg8FcOjh8cHTepsmYLwh6CzslZ9smtiKP6P02ry9Bn
 1IZi8uJi6AnQP4GS5yZBBmmwbBX/t2gfdfqLcXS2zr4YhDH8N50fXfBzfrJKXW13G353vF0TyFI
 rfZUwqzhGMgiV8UQB8dMQsuMX//EnkkY+Q2JQfeVBXQ4w+IRdNOoQJzFEO3U+K9kQfZdPouV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=813 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140080



On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
>>
>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>>>  {
>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>>>  	struct tty_struct *tty = serport->tty;
>>>> +	if (!tty) {
>>>> +		dev_err(&ctrl->dev, "tty is null\n");
>>>> +		return;
>>>> +	}
>>>
>>> What prevents tty from going NULL right after you just checked this?
>>
>> First sorry for reply so late for I have a long statutory holidays.
>> Maybe I don't get your point. From my side, there is nothing to prevent it.
>> Check here is to avoid code go on if tty is NULL.
> 
> Yes, but the problem is, serport->tty could change to be NULL right
> after you check it, so you have not removed the real race that can
> happen here.  There is no lock, so by adding this check you are only
> reducing the risk of the problem happening, not actually fixing the
> issue so that it will never happen.
> 
> Please fix it so that this can never happen.
> 

Actually I have never thought the race condition issue since the crash I met is
not caused by race condition. It's caused due to Bluetooth driver call
ttyport_close() after ttyport_open() failed. This two action happen one after
another in one thread and it seems impossible to have race condition. And with
my fix the crash doesn't happen again in several test of same case.

Let me introduce the complete process for you:
  1) hci_dev_open_sync()->
hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
serdev_device_close() to close tty normally. And then call serdev_device_open()
to retry.
  2) serdev_device_open() fails due to tty_init_dev() fails, then tty gets
released, which means this time the tty has been freed succesfully.
  3) Return back to upper func  hci_dev_open_sync(),
hdev->close()(hci_uart_close) is called. And hci_uart_close calls
hci_uart_flush() and serdev_device_close(). serdev_device_close() tries to close
tty again, it's calltrace is serdev_device_close()->ttyport_close()->tty_lock(),
tty_unlock(), tty_release_struct(). The four funcs hci_uart_flush(), tty_lock(),
tty_unlock(), tty_release_struct() read tty pointer's value, which is invalid
and causes crash.

