Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B6372;
	Wed, 19 Mar 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386569; cv=none; b=Y9vMwwwxgglfFwsoKJGyptCLwvRgJ35zVeisGY4ustU+7fjTMFWbE/rwwBEG1f2Ni8QAzVdkvzlSRwloWU7Rx2q/Uax3plob+MJaZ2f3HRLZX889HALsNUo+UmTROueegJwaK6xRm80sicH7j/jPX9gN06LRCRt93MxCK+YE/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386569; c=relaxed/simple;
	bh=hoFKpOFzyzUs5Tf+F0zgQXoNmD8Y2fp616I9iAWieZg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=iCmTZszDhuLjkC209Dr/XxpAQNLGfggrRFgtmI3I5qnco3pdb6JKWEf+a7HdD+KrLxoLpBdeSzL1q43ZKGzimBsCLWTvhq81r7APRf9YaJ1Def2RGkCntUByn0t8hMUXj0OQs4sy3ODE39HSzq2bzXNULXaBU1ZkSlAUZ/EbM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hyP6YvE9; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hyP6YvE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742386527;
	bh=hoFKpOFzyzUs5Tf+F0zgQXoNmD8Y2fp616I9iAWieZg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=hyP6YvE9U8Sa5B9E7YTi/Gq9AuiEy3sDGMo0CYWYhYnuYWSOH7IhMXuUeIJatVs/C
	 MHdOAqetmf9dKZPrdbH3GNNRuN654lscxOvTAYMQCmwoNr+i9WKHc0044x/cqeUzxV
	 E9iv0u55IgsFiH+14Ir8+icxwkf/qksNS3VefoME=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTaNE5G7a0fa7M/rEhb0o4JjCHUE1mhqHo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: qoIzFjdllbkWJf7JCxb3nbZihj4PhY5B52skllgoaD0=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1742386520t8481319
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?RmVycnkgVG90aA==?=" <ftoth@exalondelft.nl>, "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 19 Mar 2025 20:15:19 +0800
X-Priority: 3
Message-ID: <tencent_2C47E37E3DFC481229FF3C45@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
	<tencent_7FB378712CE341FE55666DAD@qq.com>
	<2025031900-junkyard-crane-4c93@gregkh>
In-Reply-To: <2025031900-junkyard-crane-4c93@gregkh>
X-QQ-ReplyHash: 1527423396
X-BIZMAIL-ID: 9774899562864434385
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 19 Mar 2025 20:15:21 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MzaZbajgbPzxtnuxDeLhi9EiLQMaOZ/9CMXbEXbyF1R47Yqhh2csIZXv
	98K/6urs3LIf+eeSTYGAWSM3Abl0kNgQbbPitQGOO4YlwrmsKtzbpiyDMNZ1vcVkp3l2JI/
	qhNztxRWCeE3wiXDULc3yk8x0VZBhTLxdqJOUUIYqIrHTTp61m7G+WzdKQTY2iXLxbCDra6
	7bxcvvDIVDmfUaZtJu9e5Eg++/lB6Zp6UopfoNMo9tJFlEzvBFyTLmGzKcQajMrS5BbF6go
	wpxY+K2dbocMFD7jkS+udKvlLMG1L1kbFmvvFelN78QVhMx8fKk+kLcqF+tiipIyQloph6z
	QiR0rG4gio5go9oMZlZ8wxj9XkcZ1uFzdPMD2ZNHms6Fa8rnPGCbp6wv2ed9zHjbqLyBDGy
	8TVADRIJvXXwl+ZINzHioqL4qIzgHfL2nA/XiVBZ9gzfH7OxFnIi1OXkoHrYu/PM/9PrSgv
	5M9QBEGHSMS/w9cNIY7SJaN+mmLroqzztnBbiDYPSAa0ONQ65TMZML4fWPLnWLq2V469/KF
	pxfBjzYHyqrqpWKrglNHDI8bgsu+KH16lXBIMyfxnhrAa8DPjLf/OX7tnIlNOhCfZzzQn+D
	/SOx7qXm9Vs7TF8GY5bxTu0r5zk/BgPsNnv9orbLTrAkVkeMX01q6LtqusRw+SxjBTQEWGe
	c2rSciTzV791YT+6wFHKACfB7MSdcf8rGEwP8IiUEzAbyUN/IeA5WN4B7wt9Oe32N/bkXJo
	77nURDgUOZUzNKhW86FpVoJafOzK0BBO8SWoWkGKy6CnjyoZtM603aXeb66NsWUrq1bnCK4
	8M+g7gY/wVcqZYb6doQh/dPCe1Vt2Y/iT/fLV2TsW54IjM1fQwwDEo8Iw1db1leKO5Lej21
	hRZhSH/ObR6IztMPztinuhkMaYebdfssN63coaT8/Ttr2nmGmwT6kvnj7hZvVotCLWmUypx
	EDezPoNLdu7pNht6L7bpOwVcDleIB2IxjXBKtcSNKTqZl4c03G1tPIvH9uBMloEjkdzaot0
	u/q40nqi+OoglOMa+Aq7BwipMQUxaqtYm2NV3RzYMKmf9GSC8Nz+f2jsLT2TlBiKtRatvrA
	Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNClRoZSBwaW5nIHF1ZXJ5IHRoZSBwYXRjaCBzdGF0ZToNCg0KW1BBVENIXSBz
ZXJpYWw6IDgyNTBfZG1hOiB0ZXJtaW5hdGUgY29ycmVjdCBETUEgaW4gdHhfZG1hX2ZsdXNo
KCkNCg0KV2hlbiBmbHVzaGluZyB0cmFuc21pdCBzaWRlIERNQSwgaXQgaXMgdGhlIHRyYW5z
bWl0IGNoYW5uZWwgdGhhdCBzaG91bGQNCmJlIHRlcm1pbmF0ZWQsIG5vdCB0aGUgcmVjZWl2
ZSBjaGFubmVsLg0KDQpGaXhlczogOWU1MTJlYWFmOGY0MCAoInNlcmlhbDogODI1MDogRml4
IGZpZm8gdW5kZXJmbG93IG9uIGZsdXNoIikNClJlcG9ydGVkLWJ5OiBXZW50YW8gR3VhbiA8
Z3VhbndlbnRhb0B1bmlvbnRlY2guY29tPg0KU2lnbmVkLW9mZi1ieTogSm9obiBLZWVwaW5n
IDxqa2VlcGluZ0Bpbm11c2ljYnJhbmRzLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfZG1hLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX2RtYS5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kbWEuYw0K
aW5kZXggZjI0NWE4NGY0YTUwOC4uYmRkMjZjOWYzNGJkZiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZG1hLmMNCisrKyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfZG1hLmMNCkBAIC0xNjIsNyArMTYyLDcgQEAgdm9pZCBzZXJpYWw4MjUw
X3R4X2RtYV9mbHVzaChzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnApDQogICAqLw0KICBkbWEt
PnR4X3NpemUgPSAwOw0KIA0KLSBkbWFlbmdpbmVfdGVybWluYXRlX2FzeW5jKGRtYS0+cnhj
aGFuKTsNCisgZG1hZW5naW5lX3Rlcm1pbmF0ZV9hc3luYyhkbWEtPnR4Y2hhbik7DQogfQ0K
IA0KIGludCBzZXJpYWw4MjUwX3J4X2RtYShzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnApDQot
LSANCjIuNDguMQ==

