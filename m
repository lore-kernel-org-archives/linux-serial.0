From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] serial/amba-pl011: Unconditionally poll for FIFO space
 before each TX char
Date: Tue, 12 May 2015 16:00:38 +0100
Message-ID: <20150512150037.GA29594@e103592.cambridge.arm.com>
References: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
 <20150512160027.21244f64@north>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150512160027.21244f64@north>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gVHVlLCBNYXkgMTIsIDIwMTUgYXQgMDM6MDA6MjdQTSArMDEwMCwgSmFrdWIgS2ljacWEc2tp
IHdyb3RlOgo+IE9uIFR1ZSwgMTIgTWF5IDIwMTUgMTQ6NDQ6MjYgKzAxMDAsIERhdmUgTWFydGlu
IHdyb3RlOgo+ID4gVGhpcyB3aWxsIGNhdXNlIGEgY29uZmxpY3Qgd2l0aCB0dHktbmV4dCBiZWNh
dXNlIGl0IHB1bGxzIGZvcndhcmQKPiA+IHNvbWUgY2hhbmdlcyBtYWRlIGJ5IGNvbW1pdCAxZTg0
ZDIyIChzZXJpYWwvYW1iYS1wbDAxMTogUmVmYWN0b3IgYW5kCj4gPiBzaW1wbGlmeSBUWCBGSUZP
IGhhbmRsaW5nKTsgaG93ZXZlciwgdGhlIHJlc29sdXRpb24gaXMgc2ltcGxlIGV4Y2VwdAo+ID4g
Zm9yIHRoZSBmb2xsb3dpbmcgbGluZXMgd2hpY2ggbWF5IG5lZWQgdG8gYmUgZGVsZXRlZCBtYW51
YWxseSBmcm9tCj4gPiBhbWJhLXBsMDExLmM6cGwwMTFfc3RhcnR1cCgpOgo+IAo+IEJ5IHJlc29s
dXRpb24gaXMgc2ltcGxlIHlvdSBtZWFuOiBrZWVwIHRoZSBjb2RlIGFzIGl0IGlzIGluIHR0eS1u
ZXh0LAo+IHJpZ2h0PwoKWWVzLCB0aGF0J3MgcmlnaHQuCgpDaGVlcnMKLS0tRGF2ZQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
