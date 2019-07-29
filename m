From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v7 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date: Mon, 29 Jul 2019 12:03:07 +0300
Message-ID: <87wog1xlf8.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
 <1564167161-3972-4-git-send-email-sorganov@gmail.com>
 <20190726192940.jy4frulgbetf5d2v@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190726192940.jy4frulgbetf5d2v@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Fri,
 26 Jul 2019 21:29:40 +0200")
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
OgoKPiBPbiBGcmksIEp1bCAyNiwgMjAxOSBhdCAwOTo1Mjo0MVBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gQ2FsbGVkIGluIG9ubHkgb25lIHBsYWNlLCBmb3IgUlMyMzIsIGl0IG9u
bHkgb2JzY3VyZXMgdGhpbmdzLCBhcyBpdAo+PiBkb2Vzbid0IGdvIHdlbGwgd2l0aCAyIHNpbWls
YXIgbmFtZWQgZnVuY3Rpb25zLAo+PiBpbXhfdWFydF9ydHNfaW5hY3RpdmUoKSBhbmQgaW14X3Vh
cnRfcnRzX2FjdGl2ZSgpLCB0aGF0IGJvdGggYXJlCj4+IFJTNDg1LXNwZWNpZmljLgo+Cj4gSSBk
b24ndCBzaGFyZSB0aGUgY3JpdGljLiBJTUhPIHRoZSBuYW1lIGlzIGZpbmUuIGlteF91YXJ0X3J0
c19pbmFjdGl2ZQo+IHNldHMgcnRzIHRvIGl0cyBpbmFjdGl2ZSBsZXZlbCwKPiBpbXhfdWFydF9y
dHNfYWN0aXZlKCkgdG8gaXRzIGFjdGl2ZSBsZXZlbAoKTm90IGV4YWN0bHksIGluIGZhY3QgYm90
aCBkbyBtb3JlIHRoYW4gdGhhdCwgaW4gYSBzaW1pbGFyIG1hbm5lci4KCj4gaW14X3VhcnRfcnRz
X2F1dG8oKSBsZXRzIHRoZSBvdXRwdXQgZHJpdmUgYXV0b21hdGljYWxseSBieSB0aGUKPiByZWNl
aXZlci4KCkFuZCB0aGlzIG9uZSB3YXMgZGlmZmVyZW50IGFuZCBpdCB3YXMgcmF0aGVyIGNvbmZ1
c2luZyB3aGVuIEkndmUgdHJpZWQKdG8gZ3JvayB0aGUgbG9naWMgb2YgdGhlIGRyaXZlci4KCj4g
VGhlIG5hbWUgc3RhcnRlZCB0byBiZSBhIGJpdCB3cm9uZyBpbiBwYXRjaCAxIG9mIHRoZSBzZXJp
ZXMgaG93ZXZlci4KClRoZSBmdW5jdGlvbiB3YXMgZGlmZmVyZW50IGZyb20gZmlyc3QgdHdvIGV2
ZW4gYmVmb3JlIHRoZSBwYXRjaCwgYXMgaXQKZG9lcyBub3QgZG8gYW55IG9mIHRob3NlIGFkZGl0
aW9uYWwgdGhpbmdzIHRoZSBmaXJzdCB0d28gZG8uCgo+IEFuZCBJIHN0aWxsIG9iamVjdCByZW1v
dmluZyB0aGlzIGZ1bmN0aW9uIGJlY2F1c2Ugd2l0aCB0aGUgc2VtYW50aWMKPiB0aGlzIGZ1bmN0
aW9uIGdvdCBpbiBwYXRjaCAxIGl0IGlzIHN1aXRlYWJsZSB0byBiZSB1c2VkIGluCj4gaW14X3Vh
cnRfc2V0X21jdHJsKCkuCgpJdCBpcyBub3QsIGFzIGl0IGRvZXMgcmVxdWlyZSBjaGFuZ2UgdG8g
YmUgdXNlZCB0aGVyZSwgYXMgd2UndmUgYWxyZWFkeQpzZWVuLCBhbmQgdGhlbiBpdCBiZWNvbWVz
IHZlcnkgZGlmZmVyZW50IGZ1bmN0aW9uIGZyb20gd2hhdCBpdCB3YXMgYXQKdGhlIGJlZ2lubmlu
Zy4KCkV2ZW4gdGhlbiwgdGhlIGVuZCByZXN1bHQgSSd2ZSBzaG93biB5b3Ugd2hlbiBhdHRlbXB0
aW5nIHRvIHNvbWVob3cgcHJlc2VydmUKc29tZSByZS1pbmNhcm5hdGlvbiBvZiB0aGlzIGZ1bmN0
aW9uIHN0aWxsIHNlZW1zIG1vcmUgY3VtYmVyc29tZSB0byBtZQp0aGFuIHRoZSBlbmQgcmVzdWx0
IG9mIHRoZXNlIHBhdGNoZXMuCgpUaGF0IHNhaWQsIHRoaXMgYSBtYXR0ZXIgb2YgdGFzdGUgYW5k
IHN0eWxlLCBub3QgY29ycmVjdG5lc3MsIGFuZCBjb3VsZApiZSBjaGFuZ2VkIGFzIGEgZm9sbG93
LXVwLCBub3QgdG8gcmlzayBicmVha2luZyBhbHJlYWR5IHRlc3RlZCBwYXRjaApzZXJpZXMuCgpU
aGFua3MsCgotLSBTZXJnZXkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
