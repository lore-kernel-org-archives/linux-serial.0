From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Mon, 21 Nov 2016 12:00:11 +0100
Message-ID: <1479726011.2807.11.camel@googlemail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160805065845.GI17874@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

SGV5IFV3ZQoKT24gRnJpLCAyMDE2LTA4LTA1IGF0IDA4OjU4ICswMjAwLCBVd2UgS2xlaW5lLUvD
tm5pZyB3cm90ZToKPiBPbmNlIHRoaXMgaXMgZG9uZSAoYW5kIHN0aWxsIGFuIGlzc3VlKQoKWWVz
LCBwYXRjaCBiNWNhMDI4ZmU5YmEyMDkwYSAoQVJNOiBkdHM6IGlteDZzeDogZG9jdW1lbnQgU0lP
TiBuZWNlc3NpdHkKb2YgRU5FVDFfUkVGX0NMSzEpIGlzIGRvbmUgYW5kIG1haW5saW5lIGFuZCBE
U1IgaXJxIGhhbmRsaW5nIGlzIHN0aWxsIGFuCmlzc3VlLgoKPiAgSSdkIHN1Z2dlc3QgdG8gc3Rh
bmRhcmRpemUgYSBkdAo+IHByb3BlcnR5Cj4gCj4gCWRpc2FibGUtZHNyOwoKV291bGQgeW91IGdv
IGZvcndhcmQ/Cgo+IChhbmQgdGhlIHNhbWUgZm9yIHRoZSBvdGhlciBoYW5kc2hha2luZyBsaW5l
cykgYW5kIHN1cHBvcnQgdGh7aXMsZXNlfSBpbgo+IHRoZSBpbXggdWFydCBkcml2ZXIuIFJldmVy
dGluZyAyN2UxNjUwMTA1MmUgSU1PIGlzbid0IGEgc2Vuc2libGUgb3B0aW9uLgoKT2theSwgSSdt
IGZpbmUgd2l0aCBhICdkaXNhYmxlLWRzcicgc29sdXRpb24uCgpUaGFua3MKICAtLSBDaHJpc3Rv
cGgKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
