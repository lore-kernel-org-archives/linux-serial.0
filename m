From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/4] OF: Add helper for matching against linux, stdout-path
Date: Thu, 22 Nov 2012 06:33:13 +0100
Message-ID: <20653.47385.793796.215803@ipc1.ka-ro>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
 <20121121172631.GV10369@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121121172631.GV10369@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

SGksCgpTYXNjaGEgSGF1ZXIgd3JpdGVzOgo+IE9uIFdlZCwgTm92IDIxLCAyMDEyIGF0IDA0OjU3
OjA1UE0gKzAxMDAsIEplYW4tQ2hyaXN0b3BoZSBQTEFHTklPTC1WSUxMQVJEIHdyb3RlOgo+ID4g
RnJvbTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgo+ID4gCj4gPiBkZXZp
Y2V0cmVlcyBtYXkgaGF2ZSBhIGxpbnV4LHN0ZG91dC1wYXRoIG9yIHN0ZG91dC1wYXRoIHByb3Bl
cnR5Cj4gPiBpbiB0aGUgY2hvc2VuIG5vZGUgZGVzY3JpYmluZyB0aGUgY29uc29sZSBkZXZpY2Uu
IFRoaXMgYWRkcyBhIGhlbHBlcgo+ID4gZnVuY3Rpb24gdG8gbWF0Y2ggYSBkZXZpY2UgYWdhaW5z
dCB0aGlzIHByb3BlcnR5IGFuZCByZXRyaWV2ZSB0aGUgb3B0aW9ucwo+ID4gc28gYSBkcml2ZXIg
Y2FuIGNhbGwgYWRkX3ByZWZlcnJlZF9jb25zb2xlIGZvciBhIG1hdGNoaW5nIGRldmljZS4KPiA+
IApbLi4uXQo+ID4gKwlpZiAoIXRtcCkKPiA+ICsJCXJldHVybiAwOwo+ID4gKwo+ID4gKwlkbl9z
dGRvdXQgPSBvZl9maW5kX25vZGVfYnlfcGF0aCh0bXApOwo+ID4gKwo+ID4gKwlpZiAoZG5fc3Rk
b3V0ICYmIGRuX3N0ZG91dCA9PSBkbikgewo+ID4gKwkJaXNfc3Rkb3V0ID0gMTsKPiA+ICsJCXRt
cF9vcHRpb24rKzsKPiA+ICsJCSpvcHRpb24gPSBrc3RyZHVwKHRtcF9vcHRpb24sIEdGUF9LRVJO
RUwpOwo+ID4gKwl9Cj4gPiArCj4gPiArCW9mX25vZGVfcHV0KGRuX3N0ZG91dCk7Cj4gCj4gZG5f
c3Rkb3V0IG1heSBiZSBOVUxMIGFzd2VsbC4KPiAKd2hpY2ggaXMgaGFuZGxlZCBncmFjZWZ1bGx5
IGJ5IG9mX25vZGVfcHV0KCkuLi4KCgpMb3RoYXIgV2HDn21hbm4KLS0gCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCgpLYS1SbyBlbGVj
dHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAyMiB8IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6
ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0MDggMTQwMi0xMApHZXNjaMOkZnRzZsO8aHJl
cjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVnaXN0ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBB
YWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVjdHJvbmljcy5kZSB8IGluZm9Aa2Fyby1lbGVj
dHJvbmljcy5kZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
