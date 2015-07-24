From: Shenwei Wang <Shenwei.Wang@freescale.com>
Subject: RE: [PATCH 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Fri, 24 Jul 2015 17:16:23 +0000
Message-ID: <BL2PR03MB370BD6DAA817B559802A8BF83810@BL2PR03MB370.namprd03.prod.outlook.com>
References: <1437165018-56026-1-git-send-email-shenwei.wang@freescale.com>
 <20150724003722.GA14027@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150724003722.GA14027@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdyZWcgS0ggW21haWx0bzpn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4gU2VudDogMjAxNcTqN9TCMjPI1SAxOTozNw0K
PiBUbzogV2FuZyBTaGVud2VpLUIzODMzOQ0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8xXSBTZXJpYWw6IGlteDogYWRkIGRldl9wbV9vcHMgdG8gc3VwcG9ydCBzdXNw
ZW5kIHRvDQo+IHJhbS9kaXNrDQo+ID4gKwlzcG9ydC0+c2F2ZWRfcmVnWzRdID0gcmVhZGwoc3Bv
cnQtPnBvcnQubWVtYmFzZSArIFVGQ1IpOw0KPiA+ICsJc3BvcnQtPnNhdmVkX3JlZ1s1XSA9IHJl
YWRsKHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVRVNDKTsNCj4gPiArCXNwb3J0LT5zYXZlZF9yZWdb
Nl0gPSByZWFkbChzcG9ydC0+cG9ydC5tZW1iYXNlICsgVVRJTSk7DQo+ID4gKwlzcG9ydC0+c2F2
ZWRfcmVnWzddID0gcmVhZGwoc3BvcnQtPnBvcnQubWVtYmFzZSArIFVCSVIpOw0KPiA+ICsJc3Bv
cnQtPnNhdmVkX3JlZ1s4XSA9IHJlYWRsKHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVQk1SKTsNCj4g
PiArCXNwb3J0LT5zYXZlZF9yZWdbOV0gPSByZWFkbChzcG9ydC0+cG9ydC5tZW1iYXNlICsgSU1Y
MjFfVVRTKTsNCj4gPiArCWNsa19kaXNhYmxlKHNwb3J0LT5jbGtfaXBnKTsNCj4gPiArDQo+ID4g
Kwlwcl9kZWJ1ZygiMHglcCAoJWQpXHJcbiIsIHNwb3J0LT5wb3J0Lm1lbWJhc2UsIHNwb3J0LT5w
b3J0LmxpbmUpOw0KPiANCj4gWW91IGhhdmUgYSBzdHJ1Y3QgZGV2aWNlLCBwbGVhc2UgdXNlIGRl
dl9kYmcoKSBpbnN0ZWFkLg0KDQpBZG9wdGVkIGluIFBBVENIIHYyLg0KDQo+IA0KPiA+ICsNCj4g
PiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsJd3JpdGVsKHNwb3J0LT5zYXZlZF9y
ZWdbMl0sIHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVQ1IzKTsNCj4gPiArCXdyaXRlbChzcG9ydC0+
c2F2ZWRfcmVnWzNdLCBzcG9ydC0+cG9ydC5tZW1iYXNlICsgVUNSNCk7DQo+ID4gKwljbGtfZGlz
YWJsZShzcG9ydC0+Y2xrX2lwZyk7DQo+ID4gKw0KPiA+ICsJcHJfZGVidWcoIjB4JXAgKCVkKVxy
XG4iLCBzcG9ydC0+cG9ydC5tZW1iYXNlLCBzcG9ydC0+cG9ydC5saW5lKTsNCj4gDQo+IFNhbWUg
aGVyZSwgcGxlYXNlIHVzZSBkZXZfZGJnKCkNCg0KQWRvcHRlZCBpbiBQQVRDSCB2Mi4NCg0KVGhh
bmtzLA0KU2hlbndlaQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
