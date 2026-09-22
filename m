Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC56375ADD;
	Tue, 22 Sep 2026 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065756; cv=none; b=mbMMU5hyYKPuZiDpbWmXDBNtrRf5okeTxw4W5bXFfbD59XJGNO5mRUqRkke4O2gacAZaarBBEM0/mJopHUoJl+0OlNMUIobOm62zNc2JdUKWfY68pSN7T3USe3RFZzBVudUThrk1QgK7fANahk0PhjBoc1bp01/i4Ow0GszOeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065756; c=relaxed/simple;
	bh=qnoll3Gl1nyyRg5uk5+JlX/6VytXLqnlS1hZMgMavvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DRj0hXTnfodVCJLbhJ5eUpCQThirzzFDDOVZaPqZ7QaDgh2X/go8Pfk7UESf9LQKyKOUzN7ThKjaxzvzUO+HG13ZnKF9hDlqspNddhQXyCxu/aAdoN6BX5yThMiSZ5CgHQRTYyxXKbNxRgvsdXDyA2KlDqgztNC84sOQTXi4tW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RNwWRP9F; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RNwWRP9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qnoll3Gl1nyyRg5uk5+JlX/6VytXLqnlS1hZMgMavvY=; b=R
	NwWRP9F5BPYXmSDWAJQfRmpnoOszT2orSP3u0oCdHZVq6mnHamYOXonbeHsow2zB
	lYyrdzhcsQ/QeiWStDCFGgVcxODu43kafaXkp2T6ZUfwYUZLdf+nIz3eirG5RCqX
	Uli6/RKw2xVcJ4H7Jne37fPrwQ0hLs4nMjmF8w09xE=
Date: Tue, 22 Sep 2026 16:28:00 +0800 (CST)
From: zl020895  <zl020895@163.com>
To: "Linus Walleij" <linusw@kernel.org>
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
Subject: Re:Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75
 pinctrl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAD++jLnUVOAtq-h_qDdWpEhZFZehFKo4qqgcTHD9zDQTdF4yhg@mail.gmail.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
 <CAD++jLnUVOAtq-h_qDdWpEhZFZehFKo4qqgcTHD9zDQTdF4yhg@mail.gmail.com>
X-NTES-SC: AL_Qu2SAvyduk4j5iOeZekcn0wRhug/UMa4u/sm3YNXc84FpwPw5QMjZmNDNHL32tKTBxilqxOseRpTx8lTXqZ3KLaXA5U/vIF3zQFUwP6sBg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <408f0b0c.7560.1a0c83a9ff4.Coremail.zl020895@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgD3vzgQPLJqKLkVAA--.40070W
X-CM-SenderInfo: d2oqjiqyzvqiywtou0bp/xtbCxRBay2qyPBBDAwAA3w
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTGludXMsCgpUaGFuayB5b3UuCgoiUHV0dGluZyBzb21lIHBpZWNlcyBpbiBwbGFjZSB0byBi
ZWdpbiB3aXRoIiBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4gV2hhdCBkbyBJIG5lZWQgdG8gZG8g
bmV4dD8gSeKAmW0gc3RpbGwgbmV3IHRvIHRoaXMsIHRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZSBh
bmQgZ3VpZGFuY2UuCgpCZXN0IHJlZ2FyZHMsCkxvbmcgWmhhbwoKQXQgMjAyNi0wOS0yMiAxNTox
MToxOSwgIkxpbnVzIFdhbGxlaWoiIDxsaW51c3dAa2VybmVsLm9yZz4gd3JvdGU6Cj5IaSBMb25n
LAo+Cj5PbiBNb24sIFNlcCAyMSwgMjAyNiBhdCA2OjIz4oCvQU0gTG9uZyBaaGFvIHZpYSBCNCBS
ZWxheQo+PGRldm51bGwrbG9uZ3poYW8uYW1iYXJlbGxhLmNvbUBrZXJuZWwub3JnPiB3cm90ZToK
Pgo+PiBGcm9tOiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5jb20+Cj4+Cj4+IERvY3Vt
ZW50IHRoZSBDVjc1IHBpbiBjb250cm9sbGVyIGJpbmRpbmcgdXNpbmcgZ2VuZXJpYyBmdW5jdGlv
biBhbmQKPj4gZ3JvdXBzIHByb3BlcnRpZXMgZm9yIHBpbm11eCBjb25maWd1cmF0aW9uLgo+Pgo+
PiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXN3QGtlcm5lbC5vcmc+Cj4+IFJldmll
d2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFs
Y29tbS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IExvbmcgWmhhbyA8bG9uZ3poYW9AYW1iYXJlbGxh
LmNvbT4KPgo+SXMgdGhpcyBzb21ldGhpbmcgSSBzaG91bGQganVzdCBhcHBseSB0byB0aGUgcGlu
Y3RybCB0cmVlPwo+Cj5TYW1lIHF1ZXN0aW9uIGFib3V0IHRoZSBkcml2ZXIuCj4KPkknbSBub3Qg
c3VyZSB5b3UnbGwgZ2V0IGFsbCBvZiB0aGUgQW1iYXJlbGxhIGluIGZvciB2Ny40IGFueXdheQo+
c28gd2hhdCBhYm91dCBwdXR0aW5nIHNvbWUgcGllY2VzIGluIHBsYWNlIHRvIGJlZ2luIHdpdGg/
Cj4KPllvdXJzLAo+TGludXMgV2FsbGVpago=
