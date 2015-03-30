From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
Date: Mon, 30 Mar 2015 16:28:11 +0200
Message-ID: <20150330162811.3673482b@north>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gRnJpLCAyNyBNYXIgMjAxNSAxNDo1OTozMSArMDAwMCwgRGF2ZSBNYXJ0aW4gd3JvdGU6Cj4g
Q29tbWl0IDczNDc0NWMgc2VyaWFsL2FtYmEtcGwwMTE6IEFjdGl2YXRlIFRYIElSUSBwYXNzaXZl
bHkKPiBhZGRzIHNvbWUgdW5uZWNlc3NhcnkgY29tcGxleGl0eSBhbmQgb3ZlcmhlYWQgaW4gdGhl
IGZvcm0gb2YKPiBhIHNvZnRpcnEgbWVjaGFuaXNtIGZvciB0cmFuc21pdHRpbmcgaW4gdGhlIGFi
c2VuY2Ugb2YgaW50ZXJydXB0cy4KPiAKPiBBZnRlciBzb21lIGRpc2N1c3Npb24gWzFdLCB0aGlz
IHR1cm5zIG91dCB0byBiZSB1bm5lY2Vzc2FyeS4KPiAKPiBUaGlzIHBhdGNoIHNpbXBsaWZpZXMg
dGhlIGNvZGUgZmxvdyB0byByZWR1Y2UgdGhlIHJlbGlhbmNlIG9uCj4gc3VidGxlIGJlaGF2aW91
ciBhbmQgYXZvaWQgZnJhZ2lsaXR5IHVuZGVyIGZ1dHVyZSBtYWludGVuYW5jZS4KPiAKPiBUbyB0
aGlzIGVuZCwgdGhlIFRYIHNvZnRpcnEgbWVjaGFuaXNtIGlzIHJlbW92ZWQgYW5kIGluc3RlYWQK
PiBwbDAxMV9zdGFydF90eCgpIHdpbGwgbm93IHNpbXBseSBzdHVmZiB0aGUgRklGTyB1bnRpbCBm
dWxsCj4gKGd1YXJhbnRlZWluZyBmdXR1cmUgVFggSVJRcyksIG9yIHVudGlsIHRoZXJlIGFyZSBu
byBtb3JlIGNoYXJzCj4gdG8gd3JpdGUgKGluIHdoaWNoIGNhc2Ugd2UgZG9uJ3QgY2FyZSB3aGV0
aGVyIGFuIElSUSBoYXBwZW5zKS4KPiAKPiBbMV0gVGhhbmtzIHRvIEpha3ViIEtpY2nFhHNraSBm
b3IgaGlzIGlucHV0IGFuZCBzaW1pbGFyIHBhdGNoLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhdmUg
TWFydGluIDxEYXZlLk1hcnRpbkBhcm0uY29tPgoKU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5z
a2kgPGt1YmFraWNpQHdwLnBsPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
