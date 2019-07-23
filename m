From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 2/3] serial: imx: set_mctrl(): correctly restore
 autoRTS state
Date: Tue, 23 Jul 2019 14:16:09 +0300
Message-ID: <87muh5ypae.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563823331-5629-1-git-send-email-sorganov@gmail.com>
 <1563823331-5629-3-git-send-email-sorganov@gmail.com>
 <20190722202406.hr74mg64sxoovah7@pengutronix.de>
 <87h87d1509.fsf@osv.gnss.ru>
 <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190723094902.r7v5wzu4lkicrs3o@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Tue,
 23 Jul 2019 11:49:02 +0200")
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
OgoKPiBPbiBUdWUsIEp1bCAyMywgMjAxOSBhdCAxMjoyMDozOFBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4gd3JpdGVzOgo+PiAKPj4gPiBPbiBNb24sIEp1bCAyMiwgMjAxOSBhdCAxMDoyMjox
MFBNICswMzAwLCBTZXJnZXkgT3JnYW5vdiB3cm90ZToKPj4gPj4gaW14X3VhcnRfc2V0X21jdHJs
KCkgaGFwcGVuZWQgdG8gc2V0IFVDUjJfQ1RTQyBiaXQgd2hlbmV2ZXIgVElPQ01fUlRTCj4+ID4+
IHdhcyBzZXQsIG5vIG1hdHRlciBpZiBSVFMvQ1RTIGhhbmRzaGFrZSBpcyBlbmFibGVkIG9yIG5v
dC4gTm93IGZpeGVkIGJ5Cj4+ID4+IHR1cm5pbmcgaGFuZHNoYWtlIG9uIG9ubHkgd2hlbiBDUlRT
Q1RTIGJpdCBmb3IgdGhlIHBvcnQgaXMgc2V0Lgo+PiA+Pgo+PiA+PiBBY2tlZC1ieTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KPgo+IE9oLCB5b3Ug
YWRkZWQgbXkgQWNrIGZvciBwYXRjaGVzIDIgYW5kIDMsIHRvbywgZXZlbiBiZWZvcmUgSSBsb29r
ZWQKPiBhZ2FpbiBvbiB0aG9zZSA6LXwKCk9vcHMsIEkgdGhvdWdodCB5b3UndmUgbG9va2VkIGF0
IGFsbCAzIGJlZm9yZSBzdGFydGluZyB0byBjb21tZW50LgoKLS0gU2VyZ2V5CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
