From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v7 1/3] serial: imx: set_termios(): do not enable autoRTS if
 RTS is unset
Date: Fri, 26 Jul 2019 21:52:39 +0300
Message-ID: <1564167161-3972-2-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1564167161-3972-1-git-send-email-sorganov@gmail.com>
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

RG9uJ3QgbGV0IHJlY2VpdmVyIGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkgY29udHJvbCBSVFMgb3V0
cHV0IGlmIGl0CndhcyByZXF1ZXN0ZWQgdG8gYmUgaW5hY3RpdmUuCgpUbyBlbnN1cmUgdGhpcywg
c2V0X3Rlcm1pb3MoKSBzaG91bGRuJ3Qgc2V0IFVDUjJfQ1RTQyBiaXQgaWYgVUNSMl9DVFMKKD1U
SU9DTV9SVFMpIGlzIGNsZWFyZWQuIEFkZGVkIGNvcnJlc3BvbmRpbmcgY2hlY2sgaW4gaW14X3Vh
cnRfcnRzX2F1dG8oKQp0byBmaXggdGhpcy4KCkFja2VkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpSZXZpZXdlZC1ieTogU2FzY2hhIEhhdWVy
IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpUZXN0ZWQtYnk6IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT4KU2lnbmVkLW9mZi1ieTogU2VyZ2V5IE9yZ2Fub3YgPHNvcmdhbm92
QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCA3ICsrKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5k
ZXggNTdkNmU2Yi4uMzJmMzZkOCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5j
CisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtNDA1LDcgKzQwNSwxMiBAQCBzdGF0
aWMgdm9pZCBpbXhfdWFydF9ydHNfaW5hY3RpdmUoc3RydWN0IGlteF9wb3J0ICpzcG9ydCwgdTMy
ICp1Y3IyKQogLyogY2FsbGVkIHdpdGggcG9ydC5sb2NrIHRha2VuIGFuZCBpcnFzIGNhbGxlciBk
ZXBlbmRlbnQgKi8KIHN0YXRpYyB2b2lkIGlteF91YXJ0X3J0c19hdXRvKHN0cnVjdCBpbXhfcG9y
dCAqc3BvcnQsIHUzMiAqdWNyMikKIHsKLQkqdWNyMiB8PSBVQ1IyX0NUU0M7CisJLyoKKwkgKiBP
bmx5IGxldCByZWNlaXZlciBjb250cm9sIFJUUyBvdXRwdXQgaWYgd2Ugd2VyZSBub3QgcmVxdWVz
dGVkIHRvIGhhdmUKKwkgKiBSVFMgaW5hY3RpdmUgKHdoaWNoIHRoZW4gc2hvdWxkIHRha2UgcHJl
Y2VkZW5jZSkuCisJICovCisJaWYgKCp1Y3IyICYgVUNSMl9DVFMpCisJCSp1Y3IyIHw9IFVDUjJf
Q1RTQzsKIH0KIAogLyogY2FsbGVkIHdpdGggcG9ydC5sb2NrIHRha2VuIGFuZCBpcnFzIG9mZiAq
LwotLSAKMi4xMC4wLjEuZzU3YjAxYTMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
