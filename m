Received: from outbound.pv.icloud.com (p-west1-cluster6-host2-snip4-10.eps.apple.com [57.103.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEF1E1C1A
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581076; cv=none; b=BKwrLQOicrw41ZpVlHoLwY3I/Yv//KMjclSz1/i2twypiVe15jtioRn4TPDcqGokAXCF6QgiAvyx/E3elgwfjIX3oKEx36thb38QUeZ+OxR5Zt7J3QLdXTds13z6ajB8yW0mAPhvUdQk87bpvO0exuu7LyjztgVYiPhqJAD3b1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581076; c=relaxed/simple;
	bh=hLf8I3qN0IkenLrmP40OHYgcgFtsnAx3thMVnWAlEWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozzrBV4V9M1i9bB8mI5RVh4d59T5cO07HpEL2qXOm0T1tc6mpxQDxxk14ncYa3m9Q2FyjhCdu1kRdD07kLm+HelK6GxaRmNtv40aoF46gBNbjinMujVDeLAlIZPhbQwJ+BlsrokkPlK/iYkChVVi13NsYcaNR6puDBGDbn3sz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lAGtUJsj; arc=none smtp.client-ip=57.103.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lAGtUJsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=g+6OjhU/9zBErXb66CoyZ6TSEdzr2Bs/NZolCVB1gKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=lAGtUJsjOqFEjLIlBi+tz+smy0Rx7aUZyw8ewDvmrPIwiGc23/s9nrZZ9tQUrtg3z
	 9IdxXrgwlGzdZSMBk8wpEzXnfYFIlVei10Wd48drWmm7eQQkVLbpy5UAFKIuzYldE8
	 cPkwwb1C7CfA64Qr8J1KXCW4EpaxzaITrputK/GkoOGZ4oAIcZ1ITRUq/KOjhh3biy
	 vCqFu4oJBUWmKRzFyG4LsBYvnTMX0WwJ1I/NhCKaHbLDHnchkQ77OowfJBf23WHEPN
	 DHtoAJTJkx0w13R27vrep+rEq+lzKNtYHrHvZ6IxzTYk1CMAZrriq9oJ5rFFfAps/n
	 EsThlGrGErhDg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id B19C31800578;
	Fri, 25 Apr 2025 11:37:49 +0000 (UTC)
Message-ID: <05d1f626-1c76-4b78-9028-f31d42f4d528@icloud.com>
Date: Fri, 25 Apr 2025 19:37:45 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serdev: Remove repeated device name in
 dev_(err|dbg) messages
To: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
 <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
 <f2389ea1-44f9-4d66-b8e1-d55281541aa8@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <f2389ea1-44f9-4d66-b8e1-d55281541aa8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iTYpRsSntvIBGYBxtNXsiDkXA_weDRtw
X-Proofpoint-ORIG-GUID: iTYpRsSntvIBGYBxtNXsiDkXA_weDRtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504250084

On 2025/4/25 13:38, Jiri Slaby wrote:
>>
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index
>> 971651b8e18dcbb5b7983cdfa19e7d60d4cd292b..f00106de76a0f1e547310c7d21cc2fe3d5869e28 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -118,12 +118,12 @@ int serdev_device_add(struct serdev_device *serdev)
>>         err = device_add(&serdev->dev);
>>       if (err < 0) {
>> -        dev_err(&serdev->dev, "Can't add %s, status %pe\n",
>> -            dev_name(&serdev->dev), ERR_PTR(err));
>> +        dev_err(&serdev->dev, "Can't add serdev, status %pe\n",
>> +            ERR_PTR(err));
> 
> You don't need to wrap now.
> 
> Could you also get rid of ERR_PTR() and print err directly using %d?
> 
>>           goto err_clear_serdev; 

sure, will do it in next revision.

