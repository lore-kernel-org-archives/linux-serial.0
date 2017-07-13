From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 0/9] Add support for STM32H7 serial
Date: Thu, 13 Jul 2017 15:08:26 +0000
Message-ID: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <F7E7299FAAADD944BEC37A00927B1F51@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

VGhpcyBwYXRjaHNldCB1cGRhdGVzIGV4aXN0aW5nIHN0bTMyIHVzYXJ0IGRyaXZlcjoNCi0gTWlz
YyBmaXhlczogY29weXJpZ2h0LCBtdXRsaXBvcnQgbWFuYWdlbWVudCBhbmQgdGltZW91dCBpc3N1
ZQ0KLSBBZGQgc3VwcG9ydCBmb3IgU1RNMzJINw0KLSBBZGQgc3VwcG9ydCBmb3Igd2FrZS11cCBh
bmQgZmlmbyBtYW5hZ2VtZW50IChmb3IgU1RNMzJINykNCg0KQmljaCBIZW1vbiAoMik6DQogIHNl
cmlhbDogc3RtMzI6IGZpeCBjb3B5cmlnaHQNCiAgc2VyaWFsOiBzdG0zMjogYWRkIFJUUyBzdXBw
b3J0DQoNCkZhYnJpY2UgR2FzbmllciAoMyk6DQogIHNlcmlhbDogc3RtMzI6IGZpeCBlcnJvciBo
YW5kbGluZyBpbiBwcm9iZQ0KICBkdC1iaW5kaW5nczogc2VyaWFsOiBhZGQgY29tcGF0aWJsZSBm
b3Igc3RtMzJoNw0KICBzZXJpYWw6IHN0bTMyOiBhZGQgd2FrZXVwIG1lY2hhbmlzbQ0KDQpHZXJh
bGQgQmFlemEgKDQpOg0KICBzZXJpYWw6IHN0bTMyOiBmaXggbXVsdGktcG9ydHMgbWFuYWdlbWVu
dA0KICBzZXJpYWw6IHN0bTMyOiBJbmNyZWFzZSBtYXhpbXVtIG51bWJlciBvZiBwb3J0cw0KICBz
ZXJpYWw6IHN0bTMyOiBmaXggcGlvIHRyYW5zbWl0IHRpbWVvdXQNCiAgc2VyaWFsOiBzdG0zMjog
YWRkIGZpZm8gc3VwcG9ydA0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3N0LHN0
bTMyLXVzYXJ0LnR4dCAgfCAgMTcgKystDQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0
LmMgICAgICAgICAgICAgICAgICAgfCAxMjMgKysrKysrKysrKysrKysrKysrKy0tDQogZHJpdmVy
cy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmggICAgICAgICAgICAgICAgICAgfCAgMzcgKysrKysr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTYyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K
DQotLSANCjEuOS4xDQo=
