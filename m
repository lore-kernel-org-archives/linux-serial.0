Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB218F2CB
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578214; cv=none; b=kMicCVJ72ZSS5bRnHRD7clkeXXTSK4TjflV6D70YwEv0KLCF88k/vFt47xmVrdfioSS3nRJhhMk/RjLE2T/heXFJ5ENWwAiOjpGbiVTfdTPZ/LD/PBFavjJnKMi9o905FB/h0iieKlY5EW83WqZiAlC1SvK3HEieLWd5p1IrXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578214; c=relaxed/simple;
	bh=1Ydk+OWiTnXAHwOuMX34qo5U40tky81PZQBs4gDvO7g=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=tqdgoUXEQK83cY5aW3nonSuZuVsXrFI3Gvv8Cmx7RLUhLWd5zja6N7sZYS/QE3o/Wbl1U6/a2MUk/+EkAF3zEpjzh3TZ3s+kGbSbJp2gBWyyGIKIWmae81wgeIZQ/tn7UHsrjg9SWXZVGtHMhur8IWdBSC1Ft7rCyZG3O3rowJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OReSv/02; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OReSv/02"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240605090327epoutp03c173c1f007baa8a161b7cab6c8a84aeb~WEEd9HKcZ0819108191epoutp03Y
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 09:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240605090327epoutp03c173c1f007baa8a161b7cab6c8a84aeb~WEEd9HKcZ0819108191epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717578207;
	bh=1Ydk+OWiTnXAHwOuMX34qo5U40tky81PZQBs4gDvO7g=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=OReSv/02hefZTHnFeuuUX8pa47sDD+OnGNCwF0vG+ItLFat5HLybE+k57nGXi3rH5
	 9qhAZZulidlc8CNx+NgDP/UMjgVYQvEierfK/Vk1UygbUOt0WUoWUAunW9P7i50Tdh
	 eaI1rKSQsXqJHdh40Pp5H1ezty92/qZ1e/LUh4fc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240605090326epcas5p124538737401f364639c29aa6c627870b~WEEdug8cK1283012830epcas5p1A;
	Wed,  5 Jun 2024 09:03:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VvM252P1rz4x9QG; Wed,  5 Jun
	2024 09:03:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.29.19174.CD920666; Wed,  5 Jun 2024 18:03:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240605090323epcas5p4ceef993ef6a017c805687bbaf94a8fa8~WEEbDQY8e0902409024epcas5p4A;
	Wed,  5 Jun 2024 09:03:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240605090323epsmtrp28cef3b2557b53d95927d7fed626dffb4~WEEbCmtov1690916909epsmtrp2n;
	Wed,  5 Jun 2024 09:03:23 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-55-666029dc9085
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.8B.08622.BD920666; Wed,  5 Jun 2024 18:03:23 +0900 (KST)
Received: from INBRO002756 (unknown [107.122.12.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240605090322epsmtip2c40d30d045f5c56fc09af4f3e7cb61a0~WEEZ_oY8r1486814868epsmtip2F;
	Wed,  5 Jun 2024 09:03:22 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Kwanghoon Son'" <k.son@samsung.com>, <krzk@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <20240605040719.160778-1-k.son@samsung.com>
Subject: RE: [PATCH] serial: samsung: Change MAX_CLK_NAME_LENGTH to 17
Date: Wed, 5 Jun 2024 14:33:21 +0530
Message-ID: <033801dab727$3835d2f0$a8a178d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJsKbdffATXsgma7My52wvbWvpMKAFCuxyIsIvjyzA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmuu4dzYQ0g6kfeCyaF69ns3g3V8ai
	d81VJovz5zewW8w4v4/J4sziXnYHNo9NqzrZPPbPXcPu0bdlFaPH501yASxR2TYZqYkpqUUK
	qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
	+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZq+cdZCt4yVdx
	auNitgbGRr4uRk4OCQETidamXexdjFwcQgJ7GCWmPVnABuF8YpRo+POBEaRKSOAbo8TS27Iw
	Hcs3bWKEKNrLKPF++24WCOcFo8SrcxtZQarYBHQldixuYwOxRQR2M0o8+soPYnMKWEgseLOO
	BcQWFnCT+HP0O1MXIwcHi4CKxIS3miBhXgFLiUvLLzFC2IISJ2c+AStnFtCWWLbwNTPEEQoS
	P58uY4UYbyWx5flPVogacYmXR4+AvSMh8JNdYv+xBlaIBheJ6R/6mSBsYYlXx7ewQ9hSEp/f
	7WWDsLMljl+cBWVXSHS3foSqsZfY+egmC8idzAKaEut36UPs4pPo/f0E7HwJAV6JjjYhiGpV
	ieZ3V1kgbGmJid3dUBd4SHyeuwsabt2MEnM617JNYFSYheTNWUjenIXknVkImxcwsqxilEot
	KM5NT002LTDUzUsth0d4cn7uJkZw0tQK2MG4esNfvUOMTByMhxglOJiVRHj9iuPThHhTEiur
	Uovy44tKc1KLDzGaAsN+IrOUaHI+MG3nlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5Ykpqd
	mlqQWgTTx8TBKdXAVGI94TzjE7mIwOCGk5mcFR+T1KJ+FbfIMUSzlVzsCnthtalW6uL2NE2G
	f9ZS6dq3sy5+KAtXVa7d/cTTpyVwZYqXqvonTvZzU6afn5wor9pnqXIrUrwvtp6b45J2An/n
	duHL5Qp3S0N1V0a++JwkfnRClD7rq/q718SP7RCeGzhVnXGu9IlX4dfYtr87scVI4Ubzge6g
	FvudHbYWLcxvv2Z/iV72Pvz9kuYH3vxKb472Cs1i637XJbTm5bTrK464t/i+c6ypY7YLXy7c
	qn7fPmD9MZ6FIsLbJL3Pbmg0+e2t3s/JXM361LlB4p3+xVvf+I/PurhOfm8t+wpLpd2t746p
	JE6cmD7HIyp9SZkSS3FGoqEWc1FxIgDo5iKbIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO5tzYQ0g8YXphbNi9ezWbybK2PR
	u+Yqk8X58xvYLWac38dkcWZxL7sDm8emVZ1sHvvnrmH36NuyitHj8ya5AJYoLpuU1JzMstQi
	fbsErozWmbPYC65wV/zcsJ2xgfEdZxcjJ4eEgInE8k2bGLsYuTiEBHYzSjxaM5cRIiEtcX3j
	BHYIW1hi5b/n7BBFzxglbp87BpZgE9CV2LG4jQ0kISJwkFGisf00VFUno8SZjlusIFWcAhYS
	C96sYwGxhQXcJP4c/c7UxcjBwSKgIjHhrSZImFfAUuLS8kuMELagxMmZT8DKmQW0JXoftjLC
	2MsWvmaGuEhB4ufTZWDjRQSsJLY8/8kKUSMu8fLoEfYJjEKzkIyahWTULCSjZiFpWcDIsopR
	MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhGtLR2MO5Z9UHvECMTB+MhRgkOZiURXr/i
	+DQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamI5IP0u+
	w+rP0iRfdCQljD2Cv8xc3J3L6FPoQe0WfrvprZ+Fp8VK2GX4GzalFsxcs7C8+I+CpsP5G7+u
	FM+bUSvw63uT6vXg+KkdVT5bj641Drxlz+vY01G0TGOy9/TUkP984rdOV5+/eLhf/ELXhKdf
	xL4UbODxdrHOtwt2tq7eHsN8Y0Vt1bsQV+7r1m3WJk1t84x4/ZZy73VeVrnFvaUwfuKK3c94
	tQQNu8tDj0qvaNilpyX6/mLViWhbhvIndfvrd816JHX44ZSjzNNW8Rg3HWyTq2GIarq2b+dW
	gbum8T/qkvYs+b3x4/Jcyb1peyKaul13vN3O8LP8w4wbh95kPTBjE/Oq7P19fFGvEktxRqKh
	FnNRcSIAKwW4yQADAAA=
X-CMS-MailID: 20240605090323epcas5p4ceef993ef6a017c805687bbaf94a8fa8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba
References: <CGME20240605040759epcas1p36d200e262d9a98f9879cf7fd0ee94bba@epcas1p3.samsung.com>
	<20240605040719.160778-1-k.son@samsung.com>



> -----Original Message-----
> From: Kwanghoon Son <k.son=40samsung.com>
> Sent: Wednesday, June 5, 2024 9:37 AM
> To: krzk=40kernel.org; alim.akhtar=40samsung.com; gregkh=40linuxfoundatio=
n.org;
> jirislaby=40kernel.org; linux-samsung-soc=40vger.kernel.org; linux-
> serial=40vger.kernel.org
> Cc: Kwanghoon Son <k.son=40samsung.com>
> Subject: =5BPATCH=5D serial: samsung: Change MAX_CLK_NAME_LENGTH to 17
>=20
> clkname =22clk_uart_baud=22 already 13 byte, so compiler warns
> drivers/tty/serial/samsung_tty.c:1392:17: note: =E2=80=98sprintf=E2=80=99=
=20output=20between=2015=20and=0D=0A>=2017=20bytes=20into=20a=20destination=
=20of=20size=2015=0D=0A=0D=0AThere=20was=20a=20similar=20discussion=20aroun=
d=20buffer=20size=20of=20clkname=20last=20year=0D=0Ahttps://www.spinics.net=
/lists/arm-kernel/msg1039769.html=20=0D=0Aand=20it=20was=20concluded=20that=
=20it=E2=80=99s=20a=20false=20warning=20AFAIR.=20=0D=0A=20=0D=0A=0D=0A>=20=
=0D=0A>=20Signed-off-by:=20Kwanghoon=20Son=20<k.son=40samsung.com>=0D=0A>=
=20---=0D=0A>=20=20drivers/tty/serial/samsung_tty.c=20=7C=202=20+-=0D=0A>=
=20=201=20file=20changed,=201=20insertion(+),=201=20deletion(-)=0D=0A>=20=
=0D=0A>=20diff=20--git=20a/drivers/tty/serial/samsung_tty.c=20b/drivers/tty=
/serial/samsung_tty.c=0D=0A>=20index=20dc35eb77d2ef..cad838ac8aa2=20100644=
=0D=0A>=20---=20a/drivers/tty/serial/samsung_tty.c=0D=0A>=20+++=20b/drivers=
/tty/serial/samsung_tty.c=0D=0A>=20=40=40=20-1339,7=20+1339,7=20=40=40=20st=
atic=20void=20s3c24xx_serial_pm(struct=20uart_port=20*port,=0D=0A>=20unsign=
ed=20int=20level,=0D=0A>=20=20=20*=0D=0A>=20=20=20*/=0D=0A>=20=0D=0A>=20-=
=23define=20MAX_CLK_NAME_LENGTH=2015=0D=0A>=20+=23define=20MAX_CLK_NAME_LEN=
GTH=2017=0D=0A>=20=0D=0A>=20=20static=20inline=20u8=20s3c24xx_serial_getsou=
rce(struct=20uart_port=20*port)=20=20=7B=0D=0A>=20--=0D=0A>=202.39.2=0D=0A=
=0D=0A=0D=0A
