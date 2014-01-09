From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
Date: Thu, 9 Jan 2014 11:58:25 +0100
Message-ID: <201401091158.25902.arnd@arndb.de>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
 <20140109103515.164af26c@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140109103515.164af26c@ipc1.ka-ro>
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
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, Yuan Yao <yao.yuan@freescale.com>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, Lothar =?utf-8?q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-serial@vger.kernel.org

T24gVGh1cnNkYXkgMDkgSmFudWFyeSAyMDE0LCBMb3RoYXIgV2HDn21hbm4gd3JvdGU6Cj4gPiAr
c3RhdGljIGludCBscHVhcnRfZG1hX3J4KHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpCj4gPiAr
ewo+ID4gKyAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2Uoc3BvcnQtPnBvcnQuZGV2LCBz
cG9ydC0+ZG1hX3J4X2J1Zl9idXMsCj4gPiArICAgICAgICAgICAgICAgICAgICAgRE1BX1JYX0JV
RkZFUl9TSVpFLCBETUFfVE9fREVWSUNFKTsKPiA+Cj4gZG1hX2FsbG9jX2NvaGVyZW50KCkgKHdo
aWNoIHlvdSB1c2UgdG8gYWxsb2NhdGUgdGhlIERNQSByeCBidWZmZXIpIGFuZAo+IGRtYV9zeW1j
XyooKSBhcmUgb3J0aG9nb25hbCB0byBlYWNoIG90aGVyIQo+IFlvdSBlaXRoZXIgYWxsb2NhdGUg
RE1BIGNvaGVyZW50IG1lbW9yeSBhcyBETUEgYnVmZmVyIG9yIHVzZSBvcmRpbmFyeQo+IG1lbW9y
eSB3aXRoIHRoZSBETUEgc3RyZWFtaW5nIEFQSSAoZG1hX21hcF8qKCksIGRtYV9zeW5jXyooKSku
Cj4gU2VlIERvY3VtZW50YXRpb24vRE1BLUFQSS1IT1dUTy50eHQKCldlbGwgc3BvdHRlZCwgaXQg
dG9vayBtZSBhIHdoaWxlIHRvIGZpZ3VyZSBvdXQgd2hhdCB0aGUgZHJpdmVyIGFjdHVhbGx5CmRv
ZXMgbWl4aW5nIHRoZXNlIHR3by4gQXBwYXJlbnRseSB0aGUgdHggcGF0aCBpcyB1c2luZyB0aGUg
c3RyZWFtaW5nCkRNQSBBUEksIHdoaWxlIHRoZSByeCBwYXRoIHVzZXMgdGhlIGNvbnNpc3RlbnQg
QVBJLgoKSSB0aGluayB0aGUgZHJpdmVyIHNob3VsZCByZWFsbHkgdXNlIHRoZSBzYW1lIEFQSSBi
b3RoIHdheXMsIGFuZCBpdApkZXBlbmRzIG9uIHRoZSBhbW91bnQgb2YgZGF0YSB0cmFuc2ZlcnJl
ZCB3aXRoIGVhY2ggRE1BIHdoaWNoIEFQSQpmaXRzIGJldHRlci4gSSdkIHNheSB0aGF0IGlmIHR5
cGljYWwgdHJhbnNmZXIgaXMganVzdCBhIGZldyBkb3plbgpieXRlcyBhdCBtb3N0LCBpdCBzaG91
bGQgcGVyZm9ybSBiZXR0ZXIgaWYgeW91IHVzZSB0aGUgY29uc2lzdGVudCBBUEkKd2l0aCB1bmNh
Y2hlYWJsZSBtZW1vcnkgYnVmZmVycywgYmVjYXVzZSBpdCB3b24ndCBoYXZlIHRoZSBvdmVyaGVh
ZApmcm9tIHRoZSBjYWNoZSBmbHVzaGVzLiBJZiB5b3Ugb2Z0ZW4gdHJhbnNmZXIga2lsb2J5dGVz
IGF0IG9uY2UsCnRoZSBzdHJlYW1pbmcgQVBJIHdvdWxkIGJlIGZhc3RlciBiZWNhdXNlIGl0IGF2
b2lkcyB1bmNhY2hlZCBtZW1vcnkKYWNjZXNzZXMuCgoJQXJuZAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
