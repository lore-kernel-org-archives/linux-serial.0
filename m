Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C228E0;
	Thu,  9 Apr 2026 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713689; cv=none; b=NvfbjWbXWKC1CBec+86VSrTTOa0ryrls50v9A6+rFjU+xe0w7khAJzmibI45IGqRqTo7T9dh0omCu6tvJ0ui1ehzOEhxra4CkWxdZAgDPx1uHECqQNeAlu8iPyd+XXLMTCvdFgeBCUc/fTfCDvhW2sO9sRd6l+Brf3EDRDZ5XgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713689; c=relaxed/simple;
	bh=NG13cdXqhW154r9VFSj2tddCyo9+eF7geiHfEuwKbnw=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Lg7n+i+M/T3O6J4BLeHBYq2Np4r3o7ECdpwJ16njBmFJVWj6jNlunPN6imBAF9ihUIO/7EepEyqXUgYx4J6oO+z6jxv8OOPMrZJJPiylAF3ZmOgBgB+EYX2DWJ+Pt7diyWv0NwTDkt3NQMXaUXhZwSx9tbhuKt3aOaqwTiG5w78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Yq5k+r5y; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Yq5k+r5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775713682; bh=NG13cdXqhW154r9VFSj2tddCyo9+eF7geiHfEuwKbnw=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=Yq5k+r5y1BKJ7+PMBy/N3yPTFicaDaP738vC6T9ilqN2TESJnBxb/x+O+ym5n/G/l
	 LK/gx3kzeSYDuNt+dusEzrEwih6nJRtPTnNyLqnw68NSh2+Nk00EN3MRL7m/rxH3qQ
	 Jz93t4j36XFiuNww4VVFsrhSx60HhC1oAqd4RvRY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: NB8AK7fcAs0K4ZQce5atX4P/9aIIRPZsReu8s9w+zczP9O4PAhrbqjvQKv5YqT
	 LlX8FCl8u6hsngR7tSKZ86/7o1gXamWHh2C0ta/nsSBrQ9qjxic080irZLviKehnxZcEJvtnfD3dA
	 sjItO4ds6o7E/EE/cJRPR/50fIUKb4UnlvwGfmAEVBhKBcMsAjM6ptm/jEs2lwNPWzPz4CeWMuCCT
	 OfeMCnUEUnaBc74aCIcjnA+WxrU5WIZAXknGiTZWgG2A+UveRf/hCvUt9aPrdiYqTjWnmyHB5jNa1
	 oHk2m1TSCRSh6opdW9iFZZdi3RPVMz4zKUB82zvdM8WWBLg7kjJzqgtqBF5alz0fuWLXFZABo2eW/
	 mtnYSQmA26CGQJHkqG5nXWi6VoyOhnXaJXaX70UZ8cnYudp8ZuE5HOljvUbz5NLGdARL0z9Vm4Me/
	 2ehAvcfiHDl9lmG1XmJYBkL8OVDz4uPeW5+fZh+5jkH045dUaxyiXU05W8GYzEdSr5AtXtUl01jai
	 xWcn94Rio2MHoxBAYyPV2u4JNV9vV3nhjDGNxgzTrATiPSaqP8nfXuwY1v0upEkuyFu0NdUuqZmwt
	 oJO5R8rBK/HE2ihT9zSkaClMBuV7bu55a7ld3IB3pPZldXLvvIRliYXRGNOOgA2qV4Dw37vcNrvKs
	 4Z8ISTpBtP6dthvc9Gu6fxqEBwrMOzL2Jcan7cmPbQJZcRF/ED7K5jR+FzonQ4DE3FxWZH8u6XRJT
	 wQNLx+23XNFOHauc5xUtFuQaL2K0SjTCdNZA7Sh/uGlZ74RXc7/UgvD1XXf6M+Z2qnw99PbUBC1fK
	 iuLwm3gYi5kW1KaX7jECQVl1mGl7FZm89kRAYWuLZebEH1b9l0BBNpEYc97+5EMLaIKcA1RBjWR8n
	 v31yGJrZy4e/e/fTXmJrfRcpvOr+RtwITYf+dhVEEM/0KLbL2JVJ5RtoKiyvRipBwCyT6FS8o5Njt
	 BznLqjgBO6MkWw5mcDUzl1+owQIQSPWHG/q8ADFF9szGMzDl6yhx6//nP1PPHwPeXuujU3HCRz43s
	 8M3gX
