From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v4 06/13] tty: xuartps: Move request_irq to after
 setting up the HW
Date: Thu, 17 Dec 2015 02:00:00 -0800
Message-ID: <20151217100000.GO3358@xsjsorenbubuntu>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
 <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
 <5669F172.6020503@hurleysoftware.com>
 <20151215154136.GU3358@xsjsorenbubuntu>
 <5670A1B6.6050708@hurleysoftware.com>
 <20151216090339.GX3358@xsjsorenbubuntu>
 <56717745.3060306@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56717745.3060306@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gV2VkLCAyMDE1LTEyLTE2IGF0IDA2OjM3QU0gLTA4MDAsIFBldGVyIEh1cmxleSB3cm90ZToK
PiBPbiAxMi8xNi8yMDE1IDAxOjAzIEFNLCBTw7ZyZW4gQnJpbmttYW5uIHdyb3RlOgo+ID4gT24g
VHVlLCAyMDE1LTEyLTE1IGF0IDAzOjI2UE0gLTA4MDAsIFBldGVyIEh1cmxleSB3cm90ZToKPiA+
PiBPbiAxMi8xNS8yMDE1IDA3OjQxIEFNLCBTw7ZyZW4gQnJpbmttYW5uIHdyb3RlOgo+ID4+PiBP
biBUaHUsIDIwMTUtMTItMTAgYXQgMDE6NDFQTSAtMDgwMCwgUGV0ZXIgSHVybGV5IHdyb3RlOgo+
ID4+Pj4gT24gMTIvMDUvMjAxNSAwODozOSBQTSwgU29yZW4gQnJpbmttYW5uIHdyb3RlOgo+ID4+
Pj4+IFJlcXVlc3RfaXJxKCkgc2hvdWxkIGJlIF9hZnRlcl8gaC93IHByb2dyYW1taW5nLCBvdGhl
cndpc2UgYW4KPiA+Pj4+PiBpbnRlcnJ1cHQgY291bGQgYmUgdHJpZ2dlcmVkIGFuZCBpbi1wcm9n
cmVzcyBiZWZvcmUgdGhlIGgvdyBoYXMgYmVlbgo+ID4+Pj4+IHNldHVwLgo+ID4+Pj4KPiA+Pj4+
IFNsaWdodCBtaXN1bmRlcnN0YW5kaW5nLiBNeSBmYXVsdDsgSSBzaG91bGQgaGF2ZSBiZWVuIG1v
cmUgZXhwbGljaXQuCj4gPj4+Pgo+ID4+Pj4gMS4gQW55IHNldHVwIG5lY2Vzc2FyeSBmb3IgdGhl
IGlzciBub3QgdG8gYmUgY29uZnVzZWQgYW5kIG1pc2RpcmVjdCBzcHVyaW91cwo+ID4+Pj4gICAg
aW50ZXJydXB0cyAob3IgaGFuZykgc2hvdWxkIGJlIGJlZm9yZSBpbnN0YWxsaW5nIHRoZSBpc3Ig
d2l0aCByZXF1ZXN0X2lycSgpCj4gPj4+PiAgICBOb25lIG9mIHRoaXMgY29kZSBzaG91bGQgdHJp
Z2dlciBhbiBpbnRlcnJ1cHQuCj4gPj4+PiAyLiBDbGVhciBwZW5kaW5nIGludGVycnVwdHMKPiA+
Pj4+IDMuIEluc3RhbGwgdGhlIGlzciB3aXRoIHJlcXVlc3RfaXJxKCkKPiA+Pj4+IDQuIEVuYWJs
ZSBpbnRlcnJ1cHRzCj4gPj4+Cj4gPj4+IElzbid0IHRoYXQgd2hhdCB0aGUgc3RhcnR1cCBmdW5j
dGlvbiBpcyBkb2luZyBub3cgLSBtb3JlIG9yIGxlc3MuIEkKPiA+Pj4gdGhpbmsgMyBhbmQgNCBh
cmUgc3dhcHBlZCB0byByZWxlYXNlIHRoZSBsb2NrIGFuZCB0aGVuIGRvIHRoZQo+ID4+PiByZXF1
ZXN0X2lycSwgYnV0IEkgYmVsaWV2ZSB0aGF0IHNob3VsZCBiZSBPSy4KPiA+Pj4gVGhlIHN0YXJ0
dXAgZnVuY3Rpb24gY29uZmlndXJlcyB0aGUgSFcuIENsZWFycyB0aGUgSVNSLiBFbmFibGVzIHRo
ZQo+ID4+PiBpbnRlbmRlZCBJUlFzIGFuZCB0aGVuIGRvZXMgdGhlIHJlcXVlc3RfaXJxIGNhbGwu
Cj4gPj4KPiA+PiBJZiB0aGUgZHJpdmVyIGVuYWJsZXMgaW50ZXJydXB0cyBiZWZvcmUgaW5zdGFs
bGluZyB0aGUgaXNyIHdpdGggcmVxdWVzdF9pcnEoKQo+ID4+IGFuZCBhbiBpbnRlcnJ1cHQgb2Nj
dXJzIHRoZXJlIHdpbGwgdGhlIG5vIGhhbmRsZXIgdG8gY2F0Y2ggaXQgYW5kIEVPSSB0aGUKPiA+
PiBkZXZpY2UuCj4gPiAKPiA+IFJlYWxseT8gU2hvdWxkbid0IHRoZSBJUlEgYmUgbWFza2VkIGlu
IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciB1bnRpbAo+ID4gZXZlcnl0aGluZyBpcyBpbiBwbGFj
ZT8KPiAKPiBTb3JyeSwgSSdtIHVzZWQgdG8gc2hhcmVkIGludGVycnVwdHMsIHdoZXJlIHRoYXQg
aXNuJ3QgdGhlIGNhc2UuCgpBaGgsIEkgZGlkbid0IGhhdmUgdG8gZGVhbCB3aXRoIHN1Y2ggY2Fz
ZXMgeWV0LiBNYWtlcyBzZW5zZSB0aG91Z2guCgoJVGhhbmtzLAoJU8O2cmVuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
