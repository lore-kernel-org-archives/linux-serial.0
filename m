From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST v4 1/2] Revert "serial/amba-pl011: Leave the TX IRQ
 alone when the UART is not open"
Date: Wed,  1 Apr 2015 12:09:44 +0100
Message-ID: <1427886584-8680-1-git-send-email-Dave.Martin@arm.com>
References: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBmMmVlNmRmYTBlODU5N2VlYThiOThkMjQwYjAwMzM5OTRlMjBk
MjE1LgoKSmFrdWIgS2ljacWEc2tpIG9ic2VydmVkIHRoYXQgdGhpcyBwYXRjaCBjYW4gY2F1c2Ug
dGhlIHBsMDExCmRyaXZlciB0byBoYW5nIGlmIGlmIHRoZSBvbmx5IHByb2Nlc3Mgd2l0aCBhIHBs
MDExIHBvcnQgb3BlbiBpcwpraWxsZWQgYnkgYSBzaWduYWwsIHBsMDExX3NodXRkb3duKCkgY2Fu
IGdldCBjYWxsZWQgd2l0aCBhbgphcmJpdHJhcnkgYW1vdW50IG9mIGRhdGEgc3RpbGwgaW4gdGhl
IEZJRk8uCgpDYWxsaW5nIF9zaHV0ZG93bigpIHdpdGggdGhlIFRYIEZJRk8gbm9uLWVtcHR5IGlz
IHF1ZXN0aW9uYWJsZQpiZWhhdmlvdXIgYW5kIG15IGl0c2VsZiBiZSBhIGJ1Zy4KClNpbmNlIHRo
ZSBhZmZlY3RlZCBwYXRjaCB3YXMgc3BlY3VsYXRpdmUgYW55d2F5LCBhbmQgYnJpbmdzIGxpbWl0
ZWQKYmVuZWZpdCwgdGhlIHNpbXBsZXN0IGNvdXJzZSBpcyB0byByZW1vdmUgdGhlIGFzc3VtcHRp
b24gdGhhdCBUWElTCndpbGwgYWx3YXlzIGJlIGxlZnQgYXNzZXJ0ZWQgYWZ0ZXIgdGhlIHBvcnQg
aXMgc2h1dCBkb3duLgoKU2lnbmVkLW9mZi1ieTogRGF2ZSBNYXJ0aW4gPERhdmUuTWFydGluQGFy
bS5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyB8ICAgIDUgKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L2FtYmEtcGwwMTEuYwppbmRleCA1YTRlOWQ1Li42ZjVhMDcyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBs
MDExLmMKQEAgLTE2MzksNiArMTYzOSw5IEBAIHN0YXRpYyBpbnQgcGwwMTFfc3RhcnR1cChzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0KQogCiAJd3JpdGV3KHVhcC0+dmVuZG9yLT5pZmxzLCB1YXAtPnBv
cnQubWVtYmFzZSArIFVBUlQwMTFfSUZMUyk7CiAKKwkvKiBBc3N1bWUgdGhhdCBUWCBJUlEgZG9l
c24ndCB3b3JrIHVudGlsIHdlIHNlZSBvbmU6ICovCisJdWFwLT50eF9pcnFfc2VlbiA9IDA7CisK
IAlzcGluX2xvY2tfaXJxKCZ1YXAtPnBvcnQubG9jayk7CiAKIAkvKiByZXN0b3JlIFJUUyBhbmQg
RFRSICovCkBAIC0xNzAyLDcgKzE3MDUsNyBAQCBzdGF0aWMgdm9pZCBwbDAxMV9zaHV0ZG93bihz
dHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogCXNwaW5fbG9ja19pcnEoJnVhcC0+cG9ydC5sb2NrKTsK
IAl1YXAtPmltID0gMDsKIAl3cml0ZXcodWFwLT5pbSwgdWFwLT5wb3J0Lm1lbWJhc2UgKyBVQVJU
MDExX0lNU0MpOwotCXdyaXRldygweGZmZmYgJiB+VUFSVDAxMV9UWElTLCB1YXAtPnBvcnQubWVt
YmFzZSArIFVBUlQwMTFfSUNSKTsKKwl3cml0ZXcoMHhmZmZmLCB1YXAtPnBvcnQubWVtYmFzZSAr
IFVBUlQwMTFfSUNSKTsKIAlzcGluX3VubG9ja19pcnEoJnVhcC0+cG9ydC5sb2NrKTsKIAogCXBs
MDExX2RtYV9zaHV0ZG93bih1YXApOwotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
