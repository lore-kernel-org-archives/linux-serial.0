From: =?utf-8?B?546LIOaWh+a2mw==?= <wwthappy@hotmail.com>
Subject: [PATCH] Disable kgdboc failed by echo space to
 /sys/module/kgdboc/parameters/kgdboc
Date: Wed, 20 Mar 2019 15:30:39 +0000
Message-ID: <KU1PR03MB2824C0511DA1CD5025CC47DECB410@KU1PR03MB2824.apcprd03.prod.outlook.com>
References: <HK0PR03MB2817154ABAB39937BFF0AB9BCB4D0@HK0PR03MB2817.apcprd03.prod.outlook.com>
 <20190319142306.GA13458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <20190319142306.GA13458@kroah.com>
Content-Language: en-US
Content-ID: <CD9028FF3E7BA34AAED70299768A6BB8@apcprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: linux-serial@vger.kernel.org

RnJvbTogV2VudGFvIFdhbmcgPHdpdGFsbHdhbmdAZ21haWwuY29tPg0KDQpFY2hvICIiIHRvIC9z
eXMvbW9kdWxlL2tnZGJvYy9wYXJhbWV0ZXJzL2tnZGJvYyB3aWxsIGZhaWwgd2l0aCAiTm8gc3Vj
aCBkZXZpY2XigJ0gZXJyb3IuDQoNClRoaXMgaXMgY2F1c2VkIGJ5IGZ1bmN0aW9uICJjb25maWd1
cmVfa2dkYm9jIiB3aG8gaW5pdCBlcnIgdG8gRU5PREVWIHdoZW4gdGhlIGNvbmZpZw0KaXMgZW1w
dHkgKGxlZ2FsIGlucHV0KSB0aGUgY29kZSBnbyBvdXQgd2l0aCBFTk9ERVYgcmV0dXJuZWQuDQoN
CkZpeGVzOiAyZGQ0NTMxNjg2NDNkICgia2dkYm9jOiBGaXggcmVzdHJpY3QgZXJyb3IiKQ0KDQpT
aWduZWQtb2ZmLWJ5OiBXZW50YW8gV2FuZyA8d2l0YWxsd2FuZ0BnbWFpbC5jb20+DQotLS0NCiBk
cml2ZXJzL3R0eS9zZXJpYWwva2dkYm9jLmMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwva2dkYm9jLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwva2dkYm9jLmMNCmluZGV4IDZmYjMx
MmUuLmJmZTVlOWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwva2dkYm9jLmMNCisr
KyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYw0KQEAgLTE0OCw4ICsxNDgsMTAgQEAgc3Rh
dGljIGludCBjb25maWd1cmVfa2dkYm9jKHZvaWQpDQogCWNoYXIgKmNwdHIgPSBjb25maWc7DQog
CXN0cnVjdCBjb25zb2xlICpjb25zOw0KIA0KLQlpZiAoIXN0cmxlbihjb25maWcpIHx8IGlzc3Bh
Y2UoY29uZmlnWzBdKSkNCisJaWYgKCFzdHJsZW4oY29uZmlnKSB8fCBpc3NwYWNlKGNvbmZpZ1sw
XSkpIHsNCisJCWVyciA9IDA7DQogCQlnb3RvIG5vY29uZmlnOw0KKwl9DQogDQogCWtnZGJvY19p
b19vcHMuaXNfY29uc29sZSA9IDA7DQogCWtnZGJfdHR5X2RyaXZlciA9IE5VTEw7DQotLSANCjIu
Ny40DQoNCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpL
Z2RiLWJ1Z3JlcG9ydCBtYWlsaW5nIGxpc3QKS2dkYi1idWdyZXBvcnRAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2tnZGIt
YnVncmVwb3J0Cg==
