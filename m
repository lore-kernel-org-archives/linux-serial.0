From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 06/20] serial: stm32: fix pio transmit timeout
Date: Mon, 26 Jun 2017 12:49:11 +0000
Message-ID: <1498481318-1894-7-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Content-ID: <CD0DCE9DCE188346A1392D4B8CFA4885@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogQmljaCBIZW1vbiA8YmljaC5oZW1vbkBzdC5jb20+DQoNCjEwMMK1cyB3YXMgdG9vIHNo
b3J0IGZvciBsb3cgc3BlZWQgdHJhbnNtaXNzaW9uDQooOTYwMGJwcykNCg0KU2lnbmVkLW9mZi1i
eTogR2VyYWxkIEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0KLS0tDQogZHJpdmVycy90dHkv
c2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3Rt
MzItdXNhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQppbmRleCAzY2Uw
ZjdhLi43OWFjMTY3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0
LmMNCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQpAQCAtMjQ3LDcgKzI0
Nyw3IEBAIHN0YXRpYyB2b2lkIHN0bTMyX3RyYW5zbWl0X2NoYXJzX3BpbyhzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KQ0KIAlyZXQgPSByZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dF9hdG9taWMocG9y
dC0+bWVtYmFzZSArIG9mcy0+aXNyLA0KIAkJCQkJCWlzciwNCiAJCQkJCQkoaXNyICYgVVNBUlRf
U1JfVFhFKSwNCi0JCQkJCQkxMCwgMTAwKTsNCisJCQkJCQkxMCwgMTAwMDAwKTsNCiANCiAJaWYg
KHJldCkNCiAJCWRldl9lcnIocG9ydC0+ZGV2LCAidHggZW1wdHkgbm90IHNldFxuIik7DQotLSAN
CjEuOS4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
