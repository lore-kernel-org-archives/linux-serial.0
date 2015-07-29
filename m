From: Shenwei Wang <Shenwei.Wang@freescale.com>
Subject: RE: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
Date: Wed, 29 Jul 2015 21:54:58 +0000
Message-ID: <CY1PR0301MB08437D6E977C99821622976A838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
 <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
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
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBb
bWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxNeW5tDfmnIgyOeaXpSAxNjo0
Ng0KPiBUbzogV2FuZyBTaGVud2VpLUIzODMzOQ0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzFdIFNlcmlhbDogaW14OiBh
ZGQgZGV2X3BtX29wcyB0byBzdXBwb3J0IHN1c3BlbmQgdG8NCj4gcmFtL2Rpc2sNCj4gDQo+IE9u
IFdlZCwgSnVsIDI5LCAyMDE1IGF0IDY6NDEgUE0sIFNoZW53ZWkgV2FuZyA8U2hlbndlaS5XYW5n
QGZyZWVzY2FsZS5jb20+DQo+IHdyb3RlOg0KPiANCj4gPj4gY2xrX2VuYWJsZSgpIG1heSBmYWls
LCBzbyB5b3Ugc2hvdWxkIGNoZWNrIGl0cyByZXR1cm4gdmFsdWUuDQo+ID4NCj4gPiBUaGUgY2hl
Y2sgc2VlbXMgYSBsaXR0bGUgc3VwZXJmbHVvdXMgYmVjYXVzZSB0aGUgZmFpbHVyZSBjb25kaXRp
b24gZm9yDQo+ID4gY2xrX2VuYWJsZSBpcyAoY2xrID09IE5VTEwgfHwgSVNfRVJSKGNsaykpIE9u
Y2UgdGhpcyBmdW5jdGlvbiBpcw0KPiA+IGNhbGxlZCB3aGljaCBtZWFucyB0aGUgaW5pdGlhbGl6
YXRpb24gb2YgdGhlIGRyaXZlciBpcyBzdWNjZXNzZnVsLg0KPiANCj4gTm90IHN1cGVyZmx1b3Mu
IFlvdSBjYW4ndCBhc3N1bWUgdGhhdCBjbGtfZW5hYmxlKCkgd2lsbCBhbHdheXMgYmUgc3VjY2Vz
c2Z1bC4NCj4gQmV0dGVyIGNoZWNrIGl0cyByZXR1cm4gdmFsdWUuDQoNCkkgYW0gdmVyeSBpbnRl
cmVzdGluZyB0byBrbm93IGlmIHlvdSBjb3VsZCBwcm92aWRlIGFuIGV4YW1wbGUgY29uZGl0aW9u
IHRoYXQgbWF5IGNhdXNlIA0KY2xrX2VuYWJsZSBmYWlsZWQgaW4gdGhpcyBjYWxsYmFjayBmdW5j
dGlvbj8NCg0KUmVnYXJkcywNClNoZW53ZWkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
