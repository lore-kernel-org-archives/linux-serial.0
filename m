Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE53BCD01;
	Tue, 22 Sep 2026 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050845; cv=none; b=vCqC08UWqsklponm8GoGi4r2wxnm/YynD3MNLr44rDEED89w4UDCa0jhmhKtl1pBo5EdBVapFTc2xyWSZhuNWIeNMd3WFS+ZpQJp1z+OaMreI4n8YZhkhvl9Z10VqjdSX32Xr4ivvMueulgNYTTCL+TuJg6LUPN88cj4L7v+76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050845; c=relaxed/simple;
	bh=ad1foQTOYEXLcLgFQr70P3Xj3nYeLN3dA9t+EM+hdhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jhiRB3NRiXMBgcsjkMH2dU62quC4pJ5RL/UnjZ1UKXsMZQzgM/87YoDHkLgDnFGLkuRs7InIvAzRRuFWPHHMoJpPgbZgvsV480a1R72ksf8dTw9yOG3Z9htD5XrUCMcbUPc0qF5AjKdaHSRqGaQNqnAZlcyoTgFp5llamS1q7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WH5CGQT7; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WH5CGQT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ad1foQTOYEXLcLgFQr70P3Xj3nYeLN3dA9t+EM+hdhM=; b=W
	H5CGQT7XIildbReuFWgF+cx7krTqSVujXM9OadX60oIyUIQn/KxvC6NoGQNPDoQ6
	Euvsdpsk4u5+2MPnNPVi0AIAaYL86fGg1VLMFirppLIo2Wb0zdk/Mofg5lJ61IDy
	gqK7T8VWSKJtv+7y87YaaYr1iISs7ryKsgMu1R72ow=
Date: Tue, 22 Sep 2026 12:19:04 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Michael Walle" <michael@walle.cc>
Cc: longzhao@ambarella.com, "Arnd Bergmann" <arnd@arndb.de>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Michael Turquette" <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Linus Walleij" <linusw@kernel.org>,
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
Subject: Re:Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <DLL07DMYQ9EN.3I5OQJ93M8J1O@walle.cc>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <DLL07DMYQ9EN.3I5OQJ93M8J1O@walle.cc>
X-NTES-SC: AL_Qu2SAvyev08v4iacYukcn0wRhug/UMa4u/sm3YNXc8IFsjzg4iUlVkNgBVjUyuKtIgyxmweLaAZBxvZ/ZKZCuTITU4LEoOcwLgmvwt6CaA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <523f60f4.3f39.1a0c756b94f.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgDXf+K4AbJquzFMAA--.1123W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxRi1J2qyAbiL5AAA3B
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTWljaGFlbCwKClNvcnJ5IGFib3V0IHRoYXQuIFRoZSBzZXJpZXMgc3RhcnRlZCBhcyBTb0Mg
YnJpbmctdXAgYW5kIHRoZSBUby9DYyBsaXN0CndhcyBmcm96ZW4gZnJvbSB0aGF0LiBncGlvLXJl
Z21hcCB3YXMgYWRkZWQgbGF0ZXIgYW5kIEkgZGlkIG5vdCByZS1ydW4KZ2V0X21haW50YWluZXIg
b24gdGhvc2UgcGF0Y2hlcywgc28gSSBtaXNzZWQgeW91IGFzIHRoZSBncGlvLXJlZ21hcAptYWlu
dGFpbmVyLgoKWW91IGFyZSBDYydkIGZyb20gbm93IG9uLgoKQmVzdCByZWdhcmRzLApMb25nIFpo
YW8KCkF0IDIwMjYtMDktMjEgMjA6NDY6NTQsICJNaWNoYWVsIFdhbGxlIiA8bWljaGFlbEB3YWxs
ZS5jYz4gd3JvdGU6Cj5PbiBUdWUgU2VwIDE1LCAyMDI2IGF0IDE6MTUgUE0gQ0VTVCwgTG9uZyBa
aGFvIHZpYSBCNCBSZWxheSB3cm90ZToKPj4gVGhpcyBpcyBhIHNpbmdsZSB1bmlmaWVkIHNlcmll
cy4gUGxlYXNlIGFwcGx5IHZpYSB0aGUgU29DCj4+IHRyZWU7IHN1YnN5c3RlbSBtYWludGFpbmVy
cyBhcmUgQ2MnZCBmb3IgdGhlaXIgcGllY2VzLgo+Cj5XZWxsLCBub3QgcmVhbGx5LiBJIHdhc24n
dCBDQydlZCBvbiBhbnkgb2YgdGhlIGdwaW8tcmVnbWFwIHBhdGNoZXMuCj4KPi1taWNoYWVsCg==

