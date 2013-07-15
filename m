From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH] serial: bfin_uart: Remove redundant testing for ifdef
 CONFIG_SERIAL_BFIN_MODULE
Date: Mon, 15 Jul 2013 08:00:03 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE31BB1F67@NWD2MBX7.ad.analog.com>
References: <1373866563.24773.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:10781
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754285Ab3GOIBb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Jul 2013 04:01:31 -0400
In-Reply-To: <1373866563.24773.1.camel@phoenix>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

QWNrZWQtYnk6IFNvbmljIFpoYW5nPHNvbmljLnpoYW5nQGFuYWxvZy5jb20+DQoNCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQXhlbCBMaW4gW21haWx0bzpheGVsLmxpbkBp
bmdpY3MuY29tXQ0KPlNlbnQ6IE1vbmRheSwgSnVseSAxNSwgMjAxMyAxOjM2IFBNDQo+VG86IEpp
cmkgU2xhYnk7IEdyZWcgS3JvYWgtSGFydG1hbg0KPkNjOiBaaGFuZywgU29uaWM7IHVjbGludXgt
ZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4Lm9yZzsgbGludXgtDQo+c2VyaWFsQHZnZXIua2Vy
bmVsLm9yZw0KPlN1YmplY3Q6IFtQQVRDSF0gc2VyaWFsOiBiZmluX3VhcnQ6IFJlbW92ZSByZWR1
bmRhbnQgdGVzdGluZyBmb3IgaWZkZWYNCj5DT05GSUdfU0VSSUFMX0JGSU5fTU9EVUxFDQo+DQo+
Tm8gaWRlYSB3aHkgd2UgaGF2ZSByZWR1bmRhbnQgdGVzdGluZyBmb3IgaWZkZWYNCj5DT05GSUdf
U0VSSUFMX0JGSU5fTU9EVUxFLCBjaGVjayBpdCBvbmNlIGlzIGVub3VnaC4NCj4NCj5TaWduZWQt
b2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4NCj4tLS0NCj4gZHJpdmVycy90
dHkvc2VyaWFsL2JmaW5fdWFydC5jIHwgNCAtLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0
aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYmZpbl91YXJ0LmMg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvYmZpbl91YXJ0LmMgaW5kZXgNCj4yNmEzYmU3Li43MjAzMWQ3
IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9iZmluX3VhcnQuYw0KPisrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9iZmluX3VhcnQuYw0KPkBAIC00MSwxMCArNDEsNiBAQA0KPiAjIHVu
ZGVmIENPTkZJR19FQVJMWV9QUklOVEsNCj4gI2VuZGlmDQo+DQo+LSNpZmRlZiBDT05GSUdfU0VS
SUFMX0JGSU5fTU9EVUxFDQo+LSMgdW5kZWYgQ09ORklHX0VBUkxZX1BSSU5USw0KPi0jZW5kaWYN
Cj4tDQo+IC8qIFVBUlQgbmFtZSBhbmQgZGV2aWNlIGRlZmluaXRpb25zICovDQo+ICNkZWZpbmUg
QkZJTl9TRVJJQUxfREVWX05BTUUgICJ0dHlCRiINCj4gI2RlZmluZSBCRklOX1NFUklBTF9NQUpP
UiAgICAgMjA0DQo+LS0NCj4xLjguMS4yDQo+DQo+DQo+DQoNCg==

