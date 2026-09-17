Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E153793C1;
	Thu, 17 Sep 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635998; cv=none; b=mJR01eA0V+dJVQ0c4nbmpv5jxkO9Zt0Dzl3rZdqpb+aYB145gWi1WEI//VkZozCVlURXdWxsFifYdqcse8SVDGLosUsyX2DelLaA04cyPLIG8mq08ZfjBDE6XsCK46jVijdwB8A+c7+svOmUe+bgE1Lr+rJ6t3AkXLFtKcJSu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635998; c=relaxed/simple;
	bh=OS3MTLOP2Kaa1hSL1upbFxMfyqLs7pOgbmJt1SIIxWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FXwJW4RiY3cS8CDaENFqn11Tx607UbuKp7uo3flzUC3TqRWonK7Sh7driioDfqhRDoDMkkfa5BW8eLSvjIKd+gDsOD3MjRzpk4oQ/JIhyKzMYgc1+Fht1yZTOpgO67SzHR9GVFtR2BJsmAa0PAWW1DcN7PfxqvdxBDoPdyVrrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kKnV/91G; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kKnV/91G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OS3MTLOP2Kaa1hSL1upbFxMfyqLs7pOgbmJt1SIIxWQ=; b=k
	KnV/91GLjuQafbJTlR7gAQGk1qqIjAc0ua2otxqKs4YgV4cm2G6l3woaBlEIOySv
	XmvR3ffOBrOFNVEdI7m4yWYqr4yEUeiwJgr9pmrR2fm4vAdQWTQ1ZE+B3yxx6Pa2
	Ppp4pNwWzWPtJhVRoOUOsion6xqYqA/CXlURjIPyRo=
Date: Thu, 17 Sep 2026 17:05:10 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Linus Walleij" <linusw@kernel.org>,
	"Bartosz Golaszewski" <brgl@kernel.org>, soc@lists.linux.dev,
	longzhao@ambarella.com,
	"Long Zhao via B4 Relay" <devnull+longzhao.ambarella.com@kernel.org>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org
