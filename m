From: Steve Tell <tell@telltronics.org>
Subject: 2.4.21 patch to support LavaPort-Quad card
Date: Mon, 21 Jul 2003 00:01:22 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.21.0307202354520.21823-200000@ariel.lan.telltronics.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1871339509-1058760082=:21823"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dsl093-240-080.ral1.dsl.speakeasy.net ([66.93.240.80]:4854 "EHLO
	telltronics.org") by vger.kernel.org with ESMTP id S269216AbTGUDqY
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jul 2003 23:46:24 -0400
Received: from localhost (tell@localhost)
	by telltronics.org (8.11.6/8.9.3) with ESMTP id h6L41ON22740
	for <linux-serial@vger.kernel.org>; Mon, 21 Jul 2003 00:01:24 -0400
List-Id: linux-serial@vger.kernel.org
To: Linux serial mailing list <linux-serial@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811584-1871339509-1058760082=:21823
Content-Type: TEXT/PLAIN; charset=US-ASCII


This patch against 2.4.21 adds support for the "LavaPort Quad" PCI serial
card, which contains a 16C654 and a lava-branded pci interface chip.
The board is labeled only "P/N MOKO L75.2"
It shows up as PCI vendor ID=0x1407, with two devices 0x0220 and 0x0221,
and can run up to 460.8Kbps.

It also fixes a compilation problem due to a wrong or changed structure
field that shows up if SERIAL_DEBUG_PCI (that fix is untested, however).










--
Steve Tell  tell@telltronics.org 

---1463811584-1871339509-1058760082=:21823
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lavaport.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0307210001220.21823@ariel.lan.telltronics.org>
Content-Description: 2.4.21 patch for lavaport quad PCI serial card
Content-Disposition: attachment; filename="lavaport.patch"

LS0tIGxpbnV4LTIuNC4yMS1vcmlnL2luY2x1ZGUvbGludXgvcGNpX2lkcy5o
CTIwMDMtMDYtMTMgMTA6NTE6MzkuMDAwMDAwMDAwIC0wNDAwDQorKysgbGlu
dXgtMi40LjIxL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCTIwMDMtMDctMjAg
MjM6MDA6MDUuMDAwMDAwMDAwIC0wNDAwDQpAQCAtMTU0MSw2ICsxNTQxLDgg
QEANCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTEFWQV9QT1JUX1BMVVMJMHgw
MjAwIC8qIDJ4IDE2NjUwICovDQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0xB
VkFfUVVBRF9BCTB4MDIwMSAvKiAyeCAxNjY1MCwgaGFsZiBvZiA0IHBvcnQg
Ki8NCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTEFWQV9RVUFEX0IJMHgwMjAy
IC8qIDJ4IDE2NjUwLCBoYWxmIG9mIDQgcG9ydCAqLw0KKyNkZWZpbmUgUENJ
X0RFVklDRV9JRF9MQVZBX1BPUlRfUVVBRF9BCTB4MDIyMCAvKiAyeCAxNjY1
MCwgaGFsZiBvZiA0IHBvcnQgKi8NCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURf
TEFWQV9QT1JUX1FVQURfQgkweDAyMjEgLyogMnggMTY2NTAsIGhhbGYgb2Yg
NCBwb3J0ICovDQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0xBVkFfU1NFUklB
TAkweDA1MDAgLyogMXggMTY1NTAgKi8NCiAjZGVmaW5lIFBDSV9ERVZJQ0Vf
SURfTEFWQV9QT1JUXzY1MAkweDA2MDAgLyogMXggMTY2NTAgKi8NCiAjZGVm
aW5lIFBDSV9ERVZJQ0VfSURfTEFWQV9QQVJBTExFTAkweDgwMDANCi0tLSBs
aW51eC0yLjQuMjEtb3JpZy9kcml2ZXJzL2NoYXIvc2VyaWFsLmMJMjAwMy0w
Ni0xMyAxMDo1MTozMy4wMDAwMDAwMDAgLTA0MDANCisrKyBsaW51eC0yLjQu
MjEvZHJpdmVycy9jaGFyL3NlcmlhbC5jCTIwMDMtMDctMjAgMjM6Mzg6NDQu
MDAwMDAwMDAwIC0wNDAwDQpAQCAtNDE4Niw3ICs0MTg2LDcgQEANCiAgICAN
CiAjaWZkZWYgU0VSSUFMX0RFQlVHX1BDSQ0KIAlwcmludGsoS0VSTl9ERUJV
RyAiIFN1YnN5c3RlbSBJRCAlbHggKGludGVsIDk2MClcbiIsDQotCSAgICAg
ICAodW5zaWduZWQgbG9uZykgYm9hcmQtPnN1YmRldmljZSk7DQorCSh1bnNp
Z25lZCBsb25nKSBwY2lfZ2V0X3N1YmRldmljZShkZXYpKTsNCiAjZW5kaWYN
CiAJLyogaXMgZmlybXdhcmUgc3RhcnRlZD8gKi8NCiAJcGNpX3JlYWRfY29u
ZmlnX2R3b3JkKGRldiwgMHg0NCwgKHZvaWQqKSAmb2xkdmFsKTsgDQpAQCAt
NDg1OSw2ICs0ODU5LDEyIEBADQogCXsJUENJX1ZFTkRPUl9JRF9MQVZBLCBQ
Q0lfREVWSUNFX0lEX0xBVkFfUVVBRF9CLA0KIAkJUENJX0FOWV9JRCwgUENJ
X0FOWV9JRCwgMCwgMCwNCiAJCXBibl9iMF9idF8yXzQ2MDgwMCB9LA0KKwl7
CVBDSV9WRU5ET1JfSURfTEFWQSwgUENJX0RFVklDRV9JRF9MQVZBX1BPUlRf
UVVBRF9BLA0KKwkJUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwNCisJ
CXBibl9iMF9idF8yXzQ2MDgwMCB9LA0KKwl7CVBDSV9WRU5ET1JfSURfTEFW
QSwgUENJX0RFVklDRV9JRF9MQVZBX1BPUlRfUVVBRF9CLA0KKwkJUENJX0FO
WV9JRCwgUENJX0FOWV9JRCwgMCwgMCwNCisJCXBibl9iMF9idF8yXzQ2MDgw
MCB9LA0KIAl7CVBDSV9WRU5ET1JfSURfTEFWQSwgUENJX0RFVklDRV9JRF9M
QVZBX1NTRVJJQUwsDQogCQlQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAw
LA0KIAkJcGJuX2IwX2J0XzFfMTE1MjAwIH0sDQo=
---1463811584-1871339509-1058760082=:21823--
