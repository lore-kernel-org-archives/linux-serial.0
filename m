Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C082C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 08:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6588B60EBD
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 08:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhGWHZR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:25:17 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51986 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhGWHZR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=jvj1GIpYs0r3uyf/GEya0u6dNZrx51+z0jVXi/1YzRU=;
        b=IuyYa4c8M2sUf6L9NmdZYx0Ybh1aVRq509aDnIEWTJa8+485QbBH9koF0QAdd5mHn6wR26Iu4dHxw4SbP+vHpEGdMLdqxd+1MYoi7+IaSZ7GZLS7FMRmQKTLNhb5/xBJOoF3LqUznNAXbfMMj5NsmIOq30NxwprPI2aerQIx7PuM69ESL+XjcODZ1CD7E9pqMkCPXwL32e+OGurVqEaOqPURkYIkh+ogbxdfVF+irBSllrkxWaHAk5/UwJdwZYn9YQ5Fe9njOrOWi4IFUnBBX2v4IoTBQOYs1pSyaWIzwwHxixha7Ty0GP0odLf5lsfTx5auij2bap2sk7Wdi9KTSw==;
Received: from 152.red-88-9-105.dynamicip.rima-tde.net ([88.9.105.152] helo=[192.168.2.252])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1m6pwb-0005AI-Dd; Fri, 23 Jul 2021 09:50:05 +0200
Message-ID: <5d0780f0e05c6f335f76e99df9782b7de4537775.camel@igalia.com>
Subject: Re: [PATCH 7/8] tty: drop put_tty_driver
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jul 2021 09:49:51 +0200
In-Reply-To: <20210723074317.32690-8-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
         <20210723074317.32690-8-jslaby@suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7dNrvt9WllScon201ZN+"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--=-7dNrvt9WllScon201ZN+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIxLTA3LTIzIGF0IDA5OjQzICswMjAwLCBKaXJpIFNsYWJ5IHdyb3RlOgo+IHB1
