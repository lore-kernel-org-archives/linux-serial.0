Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E921A3021
	for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094690; cv=none; b=PtqV6ZE2LhdAQYqaVwBmHTZxMAws/zZEiRnlcHt/14O0ihava1ReFo+U2WV7lL9dmhu+YgJGMJACPr1ISW+fJdsUeVS5A/gqqAcY+mcdONZSdX/uGNj9F96Q8Ag5nPHfDAqNcXf6Xr4WvhTNdNOmXA6xFjEb3bTgREd6XmPv4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094690; c=relaxed/simple;
	bh=cBsZ2eO4aF7sK1l9PdinhT5clXTEsvjZrQll7bN3eJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ke718YcYPYXZWU+RdNQNBJ/PPCCegSwHuHCiIZXGegm0ouRpgqB/rgSz9YeKfYEnqiKYJCjjao4q8XB7rI6JKUMe+7rgqawBe7S1r6Hhp6C8TaO5snc1DbW8hEummQGXZrSJqREaqqOw6Oq6/Az5KQBIc0906Uwcb+onUb20PA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PfBNdSYr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PfBNdSYr"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53654e2ed93so428016e87.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726094686; x=1726699486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsQvXiiE/BwMXIHcPtJ3BD0FW+OgrKjq4WWnrilIU6g=;
        b=PfBNdSYriSjLJdAxVdTWNYDBSdMB+A4enZ8RtP/HTazgxZT17A8/JmJytKivxBM7HY
         /BvtMC8O4249NBJRCosPxwPN7duJ9NnrXA827rhMx7UXBWHZnMdvWTJaHxewa4VKEtju
         D1K3CzGbwcgADUUUoTj+EC/0vesF9fB8SARCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726094686; x=1726699486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsQvXiiE/BwMXIHcPtJ3BD0FW+OgrKjq4WWnrilIU6g=;
        b=ChCXV0lDg8efeS2oy1Qm13ZABNcHozryRR5cfgOZl/pIXr76U3ef8knqytXthwZIn5
         Z/rxrKByCr1aSh7RCa3qR3Od37rPo1XouwHBOEK3CwMwIgk4r3gzqiKWZkhLUvld0FFr
         /2XMtAoYAJ2cDUCRkEIalaNRpjM/+Hh2l2TagkeroFgKZovWSU8LSZPw9uxKvzCxxUCw
         GN+MX2qArr0EshIvRp0URnxAcgRWf2/G3GlEPeX9FpDX3An/RFFU/3oybYMXa+9EQR89
         AI8FK8QaVfjVLLaLH1tBArH6VVYGURi7vjpxLSHHxoek68SLbg+ZuWlYT/W6FKV/NOYj
         bX9g==
X-Gm-Message-State: AOJu0YwPTb7QFq81xeJnw1kpvMZ9xxlP31wdRh9jEDp2K0M5UKMdVpil
	m9WXRXtDCkvI6BpTZhk3uB1vEplszSNZn1iGTL/NNnf+DIAjqvND2DqsjTZb+rwrx/zqj2ez87f
	8lWW4kaSiDyGF6S7f2qhtmopgyRFIa/hIpRW+
X-Google-Smtp-Source: AGHT+IGZdfxk9r9yrt4dEdEAyO3JpEW6heb6AwNSdTR7ASYSmKEzp8tgyNWlhLhM7h1fW6S//ST3pldkEyTfgaFnoj0=
X-Received: by 2002:a05:6512:3088:b0:535:63a3:c7d1 with SMTP id
 2adb3069b0e04-53678feb530mr431482e87.48.1726094685134; Wed, 11 Sep 2024
 15:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
 <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com>
 <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com> <CA+-6iNzFb_dn8cv_OkniWPEGZHrwtgwBkuJizn4icy-d9xPKOQ@mail.gmail.com>
 <d4ba49bf-60fa-4c5e-a1a8-52b1668b3d30@broadcom.com>
In-Reply-To: <d4ba49bf-60fa-4c5e-a1a8-52b1668b3d30@broadcom.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 11 Sep 2024 18:44:33 -0400
Message-ID: <CA+-6iNyS45YOHuVRcnPrMk4NOdrDZLAX=k8NBF_HwA41m4LbvQ@mail.gmail.com>
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a0e6550621dfbce6"

