From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts
 is enabled
Date: Mon, 15 Jul 2013 16:41:25 +0800
Message-ID: <51E3B5B5.1030706@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130715082716.GM12139@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

5LqOIDIwMTPlubQwN+aciDE15pelIDE2OjI3LCBVd2UgS2xlaW5lLUvDtm5pZyDlhpnpgZM6Cj4g
ZG8geW91IHdhbnQgdG8gc2F5IHRoYXQgdGhlIGRyaXZlciBmYWlscyB0byBvbmx5IGVuYWJsZSBE
TUEgd2hlbiBSVFMvQ1RTCj4gYXJlIGF2YWlsYWJsZTsgb3IgdGhhdCB0b2RheSB0aGUgZHJpdmVy
IGNhbiBoYW5kbGUgRE1BIGp1c3QgZmluZSBldmVuCj4gd2l0aG91dCBSVFMvQ1RTPyBJIGludGVy
cHJldCB5b3VyIGNvbW1pdCBsb2cgYXMgdGhlIGxhdHRlciwgeW91ciBwYXRjaAo+IGltcGxlbWVu
dHMgdGhlIGZvcm1lciBob3dldmVyLgppbiB0aGUgbXhzLWF1YXJ0LCBpZiB0aGUgUlRTL0NUUyBp
cyBub3QgaW52YWxpZCwgdGhlIERNQSBzaG91bGQgYmUgbm90IAplbmFibGVkLgoKQnV0IGN1cnJl
bnQgY29kZSBsb3N0IHRoZSBsaW1pdCwgYSB1YXJ0IHdpdGhvdXQgdGhlIFJUUy9DVFMgbWF5IGFs
c28gCmVuYWJsZXMgdGhlIERNQSBpbiB3aGljaCBjYXNlIHRoZSB1YXJ0Cm1heSBkb2VzIG5vdCBy
dW4gb3IgcnVuIGluIGEgYWJub3JtYWwgd2F5LgoKdGhhbmtzCkh1YW5nIFNoaWppZQoKCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
