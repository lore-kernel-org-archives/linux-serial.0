Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B621FF603;
	Fri, 30 May 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594102; cv=none; b=AbgguDoY/euv/SK5LejxVRBiVdTHP4NdhPzN3/dY1YSoGMtENndPZ0iCO8dCP91RBh0kVR/0YLA8D1Xtnf+2nt72dJ06YdOdUazFPTMR4Azw3A5/Z7wVEpMdE8TwrTgS4pGe11jHDkuOcB4Dt3/G+Rx9J8TbqPLYtrc1Pfm30FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594102; c=relaxed/simple;
	bh=AaGwn0lqTXVzgZuVYGhlOtM5wFa9rQwalRqSWVUegjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pI73b8QlxX3nQ+lykdvQXv/vqc06Y+AN/V2V2mFkbrB41j+xUi9w06GCiQDEm/XQV/IbK3SzderQyfL6npKS7HzStDKY8/x5pX5dEnjIzfX4P95SauM6Cr5hRItb8VM3AoMFTw3e3sMfnwWmLy62Euh1Mq9aW0exbkTysFY6cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lclV61rN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lclV61rN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U0MkDv004882;
	Fri, 30 May 2025 08:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JBePT4VRk3EWdmQVSBKgWOtJvtAe3EhswTDKYw+kqxE=; b=lclV61rNIwmA5C8C
	O5y/PpBzPQDHFWipMOdv6pV58DEcAEz7iB+RsZn1AxLX6dbg8h3u934DB+x37C0P
	DYYykUv12bfLm5iDSHE+9gGRYo26kwSfQOSwCTYWOnj6p1cTmwy/LpcsDtw88gNy
	O6UMddlkZFccscvAA7J7trqnbKroySoIVdbytkyHjGkWtcl5i/Lyi2fz6Ra35nkJ
	GwNhyoh4m8MOoaW+6nQ6JKuuzrVpexaGbcqgwwzgp0yovaw63FuIqF7sUhqh2VSr
	o61CAYXwjIZ0s+n22MWbhLJh/sATYU60niMRoyWSBcyqmnTiY9JDSMZj+ds3KGpb
	hyEKmg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek869h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 08:34:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54U8Ys2A001683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 08:34:54 GMT
Received: from [10.253.39.138] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 May
 2025 01:34:51 -0700
Message-ID: <25361fe1-988d-41cc-a5f0-76773e41531a@quicinc.com>
Date: Fri, 30 May 2025 16:34:49 +0800
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
Content-Language: en-US
From: Xin Chen <quic_cxin@quicinc.com>
In-Reply-To: <2025052957-jawless-superhero-09be@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=68396daf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=G5QaITAZWq_18pxbImEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fLQyRINiNWSmn0E8-3kLiQ4WKZnQtxcj
X-Proofpoint-GUID: fLQyRINiNWSmn0E8-3kLiQ4WKZnQtxcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA3MSBTYWx0ZWRfX5FPdIg3r9eT4
 I8e51Ei/Q2U+ihmE3s9jTMjZDVl7zo0XbvrVA8kDhSgrTvmDbXXA8uTZEpeQq83rrTEIU4wvLMz
 sRBmVLw2G1BO1nQH01OqLC61+JYuuT7RJU8Cx02LrlARGU4k//0J0GZd3J5PhR95xk4YkBUHTGk
 cR8QX3/RzmlK+mD2ktnVXEwBX3v+iQrKOdEsP6C558nYhbLERIgiJqAdxqD7SD3T7X6Nqdz9Q7z
 L5DHjTuoOIDrsRXxvO6aTYFvpgubqK+OFOe99pPA9/VK3W+Al5Pu45FO93HszOuxEzt017hCktJ
 jzHNtome3BKnOug6Mbkmn9Wv8Kh8N1CoHq2WuEjLHG4XdF41PdeOW0TSdJUpAUN+Y4B21aS46N0
 h3NeFE08ybMd6+dEWDiiAKYQt8VV7V/3GIN2OKjbJH0V0c0kc8fbr0dXnx+JPEihnZ5ym1bS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_03,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300071



