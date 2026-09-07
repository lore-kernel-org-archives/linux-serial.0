Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1F3043DB;
	Mon,  7 Sep 2026 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777113; cv=none; b=Dufai6N4WpggBLUUcVsKHEusI3VCU4HSwNknQIiVd9ZK5gvCZsxsfeiH4MfQzW15bWJ/LQbcwpE6VWWNx4f9lMC1605TR/ytn/wbMgZmm6AjVZ38sQPoL8ojoxXWT2+N9rVeAYMuW9qgS77F4s6H7QLy+1wroLx6lpnapzekIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777113; c=relaxed/simple;
	bh=izwwPFEZ2YDHlpNeAWpO9gjIXl3/uRvj1NTux/WAIB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JpBWGSyQ1is50/LCJV/BnPh07La3yXmmlhr8faGGzmCxFvVuZgzGHzXWTrK/XTgtHhfCrvpdtnB+hIFPuwa9rmHtT9i4l3ECW+Cn9dNpVv5rKjtO5ue2cFMIIRzpugtrAiUZUOtsGJUWmmmpG61JcEZ+99+a5P4vp+AR13teLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mz9s2nX1; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mz9s2nX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=izwwPFEZ2YDHlpNeAWpO9gjIXl3/uRvj1NTux/WAIB4=; b=m
	z9s2nX1g4LUKLmfdjmG1a2TzjIbwl9fjS8Zzru0oHZeUAVhTgNFR+KwATq79L4Fk
	cCUPFv89OTZQN2C3/3Y3owqWbabwjWCnuFWjPlmttiAOCqb1SV5iSTO+ilfURmQA
	JJJ5kFlAMZL8EiHr0W/BfDUxKNJ5obVNJgNP/TyEqs=
Date: Mon, 7 Sep 2026 18:29:47 +0800 (CST)
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
Subject: Re:Re: Re: [PATCH v6 08/13] gpio: regmap: support
 write_data_after_dir and girq
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <ap5BgWtHMAxl28wF@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
 <apqxwRgi-uVKkOpr@ashevche-desk.local>
 <27a1901.423e.1a07a183bd4.Coremail.zl020895@163.com>
 <ap5BgWtHMAxl28wF@ashevche-desk.local>
