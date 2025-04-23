Received: from outbound.pv.icloud.com (p-west1-cluster6-host11-snip4-10.eps.apple.com [57.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37344283689
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420834; cv=none; b=eqJn6g20298agiWP8maB3M0tV6S+3NlfQ1LfogILzsM11jpSgO1RiznAcJgWSxG70HWo0wRkkDeGQ4aO0Ui3eA6VU8FRyG+bAnxyWRZAnti0C1mapgefZKHyHApOUZHbxhoMUqkR+aHFXvpAPmF65tHnwvOdp64ay/X8fn7BhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420834; c=relaxed/simple;
	bh=ncYCUqrnH4k5DtzAx1ju7n3hv+FcGflODH2JtmcBMIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cee36KvSzj3UyFetMe8hLuLKUzFZpkwlo+T5xKDeniz1iqpaZcd0c+3GYjLEMpRsEJ7i/SNPqIKN0pYRsDOR7qzuYhi50LHepta1dbIHeQ9N4PB6G7rvAGHbcBaOIDTh2giji6PR8/CcNP6Kbu+6D/oy8xPXtabbLr8xw8NPCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mvEA8f6w; arc=none smtp.client-ip=57.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mvEA8f6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=I7RV8N38I93hHJRFS2/QoJ+fPJKvXSud4F74bGT/hOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=mvEA8f6wqjPBna8m7yl6VxFX8P/N57pMFl+ZahWns9JPq7wx5i6YqnF1QxiSnH2/4
	 1Yk2J9LehvRYs9vCntN/R0hbY8h+DBSAqpX4kvCqKR3nb/vwsKTJCwrB328/Mige1G
	 7PniYqj8qGhNJSUf99Eym9/VqegSnvltSIrAqfqlHiM0ZhM66IoWq/m2PgmGncZT4w
	 g+zlkNqBDrVcMbX3KjX74WKe2oJfIN4zjfEufQPV1OIXJSmFqZNWDHQloc/WJzQ1ZC
	 sJkDwMG5NdZ+RnvHQGpF2qY4qeECsQF9OqGEkSUQG/7oaCjOYcn964FqNy819MjWPX
	 w5t3WtoUkv+lw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id DCF7D180205C;
	Wed, 23 Apr 2025 15:07:07 +0000 (UTC)
Message-ID: <2130b658-0c7a-497a-99b4-d3a5c4ecd8eb@icloud.com>
Date: Wed, 23 Apr 2025 23:07:03 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serdev: Get serdev controller's name by dev_name()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com>
 <2025042354-imply-pointy-92e5@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025042354-imply-pointy-92e5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CifquE0U03FnfBqBwURMvSJMjVttTVyB
X-Proofpoint-ORIG-GUID: CifquE0U03FnfBqBwURMvSJMjVttTVyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=853 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504230106

On 2025/4/23 22:35, Greg Kroah-Hartman wrote:
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index eb2a2e58fe78fbbdb5839232936a994bda86d0b4..971651b8e18dcbb5b7983cdfa19e7d60d4cd292b 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>>  		goto err_rpm_disable;
>>  	}
>>  
>> -	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>> -		ctrl->nr, &ctrl->dev);
>> +	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
>> +		dev_name(&ctrl->dev), &ctrl->dev);
> dev_dbg() already has the name in it, so why repeat it again?

i guess the author wants to print a sentence which is easy to read.

for built in name of dev_dbg(), it always happens at fixed location
and not where good sentence wants.

actually. drivers/tty/serdev/* have other such usages, for example.

dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
dev_err(&serdev->dev, "Can't add %s, status
%pe\n",dev_name(&serdev->dev), ERR_PTR(err));

