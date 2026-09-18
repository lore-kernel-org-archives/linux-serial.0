Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A743C942C;
	Fri, 18 Sep 2026 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720474; cv=none; b=sxVyNqOjivV9OwqL9KoGYFOMQBBjBtPcnMLo6Z7/5yl3w98qhlUz4BQprkq3rzZOdZLV58AVyy0jcE1/72GDuvwOPBJnamzU9YuBsisOumUnbOYFyG1GOHKmPc866hw20X6J6fNXPPXynIHcVxhxpfLGmCaB+mbLG0kfydyIWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720474; c=relaxed/simple;
	bh=A+U9NeyCw2uUc/iR5VKPiZXuak/wBBYadp2bG6uegDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WJBu+yxNAPUpOqTHSWgY9QTfgm4Si2UHH1Ih1BedTszJE6HD2lPe7+V6Yp1oK1LZM3G6N41vLbrBDP7YQs+uDVH0Xb0E9Q9iUi6pNeU4SSVQXSgAYjyFZX7kNLLzBbTYxHpwfEbKVge2LmPg92/E+gcwjpHnDwl07YqFIwUYD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W60BaHoP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W60BaHoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=A+U9NeyCw2uUc/iR5VKPiZXuak/wBBYadp2bG6uegDY=; b=W
	60BaHoParjrLUjIpIbGTR86wL4FMUqI3CTHzYhLCuakgAEm7b2KGZOm9QxFHF7Q7
	nHMIP9B++Yf+DQVScw6asQW8f0C+zb40TNbLN+M02ux7nmA28szYUxuyAuIekado
	TemWxt/GPOCYizg7vocTYzkUhIV8ljZsSBbhC87j/U=
Date: Fri, 18 Sep 2026 16:33:13 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Long Zhao" <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Linus Walleij" <linusw@kernel.org>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v7 05/15] dt-bindings: gpio: pl061: add Ambarella
 CV75 variant
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260918-affable-aardvark-of-superiority-6a5ed2@quoll>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-5-3297d3fbc9c0@ambarella.com>
 <20260918-affable-aardvark-of-superiority-6a5ed2@quoll>
