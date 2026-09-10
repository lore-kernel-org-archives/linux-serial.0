Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE393C13EE;
	Thu, 10 Sep 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031692; cv=none; b=iU5D97Iqq+fk3MZOoIURulPKvaCd7fRav9p58OY+PHVtcND3SfsTY8xphDdyHrixPPvJLSvoN2d+iPTyqBKUQyy52eZPMJv8M1q/8uL7UMuGK7XovnEBoKLKroy2ClBwhwrnxhUTot5akX9INctv/5ys4M1kjSpo0km3JT4zNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031692; c=relaxed/simple;
	bh=sLgY3kGNMUhiuDbvekSroJmn4LdKkP1crGpWtw0K8y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=duc/Ea0JOkCaJEVi9AB/WA+jefnOGC4DGU4eOvcU/IjRYnjh9Uoic41WIVz1G4l8cqVox2OFm5LrfL2lK14CvGwH188hmoE9LKRCk1URS3954iVuuBcc6AKzJkUZ8Rew1X3XElrGvo5Cw7ypD4Fg7vmjccZZCyIVbaz6yvCO0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fDWqdEwz; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fDWqdEwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sLgY3kGNMUhiuDbvekSroJmn4LdKkP1crGpWtw0K8y4=; b=f
	DWqdEwz9pXonBk+xO+4U3bNgelCLO4lj0rllTbkgB1K6xwCo1+/kMnW1ufWvlA28
	Iyq2f54/PO4/i7l5bPHWh6R+xHAIpsqB5WSVLSDcR2zJY38WDDHHH9k2wXdjs85i
	XNj05+QQiiZG3crGx/famHpzxYg5kZlNGnnac7tHfs=
Date: Thu, 10 Sep 2026 17:12:52 +0800 (CST)
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
Subject: Re:Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
 <aqJrSnr0rwv4BOJ3@ashevche-desk.local>
X-NTES-SC: AL_Qu2TC/yYvk0s5CmQZekcn0wRhug/UMa4u/sm3YNXc/0EqiX9+T4sR2RaDHjs89yCBiKngRWUTRFQw9phRId03a0R+3XdO1UpGQhOrxxtfQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <122573f8.8232.1a08a9765fc.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgBXLkGVdKJqLs1DAA--.42107W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxRWF9mqidJVRiAAA3T
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKVGhhbmtzIGZvciB0aGUgUmV2aWV3ZWQtYnkuCgo+IFdvbmRlcmluZyBpZiB3ZSBz
aG91bGQgdW5kbyB0aGlzIGluIHRoZSBwb3J0J3MgLnNodXRkb3duKCkgY2FsbGJhY2suCkkgc2F3
IHRoZSBzaHV0ZG93biBwYXRoIGFscmVhZHkgY292ZXJzIGl0OiBkdzgyNTBfc2h1dGRvd24oKSBj
YWxscwpzZXJpYWw4MjUwX2RvX3NodXRkb3duKCksIHdoaWNoIGRvZXMKCXVwLT5pZXIgPSAwOwoJ
c2VyaWFsX3BvcnRfb3V0KHBvcnQsIFVBUlRfSUVSLCAwKTsKc28gYm90aCB0aGUgSUVSIHNoYWRv
dyBhbmQgaGFyZHdhcmUgSUVSIGFyZSBjbGVhcmVkLCBpbmNsdWRpbmcgRVRPSS4KCkJlc3QgcmVn
YXJkcywKTG9uZyBaaGFvCgpBdCAyMDI2LTA5LTEwIDE2OjMzOjE0LCAiQW5keSBTaGV2Y2hlbmtv
IiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToKPk9uIEZyaSwgU2Vw
IDA0LCAyMDI2IGF0IDAyOjM4OjE4UE0gKzA4MDAsIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkgd3Jv
dGU6Cj4KPj4gVGhlIEFtYmFyZWxsYSBDVjc1IFVBUlQgaXMgQW1iYXJlbGxhIElQLCBub3QgYSBT
eW5vcHN5cyBEZXNpZ25XYXJlCj4+IGxpY2Vuc2VkIGJsb2NrLiBBdCB0aGUgcmVnaXN0ZXIgbGV2
ZWwgaXQgaXMgY2xvc2UgZW5vdWdoIHRvIERXIEFQQiBVQVJUCj4+IHRoYXQgYSBmdWxsIGN1c3Rv
bSBVQVJUIGRyaXZlciBpcyB1bm5lY2Vzc2FyeTogcmV1c2UgODI1MF9kdyB3aXRoIGEKPj4gc21h
bGwgcGxhdGZvcm0gcXVpcmsuCj4+IAo+PiBRdWlya3M6Cj4+IC0ga2VlcCBJRVIgRVRPSSAoYml0
IDUpIHNldCBmb3IgUlggdGltZW91dCBiZWhhdmlvdXIKPj4gLSBza2lwIHNldF9yYXRlOyBiYXVk
IGNsb2NrIGlzIG1hbmFnZWQgb3V0c2lkZSB0aGUgVUFSVCBibG9jawo+Cj5SZXZpZXdlZC1ieTog
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Cj4KPi4u
Lgo+Cj4+ICtzdGF0aWMgaW50IGR3ODI1MF9pZXJfbWFza19zdGFydHVwKHN0cnVjdCB1YXJ0X3Bv
cnQgKnApCj4+ICt7Cj4+ICsJc3RydWN0IGR3ODI1MF9kYXRhICpkID0gdG9fZHc4MjUwX2RhdGEo
cC0+cHJpdmF0ZV9kYXRhKTsKPj4gKwlzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVwID0gdXBfdG9f
dTgyNTBwKHApOwo+PiArCWludCByZXQ7Cj4+ICsKPj4gKwlyZXQgPSBzZXJpYWw4MjUwX2RvX3N0
YXJ0dXAocCk7Cj4+ICsJaWYgKHJldCkKPj4gKwkJcmV0dXJuIHJldDsKPj4gKwo+PiArCS8qCj4+
ICsJICogQW1iYXJlbGxhIGtlZXBzIHZhcmlhbnQgSUVSIGJpdHMgKGUuZy4gRVRPSSkgc2V0IGZv
ciBjb3JyZWN0IFJYCj4+ICsJICogdGltZW91dCBiZWhhdmlvdXIuIEZvcmNlIHRoZW0gaW50byB0
aGUgODI1MCBJRVIgc2hhZG93IHNvIGxhdGVyCj4+ICsJICogZ2VuZXJpYyBJRVIgdXBkYXRlcyBk
byBub3QgY2xlYXIgdGhlbS4KPj4gKwkgKi8KPgo+V29uZGVyaW5nIGlmIHdlIHNob3VsZCB1bmRv
IHRoaXMgaW4gdGhlIHBvcnQncyAuc2h1dGRvd24oKSBjYWxsYmFjay4KPgo+PiArCXVwLT5pZXIg
fD0gZC0+cGRhdGEtPmllcl9tYXNrOwo+PiArCXNlcmlhbF9wb3J0X291dChwLCBVQVJUX0lFUiwg
dXAtPmllcik7Cj4+ICsKPj4gKwlyZXR1cm4gMDsKPj4gK30KPgo+LS0gCj5XaXRoIEJlc3QgUmVn
YXJkcywKPkFuZHkgU2hldmNoZW5rbwo+Cg==
