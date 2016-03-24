From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 4/6] serial: imx: only count 0->1 transitions for RNG
Date: Thu, 24 Mar 2016 14:24:23 +0100
Message-ID: <1458825865-7434-5-git-send-email-u.kleine-koenig@pengutronix.de>
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

QWNjb3JkaW5nIHRvIHR0eV9pb2N0bCg0KSAoZnJvbSBtYW4tcGFnZXMgNC4wNCkgdGhlIHJuZyBt
ZW1iZXIgb25seQpjb3VudHMgMC0+MSB0cmFuc2l0aW9ucy4gRm9yIHRoZSBvdGhlciBzaWduYWxz
IChEU1IsIENELCBDVFMpIGJvdGggZWRnZXMKYXJlIHN1cHBvc2VkIHRvIGJlIGNvdW50ZWQuCgpT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJv
bml4LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwppbmRleCBmY2Q0OGZk
NzhiZjUuLjFiZjdiODZhY2Y2NiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5j
CisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtODg0LDcgKzg4NCw3IEBAIHN0YXRp
YyB2b2lkIGlteF9tY3RybF9jaGVjayhzdHJ1Y3QgaW14X3BvcnQgKnNwb3J0KQogCiAJc3BvcnQt
Pm9sZF9zdGF0dXMgPSBzdGF0dXM7CiAKLQlpZiAoY2hhbmdlZCAmIFRJT0NNX1JJKQorCWlmIChj
aGFuZ2VkICYgVElPQ01fUkkgJiYgc3RhdHVzICYgVElPQ01fUkkpCiAJCXNwb3J0LT5wb3J0Lmlj
b3VudC5ybmcrKzsKIAlpZiAoY2hhbmdlZCAmIFRJT0NNX0RTUikKIAkJc3BvcnQtPnBvcnQuaWNv
dW50LmRzcisrOwotLSAKMi43LjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
