From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v5 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Mon, 22 Jul 2019 16:57:49 +0300
Message-ID: <877e8a5fz6.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563787330-1394-1-git-send-email-sorganov@gmail.com>
 <1563787330-1394-2-git-send-email-sorganov@gmail.com>
 <20190722095405.qdc77cb2qrgltzrx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190722095405.qdc77cb2qrgltzrx@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Mon,
 22 Jul 2019 11:54:05 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JpdGVz
OgoKPiBPbiBNb24sIEp1bCAyMiwgMjAxOSBhdCAxMjoyMjowOFBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gRG9uJ3QgbGV0IHJlY2VpdmVyIGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkg
Y29udHJvbCBSVFMgb3V0cHV0IGlmIGl0Cj4+IHdhcyByZXF1ZXN0ZWQgdG8gYmUgaW5hY3RpdmUu
Cj4+IAo+PiBUbyBlbnN1cmUgdGhpcywgc2V0X3Rlcm1pb3MoKSBzaG91bGRuJ3Qgc2V0IFVDUjJf
Q1RTQyBiaXQgaWYgVUNSMl9DVFMKPj4gKD1USU9DTV9SVFMpIGlzIGNsZWFyZWQuIEFkZGVkIGNv
cnJlc3BvbmRpbmcgY2hlY2sgaW4gaW14X3VhcnRfcnRzX2F1dG8oKQo+PiB0byBmaXggdGhpcy4K
Pj4gCj4+IFJldmlld2VkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlPgo+Cj4gSSB0aGluayBpdCdzIGEgYml0IGJvbGQgdG8gYWRkIGEgcmV2aWV3
LXRhZyBmb3IgbWUgaGVyZS4gVGhlIGJlc3QgcmVhc29uCj4gZm9yIHRoYXQgdGhhdCBJJ20gYXdh
cmUgb2YgaXMgdGhhdCBJIHdyb3RlIGZvciB2NDogIltJXWYgeW91IHVwZGF0ZSB0aGUKPiBjb21t
aXQgbG9nIGFzIGFncmVlZCBhbHJlYWR5IGJlZm9yZSBhbmQgZXZlbiBhZGQgYSBjb21tZW50IGlu
Cj4gaW14X3VhcnRfcnRzX2F1dG8gYWxvbmcgdGhlIGxpbmVzIG9mIC4uLiB5b3UgY2FuIGhhdmUg
bXkgQWNrLiIgd2hpY2ggSU1PCj4gaXNuJ3QgZ29vZCBlbm91Z2ggdG8ganVzdGlmeSBhICJSZXZp
ZXdlZC1ieSIuIEkgd291bGRuJ3QgZXZlbiBhZGQgYW4KPiBBY2tlZC1ieTogd2l0aG91dCB0aGUg
b3RoZXIgcGVyc29uIGJlaW5nIGFibGUgdG8gYWN0dWFsbHkgc2VlIHRoZQo+IGNoYW5nZWQgcGF0
Y2ggKGJ1dCB0aGlzIG1pZ2h0IGJlIGFyZ3VhYmxlKS4KCkknbGwgZG8gd2hhdGV2ZXIgeW91IHNh
eS4gU2hvdWxkIEkgcmVtb3ZlIHRoZSBSZXZpZXdlZC1ieTogeW91LCBvciBpcyBpdApPSyB0byBs
ZWF2ZSBpdCBpbiwgdG8gYXZvaWQgcmUtaXRlcmF0aW5nIGFnYWluPwoKQmVzdCBSZWdhcmRzLAoK
LS0gU2VyZ2V5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