From: "=?utf-8?B?5L+e5pyd6Ziz?=" <2426767509@qq.com>
To: "=?utf-8?B?QW5keSBTaGV2Y2hlbmtv?=" <andriy.shevchenko@linux.intel.com>
Cc: "=?utf-8?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?amlyaXNsYWJ5?=" <jirislaby@kernel.org>, "=?utf-8?B?a2Vlcw==?=" <kees@kernel.org>, "=?utf-8?B?Zm91cmllci50aG9tYXM=?=" <fourier.thomas@gmail.com>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?Z3N6aGFp?=" <gszhai@bjtu.edu.cn>, "=?utf-8?B?Wmhhb3lhbmcgWXU=?=" <23120469@bjtu.edu.cn>
Subject: Re: [PATCH] tty: serial: pch_uart: add check for dma_alloc_coherent()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 9 Apr 2026 13:46:50 +0800
X-Priority: 3
Message-ID: <tencent_7753BD5DA5FC7F7BB722609FA158ACC5F50A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260408072421.831-1-23120469@bjtu.edu.cn>
	<adZWm7GxCU_-T0zc@ashevche-desk.local>
In-Reply-To: <adZWm7GxCU_-T0zc@ashevche-desk.local>
X-QQ-mid: xmsezb51-0t1775713610t4euz07oj

SGkgQW5keSwKClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQgdGhlIHN1Z2dlc3Rpb25z
IQoKPiBMb29rcyBsaWtlIGl0IGRlc2VydmVzIGEgRml4ZXMgdGFnLgoKQWdyZWVkLiBJIHdp
bGwgZmluZCB0aGUgb3JpZ2luYWwgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGlzIGlzc3Vl
IGFuZCBhZGQgdGhlIHByb3BlciBGaXhlcyB0YWcgaW4gdGhlIHYyIHBhdGNoLiBJJ2xsIHNl
bmQgaXQgb3V0IHNob3J0bHkuCgo+IEFsc28gaWRlYWxseSB0aGlzIGRyaXZlciBzaG91bGQg
YmUgY29udmVydGVkIHRvIG9uZSBvZiA4MjUwIGNhc2VzLgo+IFRoZSBsYXR0ZXIgaGFzIGFs
cmVhZHkgRE1BIHN1cHBvcnQuIE5vdGUsIGlmIHlvdSBhcmUgZ29pbmcgdGhpcwo+IGRpcmVj
dGlvbiwgSSBoYXZlIHRoZSBoYXJkd2FyZSB0byB0ZXN0LgoKVGhhbmsgeW91IHZlcnkgbXVj
aCBmb3Igb2ZmZXJpbmcgdG8gdGVzdCBvbiB0aGUgYWN0dWFsIGhhcmR3YXJlISBUaGF0IGlz
IGluY3JlZGlibHkgaGVscGZ1bC4gCgpJIGFncmVlIHRoYXQgY29udmVydGluZyB0aGlzIGRy
aXZlciB0byB0aGUgODI1MCBmcmFtZXdvcmsgaXMgdGhlIHJpZ2h0IGRpcmVjdGlvbi4gU2lu
Y2UgdGhhdCB3b3VsZCBiZSBhIGxhcmdlciByZWZhY3RvcmluZyBlZmZvcnQsIEkgdGhpbmsg
aXQgbWlnaHQgYmUgYmVzdCB0byBhcHBseSB0aGlzIHF1aWNrIE5VTEwgcG9pbnRlciBmaXgg
Zmlyc3Qgc28gdGhhdCB0aGUgY3VycmVudCBkcml2ZXIgaXMgc2FmZS4gCgpBZnRlciB0aGlz
IGZpeCBpcyBzZXR0bGVkLCBJIGFtIHZlcnkgaW50ZXJlc3RlZCBpbiB0YWtpbmcgYSBsb29r
IGF0IHRoZSA4MjUwIGNvbnZlcnNpb24gYXMgYSBmb2xsb3ctdXAgcHJvamVjdC4gSSBtaWdo
dCBuZWVkIHNvbWUgdGltZSB0byBzdHVkeSB0aGUgODI1MCBETUEgZnJhbWV3b3JrLCBidXQg
SSB3aWxsIGRlZmluaXRlbHkgcmVhY2ggb3V0IHdpdGggYSBwYXRjaCBzZXJpZXMgZm9yIHlv
dSB0byB0ZXN0IHdoZW4gSSBnZXQgdGhlcmUhCgpCZXN0IHJlZ2FyZHMsClpoYW95YW5nIFl1


