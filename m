Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F042C64E69
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2CE20657
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g9VvjBU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgKWUO6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgKWUO5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Nov 2020 15:14:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DBC061A4E
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2020 12:14:57 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so511159wmg.3
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2020 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDWubgFTLW/WDF2QmyitkdvTfv0YBZTnGKsiQWm2kIs=;
        b=g9VvjBU1COnozoDwfa81MJiEJ7WMClCPh8Ss6recl5CtdaCa8xxZ7uFXnYdxcJ7aR9
         Sr7b6O/TcULPIY210Pjl1bBqiffT1TvTP5yTUfgElHnIUXlkQz41NyGZOHSSXWdh5tJH
         rFMyUfM6hqAotOZuoS8lLYqHr8QHD5rJC1/00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDWubgFTLW/WDF2QmyitkdvTfv0YBZTnGKsiQWm2kIs=;
        b=mjyu1PksViie9pMeYx3X8YYxGqHBdkJwE80k8MjxxrqRVTSTpv6B+ZToEn5gqsspq6
         c+azHLKWA1fIItui08E0Di/dDK4Q924NeT+dsU/+XOHkoSyEe2RqPdwfKsbpp1bLxfgC
         Xb4zUpXgHpfi9Ct22rCdRdS6qiwI/3hUaBk1swb0a0TI7ieV7XdWIR/jCQIrwKqzXHfc
         A6pioqibficQ79nVBUh7bghjcAzzGHavsodln68bzh+M3iKnCL35tZEZMr5aAVtAL0Uh
         g9iRgckCaXPHJdsFC8bXlI+Pg/sYVEkyt2FGQIGqCBLcgXJkJz6ahnCGEPKNi6fS4tj0
         dkkA==
X-Gm-Message-State: AOAM533z0BgdTaVLvea+cmFHtWmXtv/uwMAqOKozLG8h100IyFKlnBsN
        k6aBgkiJfAsmHYDXgByUrXmoQ1sHe+Y3+LrRkbECJQ==
X-Google-Smtp-Source: ABdhPJxVt4Z6bdquDARP/Km1spx163my/miPREm0XDWtNkIGJ/yT+4idWox1gWFVUftjXq6QkxER0ZUz2Ec9VW90fx8=
X-Received: by 2002:a7b:c255:: with SMTP id b21mr648443wmj.72.1606162496168;
 Mon, 23 Nov 2020 12:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20201120194305.8847-1-alcooperx@gmail.com> <20201120194305.8847-2-alcooperx@gmail.com>
 <CA+-6iNxteaMui4XdC-eMctguuZs3T-G85UMuwa7fNUCkJqE1Cw@mail.gmail.com>
In-Reply-To: <CA+-6iNxteaMui4XdC-eMctguuZs3T-G85UMuwa7fNUCkJqE1Cw@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 23 Nov 2020 15:14:43 -0500
Message-ID: <CA+-6iNxyrsnDb_O4Kdo34i_+E+bX=ro6-uDfUS-ziFx+Ee0d=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
To:     Al Cooper <alcooperx@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000ee47805b4cbd91c"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--0000000000000ee47805b4cbd91c
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 23, 2020 at 10:58 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Fri, Nov 20, 2020 at 2:45 PM Al Cooper <alcooperx@gmail.com> wrote:
> >
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > This commit has of_platform_serial_probe() check specifically for the
> > "brcm,bcm7271-uart" and whether its companion driver is enabled. If it
> > is the case, and the clock provider is not ready, we want to make sure
> > that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
> > getting the UART registered via 8250_of.c.
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/tty/serial/8250/8250_of.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> > index 65e9045dafe6..aa458f3c6644 100644
> > --- a/drivers/tty/serial/8250/8250_of.c
> > +++ b/drivers/tty/serial/8250/8250_of.c
> > @@ -192,6 +192,10 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
> >         u32 tx_threshold;
> >         int ret;
> >
> > +       if (IS_ENABLED(CONFIG_SERIAL_8250_BCM7271) &&
> > +           of_device_is_compatible(ofdev->dev.of_node, "brcm,bcm7271-uart"))
> > +               return -ENODEV;
> > +
> NOTE: this commit is a "strawman" commit, and I will not be surprised
> if it gets quickly NAKed. We have a new idea on how to solve this
> issue, and if that not is not viable, will ask for a dialog on this
> problem either in this thread or through a separate RFC.


This commit is no longer needed  as part of this patchset; we have
addressed the problem elsewhere.  Sorry about the noise.
>
>
> Regards,
> Jim Quinlan
> Broadcom STB
>
>
>
> >         port_type = (unsigned long)of_device_get_match_data(&ofdev->dev);
> >         if (port_type == PORT_UNKNOWN)
> >                 return -EINVAL;
> > --
> > 2.17.1
> >

--0000000000000ee47805b4cbd91c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGQPjgDsk1tW
4hkIs03oyaGay5Ut2FkOgwqtZHLADDn0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyMzIwMTQ1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDAi5hNL+m7ROLEgQ5aHLU2rubOKiR+
tp6d3YwekBX9hpZFr1zo/EPf26qF9JFpnOf8grcSIB07O/jfYZJ8t6LpMnpXO6pU75h6OIlPkl0c
sEEF8sXj9JPEdk9SAHX0m3ZtEjttbF566bIWUPEgCRQ21gs75cr7oDz+/NKRVU4efB+kf2YuimFY
X44W8D7Ac7rD2Vw+Tv9P/Eu5XI4C2v4orIx/itvC+LKwbiTlt7Rsz+/z3IznBeWw+2PJuNBW971A
7t0DCHCAAVfpaIBMtpqiJ8CHQ5HaJBUExj8k4vDFDQrqNLoJ74SH5/cyWag8/qqw1Mp3g2ij1c4T
v0lshRmL
--0000000000000ee47805b4cbd91c--