X-NTES-SC: AL_Qu2TCvucuUEj4SSaZ+kcn0wRhug/UMa4u/sm3YNXc+8GoC3f4joEek5lHXDK79C+JR6CqT2UbRFW0t1ffJNTQiBizjLGGro2SdHZZlp2GQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6ca46138.9970.1a07b6abb25.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kygvCgD3P+kbkp5qdBRBAA--.16072W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxhvsXmqekhuDRgAA3X
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKClRoYW5rcyBmb3IgdGhlIGJ4dHdjIHBvaW50ZXIuCgpJIGxvb2tlZCBhdCBtYXBw
aW5nIFBMMDYxIG9udG8gcmVnbWFwLWlycS4gU3RhdHVzL21hc2svYWNrIChNSVMvSUUvSUMpCmNv
dWxkIGZpdCwgYnV0IFBMMDYxIHN0aWxsIG5lZWRzIHRoZSBjaGFpbmVkIGRlbXV4IHBsdXMgSVMv
SUJFL0lFViB0eXBlCnByb2dyYW1taW5nIChpbmNsdWRpbmcgRURHRV9CT1RIKSBhbmQgdGhlIGV4
aXN0aW5nIGdwaW9jaGlwIGltbXV0YWJsZQpoZWxwZXJzLiBUaGF0IGxvb2tzIGxpa2UgYSBwb29y
IGZpdCB2ZXJzdXMgaWRpLTQ4L2J4dHdjLXN0eWxlIGNoaXBzLCBhbmQKc3dpdGNoaW5nIHRoZSBs
b25nLXN0YW5kaW5nIEFSTSBQTDA2MSBwYXRoIGZyb20gY2hhaW5lZCB0byB0aHJlYWRlZApyZWdt
YXAtaXJxIHNlZW1zIHJpc2t5LgoKV2hhdCBJIHBsYW4gZm9yIHRoZSBuZXh0IHJvdW5kICh3aXRo
b3V0IGV4dGVuZGluZyBncGlvLXJlZ21hcCB3aXRoIGdpcnEpOgprZWVwIHRoZSBjdXN0b20gaXJx
Y2hpcCArIGNoYWluZWQgaGFuZGxlciwgY3JlYXRlIHRoZSBpcnFfZG9tYWluIGluCmdwaW8tcGww
NjEsIGFuZCBwYXNzIGl0IHZpYSBjb25maWcuaXJxX2RvbWFpbiB0byBncGlvLXJlZ21hcC4KCkRv
ZXMgdGhhdCBtYXRjaCB3aGF0IHlvdSBoYWQgaW4gbWluZCwgb3IgZG8geW91IHN0aWxsIHByZWZl
ciBhCnJlZ21hcC1pcnEtYmFzZWQgYXBwcm9hY2g/CgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoK
QXQgMjAyNi0wOS0wNyAxMjo0NTo1MywgIkFuZHkgU2hldmNoZW5rbyIgPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj5PbiBNb24sIFNlcCAwNywgMjAyNiBhdCAxMjoy
MDowM1BNICswODAwLCB6bDAyMDg5NSB3cm90ZToKPgo+PiA+IEFyZSB5b3UgZ29pbmcgdG8gZml4
IHRoaXMgSFcgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgU29DPwo+PiBObyDigJQgQW1iYXJl
bGxhIGRvZXMgbm90IHVzZSB3cml0ZV9kYXRhX2FmdGVyX2Rpci4gSXQgb25seSBwcmVzZXJ2ZXMg
dGhlCj4+IGV4aXN0aW5nIEFSTSBQTDA2MSBxdWlyayBhbHJlYWR5IGRvY3VtZW50ZWQgaW4gZ3Bp
by1wbDA2MSAoZGF0YSB3cml0ZXMKPj4gaWdub3JlZCB3aGlsZSB0aGUgcGluIGlzIHN0aWxsIGFu
IGlucHV0KS4gT25seSBwbDA2MV9hcm0gc2V0cyB0aGUgZmxhZy4KPgo+QWgsIHRoaXMgaXMgYSBn
b29kIG5ld3MhCj4KPkluIGFueSBjYXNlIHdoZW4gZG9jdW1lbnRpbmcgdGhhdCBmbGFnLCBwbGVh
c2UgYWxzbyBtZW50aW9uIHRoYXQgYW55IG5ldyBIVwo+c2hvdWxkIG5vdCB1c2UgaXQgYXMgaXQn
cyBjb25zaWRlcmVkIGJ1Z2d5IChnbGl0Y2hlcyBkdXJpbmcgZGlyZWN0aW9uIGNoYW5nZQo+YXJl
IGd1YXJhbnRlZWQpLgo+Cj4+IEkgd2lsbCBhbHNvIG1ha2UgdGhlIGZpcnN0IGdwaW9fcmVnbWFw
X3NldCgpIGNvbmRpdGlvbmFsIHNvIHRoZSBxdWlyawo+PiBwYXRoIHdyaXRlcyBvbmNlIGFmdGVy
IGRpcmVjdGlvbl9vdXRwdXQsIG5vdCB0d2ljZS4KPgo+SSBzZWUgdGhhdCBvcmlnaW5hbCBwbDA2
MSBhY3R1YWxseSB3cml0ZXMgdHdpY2UuIFRCSCBJIGRvbid0IGtub3cgdGhlIGJlc3QKPmVmZm9y
dCBoZXJlIGFuZCBpZiBpdCdzIHJlYWxseSByZXF1aXJlZCB0byBkbyBzby4gUHJvYmFibHkgb3Ro
ZXJzIGhhdmUKPmJldHRlciBpZGVhcy4uLgo+Cj4+ID4gVGhpcyBuZWVkcyB0byBiZSBpbiBhIHNl
cGFyYXRlIHVwZGF0ZS4gQWxzbyB3ZSBuZWVkIHRvIHVuZGVyc3RhbmQgd2h5Cj4+ID4gaXQgaXMg
cmVxdWlyZWQuCj4+IE9LLCBnaXJxIHdpbGwgYmUgYSBzZXBhcmF0ZSBwYXRjaC4gUEwwNjEga2Vl
cHMgYSBjdXN0b20gY2hhaW5lZAo+PiBpcnFjaGlwIChub3QgcmVnbWFwLWlycSk7IGdwaW9fcmVn
bWFwIHRvZGF5IG9ubHkgdGFrZXMgaXJxX2RvbWFpbiBvcgo+PiByZWdtYXBfaXJxX2NoaXAsIHNv
IHdlIHBhc3NlZCBnaXJxIHRvIGtlZXAgdGhlIHVzdWFsIGdwaW9faXJxX2NoaXAgKwo+PiBncGlv
Y2hpcF9hZGQgZmxvdy4gT3BlbiB0byB1c2luZyBhIGNhbGxlci1jcmVhdGVkIGlycV9kb21haW4g
aW5zdGVhZCBpZgo+PiB5b3UgcHJlZmVyLgo+Cj5JZiB0aGVyZSBpcyBhIGNoYWluZWQgSVJRLCBs
b29rIGhvdyBQTUlDIGRyaXZlcnMgdXN1YWxseSBkbyBzaW1pbGFyIHNldHVwcy4KPkZpcnN0IHdo
YXQgY29tZXMgdG8gbXkgbWluZCBpcyBkcml2ZXJzL21mZC9pbnRlbF9zb2NfcG1pY19ieHR3Yy5j
Lgo+Cj4tLSAKPldpdGggQmVzdCBSZWdhcmRzLAo+QW5keSBTaGV2Y2hlbmtvCj4K
