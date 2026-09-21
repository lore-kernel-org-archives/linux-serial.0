Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDE134CCF;
	Mon, 21 Sep 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962833; cv=none; b=qpmVw8owVkDvNrOR1MBoz61o4MqonALp3dXdmKkZs1c57cNAyrGFRhQbBl3UQNowoeNPNqa8U068mAEF1AdqoePCkuNcXZmFBeNayAU0+y+/uaRdpYL7ntZGQglvxIhw13C+/SYIjSTLKBDyZHuQ1xrHCuZ8nZ2MhmjRjleOqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962833; c=relaxed/simple;
	bh=thBRA3BdH8VdVY4ioZyS/SS+nEIYECE2vWuugLNgY/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mFcPod1nHuHurMxCDKoTUZe7161PXtrScj1w8o9oTRNSeTCuVDO/qbNoZwmH2YzqM7SIGxFzIQrN+fH6eeeLmdz4/NGEwjPUSTodJFteaE83KAuzeOC/HmZ9758847kjgTuGOG8JF6cZN/8HLKtN4j4fzy8YBaZahtlHaJu3wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M9LOz8VE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M9LOz8VE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=thBRA3BdH8VdVY4ioZyS/SS+nEIYECE2vWuugLNgY/U=; b=M
	9LOz8VEDOzW1v1SZPBtTQXUuw+YsMKEVnxVl/0cHjx3OSoeJ0X6egsKou5PFBYgY
	Wi1+GsvX8iQrfU7GrEzCATDMxFhFufmC5vdvXv3z1xkkrHp+twfDGb0DeW51aXNS
	mGvGIB9YhBi/YgIsNqWRThQ5VZxIqnaG1lWWe+9A2E=
Date: Mon, 21 Sep 2026 11:52:33 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Linus Walleij" <linusw@kernel.org>
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
Subject: Re:Re: [PATCH v7 08/15] gpiolib: regmap: add write_data_after_dir
 quirk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLkHfgu_V8i_fhE1WQe+qwJ=ictQSONWPq1fPuYYb8tSRA@mail.gmail.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-8-3297d3fbc9c0@ambarella.com>
 <CAD++jLkHfgu_V8i_fhE1WQe+qwJ=ictQSONWPq1fPuYYb8tSRA@mail.gmail.com>
