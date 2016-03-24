From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Date: Thu, 24 Mar 2016 14:24:19 +0100
Message-ID: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

SGVsbG8sCgp0aGlzIGlzIHRoZSByZXdvcmtlZCBzZXJpZXMgdG8gYWRkcmVzcyB0aGUgaGFuZHNo
YWtpbmcgcHJvYmxlbXMgSSBzYXcuCgpBbW9uZyBvdGhlcnMgaXQgbWFkZSBteSBpLk1YMjUgc3R1
Y2sgd2hlbiB0aGUgb3RoZXIgc2lkZSB0b2dnbGVzIERDRC4KVGhlIGZpcnN0IDQgcGF0Y2hlcyBh
cmUgZml4ZXMgdGhhdCBJJ2QgbGlrZSB0byBzZWUgaW4gNC42LXJjWCwgdGhlIGxhc3QgdHdvCnBh
dGNoZXMgYXJlIG1lcmdlIHdpbmRvdyBtYXRlcmlhbC4KCkJlc3QgcmVnYXJkcwpVd2UKClV3ZSBL
bGVpbmUtS8O2bmlnICg2KToKICBzZXJpYWw6IGlteDogZml4IHBvbGFyaXR5IG9mIFJJCiAgc2Vy
aWFsOiBpbXg6IGxldCBpcnEgaGFuZGxlciByZXR1cm4gSVJRX05PTkUgaWYgbm8gZXZlbnQgd2Fz
IGhhbmRsZWQKICBzZXJpYWw6IGlteDogbWFrZSBzdXJlIHVuaGFuZGxlZCBpcnFzIGFyZSBkaXNh
YmxlZAogIHNlcmlhbDogaW14OiBvbmx5IGNvdW50IDAtPjEgdHJhbnNpdGlvbnMgZm9yIFJORwog
IHNlcmlhbDogaW14OiByZW9yZGVyIGZ1bmN0aW9ucyB0byBzaW1wbGlmeSBuZXh0IHBhdGNoCiAg
c2VyaWFsOiBpbXg6IGltcGxlbWVudCBEU1IgaXJxIGhhbmRsaW5nIGZvciBEVEUgbW9kZQoKIGRy
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDE1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA1
NiBkZWxldGlvbnMoLSkKCi0tIAoyLjcuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
