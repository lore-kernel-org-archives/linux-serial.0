From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/5] serial: clps711x: fail if mctrl_gpio_init fails
Date: Thu, 12 Feb 2015 15:24:39 +0100
Message-ID: <1423751082-15888-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1423751082-15888-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-serial@vger.kernel.org

bWN0cmxfZ3Bpb19pbml0IGlzIGZ1bGx5IGF3YXJlIG9mIGJlaW5nIG9wdGlvbmFsLiBJZiBpdCBy
ZXR1cm5zIGFuIGVycm9yCmNvZGUgdGhpcyBpbmRpY2F0ZXMgYSByZWFsIGVycm9yIHRoYXQgbXVz
dCBub3QgYmUgaWdub3JlZC4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2NscHM3
MTF4LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsL2NscHM3MTF4LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvY2xw
czcxMXguYwppbmRleCA2ZTExYzI3NWYyYWIuLmQ1ZDJkZDdjNzkxNyAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL2NscHM3MTF4LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2NscHM3
MTF4LmMKQEAgLTUwMSw2ICs1MDEsOCBAQCBzdGF0aWMgaW50IHVhcnRfY2xwczcxMXhfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBzKTsKIAogCXMtPmdwaW9zID0gbWN0cmxfZ3Bpb19pbml0KCZwZGV2LT5kZXYsIDApOworCWlm
IChJU19FUlIocy0+Z3Bpb3MpKQorCSAgICByZXR1cm4gUFRSX0VSUihzLT5ncGlvcyk7CiAKIAly
ZXQgPSB1YXJ0X2FkZF9vbmVfcG9ydCgmY2xwczcxMXhfdWFydCwgJnMtPnBvcnQpOwogCWlmIChy
ZXQpCi0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
