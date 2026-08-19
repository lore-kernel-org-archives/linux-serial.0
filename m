Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A39426D2E;
	Wed, 19 Aug 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130400; cv=none; b=MjremZB1+IMb/X1q/oncECV9/O/aiqGx2w78JL8YkU0ZjwuT51RvmMdxJqFre53WUQjFWUYClzqqDtxVt7ZJMvc9WJUdo9qRULcVZ5z/D0kOtQNR3aySVA29YyH49BM+vS6hJ/t3u23qOh4ayvzeOoZ6wISxO3Stykx2ybLxkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130400; c=relaxed/simple;
	bh=1R8DjT6IWhZddPF9ppriYcIPoUIeXndNSl4I9OG62+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QcyahMgj5GRLiHfb3tGzFbSELaJAKxbbtQYfVcbbb/IF0Q3JO+Fow45T3WhXtVvyBG9Ygrfk74w/XXIQXrgPdZibBc6lJnji0FpB3prkBM6CzVuSYD4KrblevVBsPF0jYo16A7JIY2NIkFCJ1INrX33EKA1zPY+a9zV5yjslhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nsiYxzBE; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nsiYxzBE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1R8DjT6IWhZddPF9ppriYcIPoUIeXndNSl4I9OG62+M=; b=n
	siYxzBEWBxMBYihpoRBFMcjK2KWtCCINQwoXIMX4Rbk850kGPSrYzKknfOev7+Sw
	rBowQ2sfKOXn7dV3RICnnzH0tv5jezw3yGrUgVKBk5+ih0wW0nRq29+wpgT+o55o
	bDIKStGKrQM0h3h+RwfBKRrwCMXQ8ASiHhI/rV0clE=
Received: from zl020895$163.com ( [180.169.129.163] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Wed, 19 Aug 2026 17:04:36 +0800
 (CST)
Date: Wed, 19 Aug 2026 17:04:36 +0800 (CST)
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
Subject: Re:Re: [PATCH v5 05/12] dt-bindings: gpio: pl061: add Ambarella
 CV75 variant
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLngqGzethEG5Hx+oAPzZoV6rvWNGXYaycFFkDz_dXFz=g@mail.gmail.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-5-7bbb12f0360f@ambarella.com>
 <CAD++jLngqGzethEG5Hx+oAPzZoV6rvWNGXYaycFFkDz_dXFz=g@mail.gmail.com>
X-NTES-SC: AL_Qu2TBf2Yv0os4CKZZulS6DN615F8O5rMxLRDmdYrY+8JiBnj2hsZf1x6Flza4t4S6Qjtskm+L+PiF8ZvJW3f
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7b258258.6f41.1a01943e97e.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgDXfy2kcYVqde80AA--.8013W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgSB8mqFcaSWywAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTGludXMsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpJIGNoZWNrZWQgaXQganVzdCBub3cs
IEFtYmFyZWxsYSBpcyBpbiBKRVAxMDZCTiBhcyBiYW5rIDE2IC8gaWRlbnRpdHkgMHg2OC4gClBl
ciBpbmNsdWRlL2xpbnV4L2FtYmEvYnVzLmggSSBwbGFuIHRvIHVzZSBwZXJpcGhpZCAweDAwMGU4
MDYxCihkZXNpZ25lciAweGU4ID0gSkVQMTA2IDB4Njggd2l0aCBiaXQ3IHNldCwgcGFydCAweDA2
MSkuClRoZSBjb250aW51YXRpb24gYmFuayBpcyBub3QgcmVwcmVzZW50YWJsZSBpbiB0aGUgY2xh
c3NpYwo4LWJpdCBkZXNpZ25lciBmaWVsZDsgcGxlYXNlIHRlbGwgbWUgaWYgeW91IHByZWZlciBh
IGRpZmZlcmVudAplbmNvZGluZy4KCkJlc3QgcmVnYXJkcywKTG9uZyBaaGFvCgpBdCAyMDI2LTA4
LTE5IDE1OjQ3OjA2LCAiTGludXMgV2FsbGVpaiIgPGxpbnVzd0BrZXJuZWwub3JnPiB3cm90ZToK
Pk9uIFR1ZSwgQXVnIDE4LCAyMDI2IGF0IDEyOjMy4oCvUE0gTG9uZyBaaGFvIHZpYSBCNCBSZWxh
eQo+PGRldm51bGwrbG9uZ3poYW8uYW1iYXJlbGxhLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPgo+
PiArICAgICAgcHJvcGVydGllczoKPj4gKyAgICAgICAgYXJtLHByaW1lY2VsbC1wZXJpcGhpZDoK
Pj4gKyAgICAgICAgICBjb25zdDogMHgwMDAwMDA2MQo+Cj5UaGUgMHg0MSBpbiBBUk1zIFBlcmlw
aElEIGlzIGFjdHVhbGx5IHRoZSBKRURFQyBKRVAxMDYKPmltcGxlbWVudGVyIElEICg4IGJpdHMp
Lgo+Cj5TbyB5b3Ugc2hvdWxkIGlkZWFsbHkgc2V0IHRoaXMgdG8gd2hhdGV2ZXIgdGhlIGhhcmR3
YXJlIGVuZ2luZWVycwo+c2hvdWxkIGhhdmUgdXNlZCwgaGFkIHRoZXkgcGFpZCBhdHRlbnRpb24g
dG8gZGV0YWlsLgo+SWYgeW91ciBjb21wYW55IGhhcyBhIGNvbnRhY3QgcG9pbnQgYXQgSkVERUMg
dGhleSBzaG91bGQKPmtub3cgd2hpY2ggaW1wbGVtZW50ZXIgSUQgdG8gdXNlIGZvciBBbWJhcmVs
bGEgZGVzaWducy4KPgo+U2luY2UgQW1iYXJlbGxhIGlzIGV2aWRlbnRseSBhIG1lbWJlciBvZiBK
RURFQyB5b3VyCj5yZXByZXNlbnRhdGl2ZSBzaG91bGQgYmUgYWJsZSB0byBzaW1wbHkgcmVxdWVz
dCBhIEpFUDEwNgo+aW1wbGVtZW50ZXIgSUQgYW5kIGdpdmUgaXQgdG8geW91IGlmIHRoZXJlIGlz
IG5vdCBvbmUgYXNzaWduZWQKPmFscmVhZHksIGJ1dCBJIGtub3cgaXQgY2FuIGJlIGhhcmQKPnNv
bWV0aW1lcyB0byBmaW5kIHRoZSByaWdodCBwZXJzb24gaW5zaWRlIHRoZSBjb21wYW55Cj5idXQg
SSB0aGluayBpdCdkIGJlIHdvcnRoIGdvaW5nIHRoZSBleHRyYSBtaWxlIGhlcmUsIHNheSB0aGF0
Cj50aGlzIGd1eSBmcm9tIHRoZSBrZXJuZWwgY29tbXVuaXR5IHBlcnNpc3RzLgo+Cj5Zb3VycywK
PkxpbnVzIFdhbGxlaWoK