Subject: Re:Re: Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqqzyPR-2JKr-2Me@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <CAMRc=McEOcWq8i3B01AR1PnfBzSQaLEaOzE6Qa+QdVXrvS_YrA@mail.gmail.com>
 <CAD++jLnRL_s9zPNkSj2UnHWPx+QHAXV19DA7dEmGZu0AkxxyaA@mail.gmail.com>
 <aqpuMcqbra9i6UDq@ashevche-desk.local>
 <23d61058.962b.1a0a9e0b355.Coremail.zl020895@163.com>
 <aqqzyPR-2JKr-2Me@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/qYukEq5iWaZ+kcn0wRhug/UMa4u/sm3YNXc+MGvSDC6hIGUVVpN1rz8fCtAgCluxq4bCJv1MtYQqxFWkQcswCqSOP748Z5tcjgaA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2a7c61b.7ee9.1a0ae9cdb83.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lSgvCgD3P_xGratq2iZJAA--.41495W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgYCc2qrrUZoXwAA3s
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKClRoYW5rcy4gSSdsbCBnbyB3aXRoIG9wdGlvbiAyLgoKdjggd2lsbCBzcGxpdDog
TU1JTyB0byByZWdtYXAgd2l0aCB0aGUgZXhpc3RpbmcgaXJxY2hpcCBmaXJzdCwKdGhlbiBJUlFf
VFlQRV8qIG1hc2tzLCB0aGVuIGdwaW8tcmVnbWFwIGZvciBnZXQvc2V0L2RpciBhbmQgdGhlCmN1
c3RvbSBpcnFjaGlwLgoKcmVnbWFwLWlycSBzdGlsbCBjYW5ub3QgZG8gSVMvSUJFL0lFViBwbHVz
IHRoZSBBTUJBIGNoYWluZWQKZGVtdXguCgpncGlvX3JlZ21hcF9nZXRfY2hpcCgpIHN0YXlzIGZv
ciBub3c6IHRoZSBsaW5lYXIgZG9tYWluIGFuZApncGlvY2hpcF9lbmFibGVfaXJxKCkgbmVlZCBn
cGlvX2NoaXAsIHdoaWNoIG9ubHkgZXhpc3RzIGFmdGVyCmdwaW9fcmVnbWFwX3JlZ2lzdGVyKCku
IEkgY2FuIGRyb3AgaXQgaWYgd2UgZ2V0IGEgYmV0dGVyIGhvb2suCgpCZXN0IHJlZ2FyZHMsCkxv
bmcgWmhhbwoKQXQgMjAyNi0wOS0xNiAyMzoyMDo0MCwgIkFuZHkgU2hldmNoZW5rbyIgPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj5PbiBXZWQsIFNlcCAxNiwgMjAy
NiBhdCAwNzowMToxMFBNICswODAwLCB6bDAyMDg5NSB3cm90ZToKPgo+PiBBQ0s6IEdQSU8gYml0
cyB0aHJvdWdoIHRoZSBHUElPIHRyZWUsIHRoZW4gYW4gSUIgZm9yIHRoZSBTb0MgdHJlZS4KPj4g
SSB3aWxsIGtlZXAgYSB1bmlmaWVkIHNlcmllcyBmb3Igbm93Lgo+PiAKPj4gcmVnbWFwLWlycSBj
YW5ub3QgZG8gUEwwNjEgdHlwZSAoSVMvSUJFL0lFViwgYm90aC1lZGdlKSBwbHVzIHRoZQo+PiBB
TUJBIGNoYWluZWQgZGVtdXguCj4+IAo+PiBUd28gb3B0aW9ucyBmb3Igdjgg4oCUIEFuZHksIHdo
aWNoIGRvIHlvdSBwcmVmZXI/Cj4+ICAgMSkgQ29udmVydCBQTDA2MSBNTUlPIHRvIHJlZ21hcCBv
bmx5LiBLZWVwIHRoZSBleGlzdGluZyBncGlvX2NoaXAKPj4gICAgICBhbmQgaXJxY2hpcC9naXJx
IChkb3VibGUtd3JpdGUgc3RheXMgaW4gdGhlIGRyaXZlcikuIEFtYmFyZWxsYQo+PiAgICAgIGxh
eW91dCBjYW4gYmUgYSBmb2xsb3ctdXAgb24gdGhhdC4gTm8gZ3Bpby1yZWdtYXAgeWV0Lgo+PiAK
Pj4gICAyKSBBZnRlciAoMSksIGFsc28gbW92ZSBnZXQvc2V0L2RpcmVjdGlvbiB0byBncGlvLXJl
Z21hcC4gSVJRCj4+ICAgICAgd291bGQgc3RheSBhIGN1c3RvbSBQTDA2MSBpcnFjaGlwIChub3Qg
cmVnbWFwLWlycSkuIEkgYW0gbm90Cj4+ICAgICAgc3VyZSB3ZSBjYW4gYXZvaWQgYSB3YXkgdG8g
Z2V0IHRoZSBncGlvX2NoaXAgZm9yCj4+ICAgICAgZ3Bpb2NoaXBfKl9pcnEoKSAvIHRoZSBjaGFp
bmVkIGhhbmRsZXIuCj4+IAo+PiBJIGFtIGxlYW5pbmcgdG8gKDEpIGZvciB2OC4KPgo+SSB3b3Vs
ZCBwcmVmZXIgdG8gc2VlICgyKSBhbmQgdGhlbiB3ZSBjYW4gZGlzY3VzcyB0byByb2xsLWJhY2sg
aWYgaXQgbG9va3Mgbm90Cj5nb29kIGVub3VnaC4KPgo+RWl0aGVyIHdheSB5b3VyIFBNIHJ1bnRp
bWUgc3VwcG9ydCBmb3IgZ3Bpby1yZWdtYXAgaXMgYSBnb29kIGNoYW5nZS4KPgo+PiDlnKggMjAy
Ni0wOS0xNiAxODoyMzo0Ne+8jCJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+IOWGmemBk++8mgo+PiA+T24gV2VkLCBTZXAgMTYsIDIwMjYgYXQgMTE6
NDI6NTZBTSArMDIwMCwgTGludXMgV2FsbGVpaiB3cm90ZToKPj4gPj4gT24gV2VkLCBTZXAgMTYs
IDIwMjYgYXQgMTE6MTTigK9BTSBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+
IHdyb3RlOgo+PiA+PiA+IE9uIFR1ZSwgMTUgU2VwIDIwMjYgMTM6MTU6MzAgKzAyMDAsIExvbmcg
WmhhbyB2aWEgQjQgUmVsYXkKPj4gPj4gPiA8ZGV2bnVsbCtsb25nemhhby5hbWJhcmVsbGEuY29t
QGtlcm5lbC5vcmc+IHNhaWQ6Cj4+ID4+ID4gPiBUaGlzIHNlcmllcyBhZGRzIG1pbmltYWwgQW1i
YXJlbGxhIENWNzUgc3VwcG9ydCBmb3IgZWFybHkgYnJpbmctdXAgd2l0aAo+PiA+PiA+ID4gYSBz
ZXJpYWwgY29uc29sZTogRFQgYmluZGluZ3MsIFJDVCBjbG9ja3MsIHBpbmN0cmwsIFBMMDYxIEdQ
SU8gdmlhCj4+ID4+ID4gPiBncGlvLXJlZ21hcCwgODI1MF9kdyBVQVJUIHF1aXJrcywgQVJDSF9B
TUJBUkVMTEEsIENWNzUgRVZLIERULCBhbmQKPj4gPj4gPiA+IE1BSU5UQUlORVJTLgo+PiA+PiA+
ID4KPj4gPj4gPiA+IFRoaXMgaXMgYSBzaW5nbGUgdW5pZmllZCBzZXJpZXMuIFBsZWFzZSBhcHBs
eSB2aWEgdGhlIFNvQwo+PiA+PiA+ID4gdHJlZTsgc3Vic3lzdGVtIG1haW50YWluZXJzIGFyZSBD
YydkIGZvciB0aGVpciBwaWVjZXMuCj4+ID4+ID4KPj4gPj4gPiBJIHdvdWxkIHByZWZlciB0byB0
YWtlIHRoZSBHUElPIHJlZ21hcCBiaXRzIHRocm91Z2ggdGhlIEdQSU8gdHJlZSBhbmQgcHJvdmlk
ZQo+PiA+PiA+IGFuIGltbXV0YWJsZSBicmFuY2ggdG8gdGhlIFNvQyB0cmVlIGFzIGl0IGhhcyBw
b3RlbnRpYWwgZm9yIGNvbmZsaWN0cyB0aGF0Cj4+ID4+ID4gZWFybHkgaW50byB0aGUgY3ljbGUu
Cj4+ID4+IAo+PiA+PiBRdWV1ZSB0aGVtIHVwIGFuZCBzZW5kIHVzIHRoZSBJQiBpZiB5b3UgdGhp
bmsgdGhleSBhcmUgcmVhZHkhCj4+ID4+IAo+PiA+PiBMb25nIGNhbiBwcm9iYWJseSBzZW5kIGEg
UFIgYmFzZWQgb24gdGhhdCBJQiBmb3IgdGhlIHJlc3QgdG8gdGhlCj4+ID4+IFNvQyB0cmVlLCBh
IGJpdCB0cmlja3N5IGJ1dCBpdCB3b3Jrcy4KPj4gPgo+PiA+SSdtIHN0aWxsIHVuc3VyZSB3aHkg
d2UgY2FuJ3QgdXNlIElSUSBmYWNpbGl0eSBmcm9tIGdwaW8tcmVnbWFwLgo+PiA+Q2FuIHlvdSBo
YXZlIGEgbG9vayB0aGVyZT8KPj4gPgo+PiA+V2l0aCB0aGF0IGJlaW5nIHNhaWQsIEknbSBub3Qg
c3VyZSB0aGF0IHRoZSBwYXRjaCB0aGF0IGV4cG9zaW5nIGdwaW9fY2hpcAo+PiA+ZnJvbSBncGlv
LXJlZ21hcCBpcyBqdXN0aWZpZWQuCj4+ID4KPj4gPlRoZSB3aG9sZSBHUElPIHJld29yayBuZWVk
cyBhIGJpdCBtb3JlIHJvdXRpbmUgd29yayAocmVzcGxpdHRpbmcsIHJlZmFjdG9yaW5nLAo+PiA+
ZXQgY2V0ZXJhKSwgc28gbGF0ZXIgd2UgbWF5IHNlZSBjbGVhcmVyIHdoYXQncyBnb2luZyBvbi4K
Pgo+LS0gCj5XaXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cg==
