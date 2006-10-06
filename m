From: Jean-Baptiste Maneyrol <MANE@teamlog.com>
Subject: [PATCH] serial 8250.c: size_fifo tries to read write-only FCR register
Date: Fri, 6 Oct 2006 10:09:46 +0200
Message-ID: <156407352996cb4f8152a987a01b2dde@62.160.172.64>
Reply-To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="b1_156407352996cb4f8152a987a01b2dde"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-paris1.teamlog.com ([213.41.116.90]:59107 "EHLO
	au-ml2.teamlog.fr") by vger.kernel.org with ESMTP id S1751044AbWJFIGE
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 04:06:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk


--b1_156407352996cb4f8152a987a01b2dde
Content-Type: text/plain;
	charset="iso-8859-15"Content-Transfer-Encoding: 8bit

The function size_fifo wants to backup the FCR register by reading it, but
it is a write-only register. A read to this adress returns the IIR register.
The size_fifo function is only used during autoconfig, and after autoconfig
the FIFO are cleared and deactivated, so we don't need to save FCR.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>

________________________________________________
Message sent using UebiMiau 2.7.9

--b1_156407352996cb4f8152a987a01b2dde
Content-Type: text/x-patch; name="serial8250-size_fifo-bug.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="serial8250-size_fifo-bug.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuMThfYnVncy9kcml2ZXJzL3NlcmlhbC84MjUwLmMgbGludXgt
Mi42LjE4X2ZpeGVzL2RyaXZlcnMvc2VyaWFsLzgyNTAuYwotLS0gbGludXgtMi42LjE4X2J1Z3Mv
ZHJpdmVycy9zZXJpYWwvODI1MC5jCTIwMDYtMTAtMDYgMDk6NDU6MjYuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMThfZml4ZXMvZHJpdmVycy9zZXJpYWwvODI1MC5jCTIwMDYtMTAtMDYg
MDk6MzA6MTQuMDAwMDAwMDAwICswMjAwCkBAIC01MzksMTMgKzUzOSwxMiBAQAogICovCiBzdGF0
aWMgaW50IHNpemVfZmlmbyhzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnVwKQogewotCXVuc2lnbmVk
IGNoYXIgb2xkX2Zjciwgb2xkX21jciwgb2xkX2xjcjsKKwl1bnNpZ25lZCBjaGFyIG9sZF9tY3Is
IG9sZF9sY3I7CiAJdW5zaWduZWQgc2hvcnQgb2xkX2RsOwogCWludCBjb3VudDsKIAogCW9sZF9s
Y3IgPSBzZXJpYWxfaW5wKHVwLCBVQVJUX0xDUik7CiAJc2VyaWFsX291dHAodXAsIFVBUlRfTENS
LCAwKTsKLQlvbGRfZmNyID0gc2VyaWFsX2lucCh1cCwgVUFSVF9GQ1IpOwogCW9sZF9tY3IgPSBz
ZXJpYWxfaW5wKHVwLCBVQVJUX01DUik7CiAJc2VyaWFsX291dHAodXAsIFVBUlRfRkNSLCBVQVJU
X0ZDUl9FTkFCTEVfRklGTyB8CiAJCSAgICBVQVJUX0ZDUl9DTEVBUl9SQ1ZSIHwgVUFSVF9GQ1Jf
Q0xFQVJfWE1JVCk7CkBAIC01NjAsNyArNTU5LDYgQEAKIAlmb3IgKGNvdW50ID0gMDsgKHNlcmlh
bF9pbnAodXAsIFVBUlRfTFNSKSAmIFVBUlRfTFNSX0RSKSAmJgogCSAgICAgKGNvdW50IDwgMjU2
KTsgY291bnQrKykKIAkJc2VyaWFsX2lucCh1cCwgVUFSVF9SWCk7Ci0Jc2VyaWFsX291dHAodXAs
IFVBUlRfRkNSLCBvbGRfZmNyKTsKIAlzZXJpYWxfb3V0cCh1cCwgVUFSVF9NQ1IsIG9sZF9tY3Ip
OwogCXNlcmlhbF9vdXRwKHVwLCBVQVJUX0xDUiwgVUFSVF9MQ1JfRExBQik7CiAJc2VyaWFsX2Rs
X3dyaXRlKHVwLCBvbGRfZGwpOwo=


--b1_156407352996cb4f8152a987a01b2dde--


