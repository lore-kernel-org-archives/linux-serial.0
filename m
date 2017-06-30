From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
Date: Fri, 30 Jun 2017 13:12:33 +0200
Message-ID: <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
 <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, service@rdamicro.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

QW0gMjkuMDYuMjAxNyB1bSAyMjoxMCBzY2hyaWViIFJvYiBIZXJyaW5nOgo+IE9uIFR1ZSwgSnVu
IDI3LCAyMDE3IGF0IDAyOjU1OjE4QU0gKzAyMDAsIEFuZHJlYXMgRsOkcmJlciB3cm90ZToKPj4g
QWRkIGFuIGluaXRpYWwgYmluZGluZyBmb3IgdGhlIFJEQTg4MTBQTCBVQVJULgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+Cj4+IC0tLQo+PiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZGEtdWFydC50eHQgfCAx
MyArKysrKysrKysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+PiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJp
YWwvcmRhLXVhcnQudHh0Cj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3JkYS11YXJ0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zZXJpYWwvcmRhLXVhcnQudHh0Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNjg0MGE4YWVlMDM1Cj4+IC0tLSAvZGV2L251bGwKPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZGEtdWFydC50eHQK
Pj4gQEAgLTAsMCArMSwxMyBAQAo+PiArUkRBIE1pY3JvIFVBUlQKPj4gKwo+PiArUmVxdWlyZWQg
cHJvcGVydGllczoKPj4gKy0gY29tcGF0aWJsZSA6ICAicmRhLDg4MTBwbC11YXJ0IiBmb3IgUkRB
ODgxMFBMCj4+ICstIHJlZyAgICAgICAgOiAgT2Zmc2V0IGFuZCBsZW5ndGggb2YgdGhlIHJlZ2lz
dGVyIHNldCBmb3IgdGhlIGRldmljZS4KPiAKPiBObyBjbG9ja3Mgb3IgaW50ZXJydXB0cz8KCk5v
dCB5ZXQuIEkndmUgb25seSBwaWVjZWQgdG9nZXRoZXIgYW4gZWFybHljb24gZHJpdmVyIHNvIGZh
ciwgbm8gZnVsbApzZXJpYWwgZHJpdmVyLiBUaGUgLmR0c2kgZG9lc24ndCBldmVuIGhhdmUgYW4g
aW50ZXJydXB0LWNvbnRyb2xsZXIgbm9kZQp5ZXQgLSB3YXNuJ3QgY2xlYXIgdG8gbWUgd2hldGhl
ciB0aGlzIFNvQyBldmVuIGhhcyBhIEdJQyBhbmQsIGlmIHNvLAp3aGVyZSwgZnJvbSB0aGUgZG93
bnN0cmVhbSBwcmUtRFQgY29kZS4KClJlZ2FyZHMsCkFuZHJlYXMKCi0tIApTVVNFIExpbnV4IEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQpHRjogRmVsaXggSW1l
bmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uCkhSQiAyMTI4NCAoQUcgTsO8
cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
