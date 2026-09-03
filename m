Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2D49E5E1;
	Thu,  3 Sep 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436696; cv=none; b=tyjIma8o02/iIApUq7mebK9MAh4FD7ndXYkqqyQbwaxcQVxSK8MoLzlwuMz0TYi3QIwc9b4gSVu81beEAnmhvepwwNkXqFDwVygoQIlJtvKGgBWaefetu0Jb3u55T5tzTt+Z09RIMzrep6ztGPtU907epqvKXHuqr2FBnHPntb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436696; c=relaxed/simple;
	bh=TwwfU6hpks+YXRJ6fCld9MUwDFdNClhk4U3xLbF7LOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mFKEJ4sWQbatECFEBu8kLUpvdGjShKowaL+9ZOPYaAyxwB5S0/ngTl9OfRc583KopTEjapzYmBF3951QaGxgM2egjE1aGcn7UVaO7x3GVAVhOiQi8zwwr9MTVMVA9duZ72srsx2bTw/1lh2lzx2S78zJLTfhgZZhHiurwizMf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iX4QWfdz; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iX4QWfdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TwwfU6hpks+YXRJ6fCld9MUwDFdNClhk4U3xLbF7LOo=; b=i
	X4QWfdzCIGfg7Ms8Zvw0g05r1YDsVi+LDnWP81i2YQkoCXDVA4W/ZLwgF1b4Ps8o
	7/OtBS09LE6KcDhLST0EbJ7VDcGNmNx2GT1kif/+pBCmUAmTDkTFYwTCygqHW+yx
	baBl36AzpoimswmhjAiCxqYpOEEwG1TWTj41jtNGjw=
Date: Thu, 3 Sep 2026 19:56:17 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: longzhao <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc <soc@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Linus Walleij" <linusw@kernel.org>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	linux-gpio <linux-gpio@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Brian Masney" <bmasney@redhat.com>, "Lee Jones" <lee@kernel.org>,
	mfd <mfd@lists.linux.dev>
Subject: Re:Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aplcxoINt0YAjvxL@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
 <aplcxoINt0YAjvxL@ashevche-desk.local>
X-NTES-SC: AL_Qu2TCviYuU0s4SCRZekcn0wRhug/UMa4u/sm3YNXc+sEmyb9wCAKQntjBXjy8euBCTqVrACdWgFHxf1WZpRSWZYdwgSvePe0abAvWg2oAg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <709278f9.9699.1a067207b4c.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgD3vyZhYJlquTA_AA--.3357W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxgExomqZYGHZZAAA3b
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgQW5keSwKClRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbi4gCkkgd2lsbCBrZWVwIDgyNTBf
YW1iYXJlbGxhIGFuZCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGFzIHlvdQpzdWdnZXN0ZWQu
CgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoKQXQgMjAyNi0wOS0wMyAxOTo0MDo1NCwgIkFuZHkg
U2hldmNoZW5rbyIgPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj5P
biBXZWQsIEF1ZyAxOSwgMjAyNiBhdCAwMjozMTo1OVBNICswODAwLCB6bDAyMDg5NSB3cm90ZToK
Pj4gCj4+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4KPgo+PiBUaGlzIGlzIEFtYmFyZWxsYSA4MjUw
LWNvbXBhdGlibGUgSVAsIG5vdCBTeW5vcHN5cyBEZXNpZ25XYXJlLiBXZQo+PiBmaXJzdCB0cmll
ZCA4MjUwX2R3IGFmdGVyIExpbnVzIGFza2VkIHVzIHRvIG1vdmUgdG8gdGhlIDgyNTAgbGlicmFy
eTsKPj4geW91IHRoZW4gdG9sZCB1cyBub3QgdG8gdG91Y2ggODI1MF9kdyBhbmQgdG8gdXNlIDgy
NTBfYW1iYXJlbGxhCj4+IGluc3RlYWQuIFRoYXQgaXMgd2hhdCB0aGlzIHBhdGNoIGlzLgo+PiBC
YWNrZ3JvdW5kOgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL0NBRCsrakxtNkh6RVUxVE0t
Yz1WdGp2M0ZKRUJlY1ZQN1R5eFNncV9RMHpGLVl3VDZOQUBtYWlsLmdtYWlsLmNvbS8KPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc2VyaWFsL2FuOEt2dkhXWDBuYUgzWHdAYXNoZXZj
aGUtZGVzay5sb2NhbC8KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc2VyaWFsLzdF
Nzc0MzA1LTM5MjAtNEJCNy1CQTQ2LUUwNzcyRDZCRUQ4NEBhbWJhcmVsbGEuY29tLwo+PiBJIHdp
bGwgYWxzbyBzd2l0Y2ggdG8gdWFydF9yZWFkX3BvcnRfcHJvcGVydGllcygpIGFuZCB0cmltIHRo
ZQo+PiA4MjUwX2R3LWRlcml2ZWQgYm9pbGVycGxhdGUuCj4KPlRoYW5rcyBmb3IgdGhlIHJlZ2lz
dGVyIGRlc2NyaXB0aW9ucywgaXQgd2FzIGhlbHBmdWwuIEFmdGVyIGdvaW5nIHRocm91Z2ggdGhl
bQo+aXQgc2VlbXMgdGhlIHYzIGFzIHlvdSBtYWRlIGl0IGlzIGdvb2QgZW5vdWdoIChzb3JyeSBm
b3IgZ29pbmcgYmFjayBhbmQgZm9ydGgpLgo+V2hhdCBpdCBuZWVkcyBpcyBiZXR0ZXIgY29tbWl0
IG1lc3NhZ2UgZXhwbGFpbmluZyB0aGF0IHdoaWxlIGl0J3Mgbm90IGEgU3lub3BzeXMKPkRXIElQ
LCBpdCB3YXMgbWFkZSB0byBiZSBxdWl0ZSBjb21wYXRpYmxlIHdpdGggdGhhdCAob24gcmVnaXN0
ZXIgbGV2ZWwpIGFuZCBoZW5jZQo+bm8gbmV3IGRyaXZlciBpcyByZXF1aXJlZCwganVzdCBhIHNt
YWxsIHF1aXJrLgo+Cj4tLSAKPldpdGggQmVzdCBSZWdhcmRzLAo+QW5keSBTaGV2Y2hlbmtvCj4K

