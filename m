From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] clk: provide clk_is_match() dummy for non-common clk
Date: Tue, 10 Mar 2015 22:42:54 +0100
Message-ID: <CAMuHMdWvaO-qEohYX=DNybR1=1d4me=FHO8Rj-eEn2OgAKaPgg@mail.gmail.com>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8682755.oK0Ae34OOP@wuerfel>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pwm@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mike Turquette <mturquette@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, DRI Development <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gU3VuLCBNYXIgOCwgMjAxNSBhdCAxMDowNSBQTSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5k
Yi5kZT4gd3JvdGU6Cj4gQVJNIHJhbmRjb25maWcgYnVpbGQgdGVzdHMgZm91bmQgYSBuZXcgZXJy
b3IgZm9yIGNvbmZpZ3VyYXRpb25zCj4gd2l0aCBDT01NT05fQ0xLIGRpc2FibGVkIGJ1dCBIQVNf
Q0xLIHNlbGVjdGVkIGJ5IHRoZSBwbGF0Zm9ybToKPgo+IEVSUk9SOiAiY2xrX2lzX21hdGNoIiBb
c291bmQvc29jL2ZzbC9zbmQtc29jLWZzbC1zcGRpZi5rb10gdW5kZWZpbmVkIQo+Cj4gVGhpcyBt
b3ZlcyB0aGUgZGVjbGFyYXRpb24gYXJvdW5kLCBzbyB0aGlzIGNhc2UgaXMgY292ZXJlZAo+IGJ5
IHRoZSBleGlzdGluZyBzdGF0aWMgaW5saW5lIGhlbHBlciBmdW5jdGlvbi4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4gRml4ZXM6IGM2OWUxODJlNTFk
ODkgKCJjbGs6IGludHJvZHVjZSBjbGtfaXNfbWF0Y2giKQoKRllJLCB0aGlzIGFsc28gaGFwcGVu
cyBmb3Igc2gvYWxsbW9kY29uZmlnCmh0dHA6Ly9raXNza2IuZWxsZXJtYW4uaWQuYXUva2lzc2ti
L2J1aWxkcmVzdWx0LzEyMzc5ODg0LwoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAg
ICAgICAgICAgICBHZWVydAoKLS0KR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dy
YW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0gTGludXMgVG9ydmFsZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
