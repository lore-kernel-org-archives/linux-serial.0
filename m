Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227B3D348C;
	Thu, 10 Sep 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033649; cv=none; b=T3Aol87rs8+N+D7nCQRUA0WWAk8NLgIo91b0W3w2Pk7FwpLe7UyGKI1hN3m1nHJZKhDJ/tZt7IwZLcp1+CcYHmxWEUGvRKEnGG9Q61U2cktaJU8AocxQKMl7aXgXfcglubCSr3+fCLnJT3PqsW9+seKlEso14GQJ/JKlc2F37mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033649; c=relaxed/simple;
	bh=F5/vPpllGKppAQmvAZ51j2daco6+yuo7BVECN5KUbX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uoiiWb5agVMTd6R/Is33tIXwHQ3Fie/Xu/0wIFJkHnkdnsP1vPSwvH611VD5ER3XmK6M+tFgneDx3AQpEy1rjqH4BpQfuFgg9xjrXQmBX9VWnOx02X+Z6YUnAMARc3UEu/HUpmAt3n+taBvEHQFWZMoUogDKYa9NgmbE10l8U/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lqXmm7sM; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lqXmm7sM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=F5/vPpllGKppAQmvAZ51j2daco6+yuo7BVECN5KUbX0=; b=l
	qXmm7sMACXKuGTYrhuNCWfmPg5VEqhYXjr3OUG/evdiii5qKdz1WBt9cWRK4AIyR
	oOrGDa7nYpOkYEna1BshJ0UY8tk5Wjp5lZbAwr0uJOSm9quHSnEItNUmyjrM/biC
	LLq2WOZewwsIWu8Riybaa3g98vnHpzOPIGS9fsrNxk=
Date: Thu, 10 Sep 2026 17:45:36 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	longzhao@ambarella.com, "Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
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
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75
 quirks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <b199eb38-b1a2-4db6-81d8-37bab09a75b7@linux.intel.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
 <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
 <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com>
 <aqJ35vMBiBZo2iUE@ashevche-desk.local>
 <b199eb38-b1a2-4db6-81d8-37bab09a75b7@linux.intel.com>
X-NTES-SC: AL_Qu2TC/yYvE0o4CCfYekcn0wRhug/UMa4u/sm3YNXc8IFoD/G9CUlQFRoOmbk686TGjqAnROpYCR11ftiZ4N9xBLb9kFkJNpkbO2sqGB8hQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <55b27872.8ed9.1a08ab55a52.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgD3n9RAfKJqJMVDAA--.19073W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgBy42qifEADiwAA3r
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgSWxwbywgQW5keSwKCkknbGwgZ28gd2l0aCB0aGUgc2ltcGxlIGNvbW1lbnQ6CgkvKgoJICog
QW1iYXJlbGxhIGtlZXBzIHZhcmlhbnQgSUVSIGJpdHMgKGUuZy4gRVRPSSkgc2V0IGZvciBjb3Jy
ZWN0IFJYCgkgKiB0aW1lb3V0IGJlaGF2aW91ci4KCSAqLwoJdXAtPmllciB8PSBkLT5wZGF0YS0+
aWVyX21hc2s7CgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoKQXQgMjAyNi0wOS0xMCAxNzozMzoz
OCwgIklscG8gSsOkcnZpbmVuIiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+IHdyb3Rl
Ogo+T24gVGh1LCAxMCBTZXAgMjAyNiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+Cj4+IE9uIFRo
dSwgU2VwIDEwLCAyMDI2IGF0IDA1OjEyOjUyUE0gKzA4MDAsIHpsMDIwODk1IHdyb3RlOgo+PiAK
Pj4gPiA+IFdvbmRlcmluZyBpZiB3ZSBzaG91bGQgdW5kbyB0aGlzIGluIHRoZSBwb3J0J3MgLnNo
dXRkb3duKCkgY2FsbGJhY2suCj4+ID4gSSBzYXcgdGhlIHNodXRkb3duIHBhdGggYWxyZWFkeSBj
b3ZlcnMgaXQ6IGR3ODI1MF9zaHV0ZG93bigpIGNhbGxzCj4+ID4gc2VyaWFsODI1MF9kb19zaHV0
ZG93bigpLCB3aGljaCBkb2VzCj4+ID4gCXVwLT5pZXIgPSAwOwo+PiA+IAlzZXJpYWxfcG9ydF9v
dXQocG9ydCwgVUFSVF9JRVIsIDApOwo+PiA+IHNvIGJvdGggdGhlIElFUiBzaGFkb3cgYW5kIGhh
cmR3YXJlIElFUiBhcmUgY2xlYXJlZCwgaW5jbHVkaW5nIEVUT0kuCj4+IAo+PiBEZXBlbmRpbmcg
b24gdGhlIGFuc3dlciB0byBJbHBvIHRoZSBlbmFibGluZyBtYXkgbmVlZCBhbiB1cGRhdGVkIGNv
bW1lbnQKPj4gc3VtbWFyaXNpbmcgdGhlIGFib3ZlLgo+Cj5JJ2QgcHJlZmVyIHJlbW92aW5nIHRo
ZSBlbnRpcmUgIkZvcmNlIHRoZW0gLi4uIiBzZW50ZW5jZSwgaXQgZmVlbHMgcmVhbGx5IAo+YmFz
aWMgZGV0YWlsIGFib3V0IGhvdyAtPmllciB3b3Jrcy4gSSBiZWxpZXZlIHRoYXQgd291bGQgcmVz
b2x2ZSB5b3VyIAo+Y29uY2VybiBpZiByZWxhdGVzIHRvIHdoYXQgc2h1dGRvd24gZG9lcyBmb3Ig
dGhlIGZsYWcgKGNsZWFycyBpdCB3aGlsZSAKPnRoZSBjb21tZW50IGFzIGlzIHNheXMgbm90aGlu
ZyBpcyBzdXBwb3NlZCB0byBjbGVhciBpdCkuCj4KPj4gPiBBdCAyMDI2LTA5LTEwIDE2OjMzOjE0
LCAiQW5keSBTaGV2Y2hlbmtvIiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3
cm90ZToKPj4gPiA+T24gRnJpLCBTZXAgMDQsIDIwMjYgYXQgMDI6Mzg6MThQTSArMDgwMCwgTG9u
ZyBaaGFvIHZpYSBCNCBSZWxheSB3cm90ZToKPj4gCj4+IC4uLgo+PiAKPj4gPiA+PiArCS8qCj4+
ID4gPj4gKwkgKiBBbWJhcmVsbGEga2VlcHMgdmFyaWFudCBJRVIgYml0cyAoZS5nLiBFVE9JKSBz
ZXQgZm9yIGNvcnJlY3QgUlgKPj4gPiA+PiArCSAqIHRpbWVvdXQgYmVoYXZpb3VyLiBGb3JjZSB0
aGVtIGludG8gdGhlIDgyNTAgSUVSIHNoYWRvdyBzbyBsYXRlcgo+PiA+ID4+ICsJICogZ2VuZXJp
YyBJRVIgdXBkYXRlcyBkbyBub3QgY2xlYXIgdGhlbS4KPj4gPiA+PiArCSAqLwo+PiA+ID4KPj4g
PiA+V29uZGVyaW5nIGlmIHdlIHNob3VsZCB1bmRvIHRoaXMgaW4gdGhlIHBvcnQncyAuc2h1dGRv
d24oKSBjYWxsYmFjay4KPj4gCj4+IAo+Cj4tLSAKPiBpLgo=
