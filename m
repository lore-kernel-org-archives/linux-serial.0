Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7726561E;
	Thu,  8 May 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696570; cv=none; b=sqZdUKsE/WnfB5n+ACdTouWryr630i5WBoV2qyLCJF0+cZW8Ct8f1lelgK1h+x+2au3+4L16SRmzVupKXn9D466DhWJufS6DyFgCzMigfixC74TzghzQuGZ1HoI8KKXtAmfMO4qTOe/aCudVPYy4RuFDQYqrqmyDXkvyjJgEiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696570; c=relaxed/simple;
	bh=b+QRVuuaQDDP/B17F6zk5qSO093mgI3JlezK9WH6yIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sdKH1ekR/C3uQmSkE34PgBnAOyHRwjmRS6prf0PF0lLkdDN1Esv8FauBBdj1sAd7ha21IIfcayJpG70ByLfxNzkUL5JR7eRmpM0F2+cEsRM8a9zuoTmBGqND1cy4H/lPi2md4zKrg0NctLOTxDI36NqozqBQX+Mv4vyANTV+ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R7Q3FYCM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R7Q3FYCM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484WJa4025435;
	Thu, 8 May 2025 09:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wSttNrKjfcsS5u/VzVpuNaX2/1qwPC4wcthYtaGK+To=; b=R7Q3FYCMVC53djtC
	AvEoDQpzmdiXTwCdr69KL9TqyQMN23GTdejLop3XfSJfwD4ZAxzE64pPdGNubITu
	MjEig6yXi+kLQ4JJtfmIxnD0Dn6sCM29Bqh6spZvQvjI5ijiAeVSOS5EcyuyFkJs
	sEyb7J/pS6qS8+CEGm7WUE7K47XH+pdW2DgI9WE+d/Qe4TFx2VhE25s3nBDvfOP9
	ps0UVilP4uM9fZk3grIatS2gziAarFs4k17y9kt7kRUrbE6dIsV0VX2Twx6ZZqI3
	feuR9uZaxEtp1ecb8/52f1anoQv9ioBJ89Jkj3VrvbXxkJ+qXBAkVylU5djebeLb
	XImBuA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp10t1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 09:29:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5489TOQS031672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 09:29:24 GMT
Received: from [10.253.32.147] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 02:29:21 -0700
Message-ID: <d388b471-482b-48ba-a504-694529535362@quicinc.com>
Date: Thu, 8 May 2025 17:29:18 +0800
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
Content-Language: en-US
From: Xin Chen <quic_cxin@quicinc.com>
In-Reply-To: <2025043022-rumbling-guy-26fb@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA4NCBTYWx0ZWRfX15gbxE1eM+co
 qJi3W0iCnxKutbiR1v9FNL3F0ARGpN1D6XhAshQJcOfLIRs0coLexxwXPMC22XBxbQuc0pHGAor
 gxM8tKBGvk0DeURoF7otQaOJwQmCEvhw3ewrV8L7qH3iYDHreO/hVXSVfxprUWnnXLlmvTVl+vx
 mnbXdrGNyykzti2GdZsFWaC7k6bv1Wc7g2be061R0kCVYIhUIA2/GxgjDuCE3R1SUZZSInPLPwB
 knf/DMwY83ZvdjOSCjg8Ve6uvw69wRs5ktsg0+WVg9scsaINFhjiZ6017fJpCsKkrH6jNhJC3XT
 MADM/liSiWwgvkr4RoDhfxu6fHNPt3xcnAOkXiGPsBUkiXIVpEXDjZlc+H7lyfJuM+hmQDqTehb
 26/TeJ2ZVNpUk4a0lncmVyH5bbc5hGrghagoeRM63f133dhUze6ek/SdhONkc+OZ32CyUghb
X-Proofpoint-GUID: EBVNWcEGwpa6T7g7W1fmMuJ-oqytpGNP
X-Proofpoint-ORIG-GUID: EBVNWcEGwpa6T7g7W1fmMuJ-oqytpGNP
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681c7975 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=EIDKYfb7kX6--GltqKcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=410 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080084


On 4/30/2025 7:40 PM, Greg Kroah-Hartman wrote:
> On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
>> When ttyport_open() fails to initialize a tty device, serport->tty is not
>> --- a/drivers/tty/serdev/serdev-ttyport.c
>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>>  {
>>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>  	struct tty_struct *tty = serport->tty;
>> +	if (!tty) {
>> +		dev_err(&ctrl->dev, "tty is null\n");
>> +		return;
>> +	}
> 
> What prevents tty from going NULL right after you just checked this?

First sorry for reply so late for I have a long statutory holidays.
Maybe I don't get your point. From my side, there is nothing to prevent it.
Check here is to avoid code go on if tty is NULL.
> 
> And why print out that message, what can userspace do with it?
> 

I add the print just ref to code in other place. This can't be used by
userspace, but it can be used in DMesg log when system crashes.
>>
>>  	tty_driver_flush_buffer(tty);
>>  }
>> @@ -108,8 +112,10 @@ static int ttyport_open(struct serdev_controller *ctrl)
>>  	int ret;
>>
>>  	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
>> -	if (IS_ERR(tty))
>> +	if (IS_ERR(tty)) {
>> +		serport->tty = NULL;
>>  		return PTR_ERR(tty);
>> +	}
>>  	serport->tty = tty;
>>
>>  	if (!tty->ops->open || !tty->ops->close) {
>> @@ -156,6 +162,11 @@ static void ttyport_close(struct serdev_controller *ctrl)
>>
>>  	clear_bit(SERPORT_ACTIVE, &serport->flags);
>>
>> +	if (!tty) {
>> +		dev_err(&ctrl->dev, "tty is null\n");
>> +		return;
>> +	}
> 
> Again, what prevents it from changing right after you just checked it?

Same with above, there is nothing prevent it. Check here is to avoid code go on
if tty is NULL.
The check is for changes in ttyport_open(). In my project, it's possible that
ttyport_close() and ttyport_write_flush() get called after ttyport_open()
failed, at which time tty is invalid.

thanks,
Xin

