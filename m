Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0538DC78;
	Thu, 10 Sep 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031798; cv=none; b=slZqwetRWxr4ilCk4I7ZqzmNmn++E2ZeLeMiHW6LvA4a44yI9Mtr3elWUAOgfb3pTdv1lg/GzEWyZ33S6Efbrzv1DBWFshqXAjI0XIeY2BpoleXheG0+WFhwZSYmOy++jQAzUqGcP6vUNh80zK8Gv95cgHW2ZN2+sjHU3mCicFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031798; c=relaxed/simple;
	bh=GxEiQwXDBcebBVRE/dGiwDfd5iv2YE3skoV4kH1Bb+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nCe68lf/6gvwIKU9k2xSmJA0vezfzZ+7Xeb5j0UsRE+lH/8ZaqY8SW6Vo/kc2XOeJWXWALRnz8xjdpNq9i2QDGKUtpauvFkIwZl5KB8yQ6BSEIdCdzzoYbaDGs1UZEu5GsOo2QOiV1tHA2Q5qVfzAwq0rqBoB9F+KXcHavu1o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MUlcWjfo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MUlcWjfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GxEiQwXDBcebBVRE/dGiwDfd5iv2YE3skoV4kH1Bb+4=; b=M
	UlcWjfoQcsM6uozP2ZA+dhntJUpdxgTyCHJ4fHJkD2baaQI7sBKjOIxDj9Kz02PQ
	cEosw9HrwtrGXEpLFVdECD1lMwuh2el5VjCveopyzgu17zVa7yclch3NEpEJ56I3
	9L2wXCusqEIXl7kCHTwlTA9uueNLIAeQaGkVGejjZA=
Date: Thu, 10 Sep 2026 17:15:30 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Long Zhao" <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>,
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
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>, "Lee Jones" <lee@kernel.org>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <07cdbec9-49af-d500-d93d-56bfcef9f490@linux.intel.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
 <07cdbec9-49af-d500-d93d-56bfcef9f490@linux.intel.com>
