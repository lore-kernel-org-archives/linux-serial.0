Received: from outbound.pv.icloud.com (p-west1-cluster2-host12-snip4-10.eps.apple.com [57.103.64.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54C2701A4
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493720; cv=none; b=L+eVwwQS6GefX9LIsmrPvvjRmIX6e+I/UoizWgT7U80r8n0TSwTN1Wax9x7X2U6GrQzedYwR22WGYA8bE6tEkf2D8ireHYlnICEW3YtqaCIKwqYnR/K21WWgalxU5K1nXjwBhfGrkTnIztoqy4A6ZX2I/YRe+L1hvfcxdZLE6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493720; c=relaxed/simple;
	bh=CpnVpUhfy5ZGakxdnTOwXUD0DWWXTOOmfRujWpec0x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoKVnCoCu6o89OVe1qwxWMUo11y3XGQ2dL5f6OCkOyh3gOKLWYrfZMFe9xtnpdg1YKF4C8Exmat9ZgiUudR1iCwbSLNi1JlTkRfdFp+xAnG0fuDUOyFuWQiR/IEh1Y5ehKb7Gs7zSBmPc7SECWBej4CwN2VPBesaNoNaU+uEZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TpKTtkJv; arc=none smtp.client-ip=57.103.64.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TpKTtkJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=CpnVpUhfy5ZGakxdnTOwXUD0DWWXTOOmfRujWpec0x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=TpKTtkJvVMtxGgd+askuiG3kiw4V4MuEkVeV0d6Q4qeTp1TEEACIxgyza/A1fv0ZB
	 o8yk/axteYFvu7edEZaJlzAVZodSr12w2QlPU7TdjAwC5z+jTqfDMFLAzpBL9vlF36
	 Pi1SFKIYbZ6LsU+5zJtfDXZya28T1M5JGrVO0hgyMPBKHsIPWvDJ1sksIbDs5NqNyO
	 4Npd7eU13bFZ/ltSnfTeqcGBumxiUtn8Tz6nWmED3iM00J8MRuy1L7xMMUvSK9y6cT
	 yRBSnj+qCsyZ+npAxgs/fK4txtpKjj+aHYb1r6GNPv2QgTMH2ymV+5bXf53oM5dL5Y
	 NWliqpXqupMQA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 08F4218000AE;
	Thu, 24 Apr 2025 11:21:55 +0000 (UTC)
Message-ID: <55dde037-4195-453c-a2e8-f03a6be2b908@icloud.com>
Date: Thu, 24 Apr 2025 19:21:51 +0800
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
 <2130b658-0c7a-497a-99b4-d3a5c4ecd8eb@icloud.com>
 <2025042306-ripping-dental-fc37@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025042306-ripping-dental-fc37@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kiGB8zhATyes74vcijtkW74IyQmVgkXZ
X-Proofpoint-ORIG-GUID: kiGB8zhATyes74vcijtkW74IyQmVgkXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0 bulkscore=0
 mlxlogscore=670 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504240076

On 2025/4/24 00:56, Greg Kroah-Hartman wrote:
>> actually. drivers/tty/serdev/* have other such usages, for example.
>>
>> dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
>> dev_err(&serdev->dev, "Can't add %s, status
>> %pe\n",dev_name(&serdev->dev), ERR_PTR(err));
> Then those should also be fixed.

okay. let me append a patch to fix them as well.
