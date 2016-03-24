From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 1/6] serial: imx: fix polarity of RI
Date: Thu, 24 Mar 2016 14:24:20 +0100
Message-ID: <1458825865-7434-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

V2hlbiBpbiBEVEUgbW9kZSwgdGhlIGJpdCBVU1IyX1JJSU4gaXMgYWN0aXZlIGxvdy4gU28gaW52
ZXJ0IHRoZSBsb2dpYwphY2NvcmRpbmdseS4KCkZpeGVzOiA5MGViYzQ4Mzg2NjYgKCJzZXJpYWw6
IGlteDogcmVwYWlyIGFuZCBjb21wbGV0ZSBoYW5kc2hha2luZyIpClNpZ25lZC1vZmYtYnk6IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDIzMWU3ZDVjYWY2Yy4uYmZj
NDU1NWM2M2QxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC03OTcsOSArNzk3LDkgQEAgc3RhdGljIHVuc2lnbmVk
IGludCBpbXhfZ2V0X2h3bWN0cmwoc3RydWN0IGlteF9wb3J0ICpzcG9ydCkKIAlpZiAoISh1c3Ix
ICYgVVNSMl9EQ0RJTikpCiAJCXRtcCB8PSBUSU9DTV9DQVI7CiAKLQkvKiBpbiBEQ0UgbW9kZSBS
SUlOIGlzIGFsd2F5cyAwICovCi0JaWYgKHJlYWRsKHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVU1Iy
KSAmIFVTUjJfUklJTikKLQkJdG1wIHw9IFRJT0NNX1JJOworCWlmIChzcG9ydC0+ZHRlX21vZGUp
CisJCWlmICghKHJlYWRsKHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVU1IyKSAmIFVTUjJfUklJTikp
CisJCQl0bXAgfD0gVElPQ01fUkk7CiAKIAlyZXR1cm4gdG1wOwogfQotLSAKMi43LjAKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
