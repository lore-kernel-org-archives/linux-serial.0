From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v2 4/7] serial: imx: set_termios(): preserve RTS state
Date: Thu, 27 Jun 2019 09:15:20 +0300
Message-ID: <874l4bk0zr.fsf@osv.gnss.ru>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-5-git-send-email-sorganov@gmail.com>
 <20190627054040.fmox5woti4gztmat@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190627054040.fmox5woti4gztmat@pengutronix.de> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu,
 27 Jun 2019 07:40:40 +0200")
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JpdGVz
OgoKPiBPbiBXZWQsIEp1biAyNiwgMjAxOSBhdCAwNToxMTozMFBNICswMzAwLCBTZXJnZXkgT3Jn
YW5vdiB3cm90ZToKPj4gaW14X3NldF90ZXJtaW9zKCkgY2xlYXJlZCBSVFMgb24gZXZlcnkgY2Fs
bCwgbm93IGZpeGVkLgo+Cj4gSXMgdGhpcyBhIHJlYWwgcHJvYmxlbSwgb3Igc29tZXRoaW5nIHlv
dSBub3RpY2VkIGJ5IGxvb2tpbmcgYXQgdGhlIGNvZGU/Cj4gSSB0aGluayBJIGFscmVhZHkgYXNr
ZWQgdGhhdCBpbiBhIHByZXZpb3VzIHJvdW5kLCBpZiBzbyB0aGlzIHNob3VsZCBhdAo+IGxlYXN0
IGJlIGV4cGxhaW5lZCBpbiBtb3JlIGRldGFpbCBpbiB0aGUgY29tbWl0IGxvZy4KClllcywgaXQg
d2FzIHJlYWwgb2JzZXJ2ZWQgcHJvYmxlbS4gRXZlcnkgY2FsbCB0byBzZXRfdGVybWlvcyBmcm9t
IHVzZXIKc3BhY2UgKHRocm91Z2ggdGNzZXRhdHRyKCkgZnVuY3Rpb24pIGNsZWFyZWQgUlRTLgoK
PiBBbHNvIHBsZWFzZSBub3RlIHRoYXQgdGhpcyBpcyBhYm91dCB0aGUgVUNSMl9DVFMgZmxhZy4g
KEl0IGlzLCBpc24ndAo+IGl0PyBJIGRvbid0IHVuZGVyc3RhbmQgaXQgYWZ0ZXIgc3RhcmluZyBh
dCB0aGUgY29kZSBmb3IgYSB3aGlsZS4pCgoiQ1RTIiBpbiBpTVggdGVybXMgbWVhbnMgd2hhdCBl
dmVyeWJvZHkgZWxzZSBjYWxscyAiUlRTIiEgUGxlYXNlIG5vdGljZQpob3cgdGhleSBhcmUgdXNl
ZCBpbiB0aGUgZW50aXJlIGRyaXZlciwgZS5nLjoKCgkJaWYgKG1jdHJsICYgVElPQ01fUlRTKSB7
CgkJCXVjcjIgfD0gVUNSMl9DVFM7CgoKPiBBc3N1bWluZyB0aGlzIGlzIGEgcmVhbCBmaXgsIGl0
IHdvdWxkIGJlIGdyZWF0IGlmIHRoaXMgcGF0Y2ggY2FtZSBmaXJzdAo+IGluIHRoZSBzZXJpZXMg
KGkuZS4gYmVmb3JlIHRoZSBjbGVhbnVwcykgYW5kIHdvdWxkIGJlIG1vcmUgc3RyYWlnaHQKPiBm
b3J3YXJkIHRvIHVuZGVyc3RhbmQuCgpJIHJhdGhlciBiZWxpZXZlIHRoYXQgcHJlLWNsZWFudXBz
IGFjdHVhbGx5IG1ha2UgdGhlIGZpeCBtb3JlCnN0cmFpZ2h0Zm9yd2FyZCB0byB1bmRlcnN0YW5k
LgoKVGhhbmtzIQoKLS0gU2VyZ2V5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
