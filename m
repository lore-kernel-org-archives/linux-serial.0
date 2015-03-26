From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/*] serial/amba-pl011: Activate TX IRQ passively
Date: Thu, 26 Mar 2015 22:30:14 +0100
Message-ID: <20150326213014.GA21687@kroah.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

T24gV2VkLCBNYXIgMjUsIDIwMTUgYXQgMDY6MjI6MjZQTSArMDAwMCwgRGF2ZSBNYXJ0aW4gd3Jv
dGU6Cj4gVGhhbmtzIHRvIEpha3ViIEtpY2nFhHNraSBmb3IgaGlzIGJ1ZyByZXBvcnQgYW5kIGRp
c2N1c3Npb24sIGFuZCBmb3IKPiBzaG93aW5nIG91dCBob3cgd2UgY2FuIG1hbmFnZSB3aXRob3V0
IHRoZSBzb2Z0aXJxIChhbmQgcHJvdmlkaW5nIGEKPiBwYXRjaCwgdGhvdWdoIG1lcmdpbmcgbXkg
cmV3b3JrIHdpdGggaXQgZ290IGRpZmZpY3VsdCwgc28gSSBkb24ndAo+IGluY2x1ZGUgaXQgaW4g
dGhlIHNlcmllcyBub3cpLgo+IAo+IAo+IFRoZXJlIGFyZSB0d28gYWx0ZXJuYXRlIHZlcnNpb25z
IG9mIHRoZSBzZXJpZXMgdGhyZWFkZWQgZnJvbSB0aGlzIGNvdmVyCj4gbGV0dGVyOgo+IAo+ICAq
IFtQQVRDSCB2M10gLSBwYXRjaCBhZ2FpbnN0IHY0LjAtcmM1IHRoYXQgc3VwZXJzZWRlcyB0aGUg
cHJldmlvdXMKPiAgICAgICAgIHNlcmllczsgdGhpcyBpcyB0aGUgbGVzcyBjaHVybnkgb3B0aW9u
Lgo+IAo+ICAqIFtQQVRDSCB2MywgdHR5LW5leHQuLl0gLSBwYXRjaGVzIGFnYWluc3QgdHR5LW5l
eHQgdGhhdAo+ICAgICAgICAgbW9kaWZ5L3BhcnRpYWxseSByZXZlcnQgdGhlIHByZXZpb3VzIHNl
cmllcyB3aXRob3V0IG5lZWRpbmcgYQo+ICAgICAgICAgcmViYXNlLgo+IAo+IFRha2UgeW91ciBw
aWNrLgoKSSBoYXZlIG5vIGlkZWEgd2hhdCB5b3Ugd2FudCBtZSB0byBkbyBoZXJlLCBzb3JyeS4K
CkkgbmVlZCB0byBhcHBseSBwYXRjaGVzIHRvIHR0eS1uZXh0LCBJIGNhbid0IGRvIGFueXRoaW5n
IGFnYWluc3QgYQoiY2xlYW4iIDQuMC1yYzUgYXMgeW91ciBwYXRjaGVzIGFyZSBhbHJlYWR5IGlu
IHR0eS1uZXh0LgoKQW5kIEkgY2FuJ3QgdGVsbCB0aGUgdHdvIHNlcmllcyBhcGFydCBoZXJlLi4u
CgpDYW4geW91IGp1c3QgcmVzZW5kIHdoYXQgeW91IHdhbnQgbWUgdG8gYXBwbHkgdG8gdHR5LW5l
eHQgYW5kIHdlIGNhbiBnbwpmcm9tIHRoZXJlPwoKY29uZnVzZWQsCgpncmVnIGstaAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
