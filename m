From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v3 08/25] dt-bindings: serial: Document Actions Semi Owl UARTs
Date: Tue, 28 Feb 2017 07:35:18 +0100
Message-ID: <20170228063535.32069-9-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, support@lemaker.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, 96boards@ucrobotics.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

VGhpcyBVQVJUIGlzIGZvdW5kIG9uIFM1MDAgYW5kIFM5MDAgU29Dcy4KCkFja2VkLWJ5OiBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIg
PGFmYWVyYmVyQHN1c2UuZGU+Ci0tLQogdjIgLT4gdjM6IHVuY2hhbmdlZAogCiB2MSAtPiB2MjoK
ICogQWRvcHRlZCAiYWN0aW9ucyIgdmVuZG9yIHByZWZpeAogCiAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9zZXJpYWwvYWN0aW9ucyxvd2wtdWFydC50eHQgICAgICB8IDE2ICsrKysrKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hY3Rpb25zLG93bC11YXJ0
LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJp
YWwvYWN0aW9ucyxvd2wtdWFydC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc2VyaWFsL2FjdGlvbnMsb3dsLXVhcnQudHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAuLmFhODczZWEKLS0tIC9kZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2FjdGlvbnMsb3dsLXVhcnQudHh0CkBAIC0wLDAgKzEsMTYg
QEAKK0FjdGlvbnMgU2VtaSBPd2wgVUFSVAorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21w
YXRpYmxlIDogICJhY3Rpb25zLHM1MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0IiBmb3IgUzUw
MAorICAgICAgICAgICAgICAgICJhY3Rpb25zLHM5MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0
IiBmb3IgUzkwMAorLSByZWcgICAgICAgIDogIE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSByZWdp
c3RlciBzZXQgZm9yIHRoZSBkZXZpY2UuCistIGludGVycnVwdHMgOiAgU2hvdWxkIGNvbnRhaW4g
VUFSVCBpbnRlcnJ1cHQuCisKKworRXhhbXBsZToKKworCQl1YXJ0Mzogc2VyaWFsQGIwMTI2MDAw
IHsKKwkJCWNvbXBhdGlibGUgPSAiYWN0aW9ucyxzNTAwLXVhcnQiLCAiYWN0aW9ucyxvd2wtdWFy
dCI7CisJCQlyZWcgPSA8MHhiMDEyNjAwMCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDMyIElSUV9UWVBFX0xFVkVMX0hJR0g+OworCQl9OwotLSAKMi4xMC4yCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
