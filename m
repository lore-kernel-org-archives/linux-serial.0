From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Fri, 19 Jul 2019 15:18:13 +0300
Message-ID: <87h87idxq2.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
 <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190719091143.uhjxeibtolgswq2l@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri,
 19 Jul 2019 11:11:43 +0200")
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
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JpdGVz
OgoKPiBPbiBGcmksIEp1bCAxOSwgMjAxOSBhdCAxMTo0Nzo1MkFNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gc2V0X3Rlcm1pb3MoKSBzaG91bGRuJ3Qgc2V0IFVDUjJfQ1RTQyBiaXQg
aWYgVUNSMl9DVFMgKD1USU9DTV9SVFMpIGlzCj4+IGNsZWFyZWQuIEFkZGVkIGNvcnJlc3BvbmRp
bmcgY2hlY2sgaW4gaW14X3VhcnRfcnRzX2F1dG8oKSB0byBmaXggdGhpcy4KPgo+IFRoaXMgaXMg
bm90IHVuZGVyc3RhbmRhYmxlIHVubGVzcyB5b3UgcmVhZCB0aGUgcmVmZXJlbmNlIG1hbnVhbC4K
Pgo+IEluIHRlcm1zIHVuZGVyc3RhbmRhYmxlIHdpdGhvdXQgbWFudWFsLCB0aGlzIHBhdGNoIGRv
ZXM6Cj4KPiAJRG9uJ3QgbGV0IHRoZSByZWNlaXZlciBoYXJkd2FyZSBjb250cm9sIHRoZSBSVFMg
b3V0cHV0IGlmIGl0IHdhcwo+IAlyZXF1ZXN0ZWQgdG8gYmUgaW5hY3RpdmUuCgpJJ2xsIGZpeCBp
dCwgdGhhbmtzIQoKPgo+PiBSZXZpZXdlZC1ieTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1
dHJvbml4LmRlPgo+PiBUZXN0ZWQtYnk6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25p
eC5kZT4KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2V5IE9yZ2Fub3YgPHNvcmdhbm92QGdtYWlsLmNv
bT4KPj4gLS0tCj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAzICsrLQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+PiAKPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwo+
PiBpbmRleCA1N2Q2ZTZiLi45NWQ3OTg0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJp
YWwvaW14LmMKPj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCj4+IEBAIC00MDUsNyAr
NDA1LDggQEAgc3RhdGljIHZvaWQgaW14X3VhcnRfcnRzX2luYWN0aXZlKHN0cnVjdCBpbXhfcG9y
dCAqc3BvcnQsIHUzMiAqdWNyMikKPj4gIC8qIGNhbGxlZCB3aXRoIHBvcnQubG9jayB0YWtlbiBh
bmQgaXJxcyBjYWxsZXIgZGVwZW5kZW50ICovCj4+ICBzdGF0aWMgdm9pZCBpbXhfdWFydF9ydHNf
YXV0byhzdHJ1Y3QgaW14X3BvcnQgKnNwb3J0LCB1MzIgKnVjcjIpCj4+ICB7Cj4+IC0JKnVjcjIg
fD0gVUNSMl9DVFNDOwo+PiArCWlmICgqdWNyMiAmIFVDUjJfQ1RTKQo+PiArCQkqdWNyMiB8PSBV
Q1IyX0NUU0M7Cj4KPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgd3Jvbmcgb3IgdGhlIGNvbW1pdCBs
b2cgaXMgaW5zdWZmaWNpZW50Lgo+IGlteF91YXJ0X3J0c19hdXRvKCkgaGFzIG9ubHkgYSBzaW5n
bGUgY2FsbGVyIGFuZCB0aGVyZSB1Y3IyICYgVUNSMl9DVFMgaXMKPiBuZXZlciB0cnVlLiBBbmQg
Q1RTQyBpc24ndCByZXN0b3JlZCBhbnl3aGVyZSwgaXMgaXQ/CgpUaGlzIGlzIHJlYmFzZSB0byAn
dHR5LW5leHQnIGJyYW5jaCwgYW5kIHlvdSBuZWVkIHRvIGxvb2sgYXQgaXQgaW4gdGhhdApjb250
ZXh0LiBUaGVyZSwgdWNyMiAmIFVDUjJfQ1RTIGRvZXMgYWxyZWFkeSBtYWtlIHNlbnNlLCBkdWUg
dG8gcHJldmlvdXMKZml4IHRoYXQgaXMgYWxyZWFkeSB0aGVyZS4KCkFsdGVybmF0aXZlbHksIGxv
b2sgYXQgdjMgb2YgdGhlIHBhdGNoZXMsIGJ1dCB5b3UgYmFzaWNhbGx5IGFscmVhZHkgZGlkLgpJ
dCdzIHRoYXQgdGhlIGZpcnN0IHBhcnQgb2YgdjMgcGF0Y2ggc2VyaWVzIGhhcyBiZWVuIGFscmVh
ZHkgYWNjZXB0ZWQKdXBzdHJlYW0sIGFuZCB0aGlzIGlzIHRoZSByZXN0IG9mIHRob3NlIHBhdGNo
ZXMuCgpUaGFua3MhCgotLSBTZXJnZXkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