X-NTES-SC: AL_Qu2TC/WdvU8u5SiZYukcn0wRhug/UMa4u/sm3YNXc80ElTHX5Qk5QFV9DV/c98WtKxmClBWuVzh21PVmZapTMlnau6fbzs43n5vSZcX5aQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <46342be7.3c81.1a0c2181721.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fSgvCgD3n00BqrBqt2pLAA--.36901W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7gFx4mqwqgHFHgAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTGludXMsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuIHY4IHdpbGwgc2tpcCB0aGUgcHJlLWRp
cmVjdGlvbiBncGlvX3JlZ21hcF9zZXQoKSB3aGVuCndyaXRlX2RhdGFfYWZ0ZXJfZGlyIGlzIHNl
dC4gVGhlIGdwaW9fcmVnbWFwX3NldCgpIHJldHVybnMgc3RheQppZ25vcmVkLCBwZXIgQW5keS4K
CjAwMTQ6IGFkZGVkIHlvdXIgUmV2aWV3ZWQtYnkuCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoK
QXQgMjAyNi0wOS0yMSAwNjowMjo0OCwgIkxpbnVzIFdhbGxlaWoiIDxsaW51c3dAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5IaSBMb25nLAo+Cj50aGFua3MgZm9yIHlvdXIgcGF0Y2ghCj4KPk9uIFR1ZSwg
U2VwIDE1LCAyMDI2IGF0IDE6MTXigK9QTSBMb25nIFpoYW8gdmlhIEI0IFJlbGF5Cj48ZGV2bnVs
bCtsb25nemhhby5hbWJhcmVsbGEuY29tQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4KPj4gRnJvbTog
TG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPgo+Pgo+PiBTb21lIGNvbnRyb2xsZXJz
IGlnbm9yZSBkYXRhLXJlZ2lzdGVyIHdyaXRlcyB3aGlsZSBhIGxpbmUgaXMgc3RpbGwgYW4KPj4g
aW5wdXQuIE9wdGlvbmFsbHkgd3JpdGUgdGhlIG91dHB1dCB2YWx1ZSBhZ2FpbiBhZnRlciBzd2l0
Y2hpbmcgdGhlCj4+IGRpcmVjdGlvbiwgbWF0Y2hpbmcgdGhlIGV4aXN0aW5nIFBMMDYxIGJlaGF2
aW91ci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEu
Y29tPgo+Cj5PSyBJIHNlZS4KPgo+KC4uLikKPgo+Cj4+IEBAIC0yNzEsOSArMjcyLDIyIEBAIHN0
YXRpYyBpbnQgZ3Bpb19yZWdtYXBfZGlyZWN0aW9uX291dHB1dChzdHJ1Y3QgZ3Bpb19jaGlwICpj
aGlwLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+PiAgICAgICAgIH0K
Pj4KPj4gLSAgICAgICBncGlvX3JlZ21hcF9zZXQoY2hpcCwgb2Zmc2V0LCB2YWx1ZSk7Cj4+ICsg
ICAgICAgcmV0ID0gZ3Bpb19yZWdtYXBfc2V0KGNoaXAsIG9mZnNldCwgdmFsdWUpOwo+PiArICAg
ICAgIGlmIChyZXQpCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+Cj5pZiAoIWdwaW8t
PndyaXRlX2RhdGFfYWZ0ZXJfZGlyKSB7Cj4gICAgIHJldCA9IGdwaW9fcmVnbWFwX3NldChjaGlw
LCBvZmZzZXQsIHZhbHVlKTsKPiAgICAgaWYgKHJldCkKPiAgICAgICAgICAgICByZXR1cm4gcmV0
Owo+fQo+Cj5UaGVyZSBpcyBubyBwb2ludCBpbiBkb2luZyBzb21ldGhpbmcgeW91IGtub3cgd2ls
bCBub3QKPndvcmsuCj4KPj4gKyAgICAgICByZXQgPSBncGlvX3JlZ21hcF9zZXRfZGlyZWN0aW9u
KGNoaXAsIG9mZnNldCwgdHJ1ZSk7Cj4+ICsgICAgICAgaWYgKHJldCkKPj4gKyAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7Cj4+Cj4+IC0gICAgICAgcmV0dXJuIGdwaW9fcmVnbWFwX3NldF9kaXJl
Y3Rpb24oY2hpcCwgb2Zmc2V0LCB0cnVlKTsKPj4gKyAgICAgICAvKgo+PiArICAgICAgICAqIGdw
aW8gdmFsdWUgaXMgc2V0IGFnYWluLCBiZWNhdXNlIHBsMDYxIGRvZXNuJ3QgYWxsb3cgdG8gc2V0
IHZhbHVlIG9mCj4+ICsgICAgICAgICogYSBncGlvIHBpbiBiZWZvcmUgY29uZmlndXJpbmcgaXQg
aW4gT1VUIG1vZGUuCj4+ICsgICAgICAgICovCj4+ICsgICAgICAgaWYgKGdwaW8tPndyaXRlX2Rh
dGFfYWZ0ZXJfZGlyKQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGdwaW9fcmVnbWFwX3NldChj
aGlwLCBvZmZzZXQsIHZhbHVlKTsKPgo+VGhlbiB0aGVyZSBpcyBBbmR5J3MgY29tbWVudCBhcyB3
ZWxsLgo+Cj5UaGUgcmVzdCBsb29rcyBnb29kLgo+Cj5Zb3VycywKPkxpbnVzIFdhbGxlaWoK
