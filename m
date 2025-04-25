Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-4.eps.apple.com [57.103.64.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AE22DFB6
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581010; cv=none; b=JDUP7lzGXl+U4PBToHEMFCvOwjqk/Us7w1hq9+ZuyEJybu2GMnSLawbMURhESIcUbS0dNuejG8Dl70YHFJ3B35YHxVE6EMe3f3Tx3n5sUCPZnDarUhbyU/rdGKpyuGsttYaA8IcAYhEYpE3TBi8OD4IriQu5GzvdrsoYJsk6oWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581010; c=relaxed/simple;
	bh=sRgudjei4ZISFxtdnmKlQ5iylRzrWMTsFvymebWjx/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OawivIFYtfRF/+c+AY6rd0wUena+sgkLihUJnAQYaPfshuJT0M0DL7CMOlTxOOusIitx3YrBgnNEpkNM2htHvzLcYSREZ1BkR26nImnR0p7we4HLW02dwx3b/zmmCm2WbSOh1dRjACnOio2fLGaNw3YP41ovs+tdVJFx2t28XY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=l7ozcYSh; arc=none smtp.client-ip=57.103.64.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="l7ozcYSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=DtyyB+Wp1J5ic6D5MX7Rrbs3eI5ZkNUh7lR7a8rdmJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=l7ozcYShzGyaRjYlHaL91C8BFQ1TZzjtJZCUgrb6SEqX98EpSPt463VJVaePb2yDu
	 23mbwErbl6vssfnvXe2XJj7FOGPR4soiZePsV9DhDLsd365pxb2hTtcY+nLRgeg0vZ
	 E9A9EUWQKjqsR/QMuiYXKz2gok6lw8InFZ2GngpSyFEFPeinAXpm/+ggO9qsPcFegS
	 akjCWksAMB/qcDj9biMJ+Som5bKo2aI7WBkn87gMqjvhrSDmpySar1SGjS5r/PQejY
	 4kPpyt8PyDJmWAOIks6oFh3Imj4DduIhapGNNqbsVH6TE/DDXnR5dtObUs/7YFcQh9
	 jXbGLJhxXdEHg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id A9C071800099;
	Fri, 25 Apr 2025 11:36:45 +0000 (UTC)
Message-ID: <934c275b-1ea8-4a09-b2cb-6c9bca2860f3@icloud.com>
Date: Fri, 25 Apr 2025 19:36:42 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serdev: Remove repeated device name in
 dev_(err|dbg) messages
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
 <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
 <CAL_JsqKs=5Uf1rJy3iBROL5ZZVo62cTbNq+yzKr2DXU+Nhabbg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_JsqKs=5Uf1rJy3iBROL5ZZVo62cTbNq+yzKr2DXU+Nhabbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: be7_7O1NDzc79Hxb1s4D5SrZDY1ApUW3
X-Proofpoint-ORIG-GUID: be7_7O1NDzc79Hxb1s4D5SrZDY1ApUW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=958
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504250084

On 2025/4/25 02:34, Rob Herring wrote:
>> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>>                 goto err_rpm_disable;
>>         }
>>
>> -       dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
>> -               dev_name(&ctrl->dev), &ctrl->dev);
> I don't understand why you add dev_name() and then turn around and
> remove it in the next patch. Just squash the patches.

okay, will do it in next revision.

