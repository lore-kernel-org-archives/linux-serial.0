From: Bich HEMON <bich.hemon@st.com>
Subject: Re: [PATCH 4/9] serial: stm32: fix pio transmit timeout
Date: Mon, 31 Jul 2017 09:30:54 +0000
Message-ID: <b1eb499b-4099-6109-7516-3b872175b8f9@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-5-git-send-email-bich.hemon@st.com>
 <20170730143256.GA30584@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170730143256.GA30584@kroah.com>
Content-Language: en-US
Content-ID: <2A1036DA48DA924FA0CF497889C3FE53@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KT24gMDcvMzAvMjAxNyAwNDozMiBQTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdy
b3RlOg0KPiBPbiBUaHUsIEp1bCAxMywgMjAxNyBhdCAwMzowODoyOFBNICswMDAwLCBCaWNoIEhF
TU9OIHdyb3RlOg0KPj4gRnJvbTogR2VyYWxkIEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0K
Pj4NCj4+IDEwMMK1cyB3YXMgdG9vIHNob3J0IGZvciBsb3cgc3BlZWQgdHJhbnNtaXNzaW9uDQo+
PiAoOTYwMGJwcykNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBHZXJhbGQgQmFlemEgPGdlcmFsZC5i
YWV6YUBzdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCaWNoIEhlbW9uIDxiaWNoLmhlbW9uQHN0
LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYyB8IDIg
Ky0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBUaGlzIHBhdGNoIGRpZCBub3QgYXBwbHkgOigNCj4gDQoNCkkgaGF2ZSByZWJhc2VkIHRo
ZSBwYXRjaCBvbiB0b3Agb2YgeW91ciB0dHktbmV4dCBicmFuY2ggLiBQbGVhc2UgZHJvcCANCnRo
aXMgcGF0Y2ggYXMgSSB3aWxsIHNlbmQgeW91IGEgbmV3IHZlcnNpb24uDQoNClRoeCwNCg0KQmlj
aApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
