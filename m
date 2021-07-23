Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D0C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B311360EE6
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhGWHZN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:25:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51982 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhGWHZM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:25:12 -0400
X-Greylist: delayed 941 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 03:25:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=8cR8pl8hymHrrBSPVbw+uTz1x5iu2Rs+19olHXnQH50=;
        b=d+Yl8El8cd/Emnr8kO9QJ27Bo+WbaGrpRxmF4oXB5gxTEtx0zEFKQKybGZU3wlKlOMpHZSYzRQ0n9HtGJydTT/E0ZyKquMIzVa4OvFSC3kGYbEVLCHAqgGGQluCWqib0m83oIcqM7icftjpZsd3mlAOnwkwFg8mWWcMaFaHxhsqA7Pl3VqDMTM8aVlXzcZBoZXJlmo4dtZ/194nXBCmephGz746YU16Tl7wHRYuEoeHXqSsNCyU5o6hZBKUeCpU84CfwmGQ19GV9e36A72dcVxuutww4T5Hmj9hahMGmQEk5AT6HOnn3gRUzpN7GwmvphRNXXe0S+ZKKFyT3MTY7jQ==;
Received: from 152.red-88-9-105.dynamicip.rima-tde.net ([88.9.105.152] helo=[192.168.2.252])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1m6pwR-00059n-5j; Fri, 23 Jul 2021 09:49:55 +0200
Message-ID: <c0047485847a5048d304df83597b151f0abe8dec.camel@igalia.com>
Subject: Re: [PATCH 4/8] tty: stop using alloc_tty_driver
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jul 2021 09:49:44 +0200
In-Reply-To: <20210723074317.32690-5-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
         <20210723074317.32690-5-jslaby@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Z0j89mH53jiOUAMFOVtU"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--=-Z0j89mH53jiOUAMFOVtU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIxLTA3LTIzIGF0IDA5OjQzICswMjAwLCBKaXJpIFNsYWJ5IHdyb3RlOgo+IGFs
