Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EF8F6D
	for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093008; cv=none; b=hbMU6TRT36YNVLp0hRZXDbATSv2LY+kaZkMYK+uEyURVNwNUEuFIK1my+/rjY5dyOjVCW1Xd/JWsKUWB1En4ENRAHRRDADhpIjNGRiuDt4qHnaAxhL8Ycap6M56SRpQ+NoM5q6sQK1giLsV68Toqag1zMjhQX+CktfRl0E5og88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093008; c=relaxed/simple;
	bh=TpulUqgHWvuLWPXaC+xv4z9wuWNhHej1oNPgxFZ2JdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT04qzariSjb1flZrN2/wiFxKFvtNhmd99aKRp5onmjgLlLClQW+hx1jC1srXBRKmteINjDi2mzVKSH89RkxEqg7KOsmW+PkeoUztCgu+PHYgnCHExwHQbkjyoEBqsgSK9mbh0PSwLwGP65cfIo4u4g7F2YgiBgMmqCX2ysWzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TTaPbzd4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TTaPbzd4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5367ae52a01so57406e87.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726093004; x=1726697804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0cuJl7n6nwkngK21WK6y4/53wUpoQIuZRMQDvs6bCA=;
        b=TTaPbzd4luPSqBmxBUCdLXmBhC0CQqWKfqvXt2F2lwkQ+ms9dHfr1Hch37VfnG7gTe
         DdwBl+XHTJ8vek1wxhukP1tdxKZw0jptv60v1TdM3b73YZUZzOEOmK3XemmH2ZDDYpml
         UAbUfw96sQMUGy7zsm4NHphPi4j3dfufkvRt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093004; x=1726697804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0cuJl7n6nwkngK21WK6y4/53wUpoQIuZRMQDvs6bCA=;
        b=smXMjbI1xzsiIj0hoSUOaXtq/9OCPYvN5obNb6LAvvrhBDyBdIE/gpTMLz+XRXSAVw
         a7UNCHvtINfYL+kc+wdb0WJDz5yL7vACbxRZgztyr+znHXeeiQqp80jK2wfvRlI1DdW8
         WPVHTVcdW/yHmjb8DwaY6cJcZ0zU2gCIf4204RZO5mvB3f2w7CWJdx4Po5SiZbqxCJEb
         GWHyu1fBABeZ8g9N7I3zOngqVwqeioGxzBcmLANeI+X8H5urfXuobDcHIRaILruouJZv
         ymubxH58I2QQ5MhtXtJQ4lCJInxX7IWcMDoaTYSLiIU1OkSQhoMQnUaO7GEsRaOfTRHK
         UNkA==
X-Gm-Message-State: AOJu0YwU2U4dJE9+IFU2Y2n3rHTBh4Nq6RdVbf0sReNCr6ZUFthacRAf
	cMRo1/mFklHoi6X1QXQ/3a2ArAbas6T1ivowL7pbHL6OJtS8FZlv1lgmqZKh/VH3Ds134P56yOM
	iKmc3GIVZm0s2jZ3o7DDB6L0IcyHA+jjCHV6t
X-Google-Smtp-Source: AGHT+IElYdo+1c3qhbcHjtdCN7PPWgsAxv5zGsGs+T7Mg39+sgseXAGDt7tbFOr89qjivOVeEiDXONRLGe/ocGX8ZKg=
X-Received: by 2002:a05:6512:693:b0:52e:934f:bda5 with SMTP id
 2adb3069b0e04-53678fb7223mr417459e87.21.1726093003972; Wed, 11 Sep 2024
 15:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
 <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com> <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com>
In-Reply-To: <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 11 Sep 2024 18:16:32 -0400
Message-ID: <CA+-6iNzFb_dn8cv_OkniWPEGZHrwtgwBkuJizn4icy-d9xPKOQ@mail.gmail.com>
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006449e30621df58d6"

--0000000000006449e30621df58d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:01=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 9/11/24 14:47, Jim Quinlan wrote:
> > On Fri, Sep 6, 2024 at 6:54=E2=80=AFPM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >>
> >> The write to RP2_GLOBAL_CMD followed by an immediate read of
> >> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
> >> however by then the device is already in reset and cannot respond to a
> >> memory cycle access.
> >>
> >> On platforms such as the Raspberry Pi 4 and others using the
> >> pcie-brcmstb.c driver, any memory access to a device that cannot respo=
nd
> >> is met with a fatal system error, rather than being substituted with a=
ll
> >> 1s as is usually the case on PC platforms.
> >>
> >> Swapping the delay and the read ensures that the device has finished
> >> resetting before we attempt to read from it.
> >>
> >> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2=
 cards")
> >> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
> >> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> >> ---
> >>   drivers/tty/serial/rp2.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
> >> index 4132fcff7d4e..8bab2aedc499 100644
> >> --- a/drivers/tty/serial/rp2.c
> >> +++ b/drivers/tty/serial/rp2.c
> >> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, =
unsigned int asic_id)
> >>          u32 clk_cfg;
> >>
> >>          writew(1, base + RP2_GLOBAL_CMD);
> >> -       readw(base + RP2_GLOBAL_CMD);
> >>          msleep(100);
> >> +       readw(base + RP2_GLOBAL_CMD);
> >
> > Since the assumed purpose of the readw() was to flush the writew(),
> > would it make sense to add a barrier after the writew()?
>
> AFAICT there is one which is implied within the name, as it is not a
> _relaxed() variant. Did you mean a different sort of barrier to be used?

Not sure.  The __raw_writew() is followed by __io_aw(), which is a
no-op on arm64.  I don't know arm64 well enough to know if a follow-up
barrier is needed.
- Jim
> --
> Florian
>

--0000000000006449e30621df58d6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCovldm/5AnyOH7e29tQOHofPY7M3pf
tAibUcFSGdoe7TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA5
MTEyMjE2NDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEALPUhlBFZngSZc2tyajBTKNRP5F4dBNOLDYGlZAa1BjqFnwdD
PZ3+8iFaYbAC/ATUQV/b4wofbBKJAGyKDGFXxBZFTQvt9F80JHjaCeB4bKvMvJb8Bnjb7oRMBDmO
F+Wb4eTQ7BvF9SBuaPhWZUjQlsEmuSxnB5n1Zo0BAX3GD/Msy4ohbmcRUYok3RTkb7Bn39bKQw70
h6FrXKI9CfVIVB4N6Om8Y+AqyHeoVW8M2rLFNq7TM/reqOdw/mEZM/9H94bbTSWb1wkkt4bbeEEz
qFRTvXi9irbozsrUNsUsv3Fo7kNnim0ERAjCfAQ+wH/dc4WynMqSgD4N0rRh80DT9g==
--0000000000006449e30621df58d6--
