From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] serial/uuc_uart: Support higher bitrates than 115200 Bit/s
Date: Thu,  9 Jul 2015 10:34:34 +0200
Message-ID: <1436430874-17385-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-serial@vger.kernel.org

VGhlIG1heGltdW0gYml0cmF0ZSBzdXBwb3J0ZWQgZGVwZW5kcyBvbiB0aGUgY2xvY2sgcmF0ZSB1
c2VkIGluIEJSRy4KVGhpcyBpcyBzdG9yZWQgaW4gcG9ydC51YXJ0Y2xrIGR1cmluZyBwcm9iZS4g
UmVzcGVjdGluZyB0aGUgMTZ4Cm92ZXJzYW1wbGluZyBoaWdoZXIgYml0cmF0ZXMgY2FuIGJlIHN1
cHBvcnRlZC4KClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWlu
QHN5c3RlYy1lbGVjdHJvbmljLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvdWNjX3VhcnQu
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC91Y2NfdWFydC5jIGIvZHJpdmVycy90dHkv
c2VyaWFsL3VjY191YXJ0LmMKaW5kZXggN2QyNTMyYi4uNzMxOTBmNSAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3VjY191YXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3VjY191
YXJ0LmMKQEAgLTk1MCw3ICs5NTAsNyBAQCBzdGF0aWMgdm9pZCBxZV91YXJ0X3NldF90ZXJtaW9z
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJaWYgKCh0ZXJtaW9zLT5jX2NmbGFnICYgQ1JFQUQp
ID09IDApCiAJCXBvcnQtPnJlYWRfc3RhdHVzX21hc2sgJj0gfkJEX1NDX0VNUFRZOwogCi0JYmF1
ZCA9IHVhcnRfZ2V0X2JhdWRfcmF0ZShwb3J0LCB0ZXJtaW9zLCBvbGQsIDAsIDExNTIwMCk7CisJ
YmF1ZCA9IHVhcnRfZ2V0X2JhdWRfcmF0ZShwb3J0LCB0ZXJtaW9zLCBvbGQsIDAsIHBvcnQtPnVh
cnRjbGsgLyAxNik7CiAKIAkvKiBEbyB3ZSByZWFsbHkgbmVlZCBhIHNwaW5sb2NrIGhlcmU/ICov
CiAJc3Bpbl9sb2NrX2lycXNhdmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsKLS0gCjIuMy42CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYg
bWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMu
b3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
