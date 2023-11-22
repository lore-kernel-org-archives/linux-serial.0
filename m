Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="atYwDJab"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124711F
	for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 11:01:43 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cc62cca0efso851947b3.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Nov 2023 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700679703; x=1701284503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvo8yhVk+GIWrFYvUgyjH93FoIYpstqbCfBwPYaIkoQ=;
        b=atYwDJabVw9kFmB/ZqgGY8qckiifK/g1OTNa7TDRtTpsrF5OpLNxvT50QLONBTG1JM
         A+8R0tItx+z43kgJ1z2YlFn9GWcJdSt+yll86I/DCq2Fd2WE3p3I7ck9wsMH3A7jU6kS
         i4PxK7h16vwC7b7ijBAOVAOPxCWiAg72IExrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679703; x=1701284503;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvo8yhVk+GIWrFYvUgyjH93FoIYpstqbCfBwPYaIkoQ=;
        b=BaTH/fYfnpp9AABneXnQ9P7Q9L/V7UJYaWMCN23Q1zJmLS/rC0skM8Om+mJWJK9C60
         deoyGzbS3WQY1tct+urVoy1Q9omXNAvqsc827y4h4qdslsPKQW7hBEHwp8ob49Dl8tOG
         8bh/qkZPgAsaAg3XB6U8pgMYAfLywzwp8wv5u2eqW3NeYiR6g/hSPZ5DGl3Avp34w9cX
         ekbB2A1ErmN+yRtpMPNVVGqrxE1eyM4GwssJ1xLcZx7N0oN6xPnbrx6WvzfVnbCm/S4I
         FITYgOeRFF0qK9apS0DQ+KkoQE2jr7bO/HXGrWAfM4NslMqjxuOUcNM2uEg7LbV8DlEv
         g/GA==
X-Gm-Message-State: AOJu0YzJEhGvkjHou1SV1miO/u8DCeCeYXIKp7akLaSLmvF12dE8tylu
	p/j06UkwdE3PulfCPVPeJ0GnhQxIOe/+Io/3lEyWPA==
X-Google-Smtp-Source: AGHT+IFq+Al4Dzg5Y2u0cdp+jh8sUSUDkzP14I6q9BxpXanOkbPlcwQQzFGz1DepV1Ebcdlw90cmJmHKWMaNvjX9OUY=
X-Received: by 2002:a0d:d94d:0:b0:5ca:95ac:453b with SMTP id
 b74-20020a0dd94d000000b005ca95ac453bmr3402612ywe.2.1700679703165; Wed, 22 Nov
 2023 11:01:43 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
References: <20231122144208.21114-1-zajec5@gmail.com> <66c4b54b-7631-484a-9f7d-31542284e620@linaro.org>
 <08fcb328-fe4b-40c7-a01e-8a0b527b1c71@gmail.com> <758114a7-0b18-44e8-b3d8-b5aabd244279@linaro.org>
 <cac6aa8a-1515-4062-8922-4d1e31e9216e@gmail.com> <ff32cd00-e26b-4ba6-bb08-a89c702895c9@linaro.org>
 <57a77c9d-684e-4f5e-977a-4586e15f7c3e@gmail.com> <141deca9-6017-4e3f-a237-8dacc67662de@linaro.org>
 <03ad42c0-1648-43e1-bbd0-9ed02bdf4073@gmail.com> <b1f06f81-9248-73f3-b586-24e29bb9ab32@broadcom.com>
 <525384ca-f84e-471c-bc82-0029db6ccb77@linaro.org>
In-Reply-To: <525384ca-f84e-471c-bc82-0029db6ccb77@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK9bTY6ZNvRLeNx0V/T0NyVybBU8QIOFjQkAvZlpgcAqcBEXgKIk+t/ApViaRsB0ifyqgNQwaPUAiS6KKoClnwQ0QEbvXvJrhHf24A=
Date: Wed, 22 Nov 2023 11:01:40 -0800
Message-ID: <fa3228035c68d0504eeea83b2b9bd20e@mail.gmail.com>
Subject: RE: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA family
 High Speed UART
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, Alexandre TORGUE <alexandre.torgue@st.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000099bee7060ac259fb"

