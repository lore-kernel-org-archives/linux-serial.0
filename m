From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 4/9] serial: stm32: fix pio transmit timeout
Date: Thu, 13 Jul 2017 15:08:28 +0000
Message-ID: <1499958494-19354-5-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Content-ID: <177AD9F35409B74E8756A10148D9829A@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogR2VyYWxkIEJhZXphIDxnZXJhbGQuYmFlemFAc3QuY29tPg0KDQoxMDDCtXMgd2FzIHRv
byBzaG9ydCBmb3IgbG93IHNwZWVkIHRyYW5zbWlzc2lvbg0KKDk2MDBicHMpDQoNClNpZ25lZC1v
ZmYtYnk6IEdlcmFsZCBCYWV6YSA8Z2VyYWxkLmJhZXphQHN0LmNvbT4NClNpZ25lZC1vZmYtYnk6
IEJpY2ggSGVtb24gPGJpY2guaGVtb25Ac3QuY29tPg0KLS0tDQogZHJpdmVycy90dHkvc2VyaWFs
L3N0bTMyLXVzYXJ0LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNh
cnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQppbmRleCBhMTJkNzljLi5j
YTYxYmZlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMNCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jDQpAQCAtMjAyLDcgKzIwMiw3IEBA
IHN0YXRpYyB2b2lkIHN0bTMyX3RyYW5zbWl0X2NoYXJzX3BpbyhzdHJ1Y3QgdWFydF9wb3J0ICpw
b3J0KQ0KIAlyZXQgPSByZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dF9hdG9taWMocG9ydC0+bWVt
YmFzZSArIG9mcy0+aXNyLA0KIAkJCQkJCWlzciwNCiAJCQkJCQkoaXNyICYgVVNBUlRfU1JfVFhF
KSwNCi0JCQkJCQkxMCwgMTAwKTsNCisJCQkJCQkxMCwgMTAwMDAwKTsNCiANCiAJaWYgKHJldCkN
CiAJCWRldl9lcnIocG9ydC0+ZGV2LCAidHggZW1wdHkgbm90IHNldFxuIik7DQotLSANCjEuOS4x
DQo=
