From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2 04/11] tty: xuartps: Remove bogus comment and
 register write
Date: Fri, 7 Mar 2014 15:08:00 -0800
Message-ID: <e074f376-9565-422e-abee-fdaa031239a1@TX2EHSMHS043.ehs.local>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-5-git-send-email-soren.brinkmann@xilinx.com>
 <20140307212816.715e5e19@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140307212816.715e5e19@alan.etchedpixels.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gRnJpLCAyMDE0LTAzLTA3IGF0IDA5OjI4UE0gKzAwMDAsIE9uZSBUaG91c2FuZCBHbm9tZXMg
d3JvdGU6Cj4gT24gRnJpLCAgNyBNYXIgMjAxNCAxMToxMzoyNyAtMDgwMAo+IFNvcmVuIEJyaW5r
bWFubiA8c29yZW4uYnJpbmttYW5uQHhpbGlueC5jb20+IHdyb3RlOgo+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogU29yZW4gQnJpbmttYW5uIDxzb3Jlbi5icmlua21hbm5AeGlsaW54LmNvbT4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMgfCA2ICstLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jCj4gPiBpbmRleCBhNGJkNjI0MmU3MmQuLmEzOWMy
ZDI5MDkwMiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBz
LmMKPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMKPiA+IEBAIC0x
MDgyLDExICsxMDgyLDcgQEAgc3RhdGljIHZvaWQgeHVhcnRwc19jb25zb2xlX3dyaXRlKHN0cnVj
dCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqcywKPiA+ICAKPiA+ICAJeHVhcnRwc193cml0ZWwo
Y3RybCwgWFVBUlRQU19DUl9PRkZTRVQpOwo+ID4gIAo+ID4gLQkvKiByZXN0b3JlIGludGVycnVw
dCBzdGF0ZSwgaXQgc2VlbXMgbGlrZSB0aGVyZSBtYXkgYmUgYSBoL3cgYnVnCj4gPiAtCSAqIGlu
IHRoYXQgdGhlIGludGVycnVwdCBlbmFibGUgcmVnaXN0ZXIgc2hvdWxkIG5vdCBuZWVkIHRvIGJl
Cj4gPiAtCSAqIHdyaXR0ZW4gYmFzZWQgb24gdGhlIGRhdGEgc2hlZXQKPiA+IC0JICovCj4gPiAt
CXh1YXJ0cHNfd3JpdGVsKH5pbXIsIFhVQVJUUFNfSURSX09GRlNFVCk7Cj4gPiArCS8qIHJlc3Rv
cmUgaW50ZXJydXB0IHN0YXRlICovCj4gCj4gSXQgd291bGQgYmUgYXBwcm9wcmlhdGUgZm9yIHRo
ZSBjaGFuZ2Vsb2cgYXQgbGVhc3QgdG8gZXhwbGFpbiB3aHkgdGhlCj4gbm90ZSBhYm91dCB0aGUg
ZGF0YSBzaGVldCBkaWZmZXJpbmcgaXMgZ29pbmcgYXdheSAhCgpJIGRvbid0IGtub3cgd2h5IGFu
eWJvZHkgZXZlciB0aG91Z2h0IHRoaW5ncyBhcmUgYnJva2VuLiBJTUhPLCB0aGUKY29tbWVudCBk
b2VzIG5vdCBtYWtlIGFueSBzZW5zZS4gV2h5IHdvdWxkIGl0IG5vdCBiZSByZXF1aXJlZCB0byB3
cml0ZQp0aGUgZW5hYmxlIHJlZ2lzdGVyIHdoZW4geW91IGVuYWJsZSBpbnRlcnJ1cHRzPwpJIHRo
aW5rIHNvbWVvbmUgcmVhZCB0aGUgZGF0YSBzaGVldCB3cm9uZy4KCglTw7ZyZW4KCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
