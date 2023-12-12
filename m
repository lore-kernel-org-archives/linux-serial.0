Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ8CIVWQ"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A46E3
	for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 23:40:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dbcbc9c2528so103679276.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 23:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702366853; x=1702971653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ChJKkJWtW4TpwHgaD7L5Pa+1OaytgSsk6DVquR34Mk=;
        b=lZ8CIVWQiQp348+FVryACMMNcnGMAmvkv8gdnC8T4YKIsyqbnlV48my84pRd49/fPI
         CcDLi2jq7hvv7TU2sV+3u0yl+Zg+/Ul9ALSjuI92jY/CCVJKka1yAUDNMrPEDv6zZsPf
         8dGEWIHOezuoTwTfQ/qAhc8fHK5nn8CX5OHX3jB4rHm09Ry5oL2eFl9sGJXzSwI9vkVD
         /3QI8dThps53gaXZYqb+2wVNUvaOQ3VXncmb+pvXZhT2llDy369SJ05/vkEaAIqD0JbI
         F8e+BPLT5uKcJ57jO6+pfw08gIIpZr0htgDj+W0mC/N4ntrsveB+6zkl5/CzU/D+TO46
         uIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702366853; x=1702971653;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ChJKkJWtW4TpwHgaD7L5Pa+1OaytgSsk6DVquR34Mk=;
        b=FXNCptoBpo/3yhb6MXkrtQss8uAAjjNY6Y0P/qVNupF1FEPKGBTPybNVAWkfHYPKAD
         Jb2zdMHTuPaMJLYIS+QvNCmQN7qVN97Lg6RP6t36BrDHvfOHkubEqN3/3qiD7vkmOe+L
         9fD3RMtzVjl69pvngI9OBCWA2/YxUGYp3vQnyxErFRrchQhrRHx1xL8qTi/DOsZyH35n
         koJ0StvpC1l2ZBVM4G8E2uW4voMBRkjqVWc0NvcqONSHSaBhpYw9la8Q6wjhBL3wScro
         lqnRmTxI/GnbXcezvor8ALn43DjHFbrsxT+/K3MWhFNMsATz3D7JJ0JcqZzpB3nD3moS
         e6ZA==
X-Gm-Message-State: AOJu0YyKvaeJCc1+n0YjbZ++MUlS3Z3HuN3aZr5zpQjLOesYI2f1+wpp
	4XOoYZpNnBKlfEesUnBwkRJzTh9WqmaC5iS3CLo=
X-Google-Smtp-Source: AGHT+IF5RfyXfot0ti9zCnE0Jr91ypEznBlz8hwDAipDImtMr4IThO9ngCs/b0BoMO+RKHkk3lkEVKjzgCZilOmho+g=
X-Received: by 2002:a25:395:0:b0:da0:aac9:aa11 with SMTP id
 143-20020a250395000000b00da0aac9aa11mr4478773ybd.12.1702366853108; Mon, 11
 Dec 2023 23:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roman Zilka <roman.zilka@gmail.com>
Date: Tue, 12 Dec 2023 08:40:42 +0100
Message-ID: <CANZiGuGZn4uPLw7=U95ZQtMFW3pWi4Bw4rrkCdq=X1641KLy9g@mail.gmail.com>
Subject: [PATCH] tty/vt: UTF-8 parsing update according to RFC 3629, modern Unicode
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008eacb4060c4b2b67"

--0000000000008eacb4060c4b2b67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

vc_translate_unicode(), vc_sanitize_unicode():
1. Limit codepoint space to 0x10FFFF. The old algorithm followed an ancient
   version of Unicode.
