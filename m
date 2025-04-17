Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007131C84AD
	for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2025 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744864026; cv=none; b=qRil+EbyLAuPJwj6dWm3DkoKYH4u8u/QpqpIhCCF7KcV27lCJDTAMV54hbn2B+CAv2v6BVchrmqrJxbOJWYwgnqsyuyfFpigM+gHKP7C9eu2JnBr7JZOYOS/omKza2G1LsNtgUXj1yeGG29g9C9DBrnbwfBJZK9jge7OZk2c1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744864026; c=relaxed/simple;
	bh=6jOEeU7bOgzh5OB+/IJlCLlBlZShBgRYFPeIoAwUKag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MSSz8Wa08Pl4tAJo1xKd4gZT1tN0QWwA5xGjiV4Mtx5Fz8OK8HVpADtxvVZiCmuQVI1+QYx1BDnuVmP5uleC+BhHevGkuweXNhee6+gmqo2r1KI9j3PpRJmFhFMs9c96WJBZgQ5DSJTaHQdbxJzya3gLISgIZL2ubmwe3Og464k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GbeIeKCO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GbeIeKCO"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250417042701epoutp02d22d81f57d7d43fffe15527dbad556a0~3AJVMMPXJ2145321453epoutp02w
	for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2025 04:27:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250417042701epoutp02d22d81f57d7d43fffe15527dbad556a0~3AJVMMPXJ2145321453epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744864021;
	bh=0Mic3eQzqMW/WfkrWpTIHGqVKKLxGpW/SU0aNfBKGsc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GbeIeKCOgd9mws+jvTRMqzlGrxn1BmIpcGpaSscdqOnJjPBFPpyhVDV6LmtP4LrqS
	 QrcIOyHIW+l2eEUql0xbbIWBYt7AQYjB2hxuprpWItFQc8JLXq3BwCz3lEQIh3TMYu
	 Wp/ZjQfYeuMr/rTadqNGOi4fCJOeKVER9aX9To2M=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250417042700epcas5p2514834948b2daceefd1688f1ccb002fc~3AJUDAH1G0731807318epcas5p29;
	Thu, 17 Apr 2025 04:27:00 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZdPxG3CVGz3hhTH; Thu, 17 Apr
	2025 04:26:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	47.76.10173.21380086; Thu, 17 Apr 2025 13:26:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d~3AHFOTaz21902119021epcas5p2L;
	Thu, 17 Apr 2025 04:24:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250417042427epsmtrp1b1574df5707787771602dac61e22863d~3AHFLvhO22341023410epsmtrp1p;
	Thu, 17 Apr 2025 04:24:27 +0000 (GMT)
X-AuditID: b6c32a44-8b5fb700000027bd-86-680083128d7b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.6C.07818.B7280086; Thu, 17 Apr 2025 13:24:27 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250417042425epsmtip17c9190f71841f505db572cea3f01579a~3AHDr5wkd0578705787epsmtip1L;
	Thu, 17 Apr 2025 04:24:25 +0000 (GMT)
