Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A1421239;
	Mon, 21 Sep 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989032; cv=none; b=NruZC06kbBhyqCTBQUqpENm78dqJ1Xcj+21cEcPqTI5JoYucIha/GoDyuTSndplAYQTILJ/EzUpciCRlaNxG74obnQBy1i55DY/XEHlD3e0ASkKjIH9a+VSzYDRT9cu07NIl/nU7Pgl/bvzgSEKrnGuCIjx01wQBpI2hVgMVS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989032; c=relaxed/simple;
	bh=1BhpQZoAXGVHhCY2yPQOy2cprPNEspiRapZr8208ImA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ei5hXY6kZgK+KgSplcBOuPFdfv3gbFuCQgb8tVoUxDyXaJ5eyZLOyAA4+KGzEJywNGUieBMvUNBPsAY99/tH5UTBXWgJHmuS2D+1uTn0HPnect+8Gj2ooPIgx0zP5MT9lZ55xWUQ6Ei6WjJrmqk+yavdoNso1dnM6PZVhrb7c7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e+cHLb2E; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e+cHLb2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1BhpQZoAXGVHhCY2yPQOy2cprPNEspiRapZr8208ImA=; b=e
	+cHLb2EsoCJmyv5IQM9q0sqiir1Lv71mBv80vQnaKLgpB66FeKfHDB22f4OxAXsT
	YlEkv1c5YP+QgfMfc3gFGTFXs/blWnWK4cAhKXR1FQtwWLlZDbUifAVtv52YRxA6
	VyiDIwOpZjj1P+MtR2DXrhnthimjQTFHDMsLDQarek=
Date: Mon, 21 Sep 2026 19:08:48 +0800 (CST)
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
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re:Re: [PATCH v8 00/18] Ambarella CV75 SoC minimal bring-up
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAMRc=Mf-0oLOPZsPboE0dzOGE2AzNE0LXmv9fcmgWO47FtGu1g@mail.gmail.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <CAMRc=Mf-0oLOPZsPboE0dzOGE2AzNE0LXmv9fcmgWO47FtGu1g@mail.gmail.com>
X-NTES-SC: AL_Qu2TC/WTt0Ep7iiZZukcn0wRhug/UMa4u/sm3YNXc+oEoxnL1BEgV2ZqNGrf3+6vEQOojDKXWThy0/tgZolRgdClO9P1d1YqDPcyYtmcnA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c90c1c.9973.1a0c3a77d36.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgD3d8BAELFqlexLAA--.37435W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgAbjGqxEEAmzQAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzLCBCYXJ0LiAKClBsZWFzZSBxdWV1ZSB0aGUgR1BJTyBwYXRjaGVzIHlvdXJzZWxmIGFu
ZCBwcm92aWRlIGFuIGltbXV0YWJsZQpicmFuY2ggZm9yIHRoZSBTb0MgdHJlZS4KClRoZSBHUElP
IHBhcnQgaXM6CiAgZ3Bpb2xpYjogcmVnbWFwOiBhZGQgd3JpdGVfZGF0YV9hZnRlcl9kaXIgcXVp
cmsKICBncGlvbGliOiByZWdtYXA6IGFkZCBncGlvX3JlZ21hcF9nZXRfY2hpcCgpCiAgZ3Bpbzog
cGwwNjE6IGNvbnZlcnQgcmVnaXN0ZXIgYWNjZXNzIHRvIHJlZ21hcAogIGdwaW86IHBsMDYxOiB1
c2UgSVJRX1RZUEVfTEVWRUxfTUFTSyBhbmQgSVJRX1RZUEVfRURHRV9CT1RICiAgZ3BpbzogcGww
NjE6IHVzZSBjbGVhbnVwIGhlbHBlcnMgZm9yIGxvY2tzCiAgZ3BpbzogcGwwNjE6IHN3aXRjaCBk
YXRhIHBhdGggdG8gZ3Bpby1yZWdtYXAKICBncGlvOiBwbDA2MTogYWRkIEFtYmFyZWxsYSByZWdp
c3Rlci1sYXlvdXQgdmFyaWFudAoKSSB3aWxsIHNlbmQgYSBmb2xsb3ctdXAgZm9yIGdwaW9fcmVn
bWFwX2dldF9jaGlwKCkgd2l0aCB0aGUgbWlzc2luZwprZXJuZWwtZG9jLiBUaGUgcmVzdCBvZiB0
aGUgc2VyaWVzIChjbGssIHBpbmN0cmwsIFVBUlQsIERUKSBjYW4gc3RheQp3aXRoIHRoZSBTb0Mg
dHJlZSBvbmNlIHRoYXQgR1BJTyBicmFuY2ggaXMgYXZhaWxhYmxlLgoKQmVzdCByZWdhcmRzLApM
b25nIFpoYW8KCkF0IDIwMjYtMDktMjEgMTg6MzE6NDUsICJCYXJ0b3N6IEdvbGFzemV3c2tpIiA8
YnJnbEBrZXJuZWwub3JnPiB3cm90ZToKPk9uIE1vbiwgMjEgU2VwIDIwMjYgMDY6MjM6MTkgKzAy
MDAsIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkKPjxkZXZudWxsK2xvbmd6aGFvLmFtYmFyZWxsYS5j
b21Aa2VybmVsLm9yZz4gc2FpZDoKPj4gVGhpcyBzZXJpZXMgYWRkcyBtaW5pbWFsIEFtYmFyZWxs
YSBDVjc1IHN1cHBvcnQgZm9yIGVhcmx5IGJyaW5nLXVwIHdpdGgKPj4gYSBzZXJpYWwgY29uc29s
ZTogRFQgYmluZGluZ3MsIFJDVCBjbG9ja3MsIHBpbmN0cmwsIFBMMDYxIEdQSU8gdmlhCj4+IGdw
aW8tcmVnbWFwLCA4MjUwX2R3IFVBUlQgcXVpcmtzLCBBUkNIX0FNQkFSRUxMQSwgQ1Y3NSBFVksg
RFQsIGFuZAo+PiBNQUlOVEFJTkVSUy4KPj4KPj4gVGhpcyBpcyBhIHNpbmdsZSB1bmlmaWVkIHNl
cmllcy4gUGxlYXNlIGFwcGx5IHZpYSB0aGUgU29DCj4+IHRyZWU7IHN1YnN5c3RlbSBtYWludGFp
bmVycyBhcmUgQ2MnZCBmb3IgdGhlaXIgcGllY2VzLgo+Pgo+Cj5BcyBJIHNhaWQgYmVmb3JlOiB0
aGlzIGJyaW5ncyBpbiBhIGxvdCBvZiBwb3RlbnRpYWxseSBjb25mbGljdGluZyBjb2RlIGludG8K
PmRyaXZlcnMvZ3Bpby8gc28gSSdsbCBuZWVkIGFuIGltbXV0YWJsZSBicmFuY2ggdG8gcHVsbCBv
ciBJIGNhbiBxdWV1ZSB0aGUgR1BJTwo+cGFydCBteXNlbGYgYW5kIHByb3ZpZGUgYW4gaW1tdXRh
YmxlIGJyYW5jaCB0byBvdGhlciB0cmVlcy4KPgo+QmFydG9zego=
