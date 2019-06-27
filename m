From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v2 5/7] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Thu, 27 Jun 2019 09:16:57 +0300
Message-ID: <87tvcbimcm.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-6-git-send-email-sorganov@gmail.com>
 <20190627054733.wssatfb2i257737m@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190627054733.wssatfb2i257737m@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu,
 27 Jun 2019 07:47:33 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JpdGVz
OgoKPiBPbiBXZWQsIEp1biAyNiwgMjAxOSBhdCAwNToxMTozMVBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gc2V0X3Rlcm1pb3MoKSBzaG91bGRuJ3Qgc2V0IFVDUjJfQ1RTQyBiaXQg
aWYgVUNSMl9DVFMgKD1USU9DTV9SVFMpIGlzCj4+IGNsZWFyZWQuIEFkZGVkIGNvcnJlc3BvbmRp
bmcgY2hlY2sgaW4gaW14X3VhcnRfcnRzX2F1dG8oKSB0byBmaXggdGhpcy4KPj4gCj4+IFJldmll
d2VkLWJ5OiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Cj4+IFRlc3RlZC1i
eTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgo+PiBTaWduZWQtb2ZmLWJ5
OiBTZXJnZXkgT3JnYW5vdiA8c29yZ2Fub3ZAZ21haWwuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYyB8IDMgKystCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCj4+IGluZGV4IGUwZjUzNjUuLjQ4Njdm
ODAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwo+PiArKysgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMKPj4gQEAgLTQwNSw3ICs0MDUsOCBAQCBzdGF0aWMgdm9pZCBp
bXhfdWFydF9ydHNfaW5hY3RpdmUoc3RydWN0IGlteF9wb3J0ICpzcG9ydCwgdTMyICp1Y3IyKQo+
PiAgLyogY2FsbGVkIHdpdGggcG9ydC5sb2NrIHRha2VuIGFuZCBpcnFzIGNhbGxlciBkZXBlbmRl
bnQgKi8KPj4gIHN0YXRpYyB2b2lkIGlteF91YXJ0X3J0c19hdXRvKHN0cnVjdCBpbXhfcG9ydCAq
c3BvcnQsIHUzMiAqdWNyMikKPj4gIHsKPj4gLQkqdWNyMiB8PSBVQ1IyX0NUU0M7Cj4+ICsJaWYg
KCp1Y3IyICYgVUNSMl9DVFMpCj4+ICsJCSp1Y3IyIHw9IFVDUjJfQ1RTQzsKPj4gIH0KPgo+IEkg
d29uZGVyIGlmIHRoaXMgcGF0Y2ggaXMgb25seSBjb3JyZWN0IGluIHRoZSBwcmVzZW5jZSBvZiB0
aGUgcHJldmlvdXMKPiBwYXRjaC4gV2l0aCB0aGUgY29kZSBjdXJyZW50bHkgaW4gbWFpbmxpbmUg
aW14X3VhcnRfcnRzX2F1dG8oKSBpcyBvbmx5Cj4gY2FsbGVkIHdpdGggVUNSMl9DVFMgdW5zZXQu
CgpZZXMsIGV4YWN0bHkuCgpUaGFua3MhCgotLSBTZXJnZXkKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
