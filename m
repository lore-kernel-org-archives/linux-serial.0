From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 1/3] serial: xuartps: Spliting the ISR into smaller
 routines.
Date: Fri, 20 Nov 2015 06:43:48 -0800
Message-ID: <20151120144348.GS32017@xsjsorenbubuntu>
References: <1448026478-22131-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1448026478-22131-1-git-send-email-navam@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Nava kishore Manne <navam@xilinx.com>, anirudh@xilinx.com, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gRnJpLCAyMDE1LTExLTIwIGF0IDA3OjA0UE0gKzA1MzAsIE5hdmEga2lzaG9yZSBNYW5uZSB3
cm90ZToKPiBCcmVha2luZyB0aGUgc2luZ2xlIGJpZyBJU1IgdGhhdCBoYXMgYm90aCBSeCBhbmQg
VHgKPiBpbiBhIHNpbmdsZSBmdW5jdGlvbiBpbnRvIHNtYWxsZXIgb25lcwo+IAo+IFNpZ25lZC1v
ZmYtYnk6IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT4KPiAtLS0KPiBDaGFu
Z2VzIGZvciB2MjoKPiAJLS1TcGxpdHMgdXAgdGhlIElTUiB3aXRob3V0IGFueSBmdW5jdGlvbmFs
IGNoYW5nZXMgYXMgc3VnZ2VzdGVkCj4gCWJ5IFBldGVyIEh1cmxleQo+IAo+ICBkcml2ZXJzL3R0
eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jIHwgMjQ3ICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzNSBpbnNlcnRpb25zKCspLCAxMTIgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFy
dHBzLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jCj4gaW5kZXggMDA5ZTBk
Yi4uMmUxYjBhOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRw
cy5jCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYwo+IEBAIC0xNzIs
NiArMTcyLDkgQEAgc3RydWN0IGNkbnNfdWFydCB7Cj4gICNkZWZpbmUgdG9fY2Ruc191YXJ0KF9u
YikgY29udGFpbmVyX29mKF9uYiwgc3RydWN0IGNkbnNfdWFydCwgXAo+ICAJCWNsa19yYXRlX2No
YW5nZV9uYik7Cj4gIAo+ICtzdGF0aWMgdm9pZCBjZG5zX3VhcnRfaGFuZGxlX3R4KHZvaWQgKmRl
dl9pZCk7Cj4gK3N0YXRpYyB2b2lkIGNkbnNfdWFydF9oYW5kbGVfcngodm9pZCAqZGV2X2lkLCB1
bnNpZ25lZCBpbnQgaXNyc3RhdHVzKTsKCkNhbid0IHlvdSBqdXN0IG1vdmUgdGhlc2UgZnVuY3Rp
b25zIGhlcmUgaW5zdGVhZCBvZiBhZGRpbmcgcHJvdG90eXBlcwpoZXJlPyBBbHNvLCB0aGlzIGlz
IGxpa2VseSB0byBjb25mbGljdCB3aXRoCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzExLzE5
LzYyMgoKCVPDtnJlbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
