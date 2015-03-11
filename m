From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] clk: provide clk_is_match() dummy for non-common clk
Date: Wed, 11 Mar 2015 12:17:55 +0100
Message-ID: <20150311111755.GI952@pengutronix.de>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
 <20150311102208.GX8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150311102208.GX8656@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

SGV5IFJ1c3NlbGwsCgpPbiBXZWQsIE1hciAxMSwgMjAxNSBhdCAxMDoyMjowOUFNICswMDAwLCBS
dXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6Cj4gT24gU3VuLCBNYXIgMDgsIDIwMTUgYXQg
MTA6MDU6MjlQTSArMDEwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+IEFSTSByYW5kY29uZmln
IGJ1aWxkIHRlc3RzIGZvdW5kIGEgbmV3IGVycm9yIGZvciBjb25maWd1cmF0aW9ucwo+ID4gd2l0
aCBDT01NT05fQ0xLIGRpc2FibGVkIGJ1dCBIQVNfQ0xLIHNlbGVjdGVkIGJ5IHRoZSBwbGF0Zm9y
bToKPiA+IAo+ID4gRVJST1I6ICJjbGtfaXNfbWF0Y2giIFtzb3VuZC9zb2MvZnNsL3NuZC1zb2Mt
ZnNsLXNwZGlmLmtvXSB1bmRlZmluZWQhCj4gPiAKPiA+IFRoaXMgbW92ZXMgdGhlIGRlY2xhcmF0
aW9uIGFyb3VuZCwgc28gdGhpcyBjYXNlIGlzIGNvdmVyZWQKPiA+IGJ5IHRoZSBleGlzdGluZyBz
dGF0aWMgaW5saW5lIGhlbHBlciBmdW5jdGlvbi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiA+IEZpeGVzOiBjNjllMTgyZTUxZDg5ICgiY2xr
OiBpbnRyb2R1Y2UgY2xrX2lzX21hdGNoIikKPiA+IC0tLS0KPiA+IEJUVywgd2UgaGF2ZSBhIHBy
ZWV4aXN0aW5nIHByb2JsZW0gaW4gY2xrX2dldF9wYXJlbnQsCj4gPiBjbGtfcm91bmRfcmF0ZSBh
bmQgY2xrX3NldF9wYXJlbnQsIHdoaWNoIEkndmUgd29ya2VkIGFyb3VuZCBpbgo+ID4gbXkgcmFu
ZGNvbmZpZyBidWlsZHMgc28gZmFyLiBTaG91bGQgd2UgZG8gdGhhdCB0aGUgc2FtZSB3YXk/Cj4g
Cj4gTkFLLCBhcyBVd2UgcG9pbnRzIG91dCwgeW91IGRpZG4ndCBhZGRyZXNzIG15IGNvbW1lbnQu
CllvdSBjb21tZW50ZWQgb24gdGhlIHBhdGNoIHRoYXQgaXMgYzY5ZTE4MmU1MWQ4ICgiY2xrOiBp
bnRyb2R1Y2UKY2xrX2lzX21hdGNoIikgbm93IGluIG5leHQuIEFybmQganVzdCBtb3ZlZCB0aGlz
IGFyb3VuZC4KCkJlc3QgcmVnYXJkcwpVd2UKCi0tIApQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwKSW5kdXN0
cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5wZW5ndXRy
b25peC5kZS8gIHwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
