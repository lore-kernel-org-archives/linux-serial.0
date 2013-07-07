From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
Date: Sun, 7 Jul 2013 13:51:14 +0200
Message-ID: <20953.22066.706534.773272@ipc1.ka-ro>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
 <1373004752-21302-5-git-send-email-b32955@freescale.com>
 <20130706050803.GC30164@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130706050803.GC30164@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Huang Shijie <b32955@freescale.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
List-Id: linux-serial@vger.kernel.org

SGksCgpTaGF3biBHdW8gd3JpdGVzOgo+IE9uIEZyaSwgSnVsIDA1LCAyMDEzIGF0IDAyOjEyOjMw
UE0gKzA4MDAsIEh1YW5nIFNoaWppZSB3cm90ZToKPiA+IFRoZXJlIGlzIHNvbWV0aGluZyB3cm9u
ZyB3aXRoIHRoZSBSVFMvQ1RTIHBhZHM6Cj4gPiAgIFRoZSBSVFMgcGFkIGlzIGFzc2lnbmVkIHdp
dGggdGhlIENUUydzIHZhbHVlOwo+ID4gICB3aGlsZSB0aGUgQ1RTIHBhZCBpcyBhc3NpZ25lZCB3
aXRoIHRoZSBSVFMncyB2YWx1ZS4KPiA+IAo+IAo+IFNvIGJhc2ljYWxseSwgeW91IGFyZSBzYXlp
bmcgdGhhdCBzZWxlY3RfaW5wdXQgc2hvdWxkIGJlIHNldCB1cCBmb3IgQ1RTCj4gcmF0aGVyIHRo
YW4gUlRTLiAgSXQgc2VlbXMgdGhhdCB0aGUgcGVvcGxlIHdobyBnZW5lcmF0ZWQgdGhlIG1hY3Jv
IGdvdAo+IHRoZSB3cm9uZyBpbnB1dCBmcm9tIGRldmVsb3Blci4KPiAKcHJvZ3JhbW1pbmcgJ3Nl
bGVjdF9pbnB1dCcgb25seSBtYWtlcyBzZW5zZSBmb3IgaW5wdXRzLCBub3Qgb3V0cHV0cy4KU2lu
Y2UgQ1RTIGlzIGFuIG91dHB1dCBzaWduYWwsIHNlbGVjdF9pbnB1dCBvbmx5IG1ha2VzIHNlbnNl
IGZvciB0aGUKUlRTIGZ1bmN0aW9uIG9mIHRoZSBwYWRzLgoKCkxvdGhhciBXYcOfbWFubgotLSAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KCkthLVJvIGVsZWN0cm9uaWNzIEdtYkggfCBQYXNjYWxzdHJhw59lIDIyIHwgRCAtIDUyMDc2
IEFhY2hlbgpQaG9uZTogKzQ5IDI0MDggMTQwMi0wIHwgRmF4OiArNDkgMjQwOCAxNDAyLTEwCkdl
c2Now6RmdHNmw7xocmVyOiBNYXR0aGlhcyBLYXVzc2VuCkhhbmRlbHNyZWdpc3RlcmVpbnRyYWc6
IEFtdHNnZXJpY2h0IEFhY2hlbiwgSFJCIDQ5OTYKCnd3dy5rYXJvLWVsZWN0cm9uaWNzLmRlIHwg
aW5mb0BrYXJvLWVsZWN0cm9uaWNzLmRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
