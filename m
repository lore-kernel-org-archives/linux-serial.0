Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com [220.197.31.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627F4ED1BE;
	Mon, 19 Oct 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412267; cv=none; b=kIgRNEskuaM/fG9jy945LRa8aXuZOVJ2V3xrAV0afO30RDIo4py1FMpR16W46tcng9eE1guo8l+9mhu5FittcjmlcxaoWA2cFOsu5JB5Zk0SKYJIOQKTY9xZgHpV8zNzkBEpLQH23A1SPIexxEY1NLks+/VbkOTg9CMDulQWkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412267; c=relaxed/simple;
	bh=HxkZY+A2kdpdx1U21FwAkTDLKgJKacIyOqsy0+iN20A=;
	h=Content-Type:Message-ID:Cc:Subject:MIME-Version:From:Date; b=QJUkxq+bv4uqTMuSxCiXQZGbmb/BJWhjhpht3pimZOViP4U++JUWnd7Qm56U2NxLP1KJWwEUgbT2yeh1zONIYs6eKsqCw/xdfnuV+L3qIrLT1aT6kdh0/Fe9pzReBetVL15CURE8gzCF+fSM8/f/9VCGBTQU8GZTeBoBJxiPAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=UKr2Mssr; arc=none smtp.client-ip=220.197.31.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="UKr2Mssr"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABgATwC*LB*mn0TQFmWSEarb.1.1792410126342.Hmail.252270051@hdu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: =?UTF-8?B?dHR5OiB0aW1idWFydDogdGFza2xldCBtYXkgdHJpZ2dlciBVQUYgZHVyaW5nIHJlbW92ZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 252270051@hdu.edu.cn( [183.157.177.89] ) by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Oct 2026 19:42:06 +0800 (GMT+08:00)
From: LI xiao  <lixiao0@hdu.edu.cn>
Date: Mon, 19 Oct 2026 19:42:06 +0800 (GMT+08:00)
X-HM-Tid: 0aa153f5b429d458kusyc58e6ca6bff9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0kdVh1ITU5PT0kdSB1KQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSk5MVUpMTFVDQllXWRYaDxIVHRRZQVlPS0hVSk
	tISkxDSlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=UKr2MssrQn9U9S8Yh3Rmzzlc6DHlUFemJwcYfnOhyKHaWnDzC7km2ggEQRoFbrDxpTLjjf7MOu9mYr703aAvwOhrvqn4x0q+pO39TLPBqX6HQf2bPDLCrN5YjgU030QUkyFW3u9rHaFEdCOG2kRWSWQSB7w3/5+fJzn93pPyGxU=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=HxkZY+A2kdpdx1U21FwAkTDLKgJKacIyOqsy0+iN20A=;
	h=date:mime-version:subject:message-id:from;

SGVsbG8sCgpJIHN1c3BlY3QgYSB0YXNrbGV0IGxpZmV0aW1lIHJhY2UgaW4gdGhlIHRpbWJ1YXJ0
IGRyaXZlciB0aGF0IG1heSBsZWFkIHRvIGEgVUFGLgoKdGltYnVhcnRfcmVtb3ZlKCkgY2FsbHMg
dGFza2xldF9raWxsKCZ1YXJ0LT50YXNrbGV0KSBiZWZvcmUgdWFydF9yZW1vdmVfb25lX3BvcnQo
KSwgdGhlbiBmcmVlcyB1YXJ0LiBUaGUgSVJRIGhhbmRsZXIgc2NoZWR1bGVzIHRoZSBzYW1lIHRh
c2tsZXQuIEFuIElSUSBvY2N1cnJpbmcgYWZ0ZXIgdGFza2xldF9raWxsKCkgcmV0dXJucyBidXQg
YmVmb3JlIHRoZSBJUlEgaXMgZnJlZWQgYW5kIHN5bmNocm9uaXplZCBkdXJpbmcgcG9ydCBzaHV0
ZG93biBtYXkgcXVldWUgdGhlIHRhc2tsZXQgYWdhaW4uIFRoZSBzdWJzZXF1ZW50IElSUSBzeW5j
aHJvbml6YXRpb24gZG9lcyBub3QgaXRzZWxmIGRyYWluIGEgdGFza2xldCB0aGF0IGhhcyBhbHJl
YWR5IGJlZW4gcXVldWVkLCBwb3RlbnRpYWxseSBhbGxvd2luZyBpdCB0byBhY2Nlc3MgdGhlIGZy
ZWVkIHVhcnQgb2JqZWN0LgoKSSB0ZXN0ZWQgdGhpcyBvcmRlcmluZyBvbiBMaW51eCA3LjMgKGNv
bW1pdCBjMDNjMWExNDUwN2RmYWY4Yjg1NmMyNjA4ZjlhYzIxNjAyMWZjMjIyKSB1c2luZyBhIEtB
U0FOIGtlcm5lbCBpbiBhIDItdkNQVSBRRU1VIGd1ZXN0LiBBIHRlc3QgbW9kdWxlIGZvcmNlZCB0
aGUgcmVsZXZhbnQgb3JkZXJpbmcgYnkgc2NoZWR1bGluZyB0aGUgdGFza2xldCBhZnRlciB0YXNr
bGV0X2tpbGwoKSwga2VlcGluZyB0aGUgc29mdGlycSBwZW5kaW5nLCBmcmVlaW5nIHRoZSBvd25l
ciwgYW5kIHRoZW4gYWxsb3dpbmcgdGhlIHRhc2tsZXQgdG8gcnVuLiBLQVNBTiByZXBvcnRlZDoK
CkJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gdGFza2xldF9hY3Rpb25fY29tbW9u
KzB4NjA1LzB4NzgwClJlYWQgb2Ygc2l6ZSA4IC4uLiBieSB0YXNrIHRpbWJ1YXJ0LXJlcHJvLQpD
YWxsIFRyYWNlOgp0YXNrbGV0X2FjdGlvbl9jb21tb24KaGFuZGxlX3NvZnRpcnFzCmRvX3NvZnRp
cnEKX19sb2NhbF9iaF9lbmFibGVfaXAKc2ltdWxhdGVkX2lycSBbdGltYnVhcnRfdGFza2xldF9y
ZXByb10KCkFsbG9jYXRlZCBieToKX19rbWFsbG9jX2NhY2hlX25vcHJvZgp0aW1idWFydF90YXNr
bGV0X3JlcHJvX2luaXQgW3RpbWJ1YXJ0X3Rhc2tsZXRfcmVwcm9dCgpGcmVlZCBieToKa2ZyZWUK
dGltYnVhcnRfdGFza2xldF9yZXByb19pbml0IFt0aW1idWFydF90YXNrbGV0X3JlcHJvXQoKVGhp
cyByZXByb2R1Y2VyIHZhbGlkYXRlcyB0aGUgdGFza2xldCBvcmRlcmluZyBhbmQgVUFGIHNjZW5h
cmlvLCBidXQgaXQgZG9lcyBub3QgZW11bGF0ZSBUaW1iZXJkYWxlIFVBUlQgaGFyZHdhcmUgb3Ig
ZXhlcmNpc2UgdGltYnVhcnQncyBhY3R1YWwgSVJRIGhhbmRsZXIuIFRoZSByZWFsIGhhcmR3YXJl
IGludGVycnVwdCBwYXRoIGhhcyBub3QgYmVlbiB2ZXJpZmllZC4KCkNvdWxkIHlvdSByZXZpZXcg
d2hldGhlciB0aGUgZHJpdmVyIHRlYXJkb3duIGhhcyB0aGlzIHJhY2UgYW5kIGFkdmlzZSBvbiB0
aGUgYXBwcm9wcmlhdGUgZml4PwoKVGhhbmtzLApMSSBYaWFv
