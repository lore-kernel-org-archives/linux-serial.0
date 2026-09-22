Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB43B6C1D;
	Tue, 22 Sep 2026 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051044; cv=none; b=IIPl1G7vBWsoThE+ABzdHZy3zpx8wO8mS1IH4f2sB1XFWbQQ1kxd6l1g+j33BnqeS2u1mTWrAOMHRC/q1jnlM6JlOkFIUpp5Uk7bJYSjkhuYxUrDa6yTllYIMd0W7eQVONalUL2kjImMfZESwsLdnVkAQWDHUniTg2SDsLMLPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051044; c=relaxed/simple;
	bh=IaZTkgojwJAJQrGoC5NhOOXweXtHWAmBtxxIT+eq7m8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=t6xBtTygpFzzentavBTpkARwrb+bJq/fpoeukDlb6NZBI4PPu6TrSRnVcThojuTFAG7vzcjOqoswDzep+Dwi7vaxVm4kvb/J3afTdWaysz1MuMjCvnEY7zNvRT7xUx9x6hC8ZWGxWvKFw+2X2Vbb5vcj9kJyU9HlXgB9Cfmq2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TCiseVed; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TCiseVed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=IaZTkgojwJAJQrGoC5NhOOXweXtHWAmBtxxIT+eq7m8=; b=T
	CiseVed5aJoM1GxB2UT7ds/Rp3AafmFqIAbVuw+cq3fjToCfaYfRj6HkG4qlXtpT
	5xltHD5JpBnWjZQMP1PxtZWoktrS1iPvjoUcjq29xfFyFjx753g5lkcHceiPu78P
	khUsFoj3IoCW5iqRRk1lZV9w5A1dLl5Jqd/Zd+e6hM=
Date: Tue, 22 Sep 2026 12:22:08 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Michael Walle" <michael@walle.cc>
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
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
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
In-Reply-To: <DLL08SC6PWNS.2BUBIQYMBWIKQ@walle.cc>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-9-3297d3fbc9c0@ambarella.com>
 <DLL08SC6PWNS.2BUBIQYMBWIKQ@walle.cc>
X-NTES-SC: AL_Qu2SAvyev0Ep7iaRY+kcn0wRhug/UMa4u/sm3YNXc8IFsjzg4iUlVkNgBVjUyuKtIgyxmweLaAZBxvZ/ZKZCK59HEukBAsUwbKJ7cS4L4w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <650e4694.3f81.1a0c7598840.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgDn7+lwArJqGTJMAA--.1210W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxRDjVWqyAnCc3gAA3L
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTWljaGFlbCwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCmdwaW8tcmVnbWFwIGNhbiBhbHJl
YWR5IGF0dGFjaCBhIGRvbWFpbiB2aWEgY29uZmlnLmlycV9kb21haW4gb3IKcmVnbWFwX2lycV9j
aGlwLiBQTDA2MSBjYW5ub3QgdXNlIHJlZ21hcC1pcnE6IHR5cGUgaXMgcHJvZ3JhbW1lZCBpbgpJ
Uy9JQkUvSUVWIChpbmNsdWRpbmcgYm90aC1lZGdlKSBhbmQgdGhlIHBhcmVudCBJUlEgaXMgYW4g
QU1CQSBjaGFpbmVkCmRlbXV4LgoKSW4gdjggdGhlIGN1c3RvbSBsaW5lYXIgZG9tYWluIHVzZWQg
dGhlIGdwaW9fY2hpcCBhcyBob3N0X2RhdGEsIGFuZAp0aGF0IGNoaXAgb25seSBleGlzdHMgYWZ0
ZXIgZ3Bpb19yZWdtYXBfcmVnaXN0ZXIoKSwgc28gSSBhZGRlZApncGlvX3JlZ21hcF9nZXRfY2hp
cCgpLgoKSSBjYW4gZHJvcCB0aGUgaGVscGVyOiBjcmVhdGUgdGhlIGRvbWFpbiB3aXRoIHRoZSBQ
TDA2MSBwcml2YXRlIGRhdGEgYXMKaG9zdF9kYXRhLCBwYXNzIGl0IGluIGNvbmZpZy5pcnFfZG9t
YWluLCBhbmQgbGV0IGdwaW8tcmVnbWFwIHJlZ2lzdGVyCml0LiBJIHdpbGwgZG8gdGhhdCBpbiB0
aGUgbmV4dCByZXZpc2lvbiBpZiB5b3UgYWdyZWUuCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoK
QXQgMjAyNi0wOS0yMSAyMDo0ODo0NCwgIk1pY2hhZWwgV2FsbGUiIDxtaWNoYWVsQHdhbGxlLmNj
PiB3cm90ZToKPk9uIFR1ZSBTZXAgMTUsIDIwMjYgYXQgMToxNSBQTSBDRVNULCBMb25nIFpoYW8g
dmlhIEI0IFJlbGF5IHdyb3RlOgo+PiBGcm9tOiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxs
YS5jb20+Cj4+Cj4+IExldCBkcml2ZXJzIHRoYXQgaW1wbGVtZW50IGEgY3VzdG9tIGlycWNoaXAg
cmV0cmlldmUgdGhlIGdwaW9fY2hpcAo+PiBhZnRlciByZWdpc3RyYXRpb24uIEF0dGFjaCBhIGNh
bGxlci1wcm92aWRlZCBpcnFfZG9tYWluIG9ubHkgd2hlbiBpdAo+PiBpcyBwcmVzZW50Lgo+Cj5T
byB3aHkgZG8gd2UgbmVlZCB0aGlzPyBXaHkgY2FuJ3QgZ3Bpby1yZWdtYXAgcmVnaXN0ZXIgdGhl
Cj5pcnFfZG9tYWluPwo+Cj4tbWljaGFlbAo=
