Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB8AD51;
	Sat, 18 Oct 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799106; cv=none; b=TgjnZtli0cSAPo4dA15+ts7xx9N2YIUU+I+6VGaffK9M7p14nk4/pRXgeqj/zVaLB9KigWW733Bk8DyPJ9WWFv5s45uhwrn3MWoMVoI6nSxvZgGXyxEgAoM20AY9JzR9g5fHxmfNtwDxXFvyIfi4GHaYT3h468NMg+ZvM2ZfCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799106; c=relaxed/simple;
	bh=S1HCkmpQ7+I3nvlUjwOzRvoujXqhhZ/uRZvbLib6gwU=;
	h=From:To:Subject:MIME-Version:Date:Message-Id:Content-Type; b=iXoKxYusqnGI+b7F9whJCoBDftJv5EpIOWQyww4CkaB/IhAxowFNdlb9dGi5ypTK7QEpru5AFCtqNre757vGP7jsgHq+ga+2+TS2xd7X/DjSmtMyGU/GQLY0RqHVaHSoKw0UUHRcAT4UYEwufQpfQKg+WUcFQq+gV1d3k1aU83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bDXjbbHv; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bDXjbbHv"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id DBF0781069;
	Sat, 18 Oct 2025 17:51:34 +0300 (MSK)
Received: from mail-nwsmtp-mxback-production-main-74.klg.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-74.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:8240:0:640:d397:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 3603EC004F;
	Sat, 18 Oct 2025 17:51:27 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c43:341:0:640:ef0e:0 [2a02:6b8:c43:341:0:640:ef0e:0])
	by mail-nwsmtp-mxback-production-main-74.klg.yp-c.yandex.net (mxback/Yandex) with HTTPS id qoUfLLMxha60-sG2RjNhD;
	Sat, 18 Oct 2025 17:51:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1760799086; bh=XAgOav7U8f5zHxMigGatzwM+W3jGxhk+oJRplBsCXfA=;
	h=Message-Id:Date:Subject:To:From;
	b=bDXjbbHv4PauW3JWjWv/UoeA8aBwcQHS8IcJNa/7YmHinyD+ClAf8PTMWzlivji52
	 NpgILOPSieXIPtcGYiaEq4uFKn1UsHTHTLxHbb0Yx45AI9YP+v8ooKHWt4QHd2PCM/
	 IMi2E51SCitiGhyKnpPhpffZiLnqdOQNbg5U2IIU=
Authentication-Results: mail-nwsmtp-mxback-production-main-74.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by mail-sendbernar-production-main-85.klg.yp-c.yandex.net (sendbernar/Yandex) with HTTPS id 910b34ea3704d116b8d971597378f0b3;
	Sat, 18 Oct 2025 17:51:25 +0300
From: =?utf-8?B?0JLQu9Cw0LTQuNGB0LvQsNCyINCa0L7RgNC90LXQtdCy?= <vladosov50@yandex.ru>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: fix tty device index parsing [PATCH v1]
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 18 Oct 2025 21:51:25 +0700
Message-Id: <105211760797925@mail.yandex.ru>
Content-Type: multipart/mixed;
	boundary="----==--bound.799098.37777c8a-89fa-4f8a-9831-51a737989bd8"


------==--bound.799098.37777c8a-89fa-4f8a-9831-51a737989bd8
Content-Transfer-Encoding: 8bit
Content-Type: text/html; charset=utf-8

<div><div>Hello.</div><div>I am sending you the patch which fixes incorrect device index parsing in tty_dev_name_to_number().</div><div><div>Thank you for your time and attention. I am looking forward to any comments or suggestions for improvement.<div><span lang="en">Sorry for any mistakes, this is my first patch.</span><div> </div></div></div></div></div>
------==--bound.799098.37777c8a-89fa-4f8a-9831-51a737989bd8
Content-Disposition: attachment;
	filename="0001-tty-fix-device-index-parsing.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
	name="0001-tty-fix-device-index-parsing.patch"