--00000000000099bee7060ac259fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, November 22, 2023 10:46 AM
> To: William Zhang <william.zhang@broadcom.com>; Rafa=C5=82 Mi=C5=82ecki
> <zajec5@gmail.com>; Florian Fainelli <florian.fainelli@broadcom.com>;
> Anand Gore <anand.gore@broadcom.com>; Kursad Oney
> <kursad.oney@broadcom.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; Andre Przywara <andre.przywara@arm.com>;
> Alexandre TORGUE <alexandre.torgue@st.com>; Neil Armstrong
> <neil.armstrong@linaro.org>; linux-serial@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; bcm-
> kernel-feedback-list@broadcom.com; Rafa=C5=82 Mi=C5=82ecki <rafal@milecki=
.pl>
> Subject: Re: [PATCH V2 1/2] dt-bindings: serial: add Broadcom's BCMBCA
> family High Speed UART
>
> On 22/11/2023 19:39, William Zhang wrote:
> > Hi,
> >
> > On 11/22/2023 07:52 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> On 22.11.2023 16:50, Krzysztof Kozlowski wrote:
> >>> On 22/11/2023 16:49, Rafa=C5=82 Mi=C5=82ecki wrote:
> >>>>>> For example a year ago I added binding for BCMBCA SoC timer
> without
> >>>>>> actual driver, see e112f2de151b ("dt-bindings: timer: Add
> Broadcom's
> >>>>>> BCMBCA timers").
> >>>>>>
> >>>>>> I'm not sure if we're going to agree on this, but personally I lik=
e
> >>>>>> describing hardware as much as I can. So it's well documented /
> >>>>>> understood and people may eventually write drivers for it. Maybe
> it's
> >>>>>> partially because I come from Broadcom's world that isn't well
> known
> >>>>>> for upstream efforts in general.
> >>>>>
> >>>>> The problem is that "brcm,bcmbca-hs-uart" is not describing
> >>>>> hardware. It
> >>>>> is saying that all these devices have similar (compatible)
> >>>>> programming
> >>>>> model, so the OS can use just one compatible. This goes away from
> pure
> >>>>> hardware description into interpretation.
> >>>>>
> > It is the same hardware IP block used in bcmbca SoCs.  To me, it
> > perfectly describe the hardware IP block and it does not need fallback
> > because there is no fallback.  We did that for SPI controller although
> > it has two revisions of that IP block so we have brcm,bcmbca-hsspi-v1.0
> > and 1.1
> >
> >>>>> Rob already commented on such non-SoC compatibles multiple times.
> I do
> >>>>> not see any reason here to not use specific compatible as fallback.
> >>>>
> > Sorry I missed Rob's comments.  If we have any new rule or notes about
> > this, I would like to check it out.
> >
> >>>> Do I get it right we should rather have some base specific compatibl=
e
> >>>> like: "brcm,bcm63138-hs-uart" and then if anything use fallback to i=
t
> >>>> like: "brcm,bcm4908-hs-uart", "brcm,bcm63138-hs-uart"; ?
> >>>
> >>> Yes, or the other way around, depends which is probably the oldest.
> > If we absolutely can not use bcmbca-hs-uart, I would suggest to use
>
> We can, but I am surprised that you want without any driver. What's the
> point of generic compatible?
>
I agree we should have the driver along with the dts. But it looks it
depends on
the bandwidth of Rafal.

> > bcm63xx-hs-uart to be more soc specific and in fact the oldest SoC have
>
> What is xx? Wildcard? I mean... ehhh...
>
Bcm63 series of SoC (DSL broadband chip, part of the bcmbca family) and it
is
the oldest chip for such IP.   bcm63xx has been used in many ip block's
compatible
string for long time in the upstream kernel.

> Best regards,
> Krzysztof

--00000000000099bee7060ac259fb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAzMHcLLBS/YOp7rYgpB0cb1apgh
vLvpU3ZzSe9Yp1g4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTEyMjE5MDE0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAWMHHjsi6OcoZawzpyfxhMZkoTArFCDamT2EyXzYpdFli8
gDqxmBZHX90yPDa60MGhRox7bo1WSmvBlNKf9Z/V4CcI/Inz5W7BOVHKm1uMPQ1mfFnJb77z8it8
6BZRaeiLQR+iAh3Mlo1xB3O7Q5XxNQ0tPyCK4uoofc3wuB9efBSZeerg+FqsZV5IeJPHPeHqQQTo
qtDdm8p8y3mck21Sn+U0Fn5+LdBB4RJKxQl/ZohSP8PQIOND7goytEeej5QmORjT1NVJkDYDSRWz
p5FFzaUnlVUDNYoNCQ3T+UwXVz5CVwx9L9Pr/JxbGO9OgxJWPRArC3QwmzdoKzeRotsQ
--00000000000099bee7060ac259fb--