bG9jX3R0eV9kcml2ZXIgd2FzIGRlcHJlY2F0ZWQgYnkgdHR5X2FsbG9jX2RyaXZlciBpbiBjb21t
aXQKPiA3ZjBiYzZhNjhlZDkgKFRUWTogcGFzcyBmbGFncyB0byBhbGxvY190dHlfZHJpdmVyKSBp
biAyMDEyLgo+IAo+IEkgbmV2ZXIgZ290IGludG8gZWxpbWluYXRpbmcgYWxsb2NfdHR5X2RyaXZl
ciB1bnRpbCBub3cuIFNvIHdlIHN0aWxsCj4gaGF2ZSB0d28gZnVuY3Rpb25zIGZvciBhbGxvY2F0
aW5nIGRyaXZlcnMgd2hpY2ggbWlnaHQgYmUgY29uZnVzaW5nLgo+IFNvCj4gZ2V0IHJpZCBvZiBh
bGxvY190dHlfZHJpdmVyIHVzZXMgdG8gZWxpbWluYXRlIGl0IGZvciBnb29kIGluIHRoZSBuZXh0
Cj4gcGF0Y2guCj4gCj4gTm90ZSB3ZSBuZWVkIHRvIHN3aXRjaCByZXR1cm4gdmFsdWUgY2hlY2tp
bmcgYXMgdHR5X2FsbG9jX2RyaXZlciB1c2VzCj4gRVJSX1BUUi4gQW5kIGZsYWdzIGFyZSBub3cg
YSBwYXJhbWV0ZXIgb2YgdHR5X2FsbG9jX2RyaXZlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKaXJp
IFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KPiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lk
ZGxlLm5ldD4ob2RkIGZpeGVyOkFMUEhBIFBPUlQpCj4gQ2M6IEl2YW4gS29rc2hheXNreSA8aW5r
QGp1cmFzc2ljLnBhcmsubXN1LnJ1Pgo+IENjOiBNYXR0IFR1cm5lciA8bWF0dHN0ODhAZ21haWwu
Y29tPgo+IENjOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPgo+IENj
OiAiSmFtZXMgRS5KLiBCb3R0b21sZXkiIDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNo
aXAuY29tPgo+IENjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+Cj4gQ2M6IEplZmYgRGlr
ZSA8amRpa2VAYWRkdG9pdC5jb20+Cj4gQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBu
b2QuYXQ+Cj4gQ2M6IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNv
bT4KPiBDYzogQ2hyaXMgWmFua2VsIDxjaHJpc0B6YW5rZWwubmV0Pgo+IENjOiBNYXggRmlsaXBw
b3YgPGpjbXZia2JjQGdtYWlsLmNvbT4KPiBDYzogU2FtdWVsIElnbGVzaWFzIEdvbnNhbHZleiA8
c2lnbGVzaWFzQGlnYWxpYS5jb20+Cj4gQ2M6IEplbnMgVGFwcm9nZ2UgPGplbnMudGFwcm9nZ2VA
dGFwcm9nZ2Uub3JnPgo+IENjOiBLYXJzdGVuIEtlaWwgPGlzZG5AbGludXgtcGluZ2kuZGU+Cj4g
Q2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgo+IENjOiAiRGF2aWQgUy4g
TWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFA
a2VybmVsLm9yZz4KPiBDYzogSGVpa28gQ2Fyc3RlbnMgPGhjYUBsaW51eC5pYm0uY29tPgo+IENj
OiBWYXNpbHkgR29yYmlrIDxnb3JAbGludXguaWJtLmNvbT4KPiBDYzogQ2hyaXN0aWFuIEJvcm50
cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPgo+IENjOiBMYXVyZW50aXUgVHVkb3IgPGxh
dXJlbnRpdS50dWRvckBueHAuY29tPgo+IENjOiBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9y
Zz4KPiBDYzogRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPgo+IENjOiBTaGF3biBHdW8g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+Cj4gQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRy
b25peC5kZT4KPiBDYzogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KPiBDYzogRmVs
aXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPgo+IENjOiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtl
cm5lbC5vcmc+Cj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4KPiBD
YzogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+Cj4gQ2M6IEx1aXogQXVn
dXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPgo+IC0tLQo+IMKgYXJjaC9hbHBo
YS9rZXJuZWwvc3JtY29ucy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKystLS0KPiDC
oGFyY2gvbTY4ay9lbXUvbmZjb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDcgKysrLS0tLQo+IMKgYXJjaC9wYXJpc2Mva2VybmVsL3BkY19jb25zLmPCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDkgKysrKy0tLS0tCj4gwqBhcmNoL3VtL2RyaXZlcnMvbGluZS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKystLS0tLQo+IMKgYXJjaC94dGVu
c2EvcGxhdGZvcm1zL2lzcy9jb25zb2xlLmPCoMKgwqAgfMKgIDcgKysrLS0tLQo+IMKgZHJpdmVy
cy9pcGFjay9kZXZpY2VzL2lwb2N0YWwuY8KgwqDCoMKgwqDCoMKgIHzCoCA5ICsrKystLS0tLQo+
IMKgZHJpdmVycy9pc2RuL2NhcGkvY2FwaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDEwICsrKystLS0tLS0KPiDCoGRyaXZlcnMvbW1jL2NvcmUvc2Rpb191YXJ0LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgOCArKysrLS0tLQo+IMKgZHJpdmVycy9uZXQvdXNiL2hzby5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKysrLS0tLQo+IMKgZHJpdmVycy9z
MzkwL2NoYXIvY29uMzIxNS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKystLS0tCj4g
wqBkcml2ZXJzL3MzOTAvY2hhci9zY2xwX3R0eS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcg
KysrLS0tLQo+IMKgZHJpdmVycy9zMzkwL2NoYXIvc2NscF92dDIyMC5jwqDCoMKgwqDCoMKgwqDC
oCB8wqAgNyArKystLS0tCj4gwqBkcml2ZXJzL3N0YWdpbmcvZ2RtNzI0eC9nZG1fdHR5LmPCoMKg
wqDCoMKgIHzCoCA5ICsrKystLS0tLQo+IMKgZHJpdmVycy90dHkvYW1pc2VyaWFsLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrLS0tLQo+IMKgZHJpdmVycy90dHkvZWh2
X2J5dGVjaGFuLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrKy0tLS0KPiDCoGRy
aXZlcnMvdHR5L2dvbGRmaXNoLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0
ICsrKysrKystLS0tLS0tCj4gwqBkcml2ZXJzL3R0eS9odmMvaHZjX2NvbnNvbGUuY8KgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgOCArKysrLS0tLQo+IMKgZHJpdmVycy90dHkvaHZjL2h2Y3MuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKystLS0tCj4gwqBkcml2ZXJzL3R0
eS9odmMvaHZzaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrLS0t
LQo+IMKgZHJpdmVycy90dHkvaXB3aXJlbGVzcy90dHkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA4ICsrKystLS0tCj4gwqBkcml2ZXJzL3R0eS9teHNlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrKy0tLS0KPiDCoGRyaXZlcnMvdHR5L25fZ3NtLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSArKysrLS0tLS0KPiDC
oGRyaXZlcnMvdHR5L25vem9taS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA4ICsrKystLS0tCj4gwqBkcml2ZXJzL3R0eS9zZXJpYWwva2dkYl9ubWkuY8KgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNyArKystLS0tCj4gwqBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2Nv
cmUuY8KgwqDCoMKgwqDCoCB8wqAgOCArKysrKy0tLQo+IMKgZHJpdmVycy90dHkvc3luY2xpbmtf
Z3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKystLS0tCj4gwqBkcml2ZXJz
L3R0eS92dC92dC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYg
KysrLS0tCj4gwqBkcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA4ICsrKystLS0tCj4gwqBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJp
YWwuYyB8wqAgOCArKysrLS0tLQo+IMKgZHJpdmVycy91c2Ivc2VyaWFsL3VzYi1zZXJpYWwuY8Kg
wqDCoMKgwqDCoMKgIHzCoCA5ICsrKystLS0tLQo+IMKgbmV0L2JsdWV0b290aC9yZmNvbW0vdHR5
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrKy0tLS0KPiDCoDMxIGZpbGVzIGNo
YW5nZWQsIDEyMCBpbnNlcnRpb25zKCspLCAxMzIgZGVsZXRpb25zKC0pCgpGb3IgaXBhY2sgY2hh
bmdlczoKCkFja2VkLWJ5OiBTYW11ZWwgSWdsZXNpYXMgR29uc8OhbHZleiA8c2lnbGVzaWFzQGln
YWxpYS5jb20+CgpTYW0K


