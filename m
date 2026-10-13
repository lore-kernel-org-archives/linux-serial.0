Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4552CCEB;
	Tue, 13 Oct 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914045; cv=none; b=lD4yUvEDM9AIdjm3Mqs78hK9eIEYGmQ2vVTyYddY2+yPwgRXYJmNsEIQztshUIOL5A0Zd5KT0mx8JjO6dD4k2CdtT40CMjr399KuuwZV0Ikik9m6R/nr+kLPM2Y9cybsPE+kL5cXg/cgzfPYYQ16F85SktGlSlRELSeQlMw5/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914045; c=relaxed/simple;
	bh=hp1dTw3hRxiZBvSzxIR3eaRSSMR6S7lRt7/KxcL7YmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UMQJkSxW7BYTfdk6GaaiDxU9w1vnnTdK3PtPQvySHxXgdK3z2WgIAf5CtgwwYCyOQOOBPJBPCFwDQaIQ3RDorzm8z3nMEilx78MFyW0I7COm8Z8iMdN7jADl4QwP+/k53RiikeoTmwfvPWJHaPOighGYfzUul/7SarsktK8isKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OWFaVuM9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OWFaVuM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hp1dTw3hRxiZBvSzxIR3eaRSSMR6S7lRt7/KxcL7YmU=; b=O
	WFaVuM93IWPWVHz1DROYW7egfZ3MO/d1MdS/gA7+Jxi5NWJd4PoZrmiHx15AKVZ2
	4UM4Cwvntj02QhgfOh2yUzLuhNFwL2fTm+PsC0+Y4zrcQoHKQKUn5ibm288MEAes
	5R0lW7gOOP+J72R9BCZBMfN7yGrWIPetla+gvN6Ux0=
Date: Wed, 14 Oct 2026 01:51:46 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Linus Walleij" <linusw@kernel.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, longzhao@ambarella.com,
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
Subject: Re:Re: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella
 CV75 pinctrl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLmrQwAT1Sb8HGgoM8x48rN9-pPT2RB1GE18h5YA7c4CwQ@mail.gmail.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
 <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org>
 <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
 <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org>
 <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
 <56dc6c05-7fd6-43de-bc62-c353ae1dbcc3@kernel.org>
 <54b55ad7.9d3a.1a135b09587.Coremail.zl020895@163.com>
 <CAD++jLmrQwAT1Sb8HGgoM8x48rN9-pPT2RB1GE18h5YA7c4CwQ@mail.gmail.com>
X-NTES-SC: AL_Qu2SA/WavEEr4CaeZekdnUoTj+Y/XMK0uvwk1YdVc8gEnjjMwxonRUZAE2Xr9+a2LgydoDuVWhh8yd55fo9x/FIZB3Lpfw2lhbgiuZUShQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <69bf6d9d.a86d.1a1366451f1.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3NyGyb85qV71XAA--.16978W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7hJWx2rOb7KL3QAA3C
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMTAtMTQgMDA6Mzg6NDAsICJMaW51cyBXYWxsZWlqIiA8bGludXN3QGtlcm5lbC5v
cmc+IHdyb3RlOgo+T24gVHVlLCBPY3QgMTMsIDIwMjYgYXQgNDozNuKAr1BNIHpsMDIwODk1IDx6
bDAyMDg5NUAxNjMuY29tPiB3cm90ZToKPgo+PiBXb3VsZCB0aGlzIHdvcms/OiBJIHNlbmQgYSBz
dGFuZGFsb25lCj4+ICJkdC1iaW5kaW5nczogdmVuZG9yLXByZWZpeGVzOiBhZGQgQW1iYXJlbGxh
IiBwYXRjaCB0byBSb2Igd2l0aCBvbmx5Cj4+IHRoZSB0d28gbGluZXMgaW4gdmVuZG9yLXByZWZp
eGVzLnlhbWwsIGFuZCBkcm9wIHRoYXQgaHVuayBmcm9tIHRoZQo+PiBTb0Mgc2VyaWVzLiBPbmNl
IHRoZSBwcmVmaXggaXMgaW4gbGludXgtbmV4dCwgdGhlIHZlbmRvci1wcmVmaXgKPj4gd2Fybmlu
Z3Mgc2hvdWxkIGJlIGZpeGVkLiBUaGUgcmVtYWluaW5nIGV4YW1wbGUgbWF0Y2hlcywgc3VjaCBh
cwo+PiBhbWJhcmVsbGEsZHJpdmUtc3RyZW5ndGgtc3lzY29uLCBzdGlsbCBuZWVkIHRoZSBzZXBh
cmF0ZQo+PiBHUElPL1VBUlQvcGluY3RybCBiaW5kaW5ncy4KPgo+VGhhdCB3b3JrcyBmb3IgbWUg
YW5kIHNvbHZlcyBteSBwcm9ibGVtIHNvIGdvIGFoZWFkLgo+Cj5Zb3VycywKPkxpbnVzIFdhbGxl
aWoKClNlbnQ6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTAxNC1jdjc1LXByZWZp
eC12MS0xLWZlOTVlZDU2Nzg4MEBhbWJhcmVsbGEuY29tCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhh
bwo=