--000000000000a0e6550621dfbce6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:19=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 9/11/24 15:16, Jim Quinlan wrote:
> > On Wed, Sep 11, 2024 at 6:01=E2=80=AFPM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >>
> >> On 9/11/24 14:47, Jim Quinlan wrote:
> >>> On Fri, Sep 6, 2024 at 6:54=E2=80=AFPM Florian Fainelli
> >>> <florian.fainelli@broadcom.com> wrote:
> >>>>
> >>>> The write to RP2_GLOBAL_CMD followed by an immediate read of
> >>>> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the writ=
e,
> >>>> however by then the device is already in reset and cannot respond to=
 a
> >>>> memory cycle access.
> >>>>
> >>>> On platforms such as the Raspberry Pi 4 and others using the
> >>>> pcie-brcmstb.c driver, any memory access to a device that cannot res=
pond
> >>>> is met with a fatal system error, rather than being substituted with=
 all
> >>>> 1s as is usually the case on PC platforms.
> >>>>
> >>>> Swapping the delay and the read ensures that the device has finished
> >>>> resetting before we attempt to read from it.
> >>>>
> >>>> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort=
 2 cards")
> >>>> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> >>>> ---
> >>>>    drivers/tty/serial/rp2.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
> >>>> index 4132fcff7d4e..8bab2aedc499 100644
> >>>> --- a/drivers/tty/serial/rp2.c
> >>>> +++ b/drivers/tty/serial/rp2.c
> >>>> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card=
, unsigned int asic_id)
> >>>>           u32 clk_cfg;
> >>>>
> >>>>           writew(1, base + RP2_GLOBAL_CMD);
> >>>> -       readw(base + RP2_GLOBAL_CMD);
> >>>>           msleep(100);
> >>>> +       readw(base + RP2_GLOBAL_CMD);
> >>>
> >>> Since the assumed purpose of the readw() was to flush the writew(),
> >>> would it make sense to add a barrier after the writew()?
> >>
> >> AFAICT there is one which is implied within the name, as it is not a
> >> _relaxed() variant. Did you mean a different sort of barrier to be use=
d?
> >
> > Not sure.  The __raw_writew() is followed by __io_aw(), which is a
> > no-op on arm64.  I don't know arm64 well enough to know if a follow-up
> > barrier is needed.
>
> By definition all of the {read,write}{b,w,l,q} do include an adequate
> barrier
I do see this in the kernel, e.g. altera_edac.c, pci-hyperv.c,
oxu210hp-hcd.c, etc:

        write[lw](..);
        wmb();

All I am saying is that the definition of writew() for arm64 has no
explicit barrier *after* it makes the __raw_writew() call, since its
__io_aw() call is a no-op.  I really don't know if this matters, just
wanted to mention it.

Regards,
Jim


 and perform the adequate endian swapping since they originated
> from PCI drivers on x86. If you do not want any barrier you would have
> to use the _relaxed variants, or if you want native ordering, you would
> use the __raw_* variant.
> --
> Florian

--000000000000a0e6550621dfbce6
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6a+mVwRPOrkWq40gNC4kdBXbLkoVw
gxhxM2O4MR5VtzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA5
MTEyMjQ0NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEALMTH+YM6zeD6BykvshupFe5GMTcMC/5kxOqObR0Q0XKoZSzo
bpQQenXPbDfsm5ib4isZUa3cCy2gefwbrt/lkqpnd28yoUKDBxZMHnsoOsnT6gOIN87NxkA+VkuZ
bMYbFf2o+DALgW9OqsNSMJdWnlfg9tyg9n7IjP3rSF3OGAAp6lWiH+cxmzHx42pA9u9qQXiYEaNy
nowJXHRtzccj27IpuQ46iZLMa8RLEkQSSvR5gyiddxXrUlaLUMh9qs6HbVsNXmpTEOE0Fxv8LnmM
ZTQE+UKlY5AqCj4pFGHDEz7LTAMT0RXjED0jx0LcCJngUjVotCWaR8PfjuZ0AFB8EQ==
--000000000000a0e6550621dfbce6--
