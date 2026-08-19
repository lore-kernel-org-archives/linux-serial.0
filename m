Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F0437475;
	Wed, 19 Aug 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131389; cv=none; b=Iec6zNPViqixUwgLfNXni/ld191Givy5gM5IN63+4GKMKwLl8WkJp9L3cCkfcfo04mO3tFsytcR96wuV5nKnwqZGpFN51fp+tPy1eDWgHhZ4CEx3dP22WarGZzhuv70zuHC6znvgZ3G3ntXMa7yGlrIdB7SJf35oZvt+EGSMiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131389; c=relaxed/simple;
	bh=hW9Q1qCU51uLoqGiIqveU5bfYzn6cKDutLnmgvwQB6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XseODOXGynMVYc4llk2el8P+KS4gwyzYeFXa3K62y4OdiPV2AmZXBaEDvd08nt4sZCrDC4UvlXl3Osm0dCmhU19MnnnTAdSxO1FTceelejM6b0rXhv1QcC4HMLKvSpu5v8Moj9xV/5NsT4IQd62nwy8BLnlOfNIcUjYub0MGqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I27e0VvL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I27e0VvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hW9Q1qCU51uLoqGiIqveU5bfYzn6cKDutLnmgvwQB6c=; b=I
	27e0VvLiHoNyExGGtGLRmOU8awvyYTqlIRisIeg/Z3evZMdpoboDdFJ4KFS1/Glp
	q00CnKIsM0MUmkBTc2PtMN3DgD1gWK+gtyfunhwWruXj0fSquDHC5ch9ONY4Tey7
	cIMrnDN4FlByECiUTc1/WDQH5UCprvAb3zUCe69eHY=
Received: from zl020895$163.com ( [180.169.129.163] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Wed, 19 Aug 2026 17:21:09 +0800
 (CST)
Date: Wed, 19 Aug 2026 17:21:09 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: longzhao@ambarella.com, "Arnd Bergmann" <arnd@arndb.de>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Linus Walleij" <linusw@kernel.org>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Brian Masney" <bmasney@redhat.com>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: Re:Re: [PATCH v5 02/12] dt-bindings: mfd: syscon: add Ambarella
 CV75 secure scratchpad
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <6c8471ad-8d68-42d9-bc61-83968a2e8acd@kernel.org>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-2-7bbb12f0360f@ambarella.com>
 <6c8471ad-8d68-42d9-bc61-83968a2e8acd@kernel.org>
X-NTES-SC: AL_Qu2TBf2Yvkot7yWYYelS6DN615F8O5rMxLRDmdYrY+8JiBnj2hsZf1x6Flza4t6Q947My16VWDGwcqobvXWK
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d8af3ba.7360.1a01953118f.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgDnD+yGdYVqpvQ0AA--.8191W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgZ662qFdYbyuwAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

UmVzZW5kIHRoaXMgZHVlIHRvIHdyb25nIEhUTUwgZm9ybWF0IGJlZm9yZS4KCkhpIEtyenlzenRv
ZiwKClNvcnJ5IGZvciByZXNlbmRpbmcgd2l0aG91dCBhbiBvbi1saXN0IHJlcGx5LgoKSSB0cmVh
dGVkIHRoZSBjb3ZlciBsZXR0ZXIgYXMgZW5vdWdoOiB2MiBhc2tlZCB0byBkcm9wIHRoZSBzZXBh
cmF0ZQpiaW5kaW5nIGFuZCBwdXQgdGhlIGNvbXBhdGlibGUgaW4gc3lzY29uLnlhbWwsIHdoaWNo
IHYzL3Y1IGFscmVhZHkKZGlkLiBTYXNoaWtvIHRoZW4gYXNrZWQgdG8gYWxzbyBhZGQgaXQgdG8g
YSBzZWxlY3QgZW51bS4gSSB0aG91Z2h0CnRoYXQgd2FzIGEgZmFsc2UgcG9zaXRpdmUgoaogY3Vy
cmVudCBzeXNjb24ueWFtbCBoYXMgbm8gc3VjaCBzZWxlY3Q7Cm1hdGNoaW5nIGlzIGluIHN5c2Nv
bi1jb21tb24ueWFtbCB2aWEgdGhlICJzeXNjb24iIGZhbGxiYWNrIKGqIHNvIEkKZGlkIG5vdCBy
ZXBseS4KCkkgYW0gbmV3IHRvIHRoaXM6IGlmIEkgdGhpbmsgYSBTYXNoaWtvIGNvbW1lbnQgaXMg
YSBmYWxzZSBwb3NpdGl2ZSwKc2hvdWxkIEkgcmVwbHkgb24gdGhlIHBhdGNoIHRocmVhZCB3aXRo
IHRoZSByZWFzb24gYW5kIHdhaXQsIHJhdGhlcgp0aGFuIG9ubHkgbWVudGlvbmluZyBpdCBpbiB0
aGUgY292ZXIgbGV0dGVyPwoKSWYgSSBzdGlsbCBtaXNzZWQgc29tZXRoaW5nLCBJIHdpbGwgZml4
IGl0IGluIHY2LgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDgtMTkgMDM6Mjc6
MDcsICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToKPk9uIDE4
LzA4LzIwMjYgMTI6MzEsIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4+IEZyb206IExv
bmcgWmhhbyA8bG9uZ3poYW9AYW1iYXJlbGxhLmNvbT4KPj4gCj4+IEFsbG93IGFtYmFyZWxsYSxj
djc1LXNlYy1zY3JhdGNocGFkIGFzIGEgc3lzY29uIGZvciB0aGUgc2hhcmVkIHNlY3VyZQo+PiBz
Y3JhdGNocGFkIHJlZ2lzdGVycyBvbiBDVjc1Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogTG9uZyBa
aGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPgo+Cj5Zb3UgYWxyZWFkeSByZWNlaXZlZCByZXZp
ZXcgYXQgdjIgd2hpY2ggeW91IGRpZCBub3QgcmVzcG9uZCB0byBhbmQgZGlkCj5ub3QgaW1wbGVt
ZW50Lgo+Cj5CZXN0IHJlZ2FyZHMsCj5Lcnp5c3p0b2YK
