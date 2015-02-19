From: =?UTF-8?Q?aur=C3=A9lien_bouin?= <a.bouin@gmail.com>
Subject: Re: [PATCH 7/7] serial: imx: add support for half duplex rs485
Date: Thu, 19 Feb 2015 10:45:47 +0100
Message-ID: <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
 <20150219093752.GO19388@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150219093752.GO19388@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel <kernel@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

SSBob3BlIHRoaXMgbGluayB3aWxsIGJlIG9rIDoKaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1r
ZXJuZWwmbT0xNDIzNjY4NjU2MDkzODkmcT1yYXcKQmVzdCByZWdhcmRzLAoKCgoyMDE1LTAyLTE5
IDEwOjM3IEdNVCswMTowMCBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlPjoKPiBIZWxsbyBBdXLDqWxpZW4sCj4KPiBPbiBUaHUsIEZlYiAxOSwgMjAxNSBh
dCAxMDoxNToxMEFNICswMTAwLCBhdXLDqWxpZW4gYm91aW4gd3JvdGU6Cj4+IDIwMTUtMDItMTgg
MjE6NDEgR01UKzAxOjAwIFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU+Ogo+PiA+IFRoZSB0cmFuc21pdHRlciBpcyBleHBlY3RlZCB0byBiZSBjb250cm9s
bGVkIGJ5IHRoZSBVQVJUJ3MgUlRTIHBpbi4KPj4KPj4gWW91IGRlZmluYXRlbHkgY2FuIGJlIG1v
cmUgb3BlbiBpbiB1c2luZyB0aGUgbGFzdCBwYXRjaCBJIGhhdmUgc2VudAo+PiB0aGUgMTF0aCBv
ZiBmZWJydXJhcnkgdXNpbmcgcnM0ODUucGFkZGluZ1swXSB0aGF0IGdpdmUgaW4gcGFyYW1ldGVy
Cj4+IHRoZSBHUElPIHRvIHVzZSBmb3IgdHJhbnNtaXQgcGluCj4geW91IGhhdmUgYSBsaW5rPyBX
aXRob3V0IGhhdmluZyBzZWVuIHRoYXQgcGF0Y2ggdGhpcyBjYW4gd2VsbCBiZSBhCj4gc2VwYXJh
dGUgcGF0Y2guIEFuZCAoYWxzbyB3aXRob3V0IGhhdmluZyBzZWVuIHRoZSBwYXRjaCkgSSB3b25k
ZXIgd2h5Cj4gdGhlIGluZm9ybWF0aW9uIHdoaWNoIGdwaW8gdG8gdXNlIGRvZXNuJ3QgY29tZSBm
cm9tIHRoZSBkZXZpY2UgdHJlZSBidXQKPiBpcyBzdXBwbGllZCBieSB1c2Vyc3BhY2UuIEkgdGhv
dWdodCBhYm91dCBleHBhbmRpbmcgbWN0cmwtZ3BpbyBmb3IgdGhhdCwKPiBidXQgYXMgdGhlcmUg
YXJlIGEgZmV3IGNvbmZsaWN0aW5nIHBhdGNoZXMgdG8gbWN0cmwtZ3BpbyBvdXQgSSB3YW50ZWQg
dG8KPiB3YWl0IHVudGlsIHRoZSBkdXN0IHNldHRsZXMuCj4KPiBCZXN0IHJlZ2FyZHMKPiBVd2UK
Pgo+IC0tCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdl
IEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8Cj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMg
ICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZS8gIHwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
