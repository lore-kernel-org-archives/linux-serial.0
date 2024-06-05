Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDB18FDD5
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573976; cv=none; b=d5DDC+VNTQILCvLdzFdnKCXZMT2XPHDdqzltCy2RsGsfQ7TsOO5ClRJ8aHr/H275IpStAMQPKk9lumwI/MGHOODBqvHC3mhdijNhxIxV4fW88lIFpPnDOmMQHWlgpm9oBNxqAXu2yxo585sJLoH1lXIUnwXyYL81aTwAbiRr3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573976; c=relaxed/simple;
	bh=SGG1GHY0lrFlCJBwEmpI1VHoaBxwChKg/9ahGdTSr3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=VnwA6e9LBw9qqQwjM+xqaC0RFh1CJC0ElI9SkZOb8exOVq3mezag/ejA+w4UOcRxo8uTKupcgzCqs1JMYyqUNJ/XU6q7pSeFpSe3a5ERNxazGI/JD9IKWDiabo45ROb1WPL0aabKPxW3vWP/8pjKmBl67OuQm785SsuYiWLre5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k2wyQA6W; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k2wyQA6W"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240605075246epoutp04d23de8508ca117bf67607b1d5820340b~WDGwx25la2615126151epoutp04B
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 07:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240605075246epoutp04d23de8508ca117bf67607b1d5820340b~WDGwx25la2615126151epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717573966;
	bh=SGG1GHY0lrFlCJBwEmpI1VHoaBxwChKg/9ahGdTSr3Q=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=k2wyQA6WZUA7Kj+8jLRCBn8MekqYd0DiFvZZhy9p7G8YH/vPjpjZAlGUSBc0bi5Gy
	 5d4RMabYLIs4xWdPhHi2J6q+Su7qc9b5n3LjJXm/qoWayjhnjozvXtlmBLsjuzr+lc
	 NoF/AvEe2HbNf/KWA+S9bKDfs8/+cXQebCulRv9k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240605075246epcas1p36695db36f77e92a678c4ec0ede75b12e~WDGwY0_8j2371423714epcas1p3G;
	Wed,  5 Jun 2024 07:52:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VvKSY1Zydz4x9Q1; Wed,  5 Jun
	2024 07:52:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.37.10362.D4910666; Wed,  5 Jun 2024 16:52:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240605075244epcas1p33b4032f1d0f08edd8e1716cc825ff5df~WDGuqcb942489424894epcas1p3v;
	Wed,  5 Jun 2024 07:52:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240605075244epsmtrp27c095d233ec35f420a5be0a1f67c3bc0~WDGuptZfX0790607906epsmtrp2Y;
	Wed,  5 Jun 2024 07:52:44 +0000 (GMT)
