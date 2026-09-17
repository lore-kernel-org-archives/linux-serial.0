Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C4470EB6;
	Thu, 17 Sep 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649799; cv=none; b=LtRpsTtP+9GWZ99IBlQg1tL0q26EI8cMry2QONOipkwgL/KW71kImDZLYNHo/2ZjZFyglperI+yOM04jyjci4D/BunWTirFMCCsPChuRTBTDVIRkVBfIMNuZ/fnA/NxCPGSKYT1RRkOT5o5Oxzpr2uFySGJ/OWG/6ntMqaPQJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649799; c=relaxed/simple;
	bh=hJcOsp7/4gBcZglC/7Pd3zJVofVyfh4TOUzPHB2LbyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=u0srbJmFBxW1n09WNkk+5+7B1P2iGAUeOdX07sbaD7sIhrRcRW4X86eL+A4LHLYqQQB6gDQXxf50Esu8RkX3VF6MQ5VElenP1rQqAVJzT3RxTHcDURW7Bbg53LLcy4iPlktlaQE0whjYnnaZHQMJFaQF9F4tWQQT0m5UpVDkR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bhDMZFuC; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bhDMZFuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hJcOsp7/4gBcZglC/7Pd3zJVofVyfh4TOUzPHB2LbyM=; b=b
	hDMZFuCwZhSkhaMjahcX5Bc05UtoeH3U7Sl3PP+Z0O5nklwxOkrfAsaVj1kzJ1/C
	Ph75WHXQ6Jwlmp3FaB5SqyXkkkLmh60LChtuTjj/FD/tHRgEBQYw7CSWjYln4dl9
	yKGQ/bZSPv+fNWsI53VzHJ5JbdjGW84sZEoBkxnOAo=
Date: Thu, 17 Sep 2026 20:55:15 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: longzhao@ambarella.com, "Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
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
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH v7 12/15] pinctrl: ambarella: add CV75 pin
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqvbfCQ6cxfGYJeC@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-12-3297d3fbc9c0@ambarella.com>
 <aqp0VlwWotnuK9t7@ashevche-desk.local>
 <40f1f819.7f85.1a0ae9e4dae.Coremail.zl020895@163.com>
 <aqvbfCQ6cxfGYJeC@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/qftk8q4yGQY+kcn0wRhug/UMa4u/sm3YNXc+4Eqibs3gYGRG9PH0nv/8uJLS6Juh6wVSdN18d0QrRHMpJrKUK/9tD+DJuJ0EekfA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4bd10649.9ba9.1a0af6f7ffd.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aSgvCgAHvpUz46tqpbxGAA--.49547W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7hOK+2qr4zO2kQAA36
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzLCBBbmR5LgoKUElOQ1RSTF9QSU5HUk9VUCBvbmx5IGNhcnJpZXMgcGluIG51bWJlcnMu
IFRoZSBJT01VWCBhbHQgaXMgbm90IHRoZQpwaW5jdHJsIGZ1bmN0aW9uOiB0aGUgc2FtZSBwaW4g
aXMgaW4gc2V2ZXJhbCBncm91cHMgd2l0aCBkaWZmZXJlbnQKYWx0cywgYW5kIGEgZmV3IGdyb3Vw
cyBtaXggYWx0cy4KCkluIHY4IEkgd2lsbCBzd2l0Y2ggdGhlIGdyb3VwIHRhYmxlcyB0byBQSU5D
VFJMX1BJTkdST1VQIGFuZCBwYXNzIGEKcGVyLXBpbiBhbHQgYXJyYXkgYXMgZ3JvdXAgZGF0YSBm
b3Igc2V0X211eCgpLiBQSU5DVFJMX1BJTkZVTkNUSU9OCnN0YXlzIGFzIGl0IGlzLgoKQmVzdCBy
ZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDktMTcgMjA6MjI6MjAsICJBbmR5IFNoZXZjaGVu
a28iIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+T24gVGh1LCBT
ZXAgMTcsIDIwMjYgYXQgMDU6MDY6NDVQTSArMDgwMCwgemwwMjA4OTUgd3JvdGU6Cj4+IFRoYW5r
cyBmb3IgdGhlIHJldmlldy4gVGhlIHNtYWxsIGNvbW1lbnRzIHdpbGwgYmUgaW4gdjgsCj4+IGlu
Y2x1ZGluZyBwaW5jb25mIHNldCB2aWEgcmVnbWFwX2Fzc2lnbl9iaXRzLgo+PiAKPj4gUElOQ1RS
TF9QSU5HUk9VUCBkb2VzIG5vdCBmaXQgaGVyZTogZ3JvdXBzIGNhcnJ5Cj4+IEFNQkFfUElOTVVY
KHBpbiwgYWx0KSwgbm90IGEgcGluLW51bWJlciBsaXN0LCBzbyBJIHdpbGwga2VlcAo+PiBDVjc1
X0dST1VQLgo+Cj5JIGRpZG4ndCBnZXQuIEl0IHRha2VzIGEgcGluIGFzIGEgcGFyYW1ldGVyIGFu
ZCBhZGRzIHRoZSBmdW5jdGlvbiBvbiB0b3AKPm9mIGl0LiBJdCBpcyBhIGNvbWJvLCBidXQgSSB0
aGluayBpdCBzdGlsbCBmaXRzIHRoZSBwdXJwb3NlLiBQbGVhc2UsIHVzZQo+ZXhpc3RpbmcgZGF0
YSBzdHJ1Y3R1cmUgYW5kIGEgbWFjcm8uCj4KPj4gQXQgMjAyNi0wOS0xNiAxODo0OTo1OCwgIkFu
ZHkgU2hldmNoZW5rbyIgPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6
Cj4+ID5PbiBUdWUsIFNlcCAxNSwgMjAyNiBhdCAwNzoxNTo0MlBNICswODAwLCBMb25nIFpoYW8g
dmlhIEI0IFJlbGF5IHdyb3RlOgo+Cj4uLi4KPgo+PiA+PiArI2RlZmluZSBBTUJBX1BJTk1VWChw
aW4sIGFsdCkJCSgoKGFsdCkgPDwgMTIpIHwgKHBpbikpCj4+ID4+ICsjZGVmaW5lIEFNQkFfUElO
TVVYX1RPX1BJTihtdXgpCQkoKG11eCkgJiAweGZmZikKPj4gPj4gKyNkZWZpbmUgQU1CQV9QSU5N
VVhfVE9fQUxUKG11eCkJCSgoKG11eCkgPj4gMTIpICYgMHg3KQo+PiA+PiArCj4+ID4+ICtzdHJ1
Y3QgYW1iX3Bpbm11eF9ncm91cCB7Cj4+ID4+ICsJY29uc3QgY2hhciAqbmFtZTsKPj4gPj4gKwlj
b25zdCB1MzIgKm11eDsKPj4gPj4gKwl1bnNpZ25lZCBpbnQgbm11eDsKPj4gPj4gK307Cj4KPl5e
XiBsZWZ0IGZvciB0aGUgY29udGV4dC4KPgo+Cj4tLSAKPldpdGggQmVzdCBSZWdhcmRzLAo+QW5k
eSBTaGV2Y2hlbmtvCj4K
