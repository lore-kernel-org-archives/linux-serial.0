Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA276205E10
	for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2025 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871971; cv=none; b=PVmXCA7uxJiwyfHEvytOJ9uKxGWk5YdMooCR+qCJLh/UBpItO5p6QZXOqZ8hSek4Zkw+O/01cgdSaYjub//ldq0rdp4gg/PukZxpUT6voi+2WKbBlphASYNsBDk/EYQv+CiLN/hQx8E/6b0LznP9Ef+yvI/9a3hkSIqr5M6cDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871971; c=relaxed/simple;
	bh=59jZKnh0UjUE0oVRlN4BkQXlt3+BEqp/CSM8LBEvTfQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=nIIpVhPDjTXf8ovYVYrvJv1zBhghX03kR4x6MCmGvXNYu1q65JNzQAB/PTMpYVyheAID+a9act5w1n6eYwSy0zyX2dHVvwWra7Y59+SfHEa4xo75NeTcg3KE774xWebOLwT1SwJb5lHRgv0biPbKmEXj2Lp7gjsonVQL065Pwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fhom76C+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fhom76C+"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250417063926epoutp0494665b02c3b90769770878aeb5852f31~3B88cSOiF0367003670epoutp04q
	for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2025 06:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250417063926epoutp0494665b02c3b90769770878aeb5852f31~3B88cSOiF0367003670epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744871966;
	bh=fVeozOJeYXKnjtHlTCmH8PYKO3xU7YuoOVEbKh6nUIw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fhom76C+/DsLyPJvZZNj7G1Fmw+wzGF03Ve1et7EVLRS3P1HwTWtC3OeJB5IR2HBB
	 7y4iaePaEz9Ju+BP/GFcQtcjJJQNgR4h0nznCdQ8irvaC+6qFfJkALbKYJmnZZakYE
	 YgjZqsc+9bigKLJu3LI3cFKyor/GHdWVm52rzcD8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250417063926epcas5p42dc42cd6dcceca6f57eee04be5f2f97f~3B875T9Bk1038410384epcas5p4h;
	Thu, 17 Apr 2025 06:39:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZdSt42szhz6B9mH; Thu, 17 Apr
	2025 06:39:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.CF.09842.C12A0086; Thu, 17 Apr 2025 15:39:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250417053233epcas5p26ead4fdc63ececbe1a11b66fc0337f86~3BCi5Tl_92508225082epcas5p27;
	Thu, 17 Apr 2025 05:32:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250417053233epsmtrp1aa364e019649ddc717f6a682d6b4fda0~3BCi4XuIT3193131931epsmtrp1K;
	Thu, 17 Apr 2025 05:32:33 +0000 (GMT)
