From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Mon, 22 Jul 2019 22:09:41 +0300
Message-ID: <87ftmx3myy.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
 <1563787330-1394-2-git-send-email-sorganov@gmail.com>
 <20190722095405.qdc77cb2qrgltzrx@pengutronix.de>
 <877e8a5fz6.fsf@osv.gnss.ru>
 <20190722162011.wv36d7epunjm4h4t@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190722162011.wv36d7epunjm4h4t@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon,
 22 Jul 2019 18:20:11 +0200")
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
OgoKPiBPbiBNb24sIEp1bCAyMiwgMjAxOSBhdCAwNDo1Nzo0OVBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4gd3JpdGVzOgo+PiAKPj4gPiBPbiBNb24sIEp1bCAyMiwgMjAxOSBhdCAxMjoyMjow
OFBNICswMzAwLCBTZXJnZXkgT3JnYW5vdiB3cm90ZToKPj4gPj4gRG9uJ3QgbGV0IHJlY2VpdmVy
IGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkgY29udHJvbCBSVFMgb3V0cHV0IGlmIGl0Cj4+ID4+IHdh
cyByZXF1ZXN0ZWQgdG8gYmUgaW5hY3RpdmUuCj4+ID4+IAo+PiA+PiBUbyBlbnN1cmUgdGhpcywg
c2V0X3Rlcm1pb3MoKSBzaG91bGRuJ3Qgc2V0IFVDUjJfQ1RTQyBiaXQgaWYgVUNSMl9DVFMKPj4g
Pj4gKD1USU9DTV9SVFMpIGlzIGNsZWFyZWQuIEFkZGVkIGNvcnJlc3BvbmRpbmcgY2hlY2sgaW4g
aW14X3VhcnRfcnRzX2F1dG8oKQo+PiA+PiB0byBmaXggdGhpcy4KPj4gPj4gCj4+ID4+IFJldmll
d2VkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRl
Pgo+PiA+Cj4+ID4gSSB0aGluayBpdCdzIGEgYml0IGJvbGQgdG8gYWRkIGEgcmV2aWV3LXRhZyBm
b3IgbWUgaGVyZS4gVGhlIGJlc3QgcmVhc29uCj4+ID4gZm9yIHRoYXQgdGhhdCBJJ20gYXdhcmUg
b2YgaXMgdGhhdCBJIHdyb3RlIGZvciB2NDogIltJXWYgeW91IHVwZGF0ZSB0aGUKPj4gPiBjb21t
aXQgbG9nIGFzIGFncmVlZCBhbHJlYWR5IGJlZm9yZSBhbmQgZXZlbiBhZGQgYSBjb21tZW50IGlu
Cj4+ID4gaW14X3VhcnRfcnRzX2F1dG8gYWxvbmcgdGhlIGxpbmVzIG9mIC4uLiB5b3UgY2FuIGhh
dmUgbXkgQWNrLiIgd2hpY2ggSU1PCj4+ID4gaXNuJ3QgZ29vZCBlbm91Z2ggdG8ganVzdGlmeSBh
ICJSZXZpZXdlZC1ieSIuIEkgd291bGRuJ3QgZXZlbiBhZGQgYW4KPj4gPiBBY2tlZC1ieTogd2l0
aG91dCB0aGUgb3RoZXIgcGVyc29uIGJlaW5nIGFibGUgdG8gYWN0dWFsbHkgc2VlIHRoZQo+PiA+
IGNoYW5nZWQgcGF0Y2ggKGJ1dCB0aGlzIG1pZ2h0IGJlIGFyZ3VhYmxlKS4KPj4gCj4+IEknbGwg
ZG8gd2hhdGV2ZXIgeW91IHNheS4gU2hvdWxkIEkgcmVtb3ZlIHRoZSBSZXZpZXdlZC1ieTogeW91
LCBvciBpcyBpdAo+PiBPSyB0byBsZWF2ZSBpdCBpbiwgdG8gYXZvaWQgcmUtaXRlcmF0aW5nIGFn
YWluPwo+Cj4gSSdkIGxpa2UgdG8gaGF2ZSBpdCBhbiBBY2tlZC1ieS4KCk9LLCB3aWxsIGRvLCB0
aGFua3MhCgotLSBTZXJnZXkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
