From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Tue, 14 Mar 2017 16:32:00 +0100
Message-ID: <CACRpkdZyey3jyApevpe1tDyFdPut0J+7ZeiyJQgdaWJLr09mrQ@mail.gmail.com>
References: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

T24gTW9uLCBNYXIgNiwgMjAxNyBhdCAxMTowMiBBTSwgVXdlIEtsZWluZS1Lw7ZuaWcKPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6Cgo+PiBBbnl3YXksIGZvciBzaC1zY2ku
YywgcGxhdGZvcm1zIGVpdGhlciBoYXZlIERUIGFuZCBHUElPTElCLCBvciB0aGV5IGRvIG5vdAo+
PiBuZWVkIG1jdHJsLWdwaW8uCj4KPiBTbyB3ZSdyZSBpbiBhZ3JlZW1lbnQgbm93IHRoYXQgSEFM
RkdQSU9MSUIgaXMgdGhlIHdheSB0byBnbz8KPiBMaW51cywgd2hhdCBkbyB5b3UgdGhpbms/CgpJ
J20gdG9vIHN3YW1wZWQgaW4gbWFpbCBhbmQgd29yayB0byBmaWd1cmUgdGhpcyBvdXQgcmlnaHQg
bm93LiBJIGd1ZXNzCkkgd2lsbCBnZXQgYmFjayB0byBpdC4uLgoKSSBuZWVkIG1vcmUgYWN0aXZl
IGNvbWFpbnRhaW5lcnMgSSBndWVzcywgaW50ZXJlc3RlZCBpbiB0aGUgam9iPyA7KQoKWW91cnMs
CkxpbnVzIFdhbGxlaWoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
