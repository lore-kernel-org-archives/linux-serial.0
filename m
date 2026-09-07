Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBD30BB8A;
	Mon,  7 Sep 2026 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754895; cv=none; b=hxiGsuobai3Ppz1qex3Ep/5rR94czUgGvb5ks6ToSJL0Z5ld6Umqi9yKR39pS+wzkA53pCut7dsRex2tYI2lQfynOB4V6qWJ/im8fblnyxcMdbaJpdnxUUzpMh7awN/H4BxMmQyqTq9Q646ZzkaB06inrZdZk84JnsLwftU6R7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754895; c=relaxed/simple;
	bh=2cfVrGf/6fhWtnLXtJ4VBUjuiuAjaAyY8FRSTVbYPg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=R6kMiXaYsB2ZpySYxF62C3iDM0feHeZVuosQe6BILfZ/RhoTIj5PJ/ubbb4Ja9Y9A3m+7qK4bndaO7wCfNfASjkvqmxT8eXJZbsqLynPV8zgNnpVf1/WjjCUldKlhbLvfDBFgzJUxN/U5/tZq7ua/hFsanTPBMi/VIuXfC1ht/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qkjd8pGr; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qkjd8pGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2cfVrGf/6fhWtnLXtJ4VBUjuiuAjaAyY8FRSTVbYPg4=; b=Q
	kjd8pGridspGjjfoRVnbq/cHltdZmFKxzqz+Rp8c+ZDYSp1tJ8S7kRhlu9hDYMRg
	uPL/WxpTPcD7HhBk/Dek+ESHnqEoyc41nMjrdJAaGCP6d7TGraWUbJ3cPhhc6acZ
	hp+FPS92g9V3qcvKQytkLXdFVNt4Nu/xt4sVuNtGAc=
Date: Mon, 7 Sep 2026 12:20:03 +0800 (CST)
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
Subject: Re:Re: [PATCH v6 08/13] gpio: regmap: support write_data_after_dir
 and girq
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <apqxwRgi-uVKkOpr@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
 <apqxwRgi-uVKkOpr@ashevche-desk.local>
