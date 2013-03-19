From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/7] ARM: sunxi: dt: Use clocks property instead of
 clock-frequency for the UARTs
Date: Tue, 19 Mar 2013 11:35:11 +0100
Message-ID: <1363689316-7847-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sunny@allwinnertech.com, shuge@allwinnertech.com, kevin@allwinnertech.com
List-Id: linux-serial@vger.kernel.org

SXQgd2lsbCBiZSBlc3BlY2lhbGx5IHVzZWZ1bCB3aGVuIHdlIHdpbGwgaGF2ZSB0aGUgY2xvY2sg
ZGVmaW5pdGlvbnMgaW4KdGhlIGRldmljZSB0cmVlLgoKU2lnbmVkLW9mZi1ieTogTWF4aW1lIFJp
cGFyZCA8bWF4aW1lLnJpcGFyZEBmcmVlLWVsZWN0cm9ucy5jb20+CkFja2VkLWJ5OiBFbWlsaW8g
TMOzcGV6IDxlbWlsaW9AZWxvcGV6LmNvbS5hcj4KVGVzdGVkLWJ5OiBFbWlsaW8gTMOzcGV6IDxl
bWlsaW9AZWxvcGV6LmNvbS5hcj4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9zdW54aS5kdHNpIHwg
ICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N1bnhpLmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9zdW54aS5kdHNpCmluZGV4IDhiMzZhYmUuLjc5MWMwMmEgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3N1bnhpLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VueGku
ZHRzaQpAQCAtNjUsNyArNjUsNyBAQAogCQkJaW50ZXJydXB0cyA9IDwxPjsKIAkJCXJlZy1zaGlm
dCA9IDwyPjsKIAkJCXJlZy1pby13aWR0aCA9IDw0PjsKLQkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwy
NDAwMDAwMD47CisJCQljbG9ja3MgPSA8Jm9zYz47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwog
CQl9OwogCkBAIC03NSw3ICs3NSw3IEBACiAJCQlpbnRlcnJ1cHRzID0gPDI+OwogCQkJcmVnLXNo
aWZ0ID0gPDI+OwogCQkJcmVnLWlvLXdpZHRoID0gPDQ+OwotCQkJY2xvY2stZnJlcXVlbmN5ID0g
PDI0MDAwMDAwPjsKKwkJCWNsb2NrcyA9IDwmb3NjPjsKIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
CiAJCX07CiAJfTsKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
