From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] serial: imx: fix uninitialized variable warning
Date: Mon, 18 Feb 2013 08:53:43 +0100
Message-ID: <5121DE07.8060908@de.bosch.com>
References: <1361164536-1351-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1361164536-1351-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

T24gMTguMDIuMjAxMyAwNjoxNSwgU2hhd24gR3VvIHdyb3RlOgo+IENvbW1pdCA2NzdmZTU1IChz
ZXJpYWw6IGlteDogRml4IHJlY3Vyc2l2ZSBsb2NraW5nIGJ1ZykgaW50cm9kdWNlcyBhbgo+IHVu
aW5pdGlhbGl6ZWQgdmFyaWFibGUgd2FybmluZyBhcyBiZWxvdy4KPiAKPiAgIENDICAgICAgZHJp
dmVycy90dHkvc2VyaWFsL2lteC5vCj4gZHJpdmVycy90dHkvc2VyaWFsL2lteC5jOiBJbiBmdW5j
dGlvbiDigJhpbXhfY29uc29sZV93cml0ZeKAmToKPiBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6
MzQwOjI6IHdhcm5pbmc6IOKAmGZsYWdz4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4g
dGhpcyBmdW5jdGlvbiBbLVd1bmluaXRpYWxpemVkXQo+IGRyaXZlcnMvdHR5L3NlcmlhbC9pbXgu
YzoxMjE0OjE2OiBub3RlOiDigJhmbGFnc+KAmSB3YXMgZGVjbGFyZWQgaGVyZQo+IAo+IEluaXRp
YWxpemUgdGhlIHZhcmlhYmxlIHRvIHN1cHByZXNzIHRoZSB3YXJuaW5nLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+CgpBY2tlZC1ieTogRGlyayBC
ZWhtZSA8ZGlyay5iZWhtZUBkZS5ib3NjaC5jb20+CgpUaGFua3MKCkRpcmsKCj4gLS0tCj4gIGRy
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8ICAgIDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwo+IGluZGV4IGFkZjc2MTEuLjE0
N2M5ZTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCj4gKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jCj4gQEAgLTEyMTEsNyArMTIxMSw3IEBAIGlteF9jb25zb2xl
X3dyaXRlKHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqcywgdW5zaWduZWQgaW50IGNv
dW50KQo+ICAJc3RydWN0IGlteF9wb3J0ICpzcG9ydCA9IGlteF9wb3J0c1tjby0+aW5kZXhdOwo+
ICAJc3RydWN0IGlteF9wb3J0X3VjcnMgb2xkX3VjcjsKPiAgCXVuc2lnbmVkIGludCB1Y3IxOwo+
IC0JdW5zaWduZWQgbG9uZyBmbGFnczsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSAwOwo+ICAJ
aW50IGxvY2tlZCA9IDE7Cj4gIAo+ICAJaWYgKHNwb3J0LT5wb3J0LnN5c3JxKQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
