From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] serial: sa1100: add note about modem control signals
Date: Fri, 31 May 2019 17:01:42 +0100
Message-ID: <E1hWjyQ-0008Ni-8V@rmk-PC.armlinux.org.uk>
References: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531155700.crrawgf3iot2sm2t@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

QXMgc3VnZ2VzdGVkIGJ5IFV3ZSwgYWRkIGEgbm90ZSBpbmRpY2F0aW5nIHRoYXQgdGhlIG1vZGVt
IGNvbnRyb2wKc2lnbmFscyBkbyBub3Qgc3VwcG9ydCBpbnRlcnJ1cHRzLCB3aGljaCBwcmVjbHVk
ZXMgdGhlIGRyaXZlciBmcm9tCnVzaW5nIG1jdHJsX2dwaW9faW5pdCgpLgoKU3VnZ2VzdGVkLWJ5
OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPgotLS0K
IGRyaXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYwppbmRleCA5N2JkZmVjY2JlYTkuLjhlNjE4MTI5
ZTY1YyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NhMTEwMC5jCisrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9zYTExMDAuYwpAQCAtODYwLDYgKzg2MCwxMCBAQCBzdGF0aWMgaW50IHNh
MTEwMF9zZXJpYWxfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKIHN0YXRpYyBp
bnQgc2ExMTAwX3NlcmlhbF9hZGRfb25lX3BvcnQoc3RydWN0IHNhMTEwMF9wb3J0ICpzcG9ydCwg
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQogewogCXNwb3J0LT5wb3J0LmRldiA9ICZkZXYt
PmRldjsKKworCS8vIG1jdHJsX2dwaW9faW5pdCgpIHJlcXVpcmVzIHRoYXQgdGhlIEdQSU8gZHJp
dmVyIHN1cHBvcnRzIGludGVycnVwdHMsCisJLy8gYnV0IHdlIG5lZWQgdG8gc3VwcG9ydCBHUElP
IGRyaXZlcnMgZm9yIGhhcmR3YXJlIHRoYXQgaGFzIG5vIHN1Y2gKKwkvLyBpbnRlcnJ1cHRzLiAg
VXNlIG1jdHJsX2dwaW9faW5pdF9ub2F1dG8oKSBpbnN0ZWFkLgogCXNwb3J0LT5ncGlvcyA9IG1j
dHJsX2dwaW9faW5pdF9ub2F1dG8oc3BvcnQtPnBvcnQuZGV2LCAwKTsKIAlpZiAoSVNfRVJSKHNw
b3J0LT5ncGlvcykpIHsKIAkJaW50IGVyciA9IFBUUl9FUlIoc3BvcnQtPmdwaW9zKTsKLS0gCjIu
Ny40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
