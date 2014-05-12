From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 07:45:56 +0200
Message-ID: <53706014.8010203@de.bosch.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <537042B5.2040600@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <b32955@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "dean_jenkins@mentor.com" <dean_jenkins@mentor.com>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gMTIuMDUuMjAxNCAwNTo0MCwgSHVhbmcgU2hpamllIHdyb3RlOgo+IOS6jiAyMDE05bm0MDXm
nIgwOeaXpSAyMzoxOSwgZGVhbl9qZW5raW5zQG1lbnRvci5jb20g5YaZ6YGTOgo+PiBVc2UgaW14
X3N0YXJ0X3R4KCkganVzdCB0byBlbmFibGUgdGhlIFRYIGludGVycnVwdC4gSXQncyB0aGUgam9i
IG9mIHRoZQo+PiBUWCBpbnRlcnJ1cHQgSVNSIHRvIGZpbGwgdGhlIHRyYW5zbWl0IGJ1ZmZlciwg
dGhlbi4gSWYgdGhlIHRyYW5zbWl0IGJ1ZmZlcgo+PiBpcyBlbXB0eSwgdGhlIFRYIGludGVycnVw
dCBzaG91bGQgYmUgZXhlY3V0ZWQgYXMgc29vbiBhcyB0aGUgc3RhcnRfdHgoKQo+PiBlbmFibGVz
IHRoZSBpbnRlcnJ1cHQsIHNvIHRoZXJlIGlzIG5vIHJlYXNvbiBmb3IgdGhlIGV4dHJhCj4+IGlt
eF90cmFuc21pdF9idWZmZXIoKSBjYWxsLCBoZXJlLiBSZW1vdmUgaXQuCj4gSSBkb24ndCBrbm93
IHdoeSB0aGlzIHBhdGNoIG5lZWRlZD8KPiBXaGF0IHByb2JsZW0gdGhpcyBwYXRjaCBmaXggb3Ig
aW1wcm92ZT8KCkFzIHN0YXRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoZSBjYWxsIG9mIGlt
eF90cmFuc21pdF9idWZmZXIoKSBpc24ndCAKbmVlZGVkIHRoZXJlLCBzbyBpdCBjYW4gYmUgcmVt
b3ZlZC4gSS5lLiByZW1vdmUgdW5uZWVkZWQgY29kZS4KCkluIHRoZSBlbmQsIHRoaXMgY2xlYW5z
IHVwIHRoZSBwb3NzaWJsZSBsb2NraW5nIHBhdGgsIHNvIHRoYXQgaW4gdGhlIAp0aGlyZCBwYXRj
aCB0aGUgbG9ja2luZyBpc3N1ZSBjYW4gYmUgZWFzaWx5IGZpeGVkLgoKQmVzdCByZWdhcmRzCgpE
aXJrCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