dF90dHlfZHJpdmVyKCkgaXMgYW4gYWxpYXMgZm9yIHR0eV9kcml2ZXJfa3JlZl9wdXQoKS4gVGhl
cmUgaXMgbm8KPiBuZWVkCj4gZm9yIHR3byBleHBvcnRlZCBpZGVudGljYWwgZnVuY3Rpb25zLCB0
aGVyZWZvcmUgc3dpdGNoIGFsbCB1c2VycyBvZgo+IG9sZCBwdXRfdHR5X2RyaXZlcigpIHRvIG5l
dyB0dHlfZHJpdmVyX2tyZWZfcHV0KCkgYW5kIHJlbW92ZSB0aGUKPiBmb3JtZXIKPiBmb3IgZ29v
ZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KPiBDYzog
UmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4KPiBDYzogSXZhbiBLb2tzaGF5c2t5
IDxpbmtAanVyYXNzaWMucGFyay5tc3UucnU+Cj4gQ2M6IE1hdHQgVHVybmVyIDxtYXR0c3Q4OEBn
bWFpbC5jb20+Cj4gQ2M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+
Cj4gQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRkdG9pdC5jb20+Cj4gQ2M6IFJpY2hhcmQgV2VpbmJl
cmdlciA8cmljaGFyZEBub2QuYXQ+Cj4gQ2M6IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNh
bWJyaWRnZWdyZXlzLmNvbT4KPiBDYzogQ2hyaXMgWmFua2VsIDxjaHJpc0B6YW5rZWwubmV0Pgo+
IENjOiBNYXggRmlsaXBwb3YgPGpjbXZia2JjQGdtYWlsLmNvbT4KPiBDYzogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4KPiBDYzogU2FtdWVsIElnbGVzaWFzIEdvbnNhbHZleiA8c2lnbGVzaWFz
QGlnYWxpYS5jb20+Cj4gQ2M6IEplbnMgVGFwcm9nZ2UgPGplbnMudGFwcm9nZ2VAdGFwcm9nZ2Uu
b3JnPgo+IENjOiBLYXJzdGVuIEtlaWwgPGlzZG5AbGludXgtcGluZ2kuZGU+Cj4gQ2M6IFNjb3R0
IEJyYW5kZW4gPHNjb3R0LmJyYW5kZW5AYnJvYWRjb20uY29tPgo+IENjOiBVbGYgSGFuc3NvbiA8
dWxmLmhhbnNzb25AbGluYXJvLm9yZz4KPiBDYzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+Cj4gQ2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Cj4gQ2M6
IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNvbT4KPiBDYzogVmFzaWx5IEdvcmJpayA8
Z29yQGxpbnV4LmlibS5jb20+Cj4gQ2M6IENocmlzdGlhbiBCb3JudHJhZWdlciA8Ym9ybnRyYWVn
ZXJAZGUuaWJtLmNvbT4KPiBDYzogRGF2aWQgTGluIDxkdHdsaW5AZ21haWwuY29tPgo+IENjOiBK
b2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+Cj4gQ2M6IEFsZXggRWxkZXIgPGVsZGVyQGtl
cm5lbC5vcmc+Cj4gQ2M6IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPgo+IENjOiBM
YXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPgo+IENjOiBKaXJpIEtvc2lu
YSA8amlrb3NAa2VybmVsLm9yZz4KPiBDYzogRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29t
Pgo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Cj4gQ2M6IFNhc2NoYSBIYXVl
ciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0g
PGtlcm5lbEBwZW5ndXRyb25peC5kZT4KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPgo+IENjOiBOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+Cj4gQ2M6IE9s
aXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+Cj4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlA
a2VybmVsLm9yZz4KPiBDYzogTWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBpbnRlbC5jb20+
Cj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4KPiBDYzogSm9oYW4g
SGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+Cj4gQ2M6IEx1aXogQXVndXN0byB2b24g
RGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPgo+IC0tLQo+IMKgYXJjaC9hbHBoYS9rZXJuZWwv
c3JtY29ucy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPiDCoGFyY2gvbTY4ay9lbXUv
bmZjb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGFy
Y2gvdW0vZHJpdmVycy9saW5lLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIg
Ky0KPiDCoGFyY2gveHRlbnNhL3BsYXRmb3Jtcy9pc3MvY29uc29sZS5jwqDCoMKgIHwgMiArLQo+
IMKgZHJpdmVycy9jaGFyL3BjbWNpYS9zeW5jbGlua19jcy5jwqDCoMKgwqDCoCB8IDQgKystLQo+
IMKgZHJpdmVycy9jaGFyL3R0eXByaW50ay5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDQgKystLQo+IMKgZHJpdmVycy9pcGFjay9kZXZpY2VzL2lwb2N0YWwuY8KgwqDCoMKgwqDCoMKg
IHwgNCArKy0tCj4gwqBkcml2ZXJzL2lzZG4vY2FwaS9jYXBpLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNCArKy0tCj4gwqBkcml2ZXJzL21pc2MvYmNtLXZrL2JjbV92a190dHkuY8Kg
wqDCoMKgwqDCoCB8IDggKysrKy0tLS0KPiDCoGRyaXZlcnMvbW1jL2NvcmUvc2Rpb191YXJ0LmPC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgZHJpdmVycy9uZXQvdXNiL2hzby5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgZHJpdmVycy9zMzkw
L2NoYXIvY29uMzIxNS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgZHJpdmVy
cy9zMzkwL2NoYXIvc2NscF90dHkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgOCArKysrLS0tLQo+
IMKgZHJpdmVycy9zMzkwL2NoYXIvc2NscF92dDIyMC5jwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0K
PiDCoGRyaXZlcnMvczM5MC9jaGFyL3R0eTMyNzAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
ICsrLS0KPiDCoGRyaXZlcnMvc3RhZ2luZy9md3NlcmlhbC9md3NlcmlhbC5jwqDCoMKgIHwgOCAr
KysrLS0tLQo+IMKgZHJpdmVycy9zdGFnaW5nL2dkbTcyNHgvZ2RtX3R0eS5jwqDCoMKgwqDCoCB8
IDQgKystLQo+IMKgZHJpdmVycy9zdGFnaW5nL2dyZXlidXMvdWFydC5jwqDCoMKgwqDCoMKgwqDC
oCB8IDQgKystLQo+IMKgZHJpdmVycy90dHkvYW1pc2VyaWFsLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA4ICsrKystLS0tCj4gwqBkcml2ZXJzL3R0eS9laHZfYnl0ZWNoYW4uY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDYgKysrLS0tCj4gwqBkcml2ZXJzL3R0eS9nb2xkZmlz
aC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGRyaXZlcnMv
dHR5L2h2Yy9odmNfY29uc29sZS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgZHJpdmVy
cy90dHkvaHZjL2h2Y3MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKy0t
Cj4gwqBkcml2ZXJzL3R0eS9pcHdpcmVsZXNzL3R0eS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
ICsrLS0KPiDCoGRyaXZlcnMvdHR5L21pcHNfZWp0YWdfZmRjLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDIgKy0KPiDCoGRyaXZlcnMvdHR5L21veGEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGRyaXZlcnMvdHR5L214c2VyLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgZHJpdmVycy90dHkvbl9n
c20uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKy0tCj4gwqBk
cml2ZXJzL3R0eS9ub3pvbWkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDQgKystLQo+IMKgZHJpdmVycy90dHkvc2VyaWFsL2tnZGJfbm1pLmPCoMKgwqDCoMKgwqDCoMKg
wqAgfCA0ICsrLS0KPiDCoGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jwqDCoMKgwqDC
oMKgIHwgNCArKy0tCj4gwqBkcml2ZXJzL3R0eS9zeW5jbGlua19ndC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGRyaXZlcnMvdHR5L3R0eV9pby5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNiAtLS0tLS0KPiDCoGRyaXZlcnMvdHR5L3R0eW51
bGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGRyaXZl
cnMvdHR5L3ZjYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
NCArKy0tCj4gwqBkcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNiArKystLS0KPiDCoGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5j
IHwgNCArKy0tCj4gwqBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktZGJndHR5LmPCoMKgwqDCoMKgwqDC
oMKgIHwgNCArKy0tCj4gwqBkcml2ZXJzL3VzYi9zZXJpYWwvdXNiLXNlcmlhbC5jwqDCoMKgwqDC
oMKgwqAgfCA0ICsrLS0KPiDCoGluY2x1ZGUvbGludXgvdHR5X2RyaXZlci5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMSAtCj4gwqBuZXQvYmx1ZXRvb3RoL3JmY29tbS90dHkuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKgNDEgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0
aW9ucygrKSwgODkgZGVsZXRpb25zKC0pCgpGb3IgaXBhY2sgY2hhbmdlczoKCkFja2VkLWJ5OiBT
YW11ZWwgSWdsZXNpYXMgR29uc8OhbHZleiA8c2lnbGVzaWFzQGlnYWxpYS5jb20+CgpTYW0K