RnJvbSAyOWUwYWUwYjA3M2IzYzU3NmI5OGRmODU1M2IwZWY5ZTI1NWQwYmVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWbGFkb3MgS29ybmVldiA8dmxhZG9zb3Y1MEB5YW5kZXgucnU+
CkRhdGU6IFNhdCwgMTggT2N0IDIwMjUgMjE6MTY6NTAgKzA3MDAKU3ViamVjdDogW1BBVENIXSB0
dHk6IGZpeCBkZXZpY2UgaW5kZXggcGFyc2luZwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKUHJldmlvdXNseSwgc2VhcmNoZWQgZm9yIHRoZSBmaXJzdCBkaWdpdCBpbiB0aGUgZGV2
aWNlIG5hbWUgdG8gZGV0ZXJtaW5lCnRoZSBpbmRleC4gVGhpcyBjYXVzZWQgaW5jb3JyZWN0IHBh
cnNpbmcgZm9yIGRldmljZSBuYW1lcyB0aGF0IGNvbnRhaW4KZGlnaXRzIGJlZm9yZSB0aGUgaW5k
ZXgsIHN1Y2ggYXMgInR0eUNIOTM0NFVTQjAiIG9yICJ0dHlDSDkzNDRVU0IxMCIuCgpUaGUgbG9n
aWMgaXMgdXBkYXRlZCB0byBzY2FuIGJhY2t3YXJkcyBmcm9tIHRoZSBlbmQgb2YgdGhlIHN0cmlu
ZyBhbmQKbG9jYXRlIHRoZSBzdGFydCBvZiB0aGUgbGFzdCBjb250aWd1b3VzIHNlcXVlbmNlIG9m
IGRpZ2l0cywgZW5zdXJpbmcgdGhlCmNvcnJlY3QgZGV2aWNlIG51bWJlciBpcyBleHRyYWN0ZWQu
CgpFeGFtcGxlOgogICAgQmVmb3JlOiAidHR5Q0g5MzQ0VVNCMTAiIOKGkiBwYXJzZWQgYXMgIjkz
NDRVU0IxMCIKICAgIEFmdGVyOiAgInR0eUNIOTM0NFVTQjEwIiDihpIgcGFyc2VkIGFzICIxMCIK
ClNpZ25lZC1vZmYtYnk6IFZsYWRvcyBLb3JuZWV2IDx2bGFkb3NvdjUwQHlhbmRleC5ydT4KLS0t
CiBkcml2ZXJzL3R0eS90dHlfaW8uYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvdHR5X2lv
LmMgYi9kcml2ZXJzL3R0eS90dHlfaW8uYwppbmRleCBlMmQ5MmNmNzBlYjcuLjI1YWE5M2ExNjM0
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdHR5X2lvLmMKKysrIGIvZHJpdmVycy90dHkvdHR5
X2lvLmMKQEAgLTMzOCw4ICszMzgsOSBAQCBpbnQgdHR5X2Rldl9uYW1lX3RvX251bWJlcihjb25z
dCBjaGFyICpuYW1lLCBkZXZfdCAqbnVtYmVyKQogCWludCBpbmRleCwgcHJlZml4X2xlbmd0aCA9
IDA7CiAJY29uc3QgY2hhciAqc3RyOwogCi0JZm9yIChzdHIgPSBuYW1lOyAqc3RyICYmICFpc2Rp
Z2l0KCpzdHIpOyBzdHIrKykKLQkJOworCXN0ciA9IG5hbWUgKyBzdHJsZW4obmFtZSk7CisJd2hp
bGUgKHN0ciA+IG5hbWUgJiYgaXNkaWdpdCgqKHN0ciAtIDEpKSkKKwkJc3RyLS07CiAKIAlpZiAo
ISpzdHIpCiAJCXJldHVybiAtRUlOVkFMOwotLSAKMi4zNC4xCgo=
------==--bound.799098.37777c8a-89fa-4f8a-9831-51a737989bd8--
