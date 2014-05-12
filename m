From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 14:53:12 +0800
Message-ID: <53706FD8.6090201@freescale.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com>
 <53706A9A.6060707@freescale.com> <53706CC3.4030907@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53706CC3.4030907@de.bosch.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "dean_jenkins@mentor.com" <dean_jenkins@mentor.com>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

5LqOIDIwMTTlubQwNeaciDEy5pelIDE0OjQwLCBEaXJrIEJlaG1lIOWGmemBkzoKPiBPbiAxMi4w
NS4yMDE0IDA4OjMwLCBIdWFuZyBTaGlqaWUgd3JvdGU6Cj4+IOS6jiAyMDE05bm0MDXmnIgxMuaX
pSAxMzo0NSwgRGlyayBCZWhtZSDlhpnpgZM6Cj4+PiBPbiAxMi4wNS4yMDE0IDA1OjQwLCBIdWFu
ZyBTaGlqaWUgd3JvdGU6Cj4+Pj4g5LqOIDIwMTTlubQwNeaciDA55pelIDIzOjE5LCBkZWFuX2pl
bmtpbnNAbWVudG9yLmNvbSDlhpnpgZM6Cj4+Pj4+IFVzZSBpbXhfc3RhcnRfdHgoKSBqdXN0IHRv
IGVuYWJsZSB0aGUgVFggaW50ZXJydXB0LiBJdCdzIHRoZSBqb2IgCj4+Pj4+IG9mIHRoZQo+Pj4+
PiBUWCBpbnRlcnJ1cHQgSVNSIHRvIGZpbGwgdGhlIHRyYW5zbWl0IGJ1ZmZlciwgdGhlbi4gSWYg
dGhlIHRyYW5zbWl0Cj4+Pj4+IGJ1ZmZlcgo+PiAgIEZyb20gdGhlIERvY3VtZW50YXRpb24vc2Vy
aWFsL2RyaXZlciwgd2UgY2FuIHNlZToKPj4gICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+ICAgICAgc3RhcnRfdHgocG9ydCkKPj4gICAgICAgU3RhcnQgdHJh
bnNtaXR0aW5nIGNoYXJhY3RlcnMuCj4+ICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPj4KPj4gSXQgdGVsbHMgdXMgd2UgY2FuIHRyYW5zbWl0IGRhdGEgaW4g
dGhlIGlteF9zdGFydF90eC4KPgo+IFdlbGwsIGl0IGRlcGVuZHMgaG93IHlvdSByZWFkICdTdGFy
dCB0cmFuc21pdHRpbmcnLCBubz8KPgo+IEl0IGRvZXNuJ3QgaGF2ZSB0byBtZWFuICdhY3R1YWxs
eSB0cmFuc21pdCBkYXRhJy4gSXQgdGFsa3MgYWJvdXQgCj4gJ3N0YXJ0Jy4gQW5kIHRoaXMgY291
bGQgYWxzbyBtZWFuICdzdGFydCB0aGUgdHJhbnNtaXNzaW9uIChieSBlbmFibGluZyAKPiB0aGUg
aW50ZXJydXB0KScuCj4KT2sgOikKSSBkbyBub3Qgb2JqZWN0IHRoaXMgcGF0Y2guCgpNeSBvcGlu
aW9uIGlzIDogSWYgdGhlIHRoaXJkIHBhdGNoIGlzIHJlZHVuZGFudCwgY291bGQgdGhpcyBwYXRj
aCBzdGlsbCAKbmVlZGVkPwoKCj4+IEJ1dCB0aGlzIHBhdGNoIG1vdmVzIGl0IHRvIHRoZSBpbnRl
cnJ1cHQgaGFuZGxlciwKPgo+IEl0IGRvZXNuJ3QgJ21vdmUnIGFueSBjb2RlIHRvIHRoZSBpbnRl
cnJ1cHQgaGFuZGxlci4gVGhlIGNvZGUgaW4gdGhlIAo+IGludGVycnVwdCBoYW5kbGVyIGlzIGFs
cmVhZHkgdGhlcmUuCj4KaSBrbmV3IGl0LgoKPj4gdGhpcyBwYXRjaCBtYWtlcyB0aGUKPj4gaW50
ZXJydXB0IGhhbmRsZXIgZG8gbW9yZSBqb2JzLgo+Cj4gLi4uIHRvIGdldCB0aGUgbG9ja2luZyBp
biB0aGUgY29ycmVjdCBvcmRlci4KPgphZ2FpbiwgdGhlIHRoaXJkIHBhdGNoIGNhbiBiZSBpZ25v
cmVkLgpUaGUgbG9ja2luZyBpcyBjb3JyZWN0IGZvciB0aGUgaW14LmMuCgoKdGhhbmtzCkh1YW5n
IFNoaWppZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