On 5/29/2025 5:41 PM, Greg Kroah-Hartman wrote:
> On Thu, May 29, 2025 at 11:07:25AM +0200, Greg Kroah-Hartman wrote:
>> On Fri, May 23, 2025 at 10:52:27AM +0800, Xin Chen wrote:
>>>
>>>
>>> On 5/14/2025 5:14 PM, Xin Chen wrote:
>>>>
>>>>
>>>> On 5/8/2025 5:41 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, May 08, 2025 at 05:29:18PM +0800, Xin Chen wrote:
>>>>>>
>>>>>> On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>>>>>>>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>>>>>>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>>>>>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>>>>>>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>>>>>>>  {
>>>>>>>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>>>>>>>  	struct tty_struct *tty = serport->tty;
>>>>>>>> +	if (!tty) {
>>>>>>>> +		dev_err(&ctrl->dev, "tty is null\n");
>>>>>>>> +		return;
>>>>>>>> +	}
>>>>>>>
>>>>>>> What prevents tty from going NULL right after you just checked this?
>>>>>>
>>>>>> First sorry for reply so late for I have a long statutory holidays.
>>>>>> Maybe I don't get your point. From my side, there is nothing to prevent it.
>>>>>> Check here is to avoid code go on if tty is NULL.
>>>>>
>>>>> Yes, but the problem is, serport->tty could change to be NULL right
>>>>> after you check it, so you have not removed the real race that can
>>>>> happen here.  There is no lock, so by adding this check you are only
>>>>> reducing the risk of the problem happening, not actually fixing the
>>>>> issue so that it will never happen.
>>>>>
>>>>> Please fix it so that this can never happen.
>>>>>
>>>>
>>>> Actually I have never thought the race condition issue since the crash I met is
>>>> not caused by race condition. It's caused due to Bluetooth driver call
>>>> ttyport_close() after ttyport_open() failed. This two action happen one after
>>>> another in one thread and it seems impossible to have race condition. And with
>>>> my fix the crash doesn't happen again in several test of same case.
>>>>
>>>> Let me introduce the complete process for you:
>>>>   1) hci_dev_open_sync()->
>>>> hci_dev_init_sync()->hci_dev_setup_sync()->hdev->setup()(hci_uart_setup)->qca_setup(),
>>>> here in qca_setup(), qca_read_soc_version() fails and goto out, then calls
>>>> serdev_device_close() to close tty normally. And then call serdev_device_open()
>>>> to retry.
> 
> Wait, what?  Why is qca_read_soc_version() failing?  

Actually I have not root cause why qca_read_soc_version() fails of
__hci_cmd_sync_ev(). It may be relative to FW issue.

> Why are you retrying multiple times until either you run out of attempts?  

This is a retry mechanism. I find the reason in the change commit message
"Currently driver only retries to download FW if FW downloading
is failed. Sometimes observed command timeout for version request
command, if this happen on some platforms during boot time, then
a reboot is needed to turn ON BT. Instead to avoid a reboot, now
extended retry logic for version request command too."

> Why are you closing the port and then opening it again right away? 

This is a retry mechanism as above said. Do you mean there should be a gap
between close and open? The change owner maybe don't think about this issue.

> What close/open pair seems totally unnecessary, why do that at all?
> 
> If I read that function qca_setup(), it can NEVER detect if a failure
> really happened (i.e. if it does run out of retries, you just plow on
> and keep going and keep on registering things and THEN return an error
> for some reason.
> 
> In other words, the error handling in qca_setup() is very suspect, why
> not fix all of that up first?
> 

qca_read_soc_version() in qca_setup() can detect whether the hci_dev is set up
successfully. If if fails then a failure happens.
You mean I should fix why qca_read_soc_version() fails?

Thanks,
Xin


