Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334174A5EAB;
	Thu,  3 Sep 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440679; cv=none; b=un/K0Ch0+8YvAcaXX3rz+QOt86qC6MPGnEvg7ntVx2S9wr4XXTh95rww/DS6lzbeAAJpht/k1R9oa3yfB+gDrbvgnD+Cqk40y9SU5PviFUDe8ofW9KXDC9iAve2Jkc8Ua3LvBp9ugmNWwaXE2G0v7lrlwZ3TsibFWmf1Z+0vHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440679; c=relaxed/simple;
	bh=xL+CoTR59C4km0YBHA8/+2wEU5OAHfxf36Bb0007UXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ergBVZylHsMXL+ggqkeJlBeiIqCH7YH0O8/SoNMvYAXEN7Pyz9jGtqOl5707+9AHZqjLpwcjYbdLOgFFYNNGkBjNjt0r98NCIud19ai4bZw9jnYxQKR6E+lj0vzwVu8FCr7Vd8E5252jmRG/MnajjdzBbioShH313it/2K4cgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VTbqw2/F; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VTbqw2/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=xL+CoTR59C4km0YBHA8/+2wEU5OAHfxf36Bb0007UXs=; b=V
	Tbqw2/FmwS4BYiHW0rwmkxQUU0Vnv7sRkl9W17mQb+gRraw7iOPsVJH/rs7FQ/k7
	lDtHJXYlEF52X63tlpJ4wpttQpf/FkF6NedBUeTYruurmpE7kWZ56aYIr/pGZE5z
	KGl9m3KFo4lTw9AmXh7WBnFsSUJ4HWh5MA3OVGU89Q=
Received: from zl020895$163.com ( [2408:84e2:4b0:1b4c:d51e:e49:24cd:960c] )
 by ajax-webmail-wmsvr-40-115 (Coremail) ; Thu, 3 Sep 2026 21:01:58 +0800
 (CST)
Date: Thu, 3 Sep 2026 21:01:58 +0800 (CST)
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
Subject: Re:Re: Re: Re: [PATCH v5 10/12] serial: 8250: add Ambarella UART
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aplttDenvZHvn0mF@ashevche-desk.local>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
 <20260818-cv75-v5-v5-10-7bbb12f0360f@ambarella.com>
 <aoRpc2RK2_X3CdAi@ashevche-desk.local>
 <162c0385.2c076.1a018b82fa7.Coremail.zl020895@163.com>
 <aplcxoINt0YAjvxL@ashevche-desk.local>
 <709278f9.9699.1a067207b4c.Coremail.zl020895@163.com>
 <aplttDenvZHvn0mF@ashevche-desk.local>
