From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] serial: 8250: Fix THRE flag usage for CAP_MINI
Date: Wed, 28 Jun 2017 15:01:33 +0300
Message-ID: <1498651293.22624.219.camel@linux.intel.com>
References: <1498642885-8063-1-git-send-email-phil@raspberrypi.org>
 <20170628105744.42bchlftl6khvsxd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170628105744.42bchlftl6khvsxd-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

T24gV2VkLCAyMDE3LTA2LTI4IGF0IDEyOjU3ICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBIZWxsbywKPiAKPiBPbiBXZWQsIEp1biAyOCwgMjAxNyBhdCAxMDo0MToyNUFNICswMTAw
LCBQaGlsIEVsd2VsbCB3cm90ZToKPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwgRWx3ZWxsIDxwaGls
QHJhc3BiZXJyeXBpLm9yZz4KPiA+IEFja2VkLWJ5OiBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQu
bmV0Pgo+ID4gQWNrZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gwqBBZGQgcmV2aWV3
IHRhZ3MuCj4gCj4gbml0cGljazogVGhlIG9yZGVyIG9mIGxpbmVzIGluIHRoZSBTb2IgYXJlYSBt
YXR0ZXIgYW5kIHlvdSBzaG91bGQgYWRkCj4geW91ciBTb2IgYXQgdGhlIGVuZC4gU28gYXMgaXQg
d2FzIHlvdSBhZGRpbmcgdGhlIGFjayBieSBFcmljIGFuZCBBbmR5LAo+IGl0IHNob3VsZCBsb29r
IGFzIGZvbGxvd3M6Cj4gCj4gCUFja2VkLWJ5OiBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0
Pgo+IAlBY2tlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5p
bnRlbC5jb20+Cj4gCVNpZ25lZC1vZmYtYnk6IFBoaWwgRWx3ZWxsIDxwaGlsQHJhc3BiZXJyeXBp
Lm9yZz4KPiAKPiAuIE5vdGUgdGhhdCB0aGlzIGNvbW1lbnQgaXMgdmVyeSBwaWNreSwgcXVpdGUg
c29tZSBwZW9wbGUgZG9uJ3QgZ2V0IGl0Cj4gcmlnaHQgYW5kIEkgbmV2ZXIgc2F3IGEgbWFpbnRh
aW5lciByZWZ1c2UgYSBwYXRjaCBiZWNhdXNlIG9mIHRoaXMuIFNvCj4gdGhpcyBwcm9iYWJseSBk
b2Vzbid0IHdhcnJhbnQgYSB2MyA6LSkKClllYWgsIGl0J3MgZWFzaWx5IGxlYXJuZWQgd2hlbiBv
bmUgaXMgdXNpbmcKCiUgZ2l0IGNvbW1pdCAtcyBbLS1hbWVuZF0KCi0tIApBbmR5IFNoZXZjaGVu
a28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KSW50ZWwgRmlubGFuZCBPeQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcnBp
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtcnBpLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcnBpLWtl
cm5lbAo=
