From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Mon, 20 Mar 2017 11:38:52 +0100
Message-ID: <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
References: <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

SGkgVXdlLAoKT24gTW9uLCBNYXIgMjAsIDIwMTcgYXQgMTE6MzEgQU0sIFV3ZSBLbGVpbmUtS8O2
bmlnCjx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+IE9uIE1vbiwgTWFy
IDIwLCAyMDE3IGF0IDEwOjU2OjE0QU0gKzAxMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToK
Pj4gRG9jdW1lbnRhdGlvbi9ncGlvL2NvbnN1bWVyLnR4dCByaWdodGZ1bGx5IHNhdGVzOgo+PiB8
IE5vdGUgdGhhdCBncGlvX2dldCpfb3B0aW9uYWwoKSBmdW5jdGlvbnMgKGFuZCB0aGVpciBtYW5h
Z2VkIHZhcmlhbnRzKSwgdW5saWtlCj4+IHwgdGhlIHJlc3Qgb2YgZ3Bpb2xpYiBBUEksIGFsc28g
cmV0dXJuIE5VTEwgd2hlbiBncGlvbGliIHN1cHBvcnQgaXMgZGlzYWJsZWQuCj4+IHwgVGhpcyBp
cyBoZWxwZnVsIHRvIGRyaXZlciBhdXRob3JzLCBzaW5jZSB0aGV5IGRvIG5vdCBuZWVkIHRvIHNw
ZWNpYWwgY2FzZQo+PiB8IC1FTk9TWVMgcmV0dXJuIGNvZGVzLiAgU3lzdGVtIGludGVncmF0b3Jz
IHNob3VsZCBob3dldmVyIGJlIGNhcmVmdWwgdG8gZW5hYmxlCj4+IHwgZ3Bpb2xpYiBvbiBzeXN0
ZW1zIHRoYXQgbmVlZCBpdC4KPgo+IEkgY2Fubm90IGZpbmQgdGhpcyBwYXJhZ3JhcGggaW4gRG9j
dW1lbnRhdGlvbi9ncGlvL2NvbnN1bWVyLnR4dDoKPgo+ICAgICAgICAgJCBnaXQgZ3JlcCAtZSAn
RU5PU1lTJyB2NC4xMS1yYzMgLS0gRG9jdW1lbnRhdGlvbi9ncGlvLwo+ICAgICAgICAgPHZvaWQ+
CgpJdCB3YXMgYWRkZWQgYnkgY29tbWl0IDIyYzQwMzY3NmRiYmI3YzYgKCJncGlvOiByZXR1cm4g
TlVMTCBmcm9tCmdwaW9kX2dldF9vcHRpb25hbCB3aGVuIEdQSU9MSUIgaXMgZGlzYWJsZWQiKQoK
R3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0KR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBn
ZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2hu
aWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5n
IHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
