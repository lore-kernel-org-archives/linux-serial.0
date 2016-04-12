From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Date: Tue, 12 Apr 2016 19:30:32 +0200
Message-ID: <20160412173032.GS10108@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
 <20160412094846.GF26941@ibawizard.net>
 <20160412105856.GR10108@pengutronix.de>
 <20160412121759.GG26941@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160412121759.GG26941@ibawizard.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gVHVlLCBBcHIgMTIsIDIwMTYgYXQgMDI6MTc6NTlQTSArMDIwMCwgUGV0ciDFoHRldGlhciB3
cm90ZToKPiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRl
PiBbMjAxNi0wNC0xMiAxMjo1ODo1Nl06Cj4gCj4gPiBvaywgc28gVUZDUl9EQ0VEVEUgaXMgc2V0
IGFuZCBVQ1IzX0RTUiBjb250cm9scyB0aGUgRFRSIG91dHB1dCBhcwo+ID4gaW50ZW5kZWQuIFdo
YXQgaXMgY29ubmVjdGVkIHRvIHRoZSByZXNwZWN0aXZlIHBpbj8KPiA+IE1YNlFETF9QQURfRUlN
X0QyNV9fVUFSVDFfRFNSX0IgSSB0aGluayBpcyB0aGUgb25lLgo+IAo+IEl0J3Mgcm91dGVkIG91
dCB0byBBcGFsaXMgU29NIHBpbiAxMjAsIHdoaWNoIGlzIHRoZW4gY29ubmVjdGVkIHZpYSAyMlIK
PiByZXNpc3RvciBhbmQgdGhyb3VnaCBTTjY1QzMyNDNEQlIgUlMtMjMyIGxpbmUgZHJpdmVyIHRv
IGhlYWRlciB3aGljaCBJIHVzZSBhcwo+IGRlYnVnL3NlcmlhbCBjb25zb2xlLgoKVGhlbiBJIGd1
ZXNzIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHJzMjMyLXBhcnRuZXIgYXNzZXJ0cyB0aGUgaW14
NidzCkRTUiBpbiByZXBseSB0byB0aGUgaW14NiBhc3NlcnRpbmcgRFRSPwoKQmVzdCByZWdhcmRz
ClV3ZQoKLS0gClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8IFV3
ZSBLbGVpbmUtS8O2bmlnICAgICAgICAgICAgfApJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAg
ICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