X-NTES-SC: AL_Qu2TCvueu0Ar5SadZukcn0wRhug/UMa4u/sm3YNXc+8EliryyzkeY0JmJHTvyeuSICCvqhG3WSVSyu1/eZZgGVw+yjmHJBRyn3VJ6zVaxQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <27a1901.423e.1a07a183bd4.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aCgvCgD3dzNzO55qTf9AAA--.18980W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxhMtnmqeO3OlvgAA3B
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCj4gQXJlIHlvdSBnb2luZyB0byBmaXgg
dGhpcyBIVyBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBTb0M/Ck5vIOKAlCBBbWJhcmVsbGEg
ZG9lcyBub3QgdXNlIHdyaXRlX2RhdGFfYWZ0ZXJfZGlyLiBJdCBvbmx5IHByZXNlcnZlcyB0aGUK
ZXhpc3RpbmcgQVJNIFBMMDYxIHF1aXJrIGFscmVhZHkgZG9jdW1lbnRlZCBpbiBncGlvLXBsMDYx
IChkYXRhIHdyaXRlcwppZ25vcmVkIHdoaWxlIHRoZSBwaW4gaXMgc3RpbGwgYW4gaW5wdXQpLiBP
bmx5IHBsMDYxX2FybSBzZXRzIHRoZSBmbGFnLgoKSSB3aWxsIGFsc28gbWFrZSB0aGUgZmlyc3Qg
Z3Bpb19yZWdtYXBfc2V0KCkgY29uZGl0aW9uYWwgc28gdGhlIHF1aXJrCnBhdGggd3JpdGVzIG9u
Y2UgYWZ0ZXIgZGlyZWN0aW9uX291dHB1dCwgbm90IHR3aWNlLgoKPiBUaGlzIG5lZWRzIHRvIGJl
IGluIGEgc2VwYXJhdGUgdXBkYXRlLiBBbHNvIHdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aHkKPiBp
dCBpcyByZXF1aXJlZC4KT0ssIGdpcnEgd2lsbCBiZSBhIHNlcGFyYXRlIHBhdGNoLiBQTDA2MSBr
ZWVwcyBhIGN1c3RvbSBjaGFpbmVkCmlycWNoaXAgKG5vdCByZWdtYXAtaXJxKTsgZ3Bpb19yZWdt
YXAgdG9kYXkgb25seSB0YWtlcyBpcnFfZG9tYWluIG9yCnJlZ21hcF9pcnFfY2hpcCwgc28gd2Ug
cGFzc2VkIGdpcnEgdG8ga2VlcCB0aGUgdXN1YWwgZ3Bpb19pcnFfY2hpcCArCmdwaW9jaGlwX2Fk
ZCBmbG93LiBPcGVuIHRvIHVzaW5nIGEgY2FsbGVyLWNyZWF0ZWQgaXJxX2RvbWFpbiBpbnN0ZWFk
IGlmCnlvdSBwcmVmZXIuCgo+IElzIHBhaG9sZSBoYXBweSB3aXRoIHRoZSBsYXlvdXQ/CldpbGwg
Y2hlY2sgYW5kIHJlb3JkZXIgaWYgbmVlZGVkLgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0
IDIwMjYtMDktMDQgMTk6NTU6NDUsICJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+T24gRnJpLCBTZXAgMDQsIDIwMjYgYXQgMDI6Mzg6
MTVQTSArMDgwMCwgTG9uZyBaaGFvIHZpYSBCNCBSZWxheSB3cm90ZToKPgo+VGhhbmtzIGZvciB0
aGlzIGNoYW5nZSwgbXkgY29tbWVudHMgYmVsb3cuCj4KPj4gQWRkIGFuIG9wdGlvbmFsIHdyaXRl
LWFmdGVyLWRpcmVjdGlvbi1vdXRwdXQgcXVpcmsgZm9yIGNvbnRyb2xsZXJzCj4+IHRoYXQgaWdu
b3JlIGRhdGEtcmVnaXN0ZXIgd3JpdGVzIHdoaWxlIGEgbGluZSBpcyBzdGlsbCBjb25maWd1cmVk
IGFzCj4+IGlucHV0LAo+Cj5UaGUgY2hpcHMgdGhhdCByZXF1aXJlIHRoaXMgYXJlIGJ1Z2d5LiBB
cmUgeW91IGdvaW5nIHRvIGZpeCB0aGlzIEhXIGluIHRoZSBuZXh0Cj52ZXJzaW9uIG9mIHRoZSBT
b0M/Cj4KPj4gYW5kIGFsbG93IGRyaXZlcnMgdG8gcGFzcyBhbiBleGlzdGluZyBncGlvX2lycV9j
aGlwIHRocm91Z2gKPj4gZ3Bpb19yZWdtYXBfcmVnaXN0ZXIoKSBzbyBJUlEgc2V0dXAgY2FuIHN0
YXkgd2l0aCB0aGUgY2FsbGVyLgo+Cj5UaGlzIG5lZWRzIHRvIGJlIGluIGEgc2VwYXJhdGUgdXBk
YXRlLiBBbHNvIHdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aHkKPml0IGlzIHJlcXVpcmVkLiBUaGUg
Y2FsbGVyIHNob3VsZCBiZSBhYmxlIHRvIGNyZWF0ZSB0aGUgcmVzcGVjdGl2ZSBJUlEKPmRvbWFp
biB3aGljaCBpcyBpbXBvcnRhbnQuCj4KPi4uLgo+Cj4+IHN0cnVjdCBncGlvX3JlZ21hcCB7Cj4+
ICAJdW5zaWduZWQgaW50IHJlZ19kaXJfb3V0X2Jhc2U7Cj4+ICAJdW5zaWduZWQgbG9uZyAqZml4
ZWRfZGlyZWN0aW9uX21hc2s7Cj4+ICAJdW5zaWduZWQgbG9uZyAqZml4ZWRfZGlyZWN0aW9uX291
dHB1dDsKPj4gKwlib29sIHdyaXRlX2RhdGFfYWZ0ZXJfZGlyOwo+Cj5JcyBgcGFob2xlYCBoYXBw
eSB3aXRoIHRoZSBsYXlvdXQ/Cj4KPj4gICNpZmRlZiBDT05GSUdfUkVHTUFQX0lSUQo+PiAgCWlu
dCByZWdtYXBfaXJxX2xpbmU7Cj4KPi4uLgo+Cj4+IHN0YXRpYyBpbnQgZ3Bpb19yZWdtYXBfZGly
ZWN0aW9uX291dHB1dChzdHJ1Y3QgZ3Bpb19jaGlwICpjaGlwLAo+Cj4+ICAJZ3Bpb19yZWdtYXBf
c2V0KGNoaXAsIG9mZnNldCwgdmFsdWUpOwo+Cj5eXl4gKHNlZSBiZWxvdykKPgo+PiAgCj4+IC0J
cmV0dXJuIGdwaW9fcmVnbWFwX3NldF9kaXJlY3Rpb24oY2hpcCwgb2Zmc2V0LCB0cnVlKTsKPj4g
KwlyZXQgPSBncGlvX3JlZ21hcF9zZXRfZGlyZWN0aW9uKGNoaXAsIG9mZnNldCwgdHJ1ZSk7Cj4+
ICsJaWYgKHJldCkKPj4gKwkJcmV0dXJuIHJldDsKPj4gKwo+PiArCS8qIFNvbWUgY29udHJvbGxl
cnMgaWdub3JlIGRhdGEgd3JpdGVzIHdoaWxlIHRoZSBsaW5lIGlzIHN0aWxsIGFuIGlucHV0LiAq
Lwo+PiArCWlmIChncGlvLT53cml0ZV9kYXRhX2FmdGVyX2RpcikKPj4gKwkJZ3Bpb19yZWdtYXBf
c2V0KGNoaXAsIG9mZnNldCwgdmFsdWUpOwo+Cj5UaGlzIGNhbiBsZWFkIHRvIHR3byB3cml0ZXMg
dG8gdGhlIHNhbWUgcmVnaXN0ZXIsIHRoZSBhYm92ZSBuZWVkcyB0byBiZQo+Y29uZGl0aW9uYWwg
YXMgd2VsbC4KPgo+LS0gCj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cg==

