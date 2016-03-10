From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/4] serial: imx: some irq and handshaking fixes
Date: Thu, 10 Mar 2016 11:26:05 +0100
Message-ID: <1457605569-7828-1-git-send-email-u.kleine-koenig@pengutronix.de>
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

SGVsbG8sCgp0aGlzIHNlcmllcyBkb2Vzbid0IHNvbHZlIGFsbCBteSBwcm9ibGVtcyBidXQgYXQg
bGVhc3Qgc29tZS4gTm93IGZvciBteQpyZW1haW5pbmcgcHJvYmxlbSBteSBtYWNoaW5lIGF0IGxl
YXN0IGRvZXNuJ3QgcmVzZXQgKGJ5IHdhdGNoZG9nKSBidXQKZGlzYWJsZXMgdGhlIHNlcmlhbCBp
cnEgaW5zdGVhZCB3aGljaCBhdCBsZWFzdCBhbGxvd3MgdG8gZGVidWcgZnVydGhlci4KKFN0aWxs
IEknbSBhIGJpdCBvdXQgb2YgaWRlYXMuKQoKVGhlIGxhc3QgcGF0Y2ggZG9lc24ndCBmaXggYSBy
ZWFsIHByb2JsZW0gSSBoYXZlLCBqdXN0IG5vdGljZWQgdGhhdAp3aGlsZSB3b3JraW5nIG9uIHRo
ZSBoYW5kc2hha2luZyBzdHVmZi4KCkl0IHdvdWxkIGJlIGdyZWF0IGlmIHRoZXNlIHBhdGNoZWQg
bWFkZSBpdCBpbnRvIHY0LjYtcmMxLgoKQmVzdCByZWdhcmRzClV3ZQoKVXdlIEtsZWluZS1Lw7Zu
aWcgKDQpOgogIHNlcmlhbDogaW14OiByZW9yZGVyIGZ1bmN0aW9ucyB0byBzaW1wbGlmeSBuZXh0
IHBhdGNoCiAgc2VyaWFsOiBpbXg6IGltcGxlbWVudCBoYW5kc2hha2luZyBpcnEgaGFuZGxpbmcg
Zm9yIERURSBtb2RlCiAgc2VyaWFsOiBpbXg6IGxldCBpcnEgaGFuZGxlciByZXR1cm4gSVJRX05P
TkUgaWYgbm8gZXZlbnQgd2FzIGhhbmRsZWQKICBzZXJpYWw6IGlteDogb25seSBjb3VudCAwLT4x
IHRyYW5zaXRpb25zIGZvciBSTkcKCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAxNTIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA5NSBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkKCi0tIAoyLjcuMAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
