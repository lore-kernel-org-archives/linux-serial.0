From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
Date: Fri, 30 Jun 2017 14:13:29 +0200
Message-ID: <20170630141329.6144cddd@karo-electronics.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170630120446.13994-4-romain.perier@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

SGksCgpPbiBGcmksIDMwIEp1biAyMDE3IDE0OjA0OjQyICswMjAwIFJvbWFpbiBQZXJpZXIgd3Jv
dGU6Cj4gRnJvbTogTmFuZG9yIEhhbiA8bmFuZG9yLmhhbkBnZS5jb20+Cj4gCj4gSW5pdGlhbGl6
ZSBib3RoIGRtYV9pc197cnh8dHh9aW5nIHZhcmlhYmxlcyB3aGVuIERNQSBpcyBlbmFibGVkIHRv
IGF2b2lkCj4gY2hlY2tpbmcgdW5pbml0aWFsaXplZCB2YXJpYWJsZXMgaWYgcG9ydCBzaHV0ZG93
biBpcyByZXF1ZXN0ZWQgYmVmb3JlCj4gRE1BIGNoYW5uZWxzIGdldCBhIGNoYW5jZSB0byBzdGFy
dC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYW5kb3IgSGFuIDxuYW5kb3IuaGFuQGdlLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBSb21haW4gUGVyaWVyIDxyb21haW4ucGVyaWVyQGNvbGxhYm9yYS5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyB8IDMgKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCj4gaW5kZXggMTg4MDYzZC4uODFmYjQx
MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKPiArKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMKPiBAQCAtMTIyNSw2ICsxMjI1LDkgQEAgc3RhdGljIHZvaWQgaW14
X2VuYWJsZV9kbWEoc3RydWN0IGlteF9wb3J0ICpzcG9ydCkKPiAgCj4gIAlpbXhfc2V0dXBfdWZj
cihzcG9ydCwgVFhUTF9ETUEsIFJYVExfRE1BKTsKPiAgCj4gKwlzcG9ydC0+ZG1hX2lzX3J4aW5n
ID0gMDsKPiArCXNwb3J0LT5kbWFfaXNfdHhpbmcgPSAwOwo+ICsKPiAgCXNwb3J0LT5kbWFfaXNf
ZW5hYmxlZCA9IDE7Cj4gIH0KPiAgCnNwb3J0IGlzIGRldm1fa3phbGxvYygpZWQsIHNvIHRoZSB2
YXJpYWJsZXMgYXJlIGluaXRpYWxpemVkIHRvIDAgYW55d2F5LgoKCkxvdGhhciBXYcOfbWFubgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
