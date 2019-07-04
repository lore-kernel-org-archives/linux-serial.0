From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 2/7] serial: imx: set_termios(): factor-out 'ucr2' initial
 value
Date: Thu,  4 Jul 2019 16:00:24 +0300
Message-ID: <1562245229-709-3-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1562245229-709-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1562245229-709-1-git-send-email-sorganov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

U2V0IGNvbW1vbiBiaXRzIGluIGEgc2VwYXJhdGUgc3RhdGVtZW50IHRvIG1ha2UgaW5pdGlhbGl6
YXRpb24KZXhwbGljaXQgYW5kIG5vdCByZXBlYXQgdGhlIGNvbW1vbiBwYXJ0LgoKUmV2aWV3ZWQt
Ynk6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KVGVzdGVkLWJ5OiBTYXNj
aGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+ClV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CgpTaWduZWQtb2ZmLWJ5OiBTZXJnZXkgT3JnYW5v
diA8c29yZ2Fub3ZAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDUg
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jCmluZGV4IDEwNTUxMjQuLjg3ODAyZmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTE1NjMsMTAgKzE1
NjMsOSBAQCBpbXhfdWFydF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1
Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsCiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmc3BvcnQtPnBvcnQu
bG9jaywgZmxhZ3MpOwogCisJdWNyMiA9IFVDUjJfU1JTVCB8IFVDUjJfSVJUUzsKIAlpZiAoKHRl
cm1pb3MtPmNfY2ZsYWcgJiBDU0laRSkgPT0gQ1M4KQotCQl1Y3IyID0gVUNSMl9XUyB8IFVDUjJf
U1JTVCB8IFVDUjJfSVJUUzsKLQllbHNlCi0JCXVjcjIgPSBVQ1IyX1NSU1QgfCBVQ1IyX0lSVFM7
CisJCXVjcjIgfD0gVUNSMl9XUzsKIAogCWlmICh0ZXJtaW9zLT5jX2NmbGFnICYgQ1JUU0NUUykg
ewogCQlpZiAoc3BvcnQtPmhhdmVfcnRzY3RzKSB7Ci0tIAoyLjEwLjAuMS5nNTdiMDFhMwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
