Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F854657
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 04:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560490; cv=none; b=sd1Vn/69dO8iUy9vDVTe9w6+/r9CRjavh8Y/QFV3TIGIXeu5XeN3KMjz9xYmb5SDA/RNHD9qimKJhBgj1RYRk1QQPMnbr2GGT6JYh9QXehmoXoyBtPAWw0+In6SZEqHMM6ys30H4gRCaOnPlXa6RbDBYjDKm4aBOJ+MBc/gOYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560490; c=relaxed/simple;
	bh=Gylef4GcXPhQHxtq8zlE827XXS4oEjoA2fA2JFBSqf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NziQLf6Q8v47prk8jF/OVoUhx2NYx9UxQseyIs7LG2e//9F7P2+xEk49nHQHDG2fIsySqVExUKdAwt3TFFjJxJEcGtFvthOFSt/OLytz1xiYnMgTkasPZWjHsTnmPw7d+Uj67cuOeHH+HSNS44V8fkoFk0o+4fZIN5d2gf5BAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B7UohmVL; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B7UohmVL"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240605040801epoutp0297035fbf6496552f421104f11ce86241~WAChoMUQ91964019640epoutp02M
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 04:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240605040801epoutp0297035fbf6496552f421104f11ce86241~WAChoMUQ91964019640epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717560481;
	bh=eKuGQnMat5M3+u0vPMOYAf7NolpbbN6olPjo1mZERy0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=B7UohmVLB0OY3i0wJl8304Uh1sYD/ZLt0PBhHuER32bP0JGzpmx86jLIR6YgcowC0
	 TfLeISsi3x1nS6uv/A44hvsM8JfilWej1gSUKoL/3kcVFMqMbVg/8zB96leKjIjaUt
	 ohrR0trSfFmxPLeuMB2X/jLwh0LN5r6PJtUBmfRs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240605040801epcas1p4c8e9ccfb78ef3f07ec7951c99582660a~WAChT35bQ1980319803epcas1p4a;
	Wed,  5 Jun 2024 04:08:01 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.234]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VvDTD3P4yz4x9QJ; Wed,  5 Jun
	2024 04:08:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.D0.19059.0A4EF566; Wed,  5 Jun 2024 13:08:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba~WACgR0Ozu1676116761epcas1p3V;
	Wed,  5 Jun 2024 04:07:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240605040759epsmtrp18fb56ae248568c5aea09d6e6d776f754~WACgRMGC50471504715epsmtrp15;
	Wed,  5 Jun 2024 04:07:59 +0000 (GMT)
X-AuditID: b6c32a4c-e6fff70000004a73-54-665fe4a0c417
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.18.08336.F94EF566; Wed,  5 Jun 2024 13:07:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.204]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240605040759epsmtip26314e25484e240b2563186566e0ef1d1~WACgD7DdK2983129831epsmtip22;
	Wed,  5 Jun 2024 04:07:59 +0000 (GMT)
