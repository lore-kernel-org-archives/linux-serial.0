From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 01/30] disallow SERIAL_8250_PNP with SERIAL_8250_CONSOLE
Date: Wed, 25 Mar 2009 10:18:31 -0500
Message-ID: <20090325101831.1322b00f@torg>
References: <20090324151034.GC6859@ports.donpac.ru>
	<20090324152203.6a989d06@lxorguk.ukuu.org.uk>
	<20090324205945.GA28394@srcf.ucam.org>
	<20090324212653.77d6e70c@lxorguk.ukuu.org.uk>
	<20090324213416.GA29507@srcf.ucam.org>
	<20090324213841.59d6b299@lxorguk.ukuu.org.uk>
	<20090324214321.GA29671@srcf.ucam.org>
	<20090324221816.50e7ccc2@lxorguk.ukuu.org.uk>
	<20090324222934.GA30503@srcf.ucam.org>
	<20090324223632.66680ebd@lxorguk.ukuu.org.uk>
	<20090324225812.GA30827@srcf.ucam.org>
	<20090325092203.139bb144@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:37358 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757265AbZCYPTs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 11:19:48 -0400
In-Reply-To: <20090325092203.139bb144@torg>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrey Panin <pazke@donpac.ru>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBXZWQs
IDI1IE1hciAyMDA5IDA5OjIyOjAzIC0wNTAwDQpDbGFyayBXaWxsaWFtcyA8d2lsbGlhbXNAcmVk
aGF0LmNvbT4gd3JvdGU6DQoNCj4gTm8gQlogb24gdGhpcyBvbmUuIEkgd2FzIHRyeWluZyB0byBi
cmluZyB1cCBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBSVA0KPiBrZXJuZWwgb24gc29tZSBvZiBteSBs
YWIgaC93IChtb3N0bHkgd2hpdGVib3hlcywgYWxsIHcvc2VyaWFsIGNvbnNvbGUpDQo+IGFuZCBr
ZXB0IHBhbmljJ2luZyBkdXJpbmcgYm9vdC4gSSBldmVudHVhbGx5IHN0dW1ibGVkIHVwb24gUE5Q
IHNlcmlhbA0KPiBhcyBhIGxpa2VseSBjdWxwcml0LCB0dXJuZWQgaXQgb2ZmIGFuZCB0aGUgcHJv
YmxlbSB3ZW50IGF3YXkuIFNvIEkgc2VudA0KPiB0aGUgcGF0Y2ggdG8gQWxhbi4gDQo+IA0KDQpV
Z2gsIHRoYXQncyB3aGF0IEkgZ2V0IGZvciByZXBseWluZyBiZWZvcmUgbXkgdGhpcmQgY3VwIG9m
IGNvZmZlZS4gDQoNCkkgd2FzIHRyeWluZyB0byBicmluZyB1cCBhIDIuNi4yNi1ydCBrZXJuZWwg
b24gYW4gSUJNIExTMjAgYmxhZGUgYmFjayBpbg0KSmFudWFyeS4gSXQgd2FzIGEgY29tcGFyaXNv
biBleHBlcmllbWVudCAoTVJHIFJUIHdhc24ndCBnb2luZyB0byB1c2UgYQ0KMi42LjI2IGtlcm5l
bCksIHNvIEkgZGlkbid0IGZpbGUgYSBCWiBvciBrZWVwIGFueSBvZiB0aGUgZGF0YSBhcm91bmQg
OiguDQoNCkkgZG9uJ3Qgc2VlIHRoaXMgcGFuaWMgaW4gdGhlIDIuNi4yNCBzZXJpZXMsIG5vciBk
byBJIHNlZSBpdCBpbiB0aGUNCjIuNi4yOSBzZXJpZXMsIHNvIGl0IHNlZW1zIHRoYXQgSSBvbmx5
IHNhdyBpdCBpbiAyLjYuMjYuICBJJ2xsIGtlZXAgYW4NCmV5ZSBvdXQgZm9yIHRoaXMgYmVoYXZp
b3IgYWdhaW4sIGJ1dCBzdGlsbCBubyBjb21wbGFpbnQgaWYgdGhpcyBwYXRjaA0KZ2V0cyBkcm9w
cGVkLiANCg0KU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KQ2xhcmsNCi0tLS0tQkVHSU4gUEdQIFNJ
R05BVFVSRS0tLS0tDQpWZXJzaW9uOiBHbnVQRyB2Mi4wLjkgKEdOVS9MaW51eCkNCg0KaUVZRUFS
RUNBQVlGQWtuS1Mwc0FDZ2tRSHl1ai8rVFRFcDArbUFDZUpqcDkxU2hjY0NpaUt2NWVwdzV1UHIr
WQ0KZmJVQW9PRHNVOEZMT1JOcVZCREplUFQ1ODFiQlhLNmwNCj1NazViDQotLS0tLUVORCBQR1Ag
U0lHTkFUVVJFLS0tLS0NCg==
