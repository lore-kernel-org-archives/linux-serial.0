From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH RFC 5/7] serial: imx: set_termios(): preserve RTS state
Date: Fri, 14 Jun 2019 16:28:17 +0300
Message-ID: <87blz09tzi.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1560514294-29111-1-git-send-email-sorganov@gmail.com>
 <1560514294-29111-6-git-send-email-sorganov@gmail.com>
 <20190614150551.1472b154@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190614150551.1472b154@karo-electronics.de> ("Lothar
 \=\?utf-8\?Q\?Wa\=C3\=9Fmann\=22's\?\=
 message of "Fri, 14 Jun 2019 15:05:51 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: linux-serial@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

TG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVsZWN0cm9uaWNzLmRlPiB3cml0ZXM6Cj4gSGksCj4K
PiBPbiBGcmksIDE0IEp1biAyMDE5IDE1OjExOjMyICswMzAwIFNlcmdleSBPcmdhbm92IHdyb3Rl
Ogo+PiBpbXhfc2V0X3Rlcm1pb3MoKSBjbGVhcmVkIFJUUyBvbiBldmVyeSBjYWxsLCBub3cgZml4
ZWQuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnZXkgT3JnYW5vdiA8c29yZ2Fub3ZAZ21haWwu
Y29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDEyICsrKysrKysrLS0t
LQo+PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4g
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvaW14LmMKPj4gaW5kZXggOGVlOTEwZi4uZGUyMzA2OCAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwo+
PiBAQCAtMTU2NCw2ICsxNTY0LDEzIEBAIGlteF91YXJ0X3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywKPj4gIAo+PiAgCXNwaW5fbG9j
a19pcnFzYXZlKCZzcG9ydC0+cG9ydC5sb2NrLCBmbGFncyk7Cj4+ICAKPj4gKwkvKgo+PiArCSAq
IFJlYWQgY3VycmVudCBVQ1IyIGFuZCBzYXZlIGl0IGZvciBmdXR1cmUgdXNlLCB0aGVuIGNsZWFy
IGFsbCB0aGUgYml0cwo+PiArCSAqIGV4Y2VwdCB0aG9zZSB3ZSB3aWxsIG9yIG1heSBuZWVkIHRv
IHByZXNlcnZlLgo+PiArCSAqLwo+PiArCW9sZF91Y3IyID0gaW14X3VhcnRfcmVhZGwoc3BvcnQs
IFVDUjIpOwo+PiArCXVjcjIgPSBvbGRfdWNyMiAmIChVQ1IyX1RYRU4gfCBVQ1IyX1JYRU4gfCBV
Q1IyX0FURU4gfCBVQ1IyX0NUU0MpOwo+PiArCj4+ICAJdWNyMiA9IFVDUjJfU1JTVCB8IFVDUjJf
SVJUUzsKPiBzLz0vfD0vCgpOaWNlIGNhdGNoIQoKVGhhbmtzLAoKLS0gU2VyZ2V5IE9yZ2Fub3YK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
