Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFE3C3F6F;
	Mon, 21 Sep 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993284; cv=none; b=Xpx3mWMXsjyK6dOw/ueH6FSkJL2hYgwQFsxh4rsHxvGw2UpV3t4ekyGTE93Et5nk24vNKeo5E7mb0eUYgUcZw3mxKmauDuesnio2lu5xI6gZapZE+DjLH8B966cux76q15xoIlJB6mv9JXZUGJCVF0eaPwHMZfkcmQym8g060SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993284; c=relaxed/simple;
	bh=x1eBDSEnp8xXV2Qaa6P1kJIKyiMhTWpft8UHmmtwQNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YoZplLglQ+A/8DZVKU8+47VdN66BYkO79ufZxWtf7ZSRQyWY6wrA40C37n8WXeAuLiiCjVmQJ1jFO3Rwd38TctVDJf0+1DXHHxaJDscu4h6/Rq9eRDNUDwpcL3mSKg+V3qw1UDS0zZ7rydvruvHdm+xiyG89llcqL6pBPgG7kkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mhq6yoO2; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mhq6yoO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=x1eBDSEnp8xXV2Qaa6P1kJIKyiMhTWpft8UHmmtwQNU=; b=m
	hq6yoO27MPQGcxvvmUKswwl0txbqYV7Xm/coLEOybz5sQF7jtjVcmP32p4FhtlDO
	KnJX7Q455/r91xWQwQ+DiLiJyMftUuzBqmMkmN57F9opD1m/i09br2XcIkME6QEg
	JYEdapnLO0he7VGKxxH4+lK2NuocPmCiSSpL4E8jGQ=
Date: Mon, 21 Sep 2026 20:19:49 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>
Cc: longzhao@ambarella.com,
	"Long Zhao via B4 Relay" <devnull+longzhao.ambarella.com@kernel.org>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Linus Walleij" <linusw@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re:Re: [PATCH v8 09/18] gpiolib: regmap: add gpio_regmap_get_chip()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAMRc=Mf7dtxvxBUF1fOuKw0mxdhCYPj=J4ckySPZUvcZ7a6cbQ@mail.gmail.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-9-282ff5d98dda@ambarella.com>
 <CAMRc=Mf7dtxvxBUF1fOuKw0mxdhCYPj=J4ckySPZUvcZ7a6cbQ@mail.gmail.com>
X-NTES-SC: AL_Qu2TC/WSvEkj7yacY+kcn0wRhug/UMa4u/sm3YNXc+sEvwvN1yAKfXhgLWTM3uu3ORuQqwGKex1g8e9feapSOav+wmljU0SfVFj33va5Mw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3e3a7197.9e4e.1a0c3e88117.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgDnz3XlILFq0Q9MAA--.35W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgVIuWqxIOW++wAA3p
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQmFydCwKCkRvbmUsIHNlbnQgYXMgYSBmb2xsb3ctdXA6Cmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI2MDkyMS1ncGlvLWRvYy1mb2xsb3d1cC12MS0xLTYxODczODEyNGY0Y0BhbWJh
cmVsbGEuY29tLwoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDktMjEgMTg6MzU6
MDgsICJCYXJ0b3N6IEdvbGFzemV3c2tpIiA8YnJnbEBrZXJuZWwub3JnPiB3cm90ZToKPk9uIE1v
biwgMjEgU2VwIDIwMjYgMDY6MjM6MjggKzAyMDAsIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkKPjxk
ZXZudWxsK2xvbmd6aGFvLmFtYmFyZWxsYS5jb21Aa2VybmVsLm9yZz4gc2FpZDoKPj4gRnJvbTog
TG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPgo+Pgo+PiBMZXQgZHJpdmVycyB0aGF0
IGltcGxlbWVudCBhIGN1c3RvbSBpcnFjaGlwIHJldHJpZXZlIHRoZSBncGlvX2NoaXAKPj4gYWZ0
ZXIgcmVnaXN0cmF0aW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMb25nIFpoYW8gPGxvbmd6aGFv
QGFtYmFyZWxsYS5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncGlvL2dwaW8tcmVnbWFwLmMgIHwg
NiArKysrKysKPj4gIGluY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaCB8IDEgKwo+PiAgMiBmaWxl
cyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bp
by9ncGlvLXJlZ21hcC5jIGIvZHJpdmVycy9ncGlvL2dwaW8tcmVnbWFwLmMKPj4gaW5kZXggZmJk
NGM3NTM1MjVhLi4yMWUwOTkzYjg5ZTIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlv
LXJlZ21hcC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvLXJlZ21hcC5jCj4+IEBAIC0yOTUs
NiArMjk1LDEyIEBAIHZvaWQgKmdwaW9fcmVnbWFwX2dldF9kcnZkYXRhKHN0cnVjdCBncGlvX3Jl
Z21hcCAqZ3BpbykKPj4gIH0KPj4gIEVYUE9SVF9TWU1CT0xfR1BMKGdwaW9fcmVnbWFwX2dldF9k
cnZkYXRhKTsKPj4KPj4gK3N0cnVjdCBncGlvX2NoaXAgKmdwaW9fcmVnbWFwX2dldF9jaGlwKHN0
cnVjdCBncGlvX3JlZ21hcCAqZ3BpbykKPj4gK3sKPj4gKwlyZXR1cm4gJmdwaW8tPmdwaW9fY2hp
cDsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGdwaW9fcmVnbWFwX2dldF9jaGlwKTsKPgo+
UGxlYXNlIHByb3ZpZGUgYSBrZXJuZWwgZG9jIGZvciBhbGwgcHVibGljIEFQSXMuIEl0IHNob3Vs
ZCBleHBsYWluIHRoYXQgdGhpcwo+bXVzdCBub3QgYmUgdXNlZCBvdXRzaWRlIG9mIGEgR1BJTyBj
b250cm9sbGVyIGRyaXZlciBjb250ZXh0Lgo+Cj5CYXJ0Cg==
