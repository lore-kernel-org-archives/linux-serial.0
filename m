Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084134B5CC3;
	Wed, 16 Sep 2026 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556584; cv=none; b=s8WPQrf3/f6FS5ujLGpx1/btV99iMtNHh2bpsFcDHc4NJ/+AHEZagkZInMUnSWJm0hkCW11WRNDPyI5u3yDZeAU/nVQp4DQBdgRHCo3qWK5hxxahLI/MlSIaddPc29b6KdYi5Qbj30ijh0lYmHoOCuIAtU4K1RDkPPoGg99uHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556584; c=relaxed/simple;
	bh=XWYr4ENYidcskbtv9TLVflYBJ2nrgan0itQw24BVLf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iU2xz+6M4EU3HWFo1MN+b5+P5/7Ei1duFiQgVdwTDi1f1A+CI3peDmadXdpmwmC+6N7//KGxo+Gl3/832lJ92DlqkjwhQwYT44Z8r7DlaJC8RprRWLJz4wUOveci4wOzrMABjL34egEKaiKrSsLJOlU1FhMDyGz9qCFjDjMYf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QXJHNWlt; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QXJHNWlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=XWYr4ENYidcskbtv9TLVflYBJ2nrgan0itQw24BVLf4=; b=Q
	XJHNWltJ0xSQ2jiM+iN+TKdx/QfKg5EV2QfGCCC7ecN9ytw5qTQGeyoQSRXfXT77
	Mb0SBvpZRv6x4NjIJ1X7n8qKqfQfcw/OEN8q2EGHfn3rUe3/LYnW4kH9sj1lXB7w
	Prdy6/f38S5VaZxWVmvZMZs2mJDy2dYjcORs+da+x0=
