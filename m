Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0D52CCDD;
	Tue, 22 Sep 2026 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067828; cv=none; b=LgiOs7HYMjW1iRIJajiJd0+L03oQdj8e8UEOmJovg48oOgsDJFym+eyzuUA0RAkYzOkZ2mFa+EFrc991IjUTElVugXRZQEsQKVKmmTuc1AEs6Ydri2GWy/lJLsi7wuMYanofoxuA6W+NkqkteQkpONIm9Rvtdz2IXNMOMrmhNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067828; c=relaxed/simple;
	bh=sMJE4hNbjphW0GvkigJLBEzXqY1LqCjd/zuEvelbozM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KQmihAJ9NZ5VH1XouKQF0Tzpqvjf/bs2lTSVS8U2fugXIKsbxB9ZT0SI9O8lfW/XetNkKnAuIan2xo8PqJB/uztGIoeEaIVaDGXu2tn7VWR+3JpptecTzyCWo/mMSwM7SAq9c7TLf6z4RloRwqCjpjqB6ysjaaRBYL313mmD2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=er9AjLnn; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="er9AjLnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sMJE4hNbjphW0GvkigJLBEzXqY1LqCjd/zuEvelbozM=; b=e
	r9AjLnnLYALemIC2MdYQiKsDylh2yKtRFp1tzUhGSrgiJV4PbY5vs4DZt7Sd/XIZ
	hB5tvgBvP+zdnfbYSXB3+MkiZKJ4wqyAAeFnD9ET05UPPdB64719VMt2K8gX8jlA
	08dDlknEf7R9T+I5ZZ4hVq11QJcckS0/dAhYvEDHoM=
Date: Tue, 22 Sep 2026 17:02:23 +0800 (CST)
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
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re:Re: Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLkZ9F3_KQwGDZyKaFYBzO9PXVq+5v8geFE+oOM47KmagQ@mail.gmail.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <CAD++jLkCNkcf-gn0FgvLZZTibLUvbKaH6L+=nRqkNZr2iKFqsQ@mail.gmail.com>
 <39641ec4.7a73.1a0c848bfa4.Coremail.zl020895@163.com>
 <CAD++jLkZ9F3_KQwGDZyKaFYBzO9PXVq+5v8geFE+oOM47KmagQ@mail.gmail.com>
X-NTES-SC: AL_Qu2SAvyduE8v5SWRZukcn0wRhug/UMa4u/sm3YNXc84FpwPw5QMjZmNDNHL32tKTBxilqxOseRpTx8lTXqZ3SWk2S31eMJkw9vz6qHwtgQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <14afb3f3.803a.1a0c85a1b75.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgD3PyYfRLJq18cVAA--.40048W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxh9f0GqyRB-tfAAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTGludXMsCgpJIHNlZSwgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gCkkgd2lsbCBh
ZGQgdGhlIGBBc3Npc3RlZC1ieTogTExNYCB0YWcgaW4gZWFjaCBwYXRjaCBmb3IgdGhlIG5leHQg
cmVzcGluLgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0IDIwMjYtMDktMjIgMTY6NTI6NTIs
ICJMaW51cyBXYWxsZWlqIiA8bGludXN3QGtlcm5lbC5vcmc+IHdyb3RlOgo+T24gVHVlLCBTZXAg
MjIsIDIwMjYgYXQgMTA6NDTigK9BTSB6bDAyMDg5NSA8emwwMjA4OTVAMTYzLmNvbT4gd3JvdGU6
Cj4KPj4gTm8gTExNIHdhcyB1c2VkIGZvciBjb2Rpbmcgb3IgdGVzdGluZy4gRGlmZmVyZW50IGRl
dmVsb3BlcnMgYXJlIHJlc3BvbnNpYmxlIGZvcgo+PiBkaWZmZXJlbnQgcGFydHMgb2YgdGhlIGNv
ZGUuIExMTSB3YXMgb25seSB1c2VkIHRvIHBvbGlzaCBjb21taXQgbWVzc2FnZXMuCj4+IENvdWxk
IHlvdSBhZHZpc2Ugd2hldGhlciBJIHN0aWxsIG5lZWQgdG8gZGlzY2xvc2UgdGhpcz8KPgo+V2Ug
YWRkIGl0IGV2ZW4gaWYgaXQganVzdCB1c2VkIGZvciBjb21taXQgbWVzc2FnZXMsIHdlIGRvbid0
IHJlYWxseQo+ZGlmZmVyZW50aWF0ZS4KPgo+TWF5YmUgdGhpcyBpcyB0byBjb2Fyc2UgYnV0IGl0
J3Mgd2hhdCB3ZSBoYXZlLgo+Cj5UaGUgdGFnIGRvZXNuJ3QgcmVhbGx5IG1lYW4gbXVjaCwgaXQg
anVzdCBtZWFuICJhbiBMTE0gd2FzCj5pbnZvbHZlZCB3aXRoIHNvbWV0aGluZyByZWxhdGVkIHRv
IHRoaXMgcGF0Y2giLCBpdCBjb3VsZAo+aGF2ZSBiZWVuIHVzZWQganVzdCBmb3IgdGVzdGluZyBv
ciByZXZpZXcuCj4KPlNpbmNlIHdlIGhhdmUgU2FzaGlrbyByZXZpZXdpbmcgZXZlcnl0aGluZyBJ
IGd1ZXNzIGluIHRoZW9yeQo+d2Ugc2hvdWxkIGV2ZW4gYWRkIGl0IGlmIHdlIGxvb2tlZCBhdCB0
aGUgU2FzaGlrbyByZXZpZXdzLAo+YnV0IG5vYm9keSBkb2VzIHRoYXQuIFNvIGl0J3MgYSBiaXQg
YXJiaXRyYXJ5LiBOb2JvZHkncyBnb25uYQo+YmUgdXBzZXQgYWJvdXQgZWl0aGVyLCBpdCdzIGp1
c3Qgc29tZSBoZWxwZnVsIG1ldGFkYXRhLgo+Cj5Zb3VycywKPkxpbnVzIFdhbGxlaWoK