X-NTES-SC: AL_Qu2TC/yYvk8o5iOZY+kcn0wRhug/UMa4u/sm3YNXc/0EqiX9+T4sR2RaDHjs89yCBiKngRWUTRFQw9phRId0Gm3e9H0k5+Fqn0tYhpt88g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5fdd9772.82f3.1a08a99cc94.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgD3P5MydaJqQM5DAA--.42441W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxRKsHmqidTJgdAAA3+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgSWxwbywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkknbGwgZHJvcCB0aGUgc2VyaWFsX3Bv
cnRfb3V0KCkgaGVyZSBhbmQgb25seSBrZWVwOgoJdXAtPmllciB8PSBkLT5wZGF0YS0+aWVyX21h
c2s7CnNvIEVUT0kgc3RheXMgaW4gdGhlIHNoYWRvdyBhbmQgc2VyaWFsODI1MF9zZXRfaWVyKCkg
cHJvZ3JhbXMgdGhlCmhhcmR3YXJlIGxhdGVyLgoKQmVzdCByZWdhcmRzLApMb25nIFpoYW8KCkF0
IDIwMjYtMDktMTAgMTY6NDQ6MzUsICJJbHBvIErDpHJ2aW5lbiIgPGlscG8uamFydmluZW5AbGlu
dXguaW50ZWwuY29tPiB3cm90ZToKPk9uIEZyaSwgNCBTZXAgMjAyNiwgTG9uZyBaaGFvIHZpYSBC
NCBSZWxheSB3cm90ZToKPgo+PiBGcm9tOiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5j
b20+Cj4+IAo+PiBUaGUgQW1iYXJlbGxhIENWNzUgVUFSVCBpcyBBbWJhcmVsbGEgSVAsIG5vdCBh
IFN5bm9wc3lzIERlc2lnbldhcmUKPj4gbGljZW5zZWQgYmxvY2suIEF0IHRoZSByZWdpc3RlciBs
ZXZlbCBpdCBpcyBjbG9zZSBlbm91Z2ggdG8gRFcgQVBCIFVBUlQKPj4gdGhhdCBhIGZ1bGwgY3Vz
dG9tIFVBUlQgZHJpdmVyIGlzIHVubmVjZXNzYXJ5OiByZXVzZSA4MjUwX2R3IHdpdGggYQo+PiBz
bWFsbCBwbGF0Zm9ybSBxdWlyay4KPj4gCj4+IFF1aXJrczoKPj4gLSBrZWVwIElFUiBFVE9JIChi
aXQgNSkgc2V0IGZvciBSWCB0aW1lb3V0IGJlaGF2aW91cgo+PiAtIHNraXAgc2V0X3JhdGU7IGJh
dWQgY2xvY2sgaXMgbWFuYWdlZCBvdXRzaWRlIHRoZSBVQVJUIGJsb2NrCj4+IAo+PiBTaWduZWQt
b2ZmLWJ5OiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+Cj4+IC0tLQo+PiAgZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kdy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykKPj4gCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMKPj4gaW5kZXggNWZiYTkxM2YzMzAxLi5iMTVkZTQw
ZDFlMmEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHcuYwo+
PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2R3LmMKPj4gQEAgLTQzLDYgKzQz
LDkgQEAKPj4gICNkZWZpbmUgUlpOMV9VQVJUX3hETUFDUl84X1dPUkRfQlVSU1QJKDIgPDwgMSkK
Pj4gICNkZWZpbmUgUlpOMV9VQVJUX3hETUFDUl9CTEtfU1ooeCkJKCh4KSA8PCAzKQo+PiAgCj4+
ICsvKiBBbWJhcmVsbGEgSUVSOiByZWNlaXZlIHRpbWVvdXQgaW50ZXJydXB0IGVuYWJsZSAqLwo+
PiArI2RlZmluZSBBTUJBUkVMTEFfVUFSVF9JRVJfRVRPSQkJQklUKDUpCj4+ICsKPj4gIC8qIFF1
aXJrcyAqLwo+PiAgI2RlZmluZSBEV19VQVJUX1FVSVJLX09DVEVPTgkJQklUKDApCj4+ICAjZGVm
aW5lIERXX1VBUlRfUVVJUktfQVJNQURBXzM4WAlCSVQoMSkKPj4gQEAgLTYwLDYgKzYzLDcgQEAK
Pj4gIAo+PiAgc3RydWN0IGR3ODI1MF9wbGF0Zm9ybV9kYXRhIHsKPj4gIAl1OCB1c3JfcmVnOwo+
PiArCXU4IGllcl9tYXNrOwo+PiAgCXUzMiBjcHJfdmFsdWU7Cj4+ICAJdW5zaWduZWQgaW50IHF1
aXJrczsKPj4gIH07Cj4+IEBAIC01NzIsNiArNTc2LDI3IEBAIHN0YXRpYyB2b2lkIGR3ODI1MF9w
cmVwYXJlX3J4X2RtYShzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnApCj4+ICAJZHc4MjUwX3dyaXRl
bF9leHQodXAsIFJaTjFfVUFSVF9SRE1BQ1IsIHZhbCk7Cj4+ICB9Cj4+ICAKPj4gK3N0YXRpYyBp
bnQgZHc4MjUwX2llcl9tYXNrX3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9ydCAqcCkKPj4gK3sKPj4g
KwlzdHJ1Y3QgZHc4MjUwX2RhdGEgKmQgPSB0b19kdzgyNTBfZGF0YShwLT5wcml2YXRlX2RhdGEp
Owo+PiArCXN0cnVjdCB1YXJ0XzgyNTBfcG9ydCAqdXAgPSB1cF90b191ODI1MHAocCk7Cj4+ICsJ
aW50IHJldDsKPj4gKwo+PiArCXJldCA9IHNlcmlhbDgyNTBfZG9fc3RhcnR1cChwKTsKPj4gKwlp
ZiAocmV0KQo+PiArCQlyZXR1cm4gcmV0Owo+PiArCj4+ICsJLyoKPj4gKwkgKiBBbWJhcmVsbGEg
a2VlcHMgdmFyaWFudCBJRVIgYml0cyAoZS5nLiBFVE9JKSBzZXQgZm9yIGNvcnJlY3QgUlgKPj4g
KwkgKiB0aW1lb3V0IGJlaGF2aW91ci4gRm9yY2UgdGhlbSBpbnRvIHRoZSA4MjUwIElFUiBzaGFk
b3cgc28gbGF0ZXIKPj4gKwkgKiBnZW5lcmljIElFUiB1cGRhdGVzIGRvIG5vdCBjbGVhciB0aGVt
Lgo+PiArCSAqLwo+PiArCXVwLT5pZXIgfD0gZC0+cGRhdGEtPmllcl9tYXNrOwo+PiArCXNlcmlh
bF9wb3J0X291dChwLCBVQVJUX0lFUiwgdXAtPmllcik7Cj4KPnNlcmlhbDgyNTBfZG9fc3RhcnR1
cCgpIHNlZW1zIHRvIGRlZmVyIElFUiB1cGRhdGUgb24gcHVycG9zZS4gSXMgaXQgZmluZSAKPnRv
IG92ZXJyaWRlIHRoYXQgYmVoYXZpb3IgaGVyZT8KPgo+LS0gCj4gaS4KPgo+PiArCXJldHVybiAw
Owo+PiArfQo+PiArCj4+ICBzdGF0aWMgdm9pZCBkdzgyNTBfcXVpcmtzKHN0cnVjdCB1YXJ0X3Bv
cnQgKnAsIHN0cnVjdCBkdzgyNTBfZGF0YSAqZGF0YSkKPj4gIHsKPj4gIAl1bnNpZ25lZCBpbnQg
cXVpcmtzID0gZGF0YS0+cGRhdGEtPnF1aXJrczsKPj4gQEAgLTYwNiw2ICs2MzEsOCBAQCBzdGF0
aWMgdm9pZCBkdzgyNTBfcXVpcmtzKHN0cnVjdCB1YXJ0X3BvcnQgKnAsIHN0cnVjdCBkdzgyNTBf
ZGF0YSAqZGF0YSkKPj4gIAkJcC0+c2VyaWFsX2luID0gZHc4MjUwX3NlcmlhbF9pbjMyOwo+PiAg
CQlkYXRhLT51YXJ0XzE2NTUwX2NvbXBhdGlibGUgPSB0cnVlOwo+PiAgCX0KPj4gKwlpZiAoZGF0
YS0+cGRhdGEtPmllcl9tYXNrKQo+PiArCQlwLT5zdGFydHVwID0gZHc4MjUwX2llcl9tYXNrX3N0
YXJ0dXA7Cj4+ICB9Cj4+ICAKPj4gIHN0YXRpYyB2b2lkIGR3ODI1MF9yZXNldF9jb250cm9sX2Fz
c2VydCh2b2lkICpkYXRhKQo+PiBAQCAtODc5LDYgKzkwNiwxMiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGR3ODI1MF9wbGF0Zm9ybV9kYXRhIGR3ODI1MF9pbnRjMTBlZSA9IHsKPj4gIAkucXVpcmtz
ID0gRFdfVUFSVF9RVUlSS19JRVJfS0lDSywKPj4gIH07Cj4+ICAKPj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgZHc4MjUwX3BsYXRmb3JtX2RhdGEgZHc4MjUwX2FtYmFyZWxsYV9jdjc1X2RhdGEgPSB7
Cj4+ICsJLnVzcl9yZWcgPSBEV19VQVJUX1VTUiwKPj4gKwkuaWVyX21hc2sgPSBBTUJBUkVMTEFf
VUFSVF9JRVJfRVRPSSwKPj4gKwkucXVpcmtzID0gRFdfVUFSVF9RVUlSS19TS0lQX1NFVF9SQVRF
LAo+PiArfTsKPj4gKwo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkdzgyNTBfcGxhdGZvcm1fZGF0
YSBkdzgyNTBfdWx0cmFyaXNjX2RwMTAwMF9kYXRhID0gewo+PiAgCS51c3JfcmVnID0gRFdfVUFS
VF9VU1IsCj4+ICAJLmNwcl92YWx1ZSA9IEZJRUxEX1BSRVBfQ09OU1QoRFdfVUFSVF9DUFJfQUJQ
X0RBVEFfV0lEVEgsIDIpIHwKPj4gQEAgLTg4OSw2ICs5MjIsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGR3ODI1MF9wbGF0Zm9ybV9kYXRhIGR3ODI1MF91bHRyYXJpc2NfZHAxMDAwX2RhdGEgPSB7
Cj4+ICB9Owo+PiAgCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkdzgyNTBf
b2ZfbWF0Y2hbXSA9IHsKPj4gKwl7IC5jb21wYXRpYmxlID0gImFtYmFyZWxsYSxjdjc1LXVhcnQi
LCAuZGF0YSA9ICZkdzgyNTBfYW1iYXJlbGxhX2N2NzVfZGF0YSB9LAo+PiAgCXsgLmNvbXBhdGli
bGUgPSAic25wcyxkdy1hcGItdWFydCIsIC5kYXRhID0gJmR3ODI1MF9kd19hcGIgfSwKPj4gIAl7
IC5jb21wYXRpYmxlID0gImNhdml1bSxvY3Rlb24tMzg2MC11YXJ0IiwgLmRhdGEgPSAmZHc4MjUw
X29jdGVvbl8zODYwX2RhdGEgfSwKPj4gIAl7IC5jb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRh
LTM4eC11YXJ0IiwgLmRhdGEgPSAmZHc4MjUwX2FybWFkYV8zOHhfZGF0YSB9LAo+PiAKPj4gCg==

