From: y@pengutronix.de
Subject: [PATCH 02/11] serial/imx: make imx_port.devdata member point to const
 data
Date: Fri, 13 Jul 2012 14:32:05 +0200
Message-ID: <47197.8760826916$1342183078@news.gmane.org>
References: <1342182734-321-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1342182734-321-1-git-send-email-y>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, kernel@pengutronix.de, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClRoaXMgcHJlcGFyZXMgb2ZfZGV2aWNlX2lkLmRhdGEgYmVjb21pbmcgY29uc3QuIFdpdGhvdXQg
dGhpcyBjaGFuZ2UgdGhlCmZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIG9jY3VyOgoKCWRyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYzogSW4gZnVuY3Rpb24gJ3NlcmlhbF9pbXhfcHJvYmVfZHQnOgoJZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jOjE0MzA6MTc6IHdhcm5pbmc6IGFzc2lnbm1lbnQgZGlzY2Fy
ZHMgJ2NvbnN0JyBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFtlbmFibGVkIGJ5
IGRlZmF1bHRdCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpDYzogQWxhbiBDb3ggPGFsYW5AbGludXguaW50ZWwuY29tPgpD
YzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IGxp
bnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMg
fCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvaW14LmMKaW5kZXggNGVmNzQ3My4uMGFmNGVlYyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMjA3LDcgKzIw
Nyw3IEBAIHN0cnVjdCBpbXhfcG9ydCB7CiAJdW5zaWduZWQgc2hvcnQJCXRyY3ZfZGVsYXk7IC8q
IHRyYW5zY2VpdmVyIGRlbGF5ICovCiAJc3RydWN0IGNsawkJKmNsa19pcGc7CiAJc3RydWN0IGNs
awkJKmNsa19wZXI7Ci0Jc3RydWN0IGlteF91YXJ0X2RhdGEJKmRldmRhdGE7CisJY29uc3Qgc3Ry
dWN0IGlteF91YXJ0X2RhdGEgKmRldmRhdGE7CiB9OwogCiBzdHJ1Y3QgaW14X3BvcnRfdWNycyB7
Ci0tIAoxLjcuMTAuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