X-NTES-SC: AL_Qu2TCvifv00q7iCeYekcn0wRhug/UMa4u/sm3YNXc/0Esj/kyz4scntFDXrp/eCXEz6OlTaJfwFx48pKcKVZvW+TqzbAigqlbyZHIiayZw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a51b3fb.9b8c.1a0675c9db8.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgD3_4DGb5lqPuE+AA--.16267W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbC7gYOf2qZb8YJQwAA3J
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SSBzZWUuIFRoYW5rIHlvdSwgQW5keS4KCkJlc3QgcmVnYXJkcywKTG9uZyBaaGFvCgpBdCAyMDI2
LTA5LTAzIDIwOjUzOjA4LCAiQW5keSBTaGV2Y2hlbmtvIiA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPiB3cm90ZToKPk9uIFRodSwgU2VwIDAzLCAyMDI2IGF0IDA3OjU2OjE3UE0g
KzA4MDAsIHpsMDIwODk1IHdyb3RlOgo+PiAKPj4gVGhhbmtzIGZvciB0aGUgY29uZmlybWF0aW9u
LiAKPj4gSSB3aWxsIGtlZXAgODI1MF9hbWJhcmVsbGEgYW5kIHVwZGF0ZSB0aGUgY29tbWl0IG1l
c3NhZ2UgYXMgeW91Cj4+IHN1Z2dlc3RlZC4KPgo+Tm8sIEkgbWVhbiB0byBnbyBiYWNrIHRvIHRo
ZSB2ZXJzaW9uIHRoYXQgbW9kaWZpZXMgODI1MF9kdy4KPgo+PiBBdCAyMDI2LTA5LTAzIDE5OjQw
OjU0LCAiQW5keSBTaGV2Y2hlbmtvIiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
PiB3cm90ZToKPj4gPk9uIFdlZCwgQXVnIDE5LCAyMDI2IGF0IDAyOjMxOjU5UE0gKzA4MDAsIHps
MDIwODk1IHdyb3RlOgo+PiA+PiAKPj4gPj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lgo+PiA+Cj4+
ID4+IFRoaXMgaXMgQW1iYXJlbGxhIDgyNTAtY29tcGF0aWJsZSBJUCwgbm90IFN5bm9wc3lzIERl
c2lnbldhcmUuIFdlCj4+ID4+IGZpcnN0IHRyaWVkIDgyNTBfZHcgYWZ0ZXIgTGludXMgYXNrZWQg
dXMgdG8gbW92ZSB0byB0aGUgODI1MCBsaWJyYXJ5Owo+PiA+PiB5b3UgdGhlbiB0b2xkIHVzIG5v
dCB0byB0b3VjaCA4MjUwX2R3IGFuZCB0byB1c2UgODI1MF9hbWJhcmVsbGEKPj4gPj4gaW5zdGVh
ZC4gVGhhdCBpcyB3aGF0IHRoaXMgcGF0Y2ggaXMuCj4+ID4+IEJhY2tncm91bmQ6Cj4+ID4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvQ0FEKytqTG02SHpFVTFUTS1jPVZ0anYzRkpFQmVjVlA3
VHl4U2dxX1EwekYtWXdUNk5BQG1haWwuZ21haWwuY29tLwo+PiA+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1zZXJpYWwvYW44S3Z2SFdYMG5hSDNYd0Bhc2hldmNoZS1kZXNrLmxvY2Fs
Lwo+PiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1zZXJpYWwvN0U3NzQzMDUtMzky
MC00QkI3LUJBNDYtRTA3NzJENkJFRDg0QGFtYmFyZWxsYS5jb20vCj4+ID4+IEkgd2lsbCBhbHNv
IHN3aXRjaCB0byB1YXJ0X3JlYWRfcG9ydF9wcm9wZXJ0aWVzKCkgYW5kIHRyaW0gdGhlCj4+ID4+
IDgyNTBfZHctZGVyaXZlZCBib2lsZXJwbGF0ZS4KPj4gPgo+PiA+VGhhbmtzIGZvciB0aGUgcmVn
aXN0ZXIgZGVzY3JpcHRpb25zLCBpdCB3YXMgaGVscGZ1bC4gQWZ0ZXIgZ29pbmcgdGhyb3VnaCB0
aGVtCj4+ID5pdCBzZWVtcyB0aGUgdjMgYXMgeW91IG1hZGUgaXQgaXMgZ29vZCBlbm91Z2ggKHNv
cnJ5IGZvciBnb2luZyBiYWNrIGFuZCBmb3J0aCkuCj4+ID5XaGF0IGl0IG5lZWRzIGlzIGJldHRl
ciBjb21taXQgbWVzc2FnZSBleHBsYWluaW5nIHRoYXQgd2hpbGUgaXQncyBub3QgYSBTeW5vcHN5
cwo+PiA+RFcgSVAsIGl0IHdhcyBtYWRlIHRvIGJlIHF1aXRlIGNvbXBhdGlibGUgd2l0aCB0aGF0
IChvbiByZWdpc3RlciBsZXZlbCkgYW5kIGhlbmNlCj4+ID5ubyBuZXcgZHJpdmVyIGlzIHJlcXVp
cmVkLCBqdXN0IGEgc21hbGwgcXVpcmsuCj4KPi0tIAo+V2l0aCBCZXN0IFJlZ2FyZHMsCj5BbmR5
IFNoZXZjaGVua28KPgo=