X-AuditID: b6c32a4b-329ff70000002672-58-6800a21c26c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.45.08766.17290086; Thu, 17 Apr 2025 14:32:33 +0900 (KST)
Received: from INBRO000519 (unknown [107.122.1.150]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250417053232epsmtip12e87afa09158354fe2f9856bb1aa7298~3BChcJmI21636916369epsmtip1L;
	Thu, 17 Apr 2025 05:32:31 +0000 (GMT)
From: "Faraz Ata" <faraz.ata@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <dev.tailor@samsung.com>,
	<rosa.pila@samsung.com>
In-Reply-To: <d350841c-3560-4511-a866-9490737e48f7@kernel.org>
Subject: RE: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
Date: Thu, 17 Apr 2025 11:02:24 +0530
Message-ID: <06cb01dbaf5a$1ea1a8b0$5be4fa10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNDUeEKzZOD+6UL/EvMWKPcOF/PnAGTFIryAfZj8UGwu8OBsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhq7MIoYMgzlXhC0ezNvGZnFvxzJ2
	i+bF69ks3s2VsTh/fgO7xabH11gtLu+aw2Yx4/w+Joszi3vZLb78fMDswOWxaVUnm8f+uWvY
	PTYvqffo27KK0ePzJrkA1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
	3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWl
	eel6eaklVoYGBkamQIUJ2Rl7OjYwFlxgr7i2eCJTA+NKti5GTg4JAROJic3X2LsYuTiEBHYz
	SrRNPMwI4XxilHi6bBkThPONUeLV9U/sMC1r/z5mAbGFBPYySiy8YwxR9JJR4vOb/2AJNgFN
	iTufn4J1iwg0MEqsWDIHbC6zwAlGidPrbjCDVHEK2EnsetoKZHNwCAu4S6zYHQESZhFQlXj+
	4QhYCa+ApcT/3pdsELagxMmZT8AWMAvIS2x/O4cZ4iIFiZ9Pl7GC2CICThKbe1qZIWrEJV4e
	PQL2nITASg6Jxades0A0uEhseNABDQFhiVfHt0C9JiXxsr8NyvaRmHz0GyPIbRICGRJ31opA
	hO0lVi84wwoSZgZ6cv0ufYiwrMTUU+uYINbySfT+fsIEEeeV2DEPxlaWOLlnDyuELSlx6PYL
	1gmMSrOQfDYLyWezkHwwC2HbAkaWVYySqQXFuempxaYFxnmp5fAIT87P3cQITrJa3jsYHz34
	oHeIkYmD8RCjBAezkgjvOfN/6UK8KYmVValF+fFFpTmpxYcYTYHBPZFZSjQ5H5jm80riDU0s
	DUzMzMxMLI3NDJXEeZt3tqQLCaQnlqRmp6YWpBbB9DFxcEo1MF1s3eQW8oDBUj1t6su6vROj
	7TU453578ElNpWJvX8TuDwdWCrqxfWOWm7bkFK+axOPdKrMF2y0krGeKdZ9I//BFyzX19kn2
	uZ94t/ofv3wzj9F2iohvscMj5htLfv9c+m/vHzH57yzf+Gy0N8z9pz1j+tvG8C71+YdKly/b
	tuX1Q7mbUh7qG/ZNqy+f2Pnn0jU7g+sRYevjdr9n6FAJ+xH4svX02+t73oUIeDYscmDNuaBy
	4nbZ387zwsbMG7bqrWd7l7p1SkTe7JINsziCz7T1Hrx8pd1Y2Zj53CGbsk8JrX+uBnDYbrqW
	MDW/ye4j46mNm2efWJhYUN21UiLZd6bxXvWex5e/X/yxxyTUbNosJZbijERDLeai4kQAlXZ1
	TjsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTrdwEkOGwbZGWYsH87axWdzbsYzd
	onnxejaLd3NlLM6f38BusenxNVaLy7vmsFnMOL+PyeLM4l52iy8/HzA7cHlsWtXJ5rF/7hp2
	j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY0/HBsaCC+wV1xZPZGpgXMnWxcjJISFg
	IrH272MWEFtIYDejxOnDchBxSYnDT++yQtjCEiv/PWfvYuQCqnnOKLHw4mKwBjYBTYk7n58y
	gSREBFoYJY5MO8AEkmAWOMMosWleFMTUA4wS347bg9icAnYSu562MncxcnAIC7hLrNgdARJm
	EVCVeP7hCDOIzStgKfG/9yUbhC0ocXLmExaIkdoST28+hbLlJba/ncMMcZyCxM+ny8AOFRFw
	ktjc08oMUSMu8fLoEfYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3
	uDQvXS85P3cTIzjOtDR3MG5f9UHvECMTB+MhRgkOZiUR3nPm/9KFeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MB3ctEwwfsLp9bvPJzspqpwsmvmr73fq
	Sr2tshfntK/K2qhcZmmYGSrE8sjiaLNlTPySAuPvWXVFbqLh3K82vdPN8uEoEy7hPima/+Xy
	xPS8a9+jvRlnM/Rz3+T/5sh8dkveIdb4ZH0uu807t9QVan+N7p+YyWN+h2fuLObO69VeUuqi
	Uv6MPxp0DZwEDvbISmm5sXKs3Ho3dv3j8N38/j5JMy5rbon5ZN/7P2DXNRvhCQs6bvt8ibnH
	9v8u9w/RP1y8rj9mBBT9jWRX+mh3ab71PdX2cK64ip+PH3XyzD/9+9uLZcdv7piUunHzfqVt
	d9yKWEpKwthfKysU39lzkT0yY+Uhp9TAzZ4c7Zd+KbEUZyQaajEXFScCAD1EdI8iAwAA
X-CMS-MailID: 20250417053233epcas5p26ead4fdc63ececbe1a11b66fc0337f86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d
References: <CGME20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d@epcas5p2.samsung.com>
	<20250417043427.1205626-1-faraz.ata@samsung.com>
	<d350841c-3560-4511-a866-9490737e48f7@kernel.org>

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, April 17, 2025 10:50 AM
> To: Faraz Ata <faraz.ata@samsung.com>; alim.akhtar@samsung.com;
> gregkh@linuxfoundation.org; jirislaby@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> serial@vger.kernel.org; dev.tailor@samsung.com; rosa.pila@samsung.com
> Subject: Re: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
> 
> On 17/04/2025 06:34, Faraz Ata wrote:
> > ExynosAutov920 SoC supports 18 UART ports, update the value of
> UART_NR
> > to accommodate the same.
> >
> > Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
> > ---
> > Changes in v3:
> > - Fixed review comments from Krzysztof
> 
> Which ones? What changed?
> 
While sending v2  change log was missed unintentionally.
Added missed change log in v3.
> 
> Best regards,
> Krzysztof

