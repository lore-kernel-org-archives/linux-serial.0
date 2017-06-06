From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v4 08/28] dt-bindings: serial: Document Actions Semi Owl UARTs
Date: Tue,  6 Jun 2017 02:54:06 +0200
Message-ID: <20170606005426.26446-9-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, support@lemaker.org, =?UTF-8?q?=E5=BC=A0=E5=A4=A9=E7=9B=8A?= <tyzhang@actions-semi.com>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 96boards@ucrobotics.com, linux-kernel@vger.kernel.org, Thomas Liau <thomas.liau@actions-semi.com>, Rob Herring <robh+dt@kernel.org>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, =?UTF-8?q?=E5=88=98=E7=82=9C?= <liuwei@actions-semi.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?=E5=BC=A0=E4=B8=9C=E9=A3=8E?= <zhangdf@actions-semi.com>
List-Id: linux-serial@vger.kernel.org

VGhpcyBVQVJUIGlzIGZvdW5kIG9uIFM1MDAgYW5kIFM5MDAgU29Dcy4KCkFja2VkLWJ5OiBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIg
PGFmYWVyYmVyQHN1c2UuZGU+Ci0tLQogdjMgLT4gdjQ6IFVuY2hhbmdlZAogCiB2MiAtPiB2Mzog
dW5jaGFuZ2VkCiAKIHYxIC0+IHYyOgogKiBBZG9wdGVkICJhY3Rpb25zIiB2ZW5kb3IgcHJlZml4
CiAKIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hY3Rpb25zLG93bC11YXJ0LnR4dCAg
ICAgIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c2VyaWFsL2FjdGlvbnMsb3dsLXVhcnQudHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hY3Rpb25zLG93bC11YXJ0LnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYWN0aW9ucyxvd2wtdWFydC50eHQKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5hYTg3M2VhZGEwMmQKLS0tIC9k
ZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2Fj
dGlvbnMsb3dsLXVhcnQudHh0CkBAIC0wLDAgKzEsMTYgQEAKK0FjdGlvbnMgU2VtaSBPd2wgVUFS
VAorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21wYXRpYmxlIDogICJhY3Rpb25zLHM1MDAt
dWFydCIsICJhY3Rpb25zLG93bC11YXJ0IiBmb3IgUzUwMAorICAgICAgICAgICAgICAgICJhY3Rp
b25zLHM5MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0IiBmb3IgUzkwMAorLSByZWcgICAgICAg
IDogIE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQgZm9yIHRoZSBkZXZpY2Uu
CistIGludGVycnVwdHMgOiAgU2hvdWxkIGNvbnRhaW4gVUFSVCBpbnRlcnJ1cHQuCisKKworRXhh
bXBsZToKKworCQl1YXJ0Mzogc2VyaWFsQGIwMTI2MDAwIHsKKwkJCWNvbXBhdGlibGUgPSAiYWN0
aW9ucyxzNTAwLXVhcnQiLCAiYWN0aW9ucyxvd2wtdWFydCI7CisJCQlyZWcgPSA8MHhiMDEyNjAw
MCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+OworCQl9OwotLSAKMi4xMi4zCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
