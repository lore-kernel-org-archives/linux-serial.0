Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEB4F7997;
	Tue, 13 Oct 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902224; cv=none; b=IZMBhtxYZFv6tRA9LgEFH8TNEWYHKAG+mcrbCFO5DOqxzcq+yE6lfTSZpwcjf0N4uxW+b9uoWsGiz1MdxoloKTuFuLg9FyKpJVnYVAdw1P2avZH9yU6DQCJY9N3mlB6tti5EwNnq67t910Fjk7Mh6jy6syEi9MW4AgLJdZ6qyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902224; c=relaxed/simple;
	bh=kNn8WAD/z/ZpM3QZ3VuE/IiEH4+BojK9Q7ut6WpHzeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KnUQmxGa4XMYcW1p+onVZGvJWzbzv+vDRfYV3wbMl3WBZtrKtnW1MSvlmBgTPWhMy2OXHJkNCumzb1zaIZY7HwvJkj3eBFbNJNbQC/KYsvuGedy750bNIyEWpfzLmbND5x8vLuNXOCGHyOCUHIa5ErCXV3ZkKE+Y7c5ac2RvIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UUHXAkTA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UUHXAkTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kNn8WAD/z/ZpM3QZ3VuE/IiEH4+BojK9Q7ut6WpHzeg=; b=U
	UHXAkTACV9Ia7TC5OqFyzxf85WOEEMfpc9Qd76MWONAtJAw8HOnllf7GzEWhMZh9
	dwXXgTfpeA9s9MHgTNuWfKsU9XS7lL0mugzzpPvukNgmvgm8rVPxIHcDamCLlRRu
	/P/F3Lx9TTaJykuOylg1XI8pZuKx4dZWUqHAMOsRsE=
Date: Tue, 13 Oct 2026 22:35:27 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Linus Walleij" <linusw@kernel.org>, longzhao@ambarella.com,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re:Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75
 pinctrl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <56dc6c05-7fd6-43de-bc62-c353ae1dbcc3@kernel.org>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
 <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org>
 <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
 <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org>
 <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
 <56dc6c05-7fd6-43de-bc62-c353ae1dbcc3@kernel.org>