X-AuditID: b6c32a38-62079a800000287a-38-6660194df5ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.F4.18846.C4910666; Wed,  5 Jun 2024 16:52:44 +0900 (KST)
Received: from [10.113.111.204] (unknown [10.113.111.204]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240605075244epsmtip1570469698927aec2a126eb24553576be~WDGuehStU1694216942epsmtip1H;
	Wed,  5 Jun 2024 07:52:44 +0000 (GMT)
Message-ID: <c7505440-23cb-4397-8a0e-6fab707bd155@samsung.com>
Date: Wed, 5 Jun 2024 16:52:44 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: samsung: Change MAX_CLK_NAME_LENGTH to 17
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
From: Kwanghoon Son <k.son@samsung.com>
In-Reply-To: <1d68e73b-18b9-4fad-b0c0-fcd9cc9571e2@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmvq6vZEKawezJHBYP5m1js2hevJ7N
	4t1cGYvz5zewW8w4v4/J4sziXnYHNo9NqzrZPPbPXcPu0bdlFaPH501yASxR2TYZqYkpqUUK
	qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
	+nY2RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ75tPsRa0slR0
	tm1iaWCcxtzFyMkhIWAicX56A1sXIxeHkMAORoknHVuZIZxPjBK3N35kgnOefbrIDtOy9Phf
	RhBbSGAnUNXhYoii94wSN+csBiviFbCTWPOvCWguBweLgIrE6YMGEGFBiZMzn7CA2KIC8hL3
	b81gBykRFnCTaHqoBhJmFhCXuPVkPtheEZDx3Ze3sIEk2ATUJZa0rQUbzwk0vmHaAyaIBnmJ
	7W/ngF0tIfCSXeLemR2sEIe6SGx9+xLqaGGJV8e3QNlSEp/f7WWDsLMljn6EsUskrs9aBNVr
	LLF/6WQmkOOYBTQl1u/Sh9jFJ/Huaw8rSFhCgFeio00IwpSXuNVZDtEoKnHm6UeogR4Sn+fu
	YoSEzn5Gia4fT9kmMMrPQgqJWUhenoXkm1kIixcwsqxiFEstKM5NTy02LDCBx29yfu4mRnBK
	1LLYwTj37Qe9Q4xMHIyHGCU4mJVEeP2K49OEeFMSK6tSi/Lji0pzUosPMZoCo2Mis5Rocj4w
	KeeVxBuaWBqYmBkZm1gYmhkqifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cDkfdmwrv7r5ObW
	n7tkhT8kfdvAdXxx40KZjy9nhaxI/+mSpz/r54u9e+cf2JNm+7D5prjlxDVWd17UHmDbEZzW
	8ojrQelS7wWLG7NT5lVbFO5vjA5+9HBZ5B72s3vrol4m28XFyVyOKX7a+iv3vfnGcDX1bNmI
	NZteZTtaK5nMXW+iHvE10rRnd1nszVAtUY5P1+wy/1isMFg5uej4z6zSSK4Hp97N52C2Pl23
	SWj6r9Psnl+DdZevFMuYMXXnQVWV/8+zehqkYji/22ekuG1ZEB4gbxV22VG9utYzSDtp140j
	ogn5HtPWS6smLGKtVK2d+HvJGrUV6nnq+vvyNrt77ViTUyNfG+G+3Cqya6ESS3FGoqEWc1Fx
	IgDJ+9HdEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK6PZEKawYH14hYP5m1js2hevJ7N
	4t1cGYvz5zewW8w4v4/J4sziXnYHNo9NqzrZPPbPXcPu0bdlFaPH501yASxRXDYpqTmZZalF
	+nYJXBnvm0+xFrSyVHS2bWJpYJzG3MXIySEhYCKx9Phfxi5GLg4hge2MEgfWn2KHSIhKdFxu
	BEpwANnCEocPF0PUvGWU2H2vB6yGV8BOYs2/JjaQGhYBFYnTBw0gwoISJ2c+YQGxRQXkJe7f
	msEOUiIs4CbR9FANJMwsIC5x68l8JpCRIgI7GSV+PwCpAZm/n1Fi8uM5YMexCahLLGlbC7aL
	E2hXw7QHTBDdZhJdW7sYIWx5ie1v5zBPYBSchWT3LCRLZiFpmYWkZQEjyypG0dSC4tz03OQC
	Q73ixNzi0rx0veT83E2M4PDXCtrBuGz9X71DjEwcjIcYJTiYlUR4/Yrj04R4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYlI94zmNVPe05o8jnd/Qvge0n
	O7uTHravfu2VJFCx8bra706/5GtlahPl49ltpx91apxSeMI8OM23/hOzun7q6lL7/VyPuy8Y
	z5lx4LtBJM9e7q1HT/5+wXWtqfzz7by0ZyLX8lg2R+1yef79i95zpbyO/QuWten+EJl8ZYlO
	w+6eeVIVAu9V9WedvnjS7XgJ9+zA2eu/Xd3uEHb1t9WKvh9nhRLLdB702ald1Uj3CRWozd2s
	kpPW38WS53I8ce3WiVMOCMkxB8tazZ6UFpCTnDfxUt7SnuVlTbcutoRa8vBYB3NuW5VhPumM
	cPvyGcc8Y048PBDuOdkxe6pQT6Db1eDuEwY5H28GL4lernZFiaU4I9FQi7moOBEA/mgcNO4C
	AAA=
X-CMS-MailID: 20240605075244epcas1p33b4032f1d0f08edd8e1716cc825ff5df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba
References: <CGME20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba@epcas1p3.samsung.com>
	<20240605040719.160778-1-k.son@samsung.com>
	<1d68e73b-18b9-4fad-b0c0-fcd9cc9571e2@kernel.org>

On 6/5/24 3:42 PM, Krzysztof Kozlowski wrote:
> But that's not true. We do not write there more than 15, including
> terminating NULL byte, right?

For now, right. only clk_uart_baud[0-3] acceptable.

I thought this meaningful in code side, clk_num u8 can over in future.
Also don't want to see warnings.

But if It's false warning(device tree constrain), please ignore patch.


Thanks for review.

Kwang.

> Or you just sent whatever is there to silence warning?
>
> Best regards,
> Krzysztof
>