--=-Z0j89mH53jiOUAMFOVtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmD6dJgACgkQf/S6MvF9
w0OV5hAAywElC+vAkNp7u1B/QU6kA13eWS90KiAfqH3j/7FyBWixycccxu2m1ZSA
kaF6kSnH1EcSnhvrMOHtOf5VHMQNWyA8uUZ0fUPMyFKXYzVu3lazo5sKpwpwW4XY
TsE+yLPrEnq39TsCtUxqXLc9E7lGVAbJXTN1sgB2fKyG6pix85EhPQD1g2kzI2DM
Qgbn0H8pYc+hqAJ+PcokD35YKTBNBdzQqYXMdUudug/W9GvHjHWv5w1DQyn6vVpT
aFLW9MZv/xcLRAAyhXxOWIp4VnLfFLyYhOcM1AkcxNGHgSkNMDTi1E52VQz5v2Zp
b/5biKKBT5EzVMXpJEkiE9SLqfHBgAoXPq5Z4vGMofS06qjjm95wZHXheW2aA/uh
f9jlGLccorHSlKIWHBcaiVOviJYaXwWt7mQPoahL1fvvQy41kTIIt0QvRxLBPbbD
SU90UJzj7asim9jQGiImEpggUc+0nZPZEFFj6Qnj4ENv2PE/Gmne9I9cDr+hu5fr
jc9TlIbQNstylD+rJclTRBFhwCQdCbZi3YWWcyqkaPVXvAAg6VQw1wOZccQ9JEev
AfAiuYzc2a7uN+1JczgEc8sdvYpvybYY/PpaS3cdCw3Sqvfcth/ZFwDrzVUHk6Jv
ZSQCjOeiojPWOY8e81pU4SvIAEfVeEiFmmpa1hVVbxFOTiqaHZo=
=wZ4l
-----END PGP SIGNATURE-----

--=-Z0j89mH53jiOUAMFOVtU--

