From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] serial: sa1100: add note about modem control signals
Date: Fri, 31 May 2019 16:24:04 +0100
Message-ID: <E1hWjO0-00087g-7y@rmk-PC.armlinux.org.uk>
References: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531151032.tfrl7yqph6wsg5pl@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe=20Kleine=2DK=C3=83=C2=B6nig=20=3Cu=2E?=
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

QXMgc3VnZ2VzdGVkIGJ5IFV3ZSwgYWRkIGEgbm90ZSBpbmRpY2F0aW5nIHRoYXQgdGhlIG1vZGVt
IGNvbnRyb2wKc2lnbmFscyBkbyBub3Qgc3VwcG9ydCBpbnRlcnJ1cHRzLCB3aGljaCBwcmVjbHVk
ZXMgdGhlIGRyaXZlciBmcm9tCnVzaW5nIG1jdHJsX2dwaW9faW5pdCgpLgoKU3VnZ2VzdGVkLWJ5
OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPgotLS0K
ClV3ZSwgc29tZXRoaW5nIGxpa2UgdGhpcz8KCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2ExMTAwLmMg
fCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYwpp
bmRleCBhNmI0MzA5YjYyZmMuLmQ3ZGJmMDU3NmJlOCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL3NhMTEwMC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zYTExMDAuYwpAQCAtOTQ5
LDYgKzk0OSw5IEBAIHN0YXRpYyBpbnQgc2ExMTAwX3NlcmlhbF9yZXN1bWUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqZGV2KQogc3RhdGljIGludCBzYTExMDBfc2VyaWFsX2FkZF9vbmVfcG9ydChz
dHJ1Y3Qgc2ExMTAwX3BvcnQgKnNwb3J0LCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiB7
CiAJc3BvcnQtPnBvcnQuZGV2ID0gJmRldi0+ZGV2OworCisJLy8gR1BJTyBkcml2ZXIgZG9lcyBu
b3Qgc3VwcG9ydCBpbnRlcnJ1cHRzIGZvciB0aGVzZSBtb2RlbQorCS8vIGNvbnRyb2wgc2lnbmFs
cywgc28gdGhlIHNlcmlhbCBkcml2ZXIgcG9sbHMgdGhlbS4KIAlzcG9ydC0+Z3Bpb3MgPSBtY3Ry
bF9ncGlvX2luaXRfbm9hdXRvKHNwb3J0LT5wb3J0LmRldiwgMCk7CiAJaWYgKElTX0VSUihzcG9y
dC0+Z3Bpb3MpKSB7CiAJCWludCBlcnIgPSBQVFJfRVJSKHNwb3J0LT5ncGlvcyk7Ci0tIAoyLjcu
NAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
