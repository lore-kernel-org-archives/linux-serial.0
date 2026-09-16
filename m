Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4C25B08D;
	Wed, 16 Sep 2026 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534148; cv=none; b=M78ZgWDkeNLM1W1wNTaKyvP8a6AKnnLFKTbkgXyBdkxszQXlQ8VbxzDIpDOKy5cXIHtfYxwwGGqvIjJ+AzdRmwRIVcPoXuP0HRBpyFjpJ6yRajjBO7r8HfHbnqyc3eDGYPrB6fhnc7wjrjXz9C+HLqmNALtuLwca0vfpdTqtrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534148; c=relaxed/simple;
	bh=KFaDAPKfM2HmPMVbVkz7VrTW3XXo+f0MOpGfLpNabmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MfkwEOUNWSdAF+Ori+aMtSnzUB51IBg1zSKpg398R9gFwOY4v7yHFP3ycRxCPQIIqb9+CtBiqLiNTl1DmkSiGYdHA1PRIKX7pyi/eOmjk2oaBkGnPcxzFnApNooI7eAjEtqfPPND0x3OpjW7E/dpBD6yDA/1kcwm4OthCyUYlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DWvr+AeF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DWvr+AeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KFaDAPKfM2HmPMVbVkz7VrTW3XXo+f0MOpGfLpNabmg=; b=D
	Wvr+AeFfbMpnUxum/pll/sqRn3+yDlqhRA616exB2sNt9nRSGPk/j2bj+4h1woZC
	7/w432cqSyQOQ2PGWAuyU4y1dUItBDCBaItKjzolGn/Alf5bucUzcrF5wO3XygL2
	LkjPgSciKgYJUS989PjlelRAC4MF94HxT3ABNxZ+R0=
Date: Wed, 16 Sep 2026 12:47:38 +0800 (CST)
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
Subject: Re:Re: [PATCH v7 08/15] gpiolib: regmap: add write_data_after_dir
 quirk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqlfJ3PnFib1smnV@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-8-3297d3fbc9c0@ambarella.com>
 <aqlfJ3PnFib1smnV@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/mYu0gu7iifY+kcn0wRhug/UMa4u/sm3YNXc+gGgS7rxD0iflpxF2DKzOe1GTqXuzGSbTdPyMZYULtmxAyHsDsqPgM1X0Q8/rJ0pQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20ea407c.4010.1a0a88ab987.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgD334NqH6pq2mBHAA--.23889W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgsnmGqqH2vUjgAA3c
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKCk9LLiB2OCB3aWxsIGlnbm9yZSBib3RoIGdwaW9fcmVnbWFwX3NldCgpIHJldHVy
bnMsIHNhbWUgYXMgYmVmb3JlLgpPbmx5IHRoZSBleHRyYSB3cml0ZSBmb3IgdGhlIFBMMDYxIHF1
aXJrIHN0YXlzLgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDktMTUgMjM6MDc6
MTksICJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
IHdyb3RlOgo+T24gVHVlLCBTZXAgMTUsIDIwMjYgYXQgMDc6MTU6MzhQTSArMDgwMCwgTG9uZyBa
aGFvIHZpYSBCNCBSZWxheSB3cm90ZToKPgo+PiBTb21lIGNvbnRyb2xsZXJzIGlnbm9yZSBkYXRh
LXJlZ2lzdGVyIHdyaXRlcyB3aGlsZSBhIGxpbmUgaXMgc3RpbGwgYW4KPj4gaW5wdXQuIE9wdGlv
bmFsbHkgd3JpdGUgdGhlIG91dHB1dCB2YWx1ZSBhZ2FpbiBhZnRlciBzd2l0Y2hpbmcgdGhlCj4+
IGRpcmVjdGlvbiwgbWF0Y2hpbmcgdGhlIGV4aXN0aW5nIFBMMDYxIGJlaGF2aW91ci4KPgo+Li4u
Cj4KPj4gLQlncGlvX3JlZ21hcF9zZXQoY2hpcCwgb2Zmc2V0LCB2YWx1ZSk7Cj4+ICsJcmV0ID0g
Z3Bpb19yZWdtYXBfc2V0KGNoaXAsIG9mZnNldCwgdmFsdWUpOwo+PiArCWlmIChyZXQpCj4+ICsJ
CXJldHVybiByZXQ7Cj4KPkkgdGhpbmsgdGhhdCB0aGlzIG1pZ2h0IGxlYWQgdG8gcmVncmVzc2lv
bnMgd2hlbiB0aGUgZW5kIGRyaXZlciBqdXN0IGxlYXZlcwo+dGhlIG91dHB1dCBpbiB0aGUgcHJl
dmlvdXMgc3RhdGUgaW4gY2FzZSBvZiBlcnJvcnMuIEluIGFueSBjYXNlLCBldmVuIGlmIHRoaXMK
PmlzIGEgY29ycmVjdCB1cGRhdGUsIGl0IG5lZWRzIHRvIGJlIGRvbmUgc2VwYXJhdGVseSB3aXRo
IHRoZSBqdXN0aWZpY2F0aW9uCj50aGF0IHNob3dzIHRoYXQgYWxsIGN1cnJlbnQgdXNlcnMgd29u
J3QgaGF2ZSByZWdyZXNzaW9ucyBvciB0aGUgcmVncmVzc2lvbiBpcwo+YWN0dWFsbHkgYSBmaXgg
b2YgdGhlIGJlaGF2aW91ci4KPgo+PiArCXJldCA9IGdwaW9fcmVnbWFwX3NldF9kaXJlY3Rpb24o
Y2hpcCwgb2Zmc2V0LCB0cnVlKTsKPj4gKwlpZiAocmV0KQo+PiArCQlyZXR1cm4gcmV0Owo+PiAg
Cj4+IC0JcmV0dXJuIGdwaW9fcmVnbWFwX3NldF9kaXJlY3Rpb24oY2hpcCwgb2Zmc2V0LCB0cnVl
KTsKPj4gKwkvKgo+PiArCSAqIGdwaW8gdmFsdWUgaXMgc2V0IGFnYWluLCBiZWNhdXNlIHBsMDYx
IGRvZXNuJ3QgYWxsb3cgdG8gc2V0IHZhbHVlIG9mCj4+ICsJICogYSBncGlvIHBpbiBiZWZvcmUg
Y29uZmlndXJpbmcgaXQgaW4gT1VUIG1vZGUuCj4+ICsJICovCj4+ICsJaWYgKGdwaW8tPndyaXRl
X2RhdGFfYWZ0ZXJfZGlyKQo+PiArCQlyZXR1cm4gZ3Bpb19yZWdtYXBfc2V0KGNoaXAsIG9mZnNl
dCwgdmFsdWUpOwo+Cj5UYWtpbmcgdGhlIGFib3ZlIGludG8gYWNjb3VudCBJJ20gbm90IHN1cmUg
aWYgd2Ugd2FudCB0aGUgaW5jb25zaXN0ZW5jeSB3aXRoCj50aGUgYWJvdmUuIFBlcmhhcHMgYWxz
byBpZ25vcmUgdGhlIHJldHVybmVkIHZhbHVlIGZvciBub3c/Cj4KPj4gKwlyZXR1cm4gMDsKPgo+
LS0gCj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cg==
