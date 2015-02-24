From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/7] serial: imx: remove long dead code
Date: Tue, 24 Feb 2015 11:17:06 +0100
Message-ID: <1424773031-19692-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?aur=C3=A9lien=20bouin?= <a.bouin@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

VGhpcyBpZiAoMCkgZXhpc3RzIHNpbmNlIHRoZSBkcml2ZXIgd2FzIGludHJvZHVjZWQgaW4gY29t
bWl0CmM0OWJkZTgzZWI2YSAoW0FSTSBQQVRDSF0gMTk1Ni8yOiBSZTogTW90b3JvbGEgaS5NWCBz
ZXJpYWwgZHJpdmVyKQpiYWNrIGluIDIwMDQuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYyB8IDkgLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvaW14LmMKaW5kZXggMjMwNjE5MThiMGU0Li5mYTFmYjNiNDZlZDggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAg
LTEzNzMsMTUgKzEzNzMsNiBAQCBpbXhfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLAogCXVpbnQ2NF90IHRkaXY2NDsKIAogCS8qCi0J
ICogSWYgd2UgZG9uJ3Qgc3VwcG9ydCBtb2RlbSBjb250cm9sIGxpbmVzLCBkb24ndCBhbGxvdwot
CSAqIHRoZXNlIHRvIGJlIHNldC4KLQkgKi8KLQlpZiAoMCkgewotCQl0ZXJtaW9zLT5jX2NmbGFn
ICY9IH4oSFVQQ0wgfCBDUlRTQ1RTIHwgQ01TUEFSKTsKLQkJdGVybWlvcy0+Y19jZmxhZyB8PSBD
TE9DQUw7Ci0JfQotCi0JLyoKIAkgKiBXZSBvbmx5IHN1cHBvcnQgQ1M3IGFuZCBDUzguCiAJICov
CiAJd2hpbGUgKCh0ZXJtaW9zLT5jX2NmbGFnICYgQ1NJWkUpICE9IENTNyAmJgotLSAKMi4xLjQK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
