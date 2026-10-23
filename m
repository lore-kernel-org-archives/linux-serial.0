Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747521;
	b=k2p4GTcl7tUDe4bZ4bEc+ChQKdcaTXcgAFjrBaxpB3E8aucXemONbAykCiWqW/DxeTHH
	 UdyOgici+Dqqmsp7c4DfstysSeoxmNWpmoUZUjLMsfCY/+mjAztuds8OfbA2XbRu2Nh/w
	 DUEZPNfqMOEKt1VnhlG0ihyydKxXQWSIm3Do0bGVZaves7F4MOb5GK4oW3hYMBC0BnjSV
	 kiI+wNmjVdgtTVUjkDvstgXrYtrIIsy+JufqEeWn10F4N7Ca9oH1/AzK7Zs9nVnuXXNl7
	 tQ4Vs9C+a6gJiuoW0iTKgRj4zNml+Y4R03qBBtPFjA9JvTnLGYwAFo9Ubm364EOH2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747521;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=oIEbkwx7ah2+2ffXZyS1J4CXUgMzouvAvJm5LIiJGDA=;
	b=OgbcSw3KklJdMnWfF2IAJRC/0IMRLecgQajxZGBcMM9IIvkQqfpX6UBHXZ673iBJclnu
	 yEWOyytZ2qd1U+0FbQYobln+rgDc22tvcbMcBKbfIjdeyiKYd7c3OQzHqqsiEbx/Asa60
	 ic3Gn54AjwgapgKlSSXKLni9S1SPPkwQOfvQx9FvNpcX9WY9xxasbPpEO1RhY8S0Mm+2y
	 FIP//5LjGoicv/zk/Fbug/u+NqH4KGwm1AI8A6XfVpO0JkzaFEpKJJkJKRuKoIR/j1ZEd
	 mBvE/zeg55BNKZmyqEC4iDEO6fhTLERoGGT7iwEzN9UWLxn3PMkgh5w3BQp5dWTs5OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mVvaStjU;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10A606A31D;
	Fri, 23 Oct 2026 09:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E10A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mVvaStjU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=oIEbkwx7ah2+2ffXZyS1J4CXUgMzouvAvJm5LIiJGDA=; b=m
	VvaStjUd121O05QF/sXW2XRsv1pInInC7RWLl6EVhfq4Lqg3CgyjLkb0t8SosWbe
	cfdUL02TOmhoiwM9fIR0jeBwU42SiiADsXPoEUqJWSf5uHyPlX+l4c/x07VTFtcQ
	eOMYQ8XpRdUTa9x6go/VTGR7wivfXO5xSMuxYxO+8o=
Date: Fri, 23 Oct 2026 17:24:48 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: longzhao@ambarella.com,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	"Linus Walleij" <linusw@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	"Conor Dooley" <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <a9e45c44-00ae-4963-b8e5-dbf6ffa18975@kernel.org>
References: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
 <20261009-cv75-uart-v1-1-38c098efaa99@ambarella.com>
 <a9e45c44-00ae-4963-b8e5-dbf6ffa18975@kernel.org>
X-NTES-SC: AL_Qu2SAPufuEwj7iaebOkdnUoTj+Y/XMK0uvwk1YdVc/AElgPJ5AIGWXJHHmDEwu6+JAWAnwm7fhJQ+t94fJJe8au8lFxeOm3+sz/3+JE9Rg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <6883d29c.81aa.1a16813c5a6.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgDnrzjgJ9tqOzJfAA--.2322W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7gCTBWrbJ+Cv6gAA3L
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTAtMDkgMTk6MjY6MzIsICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6a0BrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIDA5LzEwLzIwMjYgMTI6NTksIExvbmcgWmhhbyB2aWEgQjQgUmVs
YXkgd3JvdGU6Cj4+IEZyb206IExvbmcgWmhhbyA8bG9uZ3poYW9AYW1iYXJlbGxhLmNvbT4KPj4g
Cj4+IEFkZCB0aGUgQW1iYXJlbGxhIENWNzUgY29tcGF0aWJsZSBzdHJpbmcgdG8gdGhlIFN5bm9w
c3lzIERXIEFQQiBVQVJUCj4+IGJpbmRpbmcuIFRoZSBibG9jayBpcyBBbWJhcmVsbGEgSVAgd2l0
aCBhIERXLWxpa2UgcmVnaXN0ZXIgbWFwLCBzbyBpdAo+PiBpcyBkZXNjcmliZWQgYXMgYSBEVyBB
UEIgVUFSVCB2YXJpYW50Lgo+PiAKPj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IExpbnVz
IFdhbGxlaWogPGxpbnVzd0BrZXJuZWwub3JnPgo+PiBTaWduZWQtb2ZmLWJ5OiBMb25nIFpoYW8g
PGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+Cj4+IC0tLQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NlcmlhbC9zbnBzLWR3LWFwYi11YXJ0LnlhbWwgfCAxICsKPj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc25wcy1kdy1hcGItdWFydC55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9zbnBzLWR3LWFwYi11YXJ0Lnlh
bWwKPj4gaW5kZXggNDlmNTFiMDAyODc5Li5jZWM1YzY3OWYxYTkgMTAwNjQ0Cj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc25wcy1kdy1hcGItdWFydC55
YW1sCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc25w
cy1kdy1hcGItdWFydC55YW1sCj4+IEBAIC01MSw2ICs1MSw3IEBAIHByb3BlcnRpZXM6Cj4+ICAg
ICAgICAgICAgLSBjb25zdDogcmVuZXNhcyxyem4xLXVhcnQKPj4gICAgICAgIC0gaXRlbXM6Cj4+
ICAgICAgICAgICAgLSBlbnVtOgo+PiArICAgICAgICAgICAgICAtIGFtYmFyZWxsYSxjdjc1LXVh
cnQKPgo+Cj5UaGlzIGRlcGVuZHMgb24gdmVuZG9yIHByZWZpeCBwYXRjaCBhdCBsZWFzdCBmcm9t
IG5leHQgcG9pbnQgb2Ygdmlldy4KPgo+QmVzdCByZWdhcmRzLAo+S3J6eXN6dG9mCgpIaSBLcnp5
c3p0b2YsIEdyZWcsIEppcmksCgpHZW50bGUgcGluZyBvbiB0aGlzIHNlcmllcy4KClRoZSBhbWJh
cmVsbGEgcHJlZml4IGlzIGluIGxpbnV4LW5leHQgbm93LgpUaGUgZHJpdmVyIHBhdGNoIGFscmVh
ZHkgaGFzIFItYiBmcm9tIExpbnVzIFdhbGxlaWosIEFuZHkgYW5kIElscG8uCgpQbGVhc2UgbGV0
IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLgoKQmVzdCByZWdhcmRzLApMb25nIFpo
YW8=
