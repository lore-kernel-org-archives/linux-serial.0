From: Wolfgang Ocker <weo@reccoware.de>
Subject: [PATCH] mxs-auart: count FIFO overrun errors
Date: Tue, 15 Nov 2016 12:05:29 +0100
Message-ID: <1479207929.4985.25.camel@reccoware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

VGhlIG14cy1hdWFydCBkcml2ZXIgZG9lcyBub3QgY291bnQgRklGTyBvdmVycnVuIGVycm9ycy4g
VGhlc2UgZXJyb3JzIG5ldmVyCmFwcGVhciBpbiAvcHJvYy90dHkvZHJpdmVyL3R0eUFQUC4gVGhp
cyBpcyBiZWNhdXNlIHRoZSBPRVJSIHN0YXR1cyBiaXQgaXMKbWFza2VkIGJ5IHJlYWRfc3RhdHVz
X21hc2sgaW4gdGhlIHJ4IGludGVycnVwdCBmdW5jdGlvbiwgYnV0IHRoZQpBVUFSVF9TVEFUX09F
UlIgYml0IGlzIG5ldmVyIHNldCBpbiByZWFkX3N0YXR1c19tYXNrLiBUaGUgcGF0Y2ggZW5hYmxl
cyB0aGUKY291bnRpbmcgb2Ygb3ZlcnJ1biBlcnJvcnMuCgpTaWduZWQtb2ZmLWJ5OiBXb2xmZ2Fu
ZyBPY2tlciA8d2VvQHJlY2Nvd2FyZS5kZT4KLS0tCsKgZHJpdmVycy90dHkvc2VyaWFsL214cy1h
dWFydC5jIHwgMiArLQrCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9teHMtYXVhcnQuYyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9teHMtYXVhcnQuYwppbmRleCA3NzA0NTRlMGRmYTMuLjhjMWM5MTEyYjNm
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL214cy1hdWFydC5jCisrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9teHMtYXVhcnQuYwpAQCAtMTAxNiw3ICsxMDE2LDcgQEAgc3RhdGljIHZv
aWQgbXhzX2F1YXJ0X3NldHRlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqdSwKwqAJCQljdHJsIHw9
IEFVQVJUX0xJTkVDVFJMX0VQUzsKwqAJfQrCoAotCXUtPnJlYWRfc3RhdHVzX21hc2sgPSAwOwor
CXUtPnJlYWRfc3RhdHVzX21hc2sgPSBBVUFSVF9TVEFUX09FUlI7CsKgCsKgCWlmICh0ZXJtaW9z
LT5jX2lmbGFnICYgSU5QQ0spCsKgCQl1LT5yZWFkX3N0YXR1c19tYXNrIHw9IEFVQVJUX1NUQVRf
UEVSUjsKLS3CoAoyLjEwLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
