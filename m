From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH RFC 5/7] serial: imx: set_termios(): preserve RTS state
Date: Fri, 14 Jun 2019 15:05:51 +0200
Message-ID: <20190614150551.1472b154@karo-electronics.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
 <1560514294-29111-6-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1560514294-29111-6-git-send-email-sorganov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-serial@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

SGksCgpPbiBGcmksIDE0IEp1biAyMDE5IDE1OjExOjMyICswMzAwIFNlcmdleSBPcmdhbm92IHdy
b3RlOgo+IGlteF9zZXRfdGVybWlvcygpIGNsZWFyZWQgUlRTIG9uIGV2ZXJ5IGNhbGwsIG5vdyBm
aXhlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTZXJnZXkgT3JnYW5vdiA8c29yZ2Fub3ZAZ21haWwu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAxMiArKysrKysrKy0tLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jCj4gaW5kZXggOGVlOTEwZi4uZGUyMzA2OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3R0
eS9zZXJpYWwvaW14LmMKPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKPiBAQCAtMTU2
NCw2ICsxNTY0LDEzIEBAIGlteF91YXJ0X3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKPiAgCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgm
c3BvcnQtPnBvcnQubG9jaywgZmxhZ3MpOwo+ICAKPiArCS8qCj4gKwkgKiBSZWFkIGN1cnJlbnQg
VUNSMiBhbmQgc2F2ZSBpdCBmb3IgZnV0dXJlIHVzZSwgdGhlbiBjbGVhciBhbGwgdGhlIGJpdHMK
PiArCSAqIGV4Y2VwdCB0aG9zZSB3ZSB3aWxsIG9yIG1heSBuZWVkIHRvIHByZXNlcnZlLgo+ICsJ
ICovCj4gKwlvbGRfdWNyMiA9IGlteF91YXJ0X3JlYWRsKHNwb3J0LCBVQ1IyKTsKPiArCXVjcjIg
PSBvbGRfdWNyMiAmIChVQ1IyX1RYRU4gfCBVQ1IyX1JYRU4gfCBVQ1IyX0FURU4gfCBVQ1IyX0NU
U0MpOwo+ICsKPiAgCXVjcjIgPSBVQ1IyX1NSU1QgfCBVQ1IyX0lSVFM7CnMvPS98PS8KCgpMb3Ro
YXIgV2HDn21hbm4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