X-NTES-SC: AL_Qu2SA/WbvUkp4SSQZukdnUoTj+Y/XMK0uvwk1YdVc84FkSfp3wMjT35qOEXs9/qoFCWqvTu+SwFvxuB9c7JXVw4GgELw3hqsIakKQoG/Mw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <54b55ad7.9d3a.1a135b09587.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgD3f2qvQc5qnCghAA--.83W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7g-JO2rOQa9TXQAA3X
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgS3J6eXN6dG9mLCBMaW51cywKClNvcnJ5IGZvciB0aGUgbWVzcy4gCgpXb3VsZCB0aGlzIHdv
cms/OiBJIHNlbmQgYSBzdGFuZGFsb25lCiJkdC1iaW5kaW5nczogdmVuZG9yLXByZWZpeGVzOiBh
ZGQgQW1iYXJlbGxhIiBwYXRjaCB0byBSb2Igd2l0aCBvbmx5CnRoZSB0d28gbGluZXMgaW4gdmVu
ZG9yLXByZWZpeGVzLnlhbWwsIGFuZCBkcm9wIHRoYXQgaHVuayBmcm9tIHRoZQpTb0Mgc2VyaWVz
LiBPbmNlIHRoZSBwcmVmaXggaXMgaW4gbGludXgtbmV4dCwgdGhlIHZlbmRvci1wcmVmaXgKd2Fy
bmluZ3Mgc2hvdWxkIGJlIGZpeGVkLiBUaGUgcmVtYWluaW5nIGV4YW1wbGUgbWF0Y2hlcywgc3Vj
aCBhcwphbWJhcmVsbGEsZHJpdmUtc3RyZW5ndGgtc3lzY29uLCBzdGlsbCBuZWVkIHRoZSBzZXBh
cmF0ZQpHUElPL1VBUlQvcGluY3RybCBiaW5kaW5ncy4KCkJlc3QgcmVnYXJkcywKTG9uZyBaaGFv
CgpBdCAyMDI2LTEwLTEzIDE3OjIyOjU2LCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyemtAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj5PbiAxMy8xMC8yMDI2IDEwOjQ0LCBMaW51cyBXYWxsZWlqIHdyb3Rl
Ogo+PiBPbiBNb24sIE9jdCAxMiwgMjAyNiBhdCA5OjA44oCvQU0gS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToKPj4+IE9uIDEyLzEwLzIwMjYgMDk6MDYsIExpbnVz
IFdhbGxlaWogd3JvdGU6Cj4+Pj4gT24gRnJpLCBPY3QgOSwgMjAyNiBhdCA4OjE34oCvQU0gS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToKPj4+Pj4gT24gMDEvMTAv
MjAyNiAwOTowMywgTGludXMgV2FsbGVpaiB3cm90ZToKPj4+Pgo+Pj4+Pj4gT24gTW9uLCBTZXAg
MjEsIDIwMjYgYXQgNjoyM+KAr0FNIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkKPj4+Pj4+IDxkZXZu
dWxsK2xvbmd6aGFvLmFtYmFyZWxsYS5jb21Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+Pj4+Pgo+Pj4+
Pj4+IEZyb206IExvbmcgWmhhbyA8bG9uZ3poYW9AYW1iYXJlbGxhLmNvbT4KPj4+Pj4+Pgo+Pj4+
Pj4+IERvY3VtZW50IHRoZSBDVjc1IHBpbiBjb250cm9sbGVyIGJpbmRpbmcgdXNpbmcgZ2VuZXJp
YyBmdW5jdGlvbiBhbmQKPj4+Pj4+PiBncm91cHMgcHJvcGVydGllcyBmb3IgcGlubXV4IGNvbmZp
Z3VyYXRpb24uCj4+Pj4+Pj4KPj4+Pj4+PiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGlu
dXN3QGtlcm5lbC5vcmc+Cj4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kg
PGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4KPj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gVGhp
cyBwYXRjaCA0LzE4IGFwcGxpZWQgdG8gdGhlIHBpbmN0cmwgdHJlZS4KPj4+Pj4KPj4+Pj4gVGhl
cmUgaXMgYSBkZXBlbmRlbmN5LCB5b3UgY2Fubm90IHRha2UgdGhpcyBwYXRjaCBhbG9uZS4KPj4+
Pgo+Pj4+IE9vcHMsIGJ1dCBpcyBpdCBhIERUUyBkZXBlbmRlbmN5IHNvIGlmIG5vbmUgb2YgdGhl
IG90aGVyIHBhdGNoZXMgZ28gaW4gdGhyb3VnaAo+Pj4KPj4+IE5vLCBpdCBpcyBhIGJpbmRpbmdz
IGRlcGVuZGVuY3ksIGludHJvZHVjaW5nIG5ldyBEVCBiaW5kaW5ncyB3YXJuaW5nIGZvcgo+Pj4g
Ym90aCB5b3VyIHRyZWUgYW5kIG5leHQuCj4+IAo+PiBJcyB0aGVyZSBhIHByb2JsZW0gd2l0aCB0
aGUgYmluZGluZ3MgcGF0Y2ggaXRzZWxmPwo+PiAKPj4gSW4gdGhhdCBjYXNlIExvbmcgY2FuIGp1
c3Qgc2VuZCBhbiBpbmNyZW1lbnRhbCBwYXRjaCB0bwo+PiBmaXggaXQgcmlnaHQ/Cj4+IAo+Pj4g
WW91ciB0cmVlIGlzIGZpbmUgaW4gdGhpcyBjYXNlIGFzIGxvbmcgYXMgbmV4dAo+Pj4gaXMgYWxz
byBmaW5lLi4uIGJ1dCBuZXh0IGlzIG5vdCwgYmVjYXVzZSB0aGF0IHBhdGNoIGRpZCBub3QgbWFr
ZSBpdCB0aGVyZS4KPj4gCj4+IEJ1dCB0aGUgcGF0Y2ggaXMgaW4gLW5leHQ/Cj4+IAo+PiB+L2xp
bnV4LW5leHQkIGxzCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJs
L2FtYmFyZWxsYSxjdjc1LXBpbmN0cmwueWFtbAo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGluY3RybC9hbWJhcmVsbGEsY3Y3NS1waW5jdHJsLnlhbWwKPj4gCj4+PiBXZSBj
YW5ub3QgaGF2ZSBhbnkgbmV3IERUIGJpbmRpbmdzIHdhcm5pbmdzIGluIG5leHQuCj4+IAo+PiBJ
IGd1ZXNzIEkganVzdCBkb24ndCBnZXQgaXQgOkQKPj4gCj4+IFRvIG1lIGl0IHNlZW1zIGxpa2Ug
YSBmYWlybHkgbm9ybWFsIHNpdHVhdGlvbjogQUNLZWQgYmluZGluZ3MgbWVyZ2VkCj4+IHRvZ2V0
aGVyIHdpdGggdGhlIGRyaXZlciwgbm8gZGVwZW5kZW5jZSBvbiBhbnl0aGluZy4KPgo+QnV0IHRo
ZXJlIGlzIGEgZGVwZW5kZW5jeS4gWW91ciBjb21taXQgdXNlcyB1bmRvY3VtZW50ZWQgdmVuZG9y
IHByZWZpeAo+d2hpY2ggaW50cm9kdWNlcyB3YXJuaW5ncy4KPgo+TmV3IHdhcm5pbmdzOgo+RG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvYW1iYXJlbGxhLGN2NzUtcGlu
Y3RybC5leGFtcGxlLmR0YjoKPnBpbmN0cmxAZTQwMTAwMDAgKGFtYmFyZWxsYSxjdjc1LXBpbmN0
cmwpOgo+J2FtYmFyZWxsYSxkcml2ZS1zdHJlbmd0aC1zeXNjb24nLCAnYW1iYXJlbGxhLHB1bGwt
c3lzY29uJyBkbyBub3QgbWF0Y2gKPmFueSBvZiB0aGUgcmVnZXhlczogJ14jLionLAo+aHR0cHM6
Ly9naXRsYWIuY29tL3JvYmhlcnJpbmcvbGludXgtZHQvLS9qb2JzLzE3MDM4MzEwOTA5Cj4KPgo+
Cj5CVFcsIHRoaXMgY29tbWl0IG9mIHlvdXJzOgo+OWMyOTMyYmFkY2QzZTNjMGZjNjMwZWFjNWZm
MmJmZDVmYWRmOTNmMQo+Cj5kb2VzIG5vdCBldmVuIGJ1aWxkLCBzbyBhIG1ha2UgZXJyb3IuCj4K
Pj4gCj4+IEJ1dCBpZiB5b3UgdGVsbCBtZSAicmV2ZXJ0IHRoZSBwYXRjaCIgSSB3aWxsIHNpbXBs
eSByZXZlcnQgdGhlIHBhdGNoCj4+IGJlY2F1c2UgSSB0cnVzdCB5b3UsIGl0IGRvZXNuJ3QgcmVh
bGx5IG1hdHRlciB3aHkuCj4KPkkgdGhpbmsgQW1iYXJlbGxhIHdvbid0IGJlIHBpY2tlZCB1cCwg
YmVjYXVzZSBvZiB0b3RhbCBtZXNzIHdpdGgKPnBhdGNoc2V0cywgdGh1cyBSb2Igc2hvdWxkIGp1
c3QgdGFrZSB0aGUgdmVuZG9yIHByZWZpeC4uLiBleGNlcHQgdGhlcmUKPmlzIG5vIHZlbmRvciBw
cmVmaXggcGF0Y2ggdG8gdGFrZSwgc2luY2UgaXQgaXMgc3F1YXNoZWQgd2l0aCBvdGhlciB3b3Jr
Lgo+Cj5JIGRvbid0IGdldCB3aHkgdGhpcyBiZWNhbWUgc28gbWVzc3kgYW5kIGhhdmUgbm8gY2x1
ZSBob3cgdGhpcyBzaG91bGQgYmUKPmZpeGVkLCBleGNlcHQgcmV2ZXJ0IHdoaWNoIGlzIHNhZCBj
aHVybi10eXBlIG9mIHdvcmsuCj4KPkJlc3QgcmVnYXJkcywKPktyenlzenRvZgo=
