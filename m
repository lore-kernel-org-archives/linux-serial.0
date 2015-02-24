From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/7] serial: imx: a fix, cleanups and rs485 support
Date: Tue, 24 Feb 2015 11:17:04 +0100
Message-ID: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: =?UTF-8?q?aur=C3=A9lien=20bouin?= <a.bouin@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

SGVsbG8sCgp0aGlzIGlzIGEgcmViYXNlZCBzZXJpZXMgZm9yIHRoZSBpbXggc2VyaWFsIGRyaXZl
ci4gSSBhbHJlYWR5IHNlbnQgaXQKb3V0IGEgd2VlayBhZ28gYmFzaW5nIG9uIDMuMTksIGJ1dCBp
dCBkb2Vzbid0IGFwcGx5IHRvIDQuMC1yYzEsIHNvIEkgZGlkCnRoZSBub24tdHJpdmlhbCByZWJh
c2luZyBhbmQgcmVzZW5kIG5vdy4KCkkgYWxzbyByZW9yZGVyZWQgdGhlIHBhdGNoZXMgdG8gaGF2
ZSB0aGUgZml4IGZpcnN0LiBJTUhPIHRoaXMgY2FuIGdvIGluCmJlZm9yZSA0LjAsIHRoZSBvdGhl
ciA2IHBhdGNoZXMgYXJlIG1lcmdlIHdpbmRvdyBtYXRlcmlhbC4KCkJlc3QgcmVnYXJkcwpVd2UK
ClV3ZSBLbGVpbmUtS8O2bmlnICg3KToKICBzZXJpYWw6IGlteDogRml4IGNsZWFyaW5nIG9mIHJl
Y2VpdmVyIG92ZXJydW4gZmxhZwogIHNlcmlhbDogaW14OiByZW1vdmUgbG9uZyBkZWFkIGNvZGUK
ICBzZXJpYWw6IGlteDogZHJvcCBtZW1iZXJzIGZyb20gZHJpdmVyIGRhdGEgdGhhdCBhcmUgb25s
eSB1c2VkIGR1cmluZwogICAgcHJvYmUKICBzZXJpYWw6IGlteDogcmVmb3JtYXQgYW5kIGNsZWFu
dXAgY29weXJpZ2h0IGhlYWRlcgogIHNlcmlhbDogaW14OiBmaXggY29tbWVudCBhYm91dCB3aGlj
aCBtYWNoaW5lcyB1c2UgdGhlIGkuTVgyMSB0eXBlCiAgc2VyaWFsOiBpbXg6IGRyb3Agc3VwcG9y
dCBmb3IgSVJEQQogIHNlcmlhbDogaW14OiBhZGQgc3VwcG9ydCBmb3IgaGFsZiBkdXBsZXggcnM0
ODUKCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICAgICAgICAgIHwgMzExICsrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9z
ZXJpYWwtaW14LmggfCAgIDUgLQogMiBmaWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKSwg
MTk3IGRlbGV0aW9ucygtKQoKLS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