X-NTES-SC: AL_Qu2TC/uZv0si5SebYOkcn0wRhug/UMa4u/sm3YNXc+4EmTLm2QYGZWdKNl/tzP+PED+yqxGsciBy6c5ic7Z9DiZ4Z4Mjf+qV5QMl6Un47w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <258a5ebc.76e6.1a0b3a5f810.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aSgvCgBnH7lJ96xqT21HAA--.51648W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7QnVR2qs90mJ9AAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LCB3aWxsIGZpeCB0aGUgY29tbWl0
IG1lc3NhZ2UgYW5kIFlBTUwgb3JkZXIgaW4gdjguCgpUaGUgQU1CQSBjb3JlIG1hdGNoZXMgdGhl
IFBMMDYxIGRyaXZlciBieSBQcmltZUNlbGwgSUQsIG5vdCBieSB0aGUgRFQgY29tcGF0aWJsZSBz
dHJpbmcuIFRoZXNlIGJhbmtzIGRvIG5vdCBpbXBsZW1lbnQgdGhlIHN0YW5kYXJkIFBMMDYxIElE
ICgweDAwMDQxMDYxKSwgc28gYXJtLHByaW1lY2VsbC1wZXJpcGhpZCBtdXN0IGJlIHNldDsgMHgw
MDBlODA2MSBpcyB0aGUgSUQgdGhlIGRyaXZlciB1c2VzIGZvciB0aGUgQW1iYXJlbGxhIGxheW91
dC4KClRoZXkgc2l0IG9uIHRoZSBQcmltZUNlbGwgYnVzIGJ1dCBhcmUgbm90IHJlZ2lzdGVyLWNv
bXBhdGlibGUgd2l0aCBhcm0scGwwNjEgKDMyLWJpdCwgMzIgbGluZXMsIGV4dHJhIG1hc2svZW5h
YmxlKSwgc28gYXJtLHBsMDYxIGlzIG5vdCBhIGZhbGxiYWNrLiBJIHdpbGwgc3BlbGwgdGhhdCBv
dXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgoKYWxsT2Ygd2lsbCBtb3ZlIGFmdGVyIHRoZSByZXF1
aXJlZDogYmxvY2suCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoKQXQgMjAyNi0wOS0xOCAxNTox
NToyMSwgIktyenlzenRvZiBLb3psb3dza2kiIDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOgo+T24g
VHVlLCBTZXAgMTUsIDIwMjYgYXQgMDc6MTU6MzVQTSArMDgwMCwgTG9uZyBaaGFvIHdyb3RlOgo+
PiBBZGQgYW1iYXJlbGxhLGN2NzUtZ3BpbyBhcyBhIFByaW1lQ2VsbC1jb21wYXRpYmxlIFBMMDYx
IHZhcmlhbnQsIHdpdGgKPj4gYXJtLHByaW1lY2VsbC1wZXJpcGhpZCBhbmQgZ3Bpby1yYW5nZXMg
cmVxdWlyZWQuIFJlZmVyZW5jZQo+Cj5Zb3UganVzdCBkZXNjcmliZWQgdGhlIGRpZmYsIGJ1dCB0
aGlzIHNob3VsZCBleHBsYWluIHdoeSB5b3UgZG8gdGhlc2UKPmNoYW5nZXMuIFdoeSBhIGZpeGVk
IHBlcmlwaGlkIGlzIG5lZWRlZD8gSXNuJ3QgaXQgaW1wbGllZCBieSBjb21wYXRpYmxlPwo+Cj4+
IHByaW1lY2VsbC55YW1sIGFuZCB1c2UgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzLgo+PiAKPj4gU2ln
bmVkLW9mZi1ieTogTG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPgo+PiAtLS0KPj4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vcGwwNjEtZ3Bpby55YW1sICAgICAgIHwgMjUg
KysrKysrKysrKysrKysrKysrKy0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwaW8vcGwwNjEtZ3Bpby55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwaW8vcGwwNjEtZ3Bpby55YW1sCj4+IGluZGV4IDRkOTcwZTU1MTA0
Yi4uMDBkMGQ4ZGRkMmM5IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZ3Bpby9wbDA2MS1ncGlvLnlhbWwKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwaW8vcGwwNjEtZ3Bpby55YW1sCj4+IEBAIC0xNSwxNyArMTUsMzYg
QEAgc2VsZWN0Ogo+PiAgICBwcm9wZXJ0aWVzOgo+PiAgICAgIGNvbXBhdGlibGU6Cj4+ICAgICAg
ICBjb250YWluczoKPj4gLSAgICAgICAgY29uc3Q6IGFybSxwbDA2MQo+PiArICAgICAgICBlbnVt
Ogo+PiArICAgICAgICAgIC0gYXJtLHBsMDYxCj4+ICsgICAgICAgICAgLSBhbWJhcmVsbGEsY3Y3
NS1ncGlvCj4+ICAgIHJlcXVpcmVkOgo+PiAgICAgIC0gY29tcGF0aWJsZQo+PiAgCj4+ICthbGxP
ZjoKPgo+YWxsT2Ygc2hvdWxkIGJlIHBsYWNlZCBhZnRlciAicmVxdWlyZWQ6IiBibG9jay4KPgo+
PiArICAtICRyZWY6IC9zY2hlbWFzL2FybS9wcmltZWNlbGwueWFtbCMKPj4gKyAgLSBpZjoKPj4g
KyAgICAgIHByb3BlcnRpZXM6Cj4+ICsgICAgICAgIGNvbXBhdGlibGU6Cj4+ICsgICAgICAgICAg
Y29udGFpbnM6Cj4+ICsgICAgICAgICAgICBjb25zdDogYW1iYXJlbGxhLGN2NzUtZ3Bpbwo+PiAr
ICAgIHRoZW46Cj4+ICsgICAgICBwcm9wZXJ0aWVzOgo+PiArICAgICAgICBhcm0scHJpbWVjZWxs
LXBlcmlwaGlkOgo+PiArICAgICAgICAgIGNvbnN0OiAweDAwMGU4MDYxCj4+ICsgICAgICByZXF1
aXJlZDoKPj4gKyAgICAgICAgLSBhcm0scHJpbWVjZWxsLXBlcmlwaGlkCj4+ICsgICAgICAgIC0g
Z3Bpby1yYW5nZXMKPj4gKwo+PiAgcHJvcGVydGllczoKPj4gICAgJG5vZGVuYW1lOgo+PiAgICAg
IHBhdHRlcm46ICJeZ3Bpb0BbMC05YS1mXSskIgo+PiAgCj4+ICAgIGNvbXBhdGlibGU6Cj4+ICAg
ICAgaXRlbXM6Cj4+IC0gICAgICAtIGNvbnN0OiBhcm0scGwwNjEKPj4gKyAgICAgIC0gZW51bToK
Pj4gKyAgICAgICAgICAtIGFtYmFyZWxsYSxjdjc1LWdwaW8KPj4gKyAgICAgICAgICAtIGFybSxw
bDA2MQo+Cj5TbyBhIFByaW1lQ2VsbC1jb21wYXRpYmxlIFBMMDYxIHZhcmlhbnQgd2hpY2ggaXMg
bm90IGNvbXBhdGlibGUgd2l0aAo+UEwwNjE/IFlvdSBoYXZlIGVudGlyZSBjb21taXQgbXNnIHRv
IGV4cGxhaW4gdGhhdCBhbmQgc2F5IHNvbWV0aGluZwo+bm9uLW9idmlvdXMgYWJvdXQgdGhlIGhh
cmR3YXJlLgo+Cj4+ICAgICAgICAtIGNvbnN0OiBhcm0scHJpbWVjZWxsCj4+ICAKPgo+QmVzdCBy
ZWdhcmRzLAo+S3J6eXN6dG9mCg==
