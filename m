Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB58361965;
	Wed, 16 Sep 2026 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534269; cv=none; b=ING0iNqALoPGA1+FKb4iByxNB4Xd+AxAvkTFTtNE4dqSa6R5oSJ3JYxHY32/MPMfUSebc92waEL0N/VJTLHj/5UDtvAyPA86sZ45AaFJ23o+8P1ql7lwOfHmmbyc2yerWo2hB2oEQmmJf9NkZ58G74GE0CchA4yf++6lwL9/FEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534269; c=relaxed/simple;
	bh=0brGLsUCM8OjbH30xJ1GI8+aQZaH1XqCveD1VKrsWZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QK/1IiN6TRmzRyZDgYkjiOMHzQbXvH+zw4QtfrG6JCWYNpG70Lrix72+KDUieOisYoL6CYvRt0QgPBQ3hqhm01OQ4wGZYmq+6AbseFafTC6c5jhSOv37MOSJWhZs39cT6KrEXL790cojkTP5OrkF0XgI6zx7vYaeFu0B1/cBwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cozk4Wq4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cozk4Wq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0brGLsUCM8OjbH30xJ1GI8+aQZaH1XqCveD1VKrsWZs=; b=c
	ozk4Wq4p0a+DYAskc3v9AeRJoPdFWFJor9rVy8GTBoM2VubqyAPdxTZ6dRvW8RyZ
	qXdVJoirnouBR8BM6pThOkUfT62bcjnWVEPGMy5OWgP6o852ML5VEF7Mn6bzmsEg
	Simst3JWQ+tkbh3OetC6/1WiW62pyZkPkW5yxTQPY4=
