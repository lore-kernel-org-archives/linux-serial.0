From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] serial: stm32: fix pio transmit timeout
Date: Mon, 31 Jul 2017 09:31:52 +0000
Message-ID: <1501493505-27933-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
Content-ID: <1B00007B14299642A25194DAEE2F7969@st.com>
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

RnJvbTogR2VyYWxkIEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0KDQoxMDDCtXMgd2FzIHRv
byBzaG9ydCBmb3IgbG93IHNwZWVkIHRyYW5zbWlzc2lvbg0KKDk2MDBicHMpDQoNClNpZ25lZC1v
ZmYtYnk6IEdlcmFsZCBCYWV6YSA8Z2VyYWxkLmJhZXphQHN0LmNvbT4NClNpZ25lZC1vZmYtYnk6
IEJpY2ggSGVtb24gPGJpY2guaGVtb25Ac3QuY29tPg0KLS0tDQogZHJpdmVycy90dHkvc2VyaWFs
L3N0bTMyLXVzYXJ0LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNh
cnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQppbmRleCA3MmMwZWMxLi5i
MTZlN2U3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMNCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQpAQCAtMjAzLDcgKzIwMyw3IEBA
IHN0YXRpYyB2b2lkIHN0bTMyX3RyYW5zbWl0X2NoYXJzX3BpbyhzdHJ1Y3QgdWFydF9wb3J0ICpw
b3J0KQ0KIAlyZXQgPSByZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dF9hdG9taWMocG9ydC0+bWVt
YmFzZSArIG9mcy0+aXNyLA0KIAkJCQkJCWlzciwNCiAJCQkJCQkoaXNyICYgVVNBUlRfU1JfVFhF
KSwNCi0JCQkJCQkxMCwgMTAwKTsNCisJCQkJCQkxMCwgMTAwMDAwKTsNCiANCiAJaWYgKHJldCkN
CiAJCWRldl9lcnIocG9ydC0+ZGV2LCAidHggZW1wdHkgbm90IHNldFxuIik7DQotLSANCjEuOS4x
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