Date: Wed, 16 Sep 2026 19:01:10 +0800 (CST)
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
Subject: Re:Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqpuMcqbra9i6UDq@ashevche-desk.local>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <CAMRc=McEOcWq8i3B01AR1PnfBzSQaLEaOzE6Qa+QdVXrvS_YrA@mail.gmail.com>
 <CAD++jLnRL_s9zPNkSj2UnHWPx+QHAXV19DA7dEmGZu0AkxxyaA@mail.gmail.com>
 <aqpuMcqbra9i6UDq@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/meuUws5iaYYOkcn0wRhug/UMa4u/sm3YNXc+0EmQv84jsnW19JAXbm4NmSDCydmwSSfylD1ctrZLJSSmM9ix4F2GWSJfiNOy6P3A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23d61058.962b.1a0a9e0b355.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgB3r9v2dqpqhlJIAA--.26232W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxhYgkWqqdvZsNQAA34
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmtzIEJhcnQsIExpbnVzLCBBbmR5LgoKQUNLOiBHUElPIGJpdHMgdGhyb3VnaCB0aGUgR1BJ
TyB0cmVlLCB0aGVuIGFuIElCIGZvciB0aGUgU29DIHRyZWUuCkkgd2lsbCBrZWVwIGEgdW5pZmll
ZCBzZXJpZXMgZm9yIG5vdy4KCnJlZ21hcC1pcnEgY2Fubm90IGRvIFBMMDYxIHR5cGUgKElTL0lC
RS9JRVYsIGJvdGgtZWRnZSkgcGx1cyB0aGUKQU1CQSBjaGFpbmVkIGRlbXV4LgoKVHdvIG9wdGlv
bnMgZm9yIHY4IOKAlCBBbmR5LCB3aGljaCBkbyB5b3UgcHJlZmVyPwogIDEpIENvbnZlcnQgUEww
NjEgTU1JTyB0byByZWdtYXAgb25seS4gS2VlcCB0aGUgZXhpc3RpbmcgZ3Bpb19jaGlwCiAgICAg
YW5kIGlycWNoaXAvZ2lycSAoZG91YmxlLXdyaXRlIHN0YXlzIGluIHRoZSBkcml2ZXIpLiBBbWJh
cmVsbGEKICAgICBsYXlvdXQgY2FuIGJlIGEgZm9sbG93LXVwIG9uIHRoYXQuIE5vIGdwaW8tcmVn
bWFwIHlldC4KCiAgMikgQWZ0ZXIgKDEpLCBhbHNvIG1vdmUgZ2V0L3NldC9kaXJlY3Rpb24gdG8g
Z3Bpby1yZWdtYXAuIElSUQogICAgIHdvdWxkIHN0YXkgYSBjdXN0b20gUEwwNjEgaXJxY2hpcCAo
bm90IHJlZ21hcC1pcnEpLiBJIGFtIG5vdAogICAgIHN1cmUgd2UgY2FuIGF2b2lkIGEgd2F5IHRv
IGdldCB0aGUgZ3Bpb19jaGlwIGZvcgogICAgIGdwaW9jaGlwXypfaXJxKCkgLyB0aGUgY2hhaW5l
ZCBoYW5kbGVyLgoKSSBhbSBsZWFuaW5nIHRvICgxKSBmb3IgdjguCgpCZXN0IHJlZ2FyZHMsCkxv
bmcgWmhhbwoK5ZyoIDIwMjYtMDktMTYgMTg6MjM6NDXvvIwiQW5keSBTaGV2Y2hlbmtvIiA8YW5k
cml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiDlhpnpgZPvvJoKPk9uIFdlZCwgU2VwIDE2
LCAyMDI2IGF0IDExOjQyOjU2QU0gKzAyMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6Cj4+IE9uIFdl
ZCwgU2VwIDE2LCAyMDI2IGF0IDExOjE04oCvQU0gQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBr
ZXJuZWwub3JnPiB3cm90ZToKPj4gPiBPbiBUdWUsIDE1IFNlcCAyMDI2IDEzOjE1OjMwICswMjAw
LCBMb25nIFpoYW8gdmlhIEI0IFJlbGF5Cj4+ID4gPGRldm51bGwrbG9uZ3poYW8uYW1iYXJlbGxh
LmNvbUBrZXJuZWwub3JnPiBzYWlkOgo+PiA+ID4gVGhpcyBzZXJpZXMgYWRkcyBtaW5pbWFsIEFt
YmFyZWxsYSBDVjc1IHN1cHBvcnQgZm9yIGVhcmx5IGJyaW5nLXVwIHdpdGgKPj4gPiA+IGEgc2Vy
aWFsIGNvbnNvbGU6IERUIGJpbmRpbmdzLCBSQ1QgY2xvY2tzLCBwaW5jdHJsLCBQTDA2MSBHUElP
IHZpYQo+PiA+ID4gZ3Bpby1yZWdtYXAsIDgyNTBfZHcgVUFSVCBxdWlya3MsIEFSQ0hfQU1CQVJF
TExBLCBDVjc1IEVWSyBEVCwgYW5kCj4+ID4gPiBNQUlOVEFJTkVSUy4KPj4gPiA+Cj4+ID4gPiBU
aGlzIGlzIGEgc2luZ2xlIHVuaWZpZWQgc2VyaWVzLiBQbGVhc2UgYXBwbHkgdmlhIHRoZSBTb0MK
Pj4gPiA+IHRyZWU7IHN1YnN5c3RlbSBtYWludGFpbmVycyBhcmUgQ2MnZCBmb3IgdGhlaXIgcGll
Y2VzLgo+PiA+Cj4+ID4gSSB3b3VsZCBwcmVmZXIgdG8gdGFrZSB0aGUgR1BJTyByZWdtYXAgYml0
cyB0aHJvdWdoIHRoZSBHUElPIHRyZWUgYW5kIHByb3ZpZGUKPj4gPiBhbiBpbW11dGFibGUgYnJh
bmNoIHRvIHRoZSBTb0MgdHJlZSBhcyBpdCBoYXMgcG90ZW50aWFsIGZvciBjb25mbGljdHMgdGhh
dAo+PiA+IGVhcmx5IGludG8gdGhlIGN5Y2xlLgo+PiAKPj4gUXVldWUgdGhlbSB1cCBhbmQgc2Vu
ZCB1cyB0aGUgSUIgaWYgeW91IHRoaW5rIHRoZXkgYXJlIHJlYWR5IQo+PiAKPj4gTG9uZyBjYW4g
cHJvYmFibHkgc2VuZCBhIFBSIGJhc2VkIG9uIHRoYXQgSUIgZm9yIHRoZSByZXN0IHRvIHRoZQo+
PiBTb0MgdHJlZSwgYSBiaXQgdHJpY2tzeSBidXQgaXQgd29ya3MuCj4KPkknbSBzdGlsbCB1bnN1
cmUgd2h5IHdlIGNhbid0IHVzZSBJUlEgZmFjaWxpdHkgZnJvbSBncGlvLXJlZ21hcC4KPkNhbiB5
b3UgaGF2ZSBhIGxvb2sgdGhlcmU/Cj4KPldpdGggdGhhdCBiZWluZyBzYWlkLCBJJ20gbm90IHN1
cmUgdGhhdCB0aGUgcGF0Y2ggdGhhdCBleHBvc2luZyBncGlvX2NoaXAKPmZyb20gZ3Bpby1yZWdt
YXAgaXMganVzdGlmaWVkLgo+Cj5UaGUgd2hvbGUgR1BJTyByZXdvcmsgbmVlZHMgYSBiaXQgbW9y
ZSByb3V0aW5lIHdvcmsgKHJlc3BsaXR0aW5nLCByZWZhY3RvcmluZywKPmV0IGNldGVyYSksIHNv
IGxhdGVyIHdlIG1heSBzZWUgY2xlYXJlciB3aGF0J3MgZ29pbmcgb24uCj4KPi0tIAo+V2l0aCBC
ZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPgo=
