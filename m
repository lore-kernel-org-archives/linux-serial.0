From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Date: Wed, 13 Apr 2016 13:16:46 +0200
Message-ID: <20160413111646.GC10108@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
 <20160412094846.GF26941@ibawizard.net>
 <20160412105856.GR10108@pengutronix.de>
 <20160412121759.GG26941@ibawizard.net>
 <20160412173032.GS10108@pengutronix.de>
 <20160413091336.GH26941@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160413091336.GH26941@ibawizard.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

T24gV2VkLCBBcHIgMTMsIDIwMTYgYXQgMTE6MTM6MzZBTSArMDIwMCwgUGV0ciDFoHRldGlhciB3
cm90ZToKPiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRl
PiBbMjAxNi0wNC0xMiAxOTozMDozMl06Cj4gCj4gPiBPbiBUdWUsIEFwciAxMiwgMjAxNiBhdCAw
MjoxNzo1OVBNICswMjAwLCBQZXRyIMWgdGV0aWFyIHdyb3RlOgo+ID4gPiBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiBbMjAxNi0wNC0xMiAxMjo1ODo1
Nl06Cj4gPiA+IAo+ID4gPiA+IG9rLCBzbyBVRkNSX0RDRURURSBpcyBzZXQgYW5kIFVDUjNfRFNS
IGNvbnRyb2xzIHRoZSBEVFIgb3V0cHV0IGFzCj4gPiA+ID4gaW50ZW5kZWQuIFdoYXQgaXMgY29u
bmVjdGVkIHRvIHRoZSByZXNwZWN0aXZlIHBpbj8KPiA+ID4gPiBNWDZRRExfUEFEX0VJTV9EMjVf
X1VBUlQxX0RTUl9CIEkgdGhpbmsgaXMgdGhlIG9uZS4KPiA+ID4gCj4gPiA+IEl0J3Mgcm91dGVk
IG91dCB0byBBcGFsaXMgU29NIHBpbiAxMjAsIHdoaWNoIGlzIHRoZW4gY29ubmVjdGVkIHZpYSAy
MlIKPiA+ID4gcmVzaXN0b3IgYW5kIHRocm91Z2ggU042NUMzMjQzREJSIFJTLTIzMiBsaW5lIGRy
aXZlciB0byBoZWFkZXIgd2hpY2ggSSB1c2UgYXMKPiA+ID4gZGVidWcvc2VyaWFsIGNvbnNvbGUu
Cj4gPiAKPiA+IFRoZW4gSSBndWVzcyB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSByczIzMi1wYXJ0
bmVyIGFzc2VydHMgdGhlIGlteDYncwo+ID4gRFNSIGluIHJlcGx5IHRvIHRoZSBpbXg2IGFzc2Vy
dGluZyBEVFI/Cj4gCj4gWWVzLCB0aGF0J3MgY29ycmVjdC4KCk9LLCB0aGF0IGZpdHMgbmljZWx5
IGluIG15IHBpY3R1cmUuIFNvIHdlIG9ubHkgaGF2ZSB0byB3YWl0IHVudGlsIEdyZWcKaGFwcGls
eSBwaWNrcyB1cCB0aGUgZml4ZXMgKGkuZS4gcGF0Y2hlcyAxIHVwIHRvIDQpLgoKQmVzdCByZWdh
cmRzClV3ZQoKLS0gClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8
IFV3ZSBLbGVpbmUtS8O2bmlnICAgICAgICAgICAgfApJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9u
cyAgICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