2. Corrected vc_translate_unicode() doc (@rescan).
3. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in Unicod=
e -
   - accept them. Another option was to complete the set of noncharacters (=
used
   to be those two, now there's more) and preserve the substitution. This i=
s
   indeed what Unicode suggests (v15.1, chap. 23.7) (not requires), but mos=
t
   codepoints are !iswprint(), so substituting just the noncharacters seeme=
d
   futile. Also, I've never seen noncharacters treated in a special way.
4. Moved what remained of vc_sanitize_unicode() into vc_translate_unicode()=
.

Signed-off-by: Roman =C5=BDilka <roman.zilka@gmail.com>
---
 drivers/tty/vt/vt.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
--=20
2.41.0

--0000000000008eacb4060c4b2b67
Content-Type: application/x-xz; 
	name="0001-tty-vt-UTF-8-parsing-update-according-to-RFC-3629-mo.patch.xz"
Content-Disposition: attachment; 
	filename="0001-tty-vt-UTF-8-parsing-update-according-to-RFC-3629-mo.patch.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2173xl0>
X-Attachment-Id: f_lq2173xl0

/Td6WFoAAATm1rRGAgAhARwAAAAQz1jM4A6bBoRdACMcieb23x6+N7xs4Towe0t0w3otfLYhGQB8
bsbpFL1YLvblTE75tDNFd9tqsL7rLMNOGAqHu+9xqmIoYYf8G5n9KkOkZhb1Gik2wScDAIR/vJ1k
p3RXL6oJueuWa8yZIcYALYPpuaDyFr3NDjsAH1bVOGwIu90ca42mKD7YwLpDI8Q7UK3P9dEMf01N
lx6xpBjn20AknZDFbhggPQkh9zB0ktbTAi7LCMejhO6qcthEqxJHs8CZ6hJVx9WaCX8FKPGYtp+A
4qo2XKZVK6nGLIFbliRmVS7gi/42ttD/zDeYm6WKv51x8sbh/S/1z/Ux8ocNsyBZ3P2+d3JvS8bu
FkDtY2zIkM0BWgBcpJAYQvwSuGXofjrr4nut+c+RiETaLamhTyYAwlronMrONrF+mkyXduFZ0Fu+
cagZMx9Vw9NCiRgcqL9YaeYlOS7yE5eEaTTa5j3tkMjSfxL30hWJ/6mkGc+8C6PlGbc1R8/gNQzL
yeCMlawtiQYTrn+sw1BhKMZA0Ku9LRwo80Dg9eKepzX5zDF94ndQ22IXnHLD4nMgkhyuCGiW93Ct
ER32Dgbssdj/7BOYdHHvCGYB8/mM4BLr5KiccBN0Nr7UxsLZywVUIyZAE2DXgHC2nyhk1vZtZtYH
ft0ij+Wew8kubxcLKP3Se+IIzzkDXDNJ44louIR+fiyQt3b8XXSLTDC8OiHZcBL/oqzDoPPSekVl
a7tMVmterGtPwk8vHsBTsAbT1ssumXfydJPxd1D8bp+0Yn0B+VpEnk59tmfVoPpJRaLTadI5zpBS
oh1zfPcT2XUmW2Lw61ILsrqldBkm98zqZtlV83ne0cts/f30dpcfYXM94Wglx+y0SWodSo3FmgpF
VBQsaWvXYgbz4FdC0VAV/PC/wjDU6FcUoihsPbSf6bz249vlbBZ8DY4ucxuHG3DjfC/eAhnHW8V0
M57Ers8MspKMsOOIBSO/PA8dS01x18HfnhqeD/bNxXhIhVxlp5+k0h0NepubjLK8F7ZVuO0avSop
EcRCaofy+9MQMy84am8zdJrsvLKr5mH8z0xnueo5rxjIoPEkEcg2HYRaJgm+UAMVq6VpyPPU3U+H
8E5+fEhMKkHf1ov1bA2VmHtjnWamx3sxXaptvld/BLnUmQ0NdpNn0UWvW+HgeShzV7qFU4wmmVBj
vyU9TbjhrwqynJMaTURXf+kAtFvEAjbpvD4Tz43u1qcRJFT8PsCK8GMQ0h2vPFVFh+BDyLzyplDh
oKCgecIr9SswdmEI3fJos7w6Fq7pZKHfP/8XTDkPRddPuMOQVa9O7Z7Uh4gClIM+orR7F7BaKMkO
H345xNA3oJ9wTJFyQAQZXo+tP56C9rxzBteK0YBrsVhW2XmK6FgiG3xaOcMBgmFhdnkAkg9QgStp
/Yx8+qRHIXBP1yr3zPBXKSYHpVYgsFZUB+7DiZvXDFdrPGkmfG9/+9QbCkKeACADeLeKtb54ui/J
BuqwGcP8/l+BUXl+/s9hO0aRlIpnlg5PvJrzGmuH7IoKqvH4g+Jkk6nBQIQWAZoVxKlymTqAPVm1
HU95rOIrVIIo4/rekeD6VvGCCnb1k5dCe3k45F0h83tEVDwmG+I+NFa6+ord4a7bfsrRxKvFAoKz
CrB7sAzOThiMireyWXG91kqr1Lufzfy9NEDvxh2a3Dba5ccTaDIly7rL9MbQOxQlJRSnzNOdC8nv
sLzhbex3bQfpiIzc6zUmRYVRdY9oLd/eRN61hCM2XVD7W1mgB5qQgHNRSPgOZgIoinTfa+2T9BJK
OsXt1uVDEgBPD9CwUkRLN1EbJolLZWnGWrIYCuf59LdS5txA/31z/ocQF4vzTxUtxtKB/A8H3fXs
T/W8uZyKITSGwLU9h1OTsmPuyKElrmxlMD8hfAcovmtLdO3fbdQdUzzi0392ULvsGpnv0v68LGi2
p5kG4cGjTysU0Hb5mBKhWOoAWwJoBBcYFZEVCiv2E98zEog006sTBWffztoa8Ft1inhPsOpl6XCZ
OEdB07/eCalft008anMfIuY69EiqOJ5H0R1whxM/nsTVjjdtxErZ3kDElxuq/IaUz7ricCG8/RYS
8wDy/Gcr2oSPKqvAYTlCU3X9g58kbGNRifHgoD3QBxkboTuXLub1VHsw+xNd0mchDlYnDRQWskU/
PQqVlUM8pE9hVbRJDJRqD4iqpfcQH6bghCwRP2HT6u3iLsAkZ75Bks2dmVd5AACEekXsM99zRAAB
oA2cHQAAvW+xwbHEZ/sCAAAAAARZWg==
--0000000000008eacb4060c4b2b67--
