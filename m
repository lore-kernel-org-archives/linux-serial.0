Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB44C54EBE
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjAPShN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjAPSgm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 13:36:42 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98410252AB;
        Mon, 16 Jan 2023 10:26:15 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 30F162F20226; Mon, 16 Jan 2023 18:26:14 +0000 (UTC)
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 084822F20226;
        Mon, 16 Jan 2023 18:26:12 +0000 (UTC)
Date:   Mon, 16 Jan 2023 21:26:11 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] serial: samsung: fix buffer size for clk_name
Message-ID: <20230116182611.GA30526@altlinux.org>
References: <20230116141658.GC8107@altlinux.org>
 <b82b1194-622c-fc65-d831-7731c72264b7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <b82b1194-622c-fc65-d831-7731c72264b7@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-16 17:16:59 +0100, Krzysztof Kozlowski wrote:

 >> Although very unlikely, the 'clk_num' value may be as big
 >> as 2**32 - 1 (uint32_max),
 > How it could be that high? Code has num_clks defined from 1
 > to 4 and it is used as strict boundary for the loop so how
 > it could end up here with higher value?

That's why I called this "very unlikely". However, nobody can
definitely exclude the possibility of extending this limit in
the future.

 > s3c24xx_serial_getsource() also returns value & with mask,
 > so up to 4 max.

Possibly, clk_num should be uint8_t then - so the buffer size
could be extended up to only 17 bytes ("clk_uart_baud255\0")
with format specifiers changed to "%u", or 18 bytes for "%d"
(clk_uart_baud-128\0).

 > This does not look like real issue but some change to satisfy
 > static code analyzers, so I don't think it's correct approach.

Although I agree this is probably only a theoretical issue, it's
always easier to spend several bytes than to prove that we don't
need to.

But, anyway, the final decision is up to you.


--=20
Alexey V. Vissarionov
gremlin =F0=F2=E9 altlinux =F4=FE=EB org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJjxZbDAAoJEFv2F9znRj5KdmsP/1RnfCZJ3WvTOPyNp46S75Rw
JUFdm31rwM8NJoD3do0unehzc+7tWJVYAED4rA5uaFeQ0HoDEkYqwLi7J7QvRyFy
zBtchlusBX/4w9uUmlHqKoFyI6LL0Rf7FOhmF7taxBF8jI2iD1MtzGso43g9TP9B
cJu8EVR82f/3aAjMRpbdVTXHQNrYHopsZzoo/FqnnVx0mdZ4iEjD7mbY8koWh6xK
O6FnSxtz61P617OZVg8xjLWWf1vGCEe5/+fbU7yu/BeEKrBpNNCWzIAVl1fHeEIW
11ijib/BjY9XmF2IvbDS+MDMHkELrlhROuBqrFV1jp5rx5eeyONbDDTWVp4wY8wc
c+nskknEhTDUVcxTe4cYMcKw1xRsYhjwIMb7R0bh97gLwS51mzU1D6IkQlmFA0Z3
0vGotEfrTt3gY5KICv1JKKRYD+WZUr+F92inGfgl43U/C9hN50EMs7C0Hks/yTWa
3reDl+22Lg4O9G7x3t9xrydmoEGF5Tglop1d/07PbeJl5lWKILfLmq/cjkWJ1gfl
kLbdlJUSOeb+EiTctw9i0XQR307vn71Iozps+DzdKEr1tBfEMxhzaQ2nbXcDNotg
huvmpzHkO84UmlkycgJmaicJ+fz7G0YVC06TM5JjcK/6zMszXFaqLlGEZGd6S7AX
LFqE8ClxtpBLW0yhrHze
=g9N2
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
