From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Mon, 6 Mar 2017 10:09:50 +0100
Message-ID: <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

SGkgVXdlLAoKT24gTW9uLCBNYXIgNiwgMjAxNyBhdCA5OjU4IEFNLCBVd2UgS2xlaW5lLUvDtm5p
Zwo8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPiBPbiBNb24sIE1hciAw
NiwgMjAxNyBhdCAwOTo0OTozOUFNICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4+
ID4gR2l2ZW4gdGhhdCBtY3RybC1ncGlvIGNhbiBiZSB1c2VmdWwgb24gbGVnYWN5IHBsYXRmb3Jt
cywgYSBkZXZpY2UgY291bGQKPj4gPiBzaWxlbnRseSBydW4gd2l0aG91dCBjdHMtZ3BpbyBldmVu
IHRoZXJlLgo+Pgo+PiBPbiBwbGF0Zm9ybXMgd2VyZSBDT05GSUdfR1BJT0xJQj1uLCB0aGlzIGlz
IG5vdCB0cnVlLCBzbyB0aGUgaXNzdWUgaXMgbW9vdC4KPj4KPj4gQWxsIHNlcmlhbCBkcml2ZXJz
IHVzaW5nIChvcHRpb25hbCkgbWN0cmwtZ3BpbyBoYXZlIHRoaXMgaW4gS2NvbmZpZzoKPj4KPj4g
ICAgIHNlbGVjdCBTRVJJQUxfTUNUUkxfR1BJTyBpZiBHUElPTElCCj4+Cj4+IFNvIHRoZXkgd2ls
bCB1c2UgbWN0cmwtZ3BpbyB3aGVuIEdQSU9MSUIgaXMgZW5hYmxlZC4KPj4gSWYgR1BJT1BMSUIg
aXMgZGlzYWJsZWQsIG5vIGZsb3cgY29udHJvbCBHUElPcyBhcmUgZXhwZWN0ZWQsIGFuZCB0aGUK
Pj4gZHJpdmVyIHNob3VsZCBub3QgYnJlYWsgdGhhdCBjYXNlLgo+Cj4gU28gaXQgYWxsIGJvaWxz
IGRvd24gdG8gdGhlIHF1ZXN0aW9uOiBJcyBHUElPTElCPW4gZW5vdWdoIHRvIGFzc3VtZSBubwo+
IGdwaW8gaXMgbmVlZGVkPwo+Cj4gSSdkIHNheSBpdCBpcyBub3QuCgpIb3cgZG9lcyB0aGUgcGxh
dGZvcm0gcmVnaXN0ZXIgdGhlc2UgR1BJT3Mgd2hlbiBHUElPUExJQiBpcyBub3QgZW5hYmxlZCBi
eQp0aGUgcGxhdGZvcm0sIGFuZCBncGlvZF9hZGRfbG9va3VwX3RhYmxlKCkgaXMgdGh1cyBub3Qg
YXZhaWxhYmxlPwoKUGxlYXNlIHNob3cgbWUgYW4gZXhhbXBsZS4KCkdye29ldGplLGVldGluZ31z
LAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tCkdlZXJ0IFV5dHRlcmhvZXZlbiAt
LSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5v
cmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNh
bGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJ
IGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
