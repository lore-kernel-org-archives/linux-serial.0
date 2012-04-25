From: Christian Melki <christian.melki@ericsson.com>
Subject: 8250.c less than 2400 baud fix.
Date: Wed, 25 Apr 2012 14:26:36 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A07E00CF0@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_1346E68D3A5B2043907CF4BF466383411A07E00CF0ESESSCMS0353e_"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw1.ericsson.se ([193.180.251.45]:46916 "EHLO
	mailgw1.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2DYM0j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Apr 2012 08:26:39 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

--_002_1346E68D3A5B2043907CF4BF466383411A07E00CF0ESESSCMS0353e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi.

We noticed that we were loosing data at speed less than 2400 baud.
It turned out our (TI16750 compatible) uart with 64 byte outgoing fifo was =
truncated to 16 byte (bit 5 sets fifo len) when modifying the fcr reg.
The input code still fills the buffer with 64 bytes if I remember correctly=
 and thus data is lost.
Our fix was to remove whiping of the fcr content and just add the TRIGGER_1=
 which we want for latency.
I can't see why this would not work on less than 2400 always, for all uarts=
...
Otherwise one would have to make sure the filling of the fifo re-checks the=
 current state of available fifo size (urrk).

Best regards,
Christian Melki


--_002_1346E68D3A5B2043907CF4BF466383411A07E00CF0ESESSCMS0353e_
Content-Type: application/octet-stream; name="8250-fix.patch"
Content-Description: 8250-fix.patch
Content-Disposition: attachment; filename="8250-fix.patch"; size=694;
	creation-date="Wed, 25 Apr 2012 06:21:33 GMT";
	modification-date="Wed, 25 Apr 2012 06:21:35 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJwTiBsaW51eC0zLjMuMi5vcmlnLy9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUw
LmMgbGludXgtMy4zLjIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MC5jCi0tLSBsaW51eC0z
LjMuMi5vcmlnLy9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwLmMJMjAxMi0wNC0yNSAwODox
OTozNS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTMuMy4yL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTAuYwkyMDEyLTA0LTI1IDA4OjIwOjM1LjAwMDAwMDAwMCArMDIwMApAQCAtMjI5OSwx
MCArMjI5OSwxMSBAQCBzZXJpYWw4MjUwX2RvX3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvCiAJ
CXF1b3QrKzsKIAogCWlmICh1cC0+Y2FwYWJpbGl0aWVzICYgVUFSVF9DQVBfRklGTyAmJiB1cC0+
cG9ydC5maWZvc2l6ZSA+IDEpIHsKLQkJaWYgKGJhdWQgPCAyNDAwKQotCQkJZmNyID0gVUFSVF9G
Q1JfRU5BQkxFX0ZJRk8gfCBVQVJUX0ZDUl9UUklHR0VSXzE7Ci0JCWVsc2UKLQkJCWZjciA9IHVh
cnRfY29uZmlnW3VwLT5wb3J0LnR5cGVdLmZjcjsKKwkJZmNyID0gdWFydF9jb25maWdbdXAtPnBv
cnQudHlwZV0uZmNyOworCQlpZiAoYmF1ZCA8IDI0MDApIHsKKwkJICAgIGZjciAmPSB+VUFSVF9G
Q1JfVFJJR0dFUl9NQVNLOworCQkgICAgZmNyIHw9IFVBUlRfRkNSX1RSSUdHRVJfMTsKKwkJfQog
CX0KIAogCS8qCg==

--_002_1346E68D3A5B2043907CF4BF466383411A07E00CF0ESESSCMS0353e_--
