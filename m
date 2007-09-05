From: Eric Leblond <eric@inl.fr>
Subject: [Patch] Add support for PCMCIA card Sierra WIreless AC850
Date: Wed, 05 Sep 2007 22:15:59 +0200
Message-ID: <1189023359.4228.6.camel@ghlodit.inl.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0958639276=="
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--===============0958639276==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-R2NJj+LrnobE4wcLLMfv"


--=-R2NJj+LrnobE4wcLLMfv
Content-Type: multipart/mixed; boundary="=-cc4HNoCEDHc3b8Tzsaw9"


--=-cc4HNoCEDHc3b8Tzsaw9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This patch adds support for Sierra Wireless AC850 which has the same Ids
as the AC710/750 but has a different firmware.

PS: Please CC answer as I've not subscribed to the list.

BR,
--=20
Eric Leblond <eric@inl.fr>
INL SARL

--=-cc4HNoCEDHc3b8Tzsaw9
Content-Disposition: attachment;
	filename=Add-support-for-Sierra-Wireless-AC850.txt
Content-Type: text/plain; name=Add-support-for-Sierra-Wireless-AC850.txt;
	charset=UTF-8
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogRXJpYyBMZWJsb25kIDxlcmljQGlubC5mcj4NCi0tLQ0KIGRyaXZlcnMv
c2VyaWFsL3NlcmlhbF9jcy5jIHwgICAgMSArDQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NlcmlhbC9zZXJp
YWxfY3MuYyBiL2RyaXZlcnMvc2VyaWFsL3NlcmlhbF9jcy5jDQppbmRleCBhMGVhNDM1Li5mMGU5
YmE2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zZXJpYWwvc2VyaWFsX2NzLmMNCisrKyBiL2RyaXZl
cnMvc2VyaWFsL3NlcmlhbF9jcy5jDQpAQCAtOTExLDYgKzkxMSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cGNtY2lhX2RldmljZV9pZCBzZXJpYWxfaWRzW10gPSB7DQogCVBDTUNJQV9NRkNfREVWSUNFX0NJ
U19NQU5GX0NBUkQoMSwgMHgwMTc1LCAweDAwMDAsICJEUDgzOTAzLmNpcyIpLA0KIAlQQ01DSUFf
TUZDX0RFVklDRV9DSVNfTUFORl9DQVJEKDEsIDB4MDEwMSwgMHgwMDM1LCAiM0NYRU01NTYuY2lz
IiksDQogCVBDTUNJQV9NRkNfREVWSUNFX0NJU19NQU5GX0NBUkQoMSwgMHgwMTAxLCAweDAwM2Qs
ICIzQ1hFTTU1Ni5jaXMiKSwNCisJUENNQ0lBX0RFVklDRV9DSVNfUFJPRF9JRDEyKCJTaWVycmEg
V2lyZWxlc3MiLCAiQUM4NTAiLCAweGQ4NWY2MjA2LCAweDQyYTJjMDE4LCAiU1dfOHh4X1NFUi5j
aXMiKSwgIC8qIFNpZXJyYSBXaXJlbGVzcyBBQzg1MCAzRyBOZXR3b3JrIEFkYXB0ZXIgUjEgKi8N
CiAJUENNQ0lBX0RFVklDRV9DSVNfTUFORl9DQVJEKDB4MDE5MiwgMHgwNzEwLCAiU1dfN3h4X1NF
Ui5jaXMiKSwJLyogU2llcnJhIFdpcmVsZXNzIEFDNzEwL0FDNzUwIEdQUlMgTmV0d29yayBBZGFw
dGVyIFIxICovDQogCVBDTUNJQV9ERVZJQ0VfQ0lTX01BTkZfQ0FSRCgweDAxOTIsIDB4YTU1NSwg
IlNXXzU1NV9TRVIuY2lzIiksICAvKiBTaWVycmEgQWlyY2FyZCA1NTUgQ0RNQSAxeHJ0dCBNb2Rl
bSAtLSBwcmUgdXBkYXRlICovDQogCVBDTUNJQV9ERVZJQ0VfQ0lTX01BTkZfQ0FSRCgweDAxM2Ys
IDB4YTU1NSwgIlNXXzU1NV9TRVIuY2lzIiksICAvKiBTaWVycmEgQWlyY2FyZCA1NTUgQ0RNQSAx
eHJ0dCBNb2RlbSAtLSBwb3N0IHVwZGF0ZSAqLw0KLS0gDQoxLjQuNC40DQoNCg==


--=-cc4HNoCEDHc3b8Tzsaw9--

--=-R2NJj+LrnobE4wcLLMfv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3w5/nxA7CdMWjzIRAu9kAKCGSI2wmdpu8DGyBMA1SrC5Rv4+OACfTPFn
kEym9xGyftxcM8P9Bb6NbSA=
=ZuXt
-----END PGP SIGNATURE-----

--=-R2NJj+LrnobE4wcLLMfv--



--===============0958639276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0958639276==--
