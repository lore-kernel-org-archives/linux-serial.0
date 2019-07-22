From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v5 2/3] serial: imx: set_mctrl(): correctly restore autoRTS
 state
Date: Mon, 22 Jul 2019 12:22:09 +0300
Message-ID: <1563787330-1394-3-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563787330-1394-1-git-send-email-sorganov@gmail.com>
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

aW14X3VhcnRfc2V0X21jdHJsKCkgaGFwcGVuZWQgdG8gc2V0IFVDUjJfQ1RTQyBiaXQgd2hlbmV2
ZXIgVElPQ01fUlRTCndhcyBzZXQsIG5vIG1hdHRlciBpZiBSVFMvQ1RTIGhhbmRzaGFrZSBpcyBl
bmFibGVkIG9yIG5vdC4gTm93IGZpeGVkIGJ5CnR1cm5pbmcgaGFuZHNoYWtlIG9uIG9ubHkgd2hl
biBDUlRTQ1RTIGJpdCBmb3IgdGhlIHBvcnQgaXMgc2V0LgoKUmV2aWV3ZWQtYnk6IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+ClJldmlld2VkLWJ5OiBT
YXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+ClRlc3RlZC1ieTogU2FzY2hhIEhh
dWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBTZXJnZXkgT3JnYW5v
diA8c29yZ2Fub3ZAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDE2
ICsrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9pbXguYwppbmRleCAzMmYzNmQ4Li4wNTliYTM1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBA
IC05NzQsMTAgKzk3NCwyMiBAQCBzdGF0aWMgdm9pZCBpbXhfdWFydF9zZXRfbWN0cmwoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IG1jdHJsKQogCWlmICghKHBvcnQtPnJzNDg1
LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKSB7CiAJCXUzMiB1Y3IyOwogCisJCS8qCisJCSAq
IFR1cm4gb2ZmIGF1dG9SVFMgaWYgUlRTIGlzIGxvd2VyZWQgYW5kIHJlc3RvcmUgYXV0b1JUUwor
CQkgKiBzZXR0aW5nIGlmIFJUUyBpcyByYWlzZWQuCisJCSAqLwogCQl1Y3IyID0gaW14X3VhcnRf
cmVhZGwoc3BvcnQsIFVDUjIpOwogCQl1Y3IyICY9IH4oVUNSMl9DVFMgfCBVQ1IyX0NUU0MpOwot
CQlpZiAobWN0cmwgJiBUSU9DTV9SVFMpCi0JCQl1Y3IyIHw9IFVDUjJfQ1RTIHwgVUNSMl9DVFND
OworCQlpZiAobWN0cmwgJiBUSU9DTV9SVFMpIHsKKwkJCXVjcjIgfD0gVUNSMl9DVFM7CisJCQkv
KgorCQkJICogVUNSMl9JUlRTIGlzIHVuc2V0IGlmIGFuZCBvbmx5IGlmIHRoZSBwb3J0IGlzCisJ
CQkgKiBjb25maWd1cmVkIGZvciBDUlRTQ1RTLCBzbyB3ZSB1c2UgaW52ZXJ0ZWQgVUNSMl9JUlRT
CisJCQkgKiB0byBnZXQgdGhlIHN0YXRlIHRvIHJlc3RvcmUgdG8uCisJCQkgKi8KKwkJCWlmICgh
KHVjcjIgJiBVQ1IyX0lSVFMpKQorCQkJCXVjcjIgfD0gVUNSMl9DVFNDOworCQl9CiAJCWlteF91
YXJ0X3dyaXRlbChzcG9ydCwgdWNyMiwgVUNSMik7CiAJfQogCi0tIAoyLjEwLjAuMS5nNTdiMDFh
MwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