From: Kwanghoon Son <k.son@samsung.com>
To: krzk@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Kwanghoon Son <k.son@samsung.com>
Subject: [PATCH] serial: samsung: Change MAX_CLK_NAME_LENGTH to 17
Date: Wed,  5 Jun 2024 13:07:19 +0900
Message-Id: <20240605040719.160778-1-k.son@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmvu6CJ/FpBoumilk8mLeNzaJ58Xo2
	i3dzZSx611xlsjh/fgO7xYzz+5gszizuZXdg99i0qpPNY//cNewefVtWMXp83iQXwBKVbZOR
	mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
	KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj8PNz
	LAWL2SreX+dsYFzD2sXIySEhYCLxYtcf5i5GLg4hgT2MEpMnbINyPjFKHNz5jwXC+cYoce3U
	RhaYlvVnljCB2EICexkl/jaVQBR9YZSYumwHM0iCTUBdYknbWnaQhIjAYkaJF5fngnUwC6hK
	dO/rBbOFBZwkNu2+CnYIC1D8zLXrQM0cHLwC5hLb59SAmBIC8hKLH0iAVPAKCEqcnPmEBWKK
	vETz1tlgl0oIXGOXuP7hL9Q/LhL7v+yHOlRY4tXxLewQtpTEy/42KDtb4ujHvWwQdonE9VmL
	oHqNJfYvncwEspdZQFNi/S59iF18Eu++9rBCnMMr0dEmBHPZrc5yiEZRiTNPP0IN9JD4PHcX
	IyR0YiW2fPvOOIFRbhaSB2YheWAWwq4FjMyrGKVSC4pz01OTDQsMdfNSy+ExmZyfu4kRnPC0
	fHYwfl//V+8QIxMH4yFGCQ5mJRFev+L4NCHelMTKqtSi/Pii0pzU4kOMpsBAncgsJZqcD0y5
	eSXxhiaWBiZmRsYmFoZmhkrivGeulKUKCaQnlqRmp6YWpBbB9DFxcEo1MFVNPW6n53DnpPnp
	CDPhevUnMUpl55yOc36Ofn64Lvxhz7sp6X1Vq0r//FW2N579Mqk0aL629qOJvxSmzNxnp/Al
	PvNKxabw0uVVx/Zv7eg6K+vU1v/6ioneQstHvtWx5XeOHnsRzPE3/0TJ8dbAWT9Pn1eaeex8
	4cdbBmcbnG8rpU3fUCMtOuHB0X+LXE/rqaS5uT9LmSliqcR3yPvb0d0/HQJM5nstuDo/5kCI
	4Xrn5aef7sn7uo1/wuZZM5fZT+LhmqJh6G14VEHhT0To7w3aqmKRppfnMjJnLXl/cBHb3rz5
	Gd2B8+8zHqvuuC/y3PxOs796xnXXQ/NV9riHiLZq/vBSs+aYnq5nYjTVMlaJpTgj0VCLuag4
	EQASC1EuAQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvO78J/FpBtdPW1g8mLeNzaJ58Xo2
	i3dzZSx611xlsjh/fgO7xYzz+5gszizuZXdg99i0qpPNY//cNewefVtWMXp83iQXwBLFZZOS
	mpNZllqkb5fAlXH4+TmWgsVsFe+vczYwrmHtYuTkkBAwkVh/ZglTFyMXh5DAbkaJQ+8vMEIk
	RCU6LjcC2RxAtrDE4cPFEDWfGCU+fF8E1swmoC6xpG0tO0hCRGAlo8S2ezfZQRLMAqoS3ft6
	mUBsYQEniU27r4I1sADFz1y7zgwylFfAXGL7nBqI+fISix9IgFTwCghKnJz5hAUkzAw0fv08
	IYiB8hLNW2czT2Dkn4WkahZC1SwkVQsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+du
	YgQHsJbmDsbtqz7oHWJk4mA8xCjBwawkwutXHJ8mxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8
	RW+KkEB6YklqdmpqQWoRTJaJg1OqgSnAzTjn0LMnmUwqke8MHackHTu3VrpwetmrfskQndte
	n9dpnt2UZn3G4o7gulKHqr9+omqKbzVFQ1z+8QeUHujU+nzyWd2jlHChH+fmT/1y4NQ0048d
	03RNgsz/sumJNPWtE7M3KXnT2nbiTwPb0aIw0fTfT8XWrnv5qGm7qUbc+2S5qHkzmvQmJC25
	tzvg4KUPd9/Z5GTF7fqepmyXuTJP4+PWR4ICu24mpD7gehbZJnZZdIsn07mToXNyhFmnzvKt
	ks5eLHdp2fzTtkLPTumfmbv5uHnQuy0Lv6pNKJJaxT/36T+BLMZT27+9u3xAJDove0m5Hov2
	o/WRIV0t7E6z1oj/lXZnPr5EvStEpVeJpTgj0VCLuag4EQBdKdlOzwIAAA==
X-CMS-MailID: 20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba
References: <CGME20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba@epcas1p3.samsung.com>

clkname "clk_uart_baud" already 13 byte, so compiler warns
drivers/tty/serial/samsung_tty.c:1392:17: note: ‘sprintf’ output between 15 and 17 bytes into a destination of size 15

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index dc35eb77d2ef..cad838ac8aa2 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1339,7 +1339,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
  *
  */
 
-#define MAX_CLK_NAME_LENGTH 15
+#define MAX_CLK_NAME_LENGTH 17
 
 static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
 {
-- 
2.39.2