Date: Wed, 16 Sep 2026 12:49:46 +0800 (CST)
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
Subject: Re:Re: [PATCH v7 09/15] gpiolib: regmap: add gpio_regmap_get_chip()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqlknvOejkE5zutq@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
 <aqlknvOejkE5zutq@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/mYu0kj4CiRZekcn0wRhug/UMa4u/sm3YNXc+gGgS7rxD0iflpxF2DKzOe1GTqXuzGSbTdPyMZYULtmDWHgzTizjvt8es72bjBGWA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <327d09fc.4043.1a0a88cad9b.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgD334PqH6pqGGFHAA--.23892W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgtHuGqqH+vnbAAA3N
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwgCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpJdCBpc24ndDsgdGhhdCB3YXMgbGVm
dG92ZXIgZnJvbSBkcm9wcGluZyBnaXJxLiB2OCB3aWxsIHJlc3RvcmUgdGhlCm9yaWdpbmFsIGF0
dGFjaCBjb2RlLiBUaGUgcmVhbCBhZGRpdGlvbiBpcyBncGlvX3JlZ21hcF9nZXRfY2hpcCgpLCBz
bwpQTDA2MSBjYW4gY3JlYXRlIGl0cyBpcnEgZG9tYWluIGFmdGVyIHJlZ2lzdGVyLgoKQmVzdCBy
ZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDktMTUgMjM6MzA6MzgsICJBbmR5IFNoZXZjaGVu
a28iIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+T24gVHVlLCBT
ZXAgMTUsIDIwMjYgYXQgMDc6MTU6MzlQTSArMDgwMCwgTG9uZyBaaGFvIHZpYSBCNCBSZWxheSB3
cm90ZToKPgo+PiBMZXQgZHJpdmVycyB0aGF0IGltcGxlbWVudCBhIGN1c3RvbSBpcnFjaGlwIHJl
dHJpZXZlIHRoZSBncGlvX2NoaXAKPj4gYWZ0ZXIgcmVnaXN0cmF0aW9uLiBBdHRhY2ggYSBjYWxs
ZXItcHJvdmlkZWQgaXJxX2RvbWFpbiBvbmx5IHdoZW4gaXQKPj4gaXMgcHJlc2VudC4KPgo+Li4u
Cj4KPj4gIHN0cnVjdCBncGlvX3JlZ21hcCAqZ3Bpb19yZWdtYXBfcmVnaXN0ZXIoY29uc3Qgc3Ry
dWN0IGdwaW9fcmVnbWFwX2NvbmZpZyAqY29uZmlnKQo+PiAgewo+PiAtCXN0cnVjdCBpcnFfZG9t
YWluICppcnFfZG9tYWluOwo+PiAgCXN0cnVjdCBncGlvX3JlZ21hcCAqZ3BpbzsKPj4gIAlzdHJ1
Y3QgZ3Bpb19jaGlwICpjaGlwOwo+PiAgCWludCByZXQ7Cj4KPj4gICNpZmRlZiBDT05GSUdfUkVH
TUFQX0lSUQo+PiAgCWlmIChjb25maWctPnJlZ21hcF9pcnFfY2hpcCkgewo+PiArCQlzdHJ1Y3Qg
aXJxX2RvbWFpbiAqaXJxX2RvbWFpbjsKPj4gKwo+PiAgCQlncGlvLT5yZWdtYXBfaXJxX2xpbmUg
PSBjb25maWctPnJlZ21hcF9pcnFfbGluZTsKPj4gIAkJcmV0ID0gcmVnbWFwX2FkZF9pcnFfY2hp
cF9md25vZGUoZGV2X2Z3bm9kZShjb25maWctPnBhcmVudCksIGNvbmZpZy0+cmVnbWFwLAo+PiAg
CQkJCQkJIGNvbmZpZy0+cmVnbWFwX2lycV9saW5lLCBjb25maWctPnJlZ21hcF9pcnFfZmxhZ3Ms
Cj4+IEBAIC00MjAsMTIgKzQyNywxNSBAQCBzdHJ1Y3QgZ3Bpb19yZWdtYXAgKmdwaW9fcmVnbWFw
X3JlZ2lzdGVyKGNvbnN0IHN0cnVjdCBncGlvX3JlZ21hcF9jb25maWcgKmNvbmZpZwo+PiAgCQkJ
Z290byBlcnJfcmVtb3ZlX2dwaW9jaGlwOwo+PiAgCj4+ICAJCWlycV9kb21haW4gPSByZWdtYXBf
aXJxX2dldF9kb21haW4oZ3Bpby0+aXJxX2NoaXBfZGF0YSk7Cj4+ICsJCWlmIChpcnFfZG9tYWlu
KSB7Cj4+ICsJCQlyZXQgPSBncGlvY2hpcF9pcnFjaGlwX2FkZF9kb21haW4oY2hpcCwgaXJxX2Rv
bWFpbik7Cj4+ICsJCQlpZiAocmV0KQo+PiArCQkJCWdvdG8gZXJyX3JlbW92ZV9ncGlvY2hpcDsK
Pj4gKwkJfQo+PiAgCX0gZWxzZQo+PiAgI2VuZGlmCj4+IC0JaXJxX2RvbWFpbiA9IGNvbmZpZy0+
aXJxX2RvbWFpbjsKPj4gLQo+PiAtCWlmIChpcnFfZG9tYWluKSB7Cj4+IC0JCXJldCA9IGdwaW9j
aGlwX2lycWNoaXBfYWRkX2RvbWFpbihjaGlwLCBpcnFfZG9tYWluKTsKPj4gKwlpZiAoY29uZmln
LT5pcnFfZG9tYWluKSB7Cj4+ICsJCXJldCA9IGdwaW9jaGlwX2lycWNoaXBfYWRkX2RvbWFpbihj
aGlwLCBjb25maWctPmlycV9kb21haW4pOwo+PiAgCQlpZiAocmV0KQo+PiAgCQkJZ290byBlcnJf
cmVtb3ZlX2dwaW9jaGlwOwo+PiAgCX0KPgo+SSBkbyBub3QgdW5kZXJzdGFuZCBob3cgaXQncyBk
aWZmZXJlbnQgZnJvbSB0aGUgb3JpZ2luYWwgb25lLiBDYW4geW91IGVsYWJvcmF0ZT8KPgo+LS0g
Cj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cg==
