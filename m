From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Disable kgdboc failed by echo space to
 /sys/module/kgdboc/parameters/kgdboc
Date: Tue, 19 Mar 2019 15:23:06 +0100
Message-ID: <20190319142306.GA13458@kroah.com>
References: <HK0PR03MB2817154ABAB39937BFF0AB9BCB4D0@HK0PR03MB2817.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <HK0PR03MB2817154ABAB39937BFF0AB9BCB4D0@HK0PR03MB2817.apcprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: =?utf-8?B?546LIOaWh+a2mw==?= <wwthappy@hotmail.com>
Cc: "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: linux-serial@vger.kernel.org

T24gRnJpLCBNYXIgMDgsIDIwMTkgYXQgMDE6NTQ6MDJBTSArMDAwMCwg546LIOaWh+a2myB3cm90
ZToKPiBGcm9tIDY2ZDM5YzBkZTBhYmQ0NWRkY2E3YWE4ZmMwODYzMmIwMWQ2NjlkN2IgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogV2VudGFvIFdhbmcgPOKAnHdpdGFsbHdhbmdAZ21h
aWwuY29t4oCdPgo+IERhdGU6IE1vbiwgNCBNYXIgMjAxOSAyMTo1ODozMyArMDgwMAo+IFN1Ympl
Y3Q6IFtQQVRDSF0gRGlzYWJsZSBrZ2Rib2MgZmFpbGVkIGJ5IGVjaG8gc3BhY2UgdG8KPiAgL3N5
cy9tb2R1bGUva2dkYm9jL3BhcmFtZXRlcnMva2dkYm9jCj4gTUlNRS1WZXJzaW9uOiAxLjAKPiBD
b250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKPiBDb250ZW50LVRyYW5zZmVy
LUVuY29kaW5nOiA4Yml0CgpXaHkgaXMgdGhpcyBhbGwgaW4geW91ciBwYXRjaCBpdHNlbGY/ICBJ
dCdzIGFsc28gbGluZS13cmFwcGVkIDooCgpQbGVhc2UganVzdCBzZW5kIHRoZSBwYXRjaCBpbiBh
ICJjbGVhbiIgZm9ybWF0LCBvciB1c2UgZ2l0IHNlbmQtZW1haWwgdG8Kc2VuZCBpdCBvdXQuCgo+
IAo+IEVjaG8gIiIgdG8gL3N5cy9tb2R1bGUva2dkYm9jL3BhcmFtZXRlcnMva2dkYm9jIHdpbGwg
ZmFpbCB3aXRoIHdyaXRlCj4gZXJyb3I6IE5vIHN1Y2ggZGV2aWNlCj4gVGhpcyBpcyBjYXVzZWQg
YnkgZnVuY3Rpb24gImNvbmZpZ3VyZV9rZ2Rib2MiIHdobyBpbml0IGVyciB0byBFTk9ERVYgd2hl
bgo+IHRoZSBjb25maWcgaXMgZW1wdHkgKGxlZ2FsIGlucHV0KSB0aGUgY29kZSBnbyBvdXQgd2l0
aCBFTk9ERVYgcmV0dXJuZWQuCj4gCj4gRml4ZXM6IDJkZDQ1MzE2ODY0M2QgKCJrZ2Rib2M6IEZp
eCByZXN0cmljdCBlcnJvciIpCj4gCj4gU2lnbmVkLW9mZi1ieTogV2VudGFvIFdhbmcgPOKAnHdp
dGFsbHdhbmdAZ21haWwuY29t4oCdPgoKTm8gbmVlZCBmb3IgIiIgZm9yIHlvdXIgZW1haWwgYWRk
cmVzcy4KCkNhbiB5b3UgcGxlYXNlIGZpeCB0aGlzIHVwIGFuZCByZXNlbmQgc28gSSBjYW4gYXBw
bHkgdGhlIHBhdGNoPwoKdGhhbmtzLAoKZ3JlZyBrLWgKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpLZ2RiLWJ1Z3JlcG9ydCBtYWlsaW5nIGxpc3QKS2dk
Yi1idWdyZXBvcnRAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2tnZGItYnVncmVwb3J0Cg==