From: Faraz Ata <faraz.ata@samsung.com>
To: alim.akhtar@samsung.com, krzk@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	dev.tailor@samsung.com, rosa.pila@samsung.com, faraz.ata@samsung.com
Subject: [PATCH v3] tty: serial: samsung_tty: support 18 uart ports
Date: Thu, 17 Apr 2025 10:04:27 +0530
Message-Id: <20250417043427.1205626-1-faraz.ata@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuq5QM0OGQfM/UYsH87axWdzbsYzd
	4tqNhewWzYvXs1m8mytjcf78BnaLTY+vsVpc3jWHzWLG+X1MFmcW97JbfPn5gNmB22PTqk42
	j/1z17B7bF5S79G3ZRWjx+dNcgGsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
	5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0
	ihNzi0vz0vXyUkusDA0MjEyBChOyMzb9+cdUsICjYsfsZqYGxk72LkZODgkBE4m7bdeBbC4O
	IYHdjBJXrvUzQjifGCUezPvGCuF8Y5Q49HszUxcjB1jLkx9mIN1CAnsZJXbNjoWoeQ/U8HgC
	K0iCTUBdYuaNIywgtohAgkTnhyNMIEXMAhcZJZ6sP84IkhAWcJY4O+Ee2FAWAVWJTQ3KIGFe
	ARuJY9PeMEOcJy+x/+BZZoi4oMTJmU/AZjIDxZu3zmYGmSkh8JZd4vmNJ4wQx7lIHOmNgegV
	lnh1fAvUm1ISL/vboGwficlHv0GVZ0jcWSsCEbaXWL3gDCtImFlAU2L9Ln2IsKzE1FPrmCC2
	8kn0/n7CBBHnldgxD8ZWlji5Zw8rhC0pcej2CyjbQ2LJo0awkUICsRL7XsROYJSfheSXWUh+
	mYWweAEj8ypGydSC4tz01GTTAsO81HJ4pCbn525iBKdNLZcdjDfm/9M7xMjEwXiIUYKDWUmE
	95z5v3Qh3pTEyqrUovz4otKc1OJDjKbA8J3ILCWanA9M3Hkl8YYmlgYmZmZmJpbGZoZK4rzN
	O1vShQTSE0tSs1NTC1KLYPqYODilGpjYmRhK7/YzpaVfZPefY+nTnsVke3zbNSFgtK9gC9H4
	cH/PrOhtsjnTc2ZZKOdJdrKlexz4XporqC7dc/Z6Pc8U45y9dWxXNKdoWOr9W3Dgeoymqo6J
	EvuZQ1N1nOY9fn+0ZKrdl3t991/ZVCjwOD65UJhh+2nmjGVqh2UiZ039v1+Dder8ws/HhXeu
	iLYs6xD5b6+3q2qLvGF4jVLEiWreD7dn3ps4R/hI2s9EgZQFTuEXY6edCOG9Yb7v+IxJXfnq
	hsFsgovMPHZuSPbk2rCi+I1SxLRDK4v7V3vukHy8IlanKdbocfsqD2X/24rfLf47vLmTGOPJ
	V9b2neXKZa8NP4oDHu1+82pZSPLmuUosxRmJhlrMRcWJAO48mbwkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnG51E0OGweE3XBYP5m1js7i3Yxm7
	xbUbC9ktmhevZ7N4N1fG4vz5DewWmx5fY7W4vGsOm8WM8/uYLM4s7mW3+PLzAbMDt8emVZ1s
	HvvnrmH32Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyNv35x1SwgKNix+xmpgbGTvYu
	Rg4OCQETiSc/zLoYuTiEBHYzSjz8vwMozgkUl5Q4/PQuK4QtLLHy33N2iKK3jBKda2czgiTY
	BNQlZt44wgIySEQgRWL/XSaQGmaBm4wSW1uXgg0SFnCWODvhHhNIDYuAqsSmBmWQMK+AjcSx
	aW+YIebLS+w/eJYZIi4ocXLmExYQmxko3rx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc9NNiww
	zEst1ytOzC0uzUvXS87P3cQIDmMtjR2M77416R9iZOJgPMQowcGsJMJ7zvxfuhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXHelYYR6UIC6YklqdmpqQWpRTBZJg5OqQamBFOm00HW9e9y/7/JFZLj
	clvpmVm84s8jzv/sHJN3TnrLwi1yoTklKur7L8Va38v/zi8rDvSXPrY++8vVkxv/VUzxslZf
	o+lhKXxtw70f6coS3lEm3XPVf+curvrWNsVgr2ra5ekTy1527kto39OsKL0vIT77wdW1Wr4f
	Xz3bt/FDdbzgr6a77iGWfo9utzpsM88W/PR41zxd9zynTXPXRU8urhAWzV5wz2zDodVF/5L/
	HMz+K63NEvsk3dqO3S4lac61b1c9qn/9897/99yvR3klK1YuNclUXpIx4WjelsIA+RqWNY3p
	4Uf6s/zrT+4++9Nj74xFT+Y0Wk7/u6qq101EbZKNeNlpi6VaV0pKlFiKMxINtZiLihMBcGMY
	sdICAAA=
X-CMS-MailID: 20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d
References: <CGME20250417042427epcas5p2df3d35803adcb24da7d83e5df586380d@epcas5p2.samsung.com>

ExynosAutov920 SoC supports 18 UART ports, update
the value of UART_NR to accommodate the same.

Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
---
Changes in v3:
- Fixed review comments from Krzysztof
- Link to v2: https://patchwork.kernel.org/project/linux-samsung-soc/patch/20250404135006.1263827-1-faraz.ata@samsung.com/

Changes in v2:
- Rebased on the latest linux-next and added reviewers as per get_maintainer
- Link to v1: https://patchwork.kernel.org/project/linux-samsung-soc/patch/20250312061932.1797993-1-faraz.ata@samsung.com/

 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 210fff7164c1..9a5211b730fb 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -52,7 +52,7 @@
 #define S3C24XX_SERIAL_MINOR	64
 
 #ifdef CONFIG_ARM64
-#define UART_NR			12
+#define UART_NR			18
 #else
 #define UART_NR			CONFIG_SERIAL_SAMSUNG_UARTS
 #endif
-- 
2.34.1