--=-7dNrvt9WllScon201ZN+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmD6dJ8ACgkQf/S6MvF9
w0NKaw//ciUdwtQHKHYyUKrPJ0ghzeOaAt8b63ZNw9prxtqlTHfzUcr7bhiv82L7
ZzlCv8dMmXdy2Y6NyjQ1s8L80jgTNQ6w8YyZLaCfPyyuGDgaD7zj9ZGe/HZ0T8eL
7XQlWMojhublAtU6e7lhdfifbubZpEdE+Th5xwDcIAf76UxSAwu6aAnocTp58d5G
kQYpcGMqdUh88LSXjqFWuwa6YyV87U8rQfd1PSrqRY99+HcaLWCvCNWwon/SMnaH
vGn9JaA8b4SzXPfbadw+hRCkqN7BO8pkCI9XqA/X28p0E2/wXXLbiQYsrV0lu3MN
ScsMGHCG7o57SpMiKQrXtMXZ2NoLnsqtZrxtl8SfJPmsprC3ePF1kBKygVIMmDfT
3G4oO09T60tXjN4MiibZMHC2CvHvhmO27H78d8BNKQP2Dsp+OOJaktyzKQ+dIzIK
0JJCPdSTvf69Vb7Z0Vkma6XYjkRtqhUX1i3Wq5OJQPPdBOlIPzrt2R+CU73uLWkH
OR/B6qtxXxXo5s7BQxQvT88QrNGaLtFJ1P21uZTkHSnhdtlKg1AxKfUBBGzrHmIJ
ULjl4y9dmp42s4mwkv+ib3VxcIi4eCkrgTEj4BL9GthRtM3sgQ6bvPlSUmaIqLT3
N+ij2dY50oQZDNGEE/GJZcDneFo0ELgl/8qNT50PVgvuU1sZmzI=
=ViRo
-----END PGP SIGNATURE-----

--=-7dNrvt9WllScon201ZN+--

