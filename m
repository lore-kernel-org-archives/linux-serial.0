Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249D36C5BF
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619881; cv=pass; b=ECiahYW4vfwt1Tr/bjK6vdYYJIiFMV1KdalHYBwqNwlAtZfN6dqBgyynI5gcuJugiVJjYmsaPt57hPt/49BTTG/V3Td2ye74DjsR13UIIXkrmDVsswctqgi/sJi46QWmeRSEb+6qrajJ24e5p3vsHhwSatAduxZz/PoA5IBVjlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619881; c=relaxed/simple;
	bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdUOTuYE45ahh62puYyU0b9IaRpR6CoQ/+HYlwRIoE64kphPt9FyQdTMGJN76PKY/6fSnCFgMwDbvKMYspv5S+wVvm+Yzte4L2Psd6s6GSQHOVx/2QI5bcmJp20etA9TwZHS+hUYau0eOSgehtzEfuVf37/lbDNfnLdmFWnVPlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgKg0Osd; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgKg0Osd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e5f8fe879so81770966b.3
        for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 01:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791619878; cv=none;
        d=google.com; s=arc-20260327;
        b=kYEIb9n6hWOvDaVIIv+BGWZLJ0b26D/pOTxnrvcu1E4FX8F5wflcUB095wpcB4bHZG
         wLp8z2Ja0ift5BhZ+VBoc1KKoSqbHFJ3MOUY44MeT9nI4TpGD+lEANIO0QtLx2rWwKBe
         DLnY33HYyKtSc9Y5Ze9SNwzhKLWfG0vYm9zUFOL7P6QBz/PlEi54xJuWJOmoIgXtL6Wd
         mis1pVgGjvL1uLh1CbgqTG2DCo2e3TnD5pfr/4+WwT0tOoJuxn8zrbkEEt3qvpvd1fJF
         92Z3+EpZN7dUXfDelcqHIc7DPgrzrar6u6eqIlHazcz8qN5lYT6f/4/nj7Z5018Wd5/p
         q3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        fh=lkXatp21VcuQYYZnSBEa44U08xNw0VLAuNXxU50VR+E=;
        b=c4zylIb0WgJluiQ6OPl+LYk9ujDbSoTrdEEjrAZLdkDkf0uOQCf3bZdNqUpr80uGa1
         y/53/eCwmHnlK5bMkbtl+qCq+2QFBmXKlhyOw8aWw9581rubMH3nDvuuM6owuTsKTvvP
         6SPI4FN46L+P7tONuL8p8alY7ZttbKzqF7U+EIC/2x4P1Dkdz4vVhzrCZbGflCTAzEw7
         Ltn8BHxE7HoOsX2KnHZZ08jSFiMfqWt4gA9TZ6oWDyIeAiw/r0SNT2U5qJHuwjoM9f7D
         ApxSyXB4GqI2HZZ403oZnce9yfIk4PiRcPtHpiKEIIHtCv9QKAMQ+Sk0FZtt5tH6xrtM
         ScRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619878; x=1792224678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        b=NgKg0OsdU/Za3gEPX3nXLxLPAOaH+SfzqxcRzsVU18uNYiDCWR1QnMU+xloBEpCIxV
         jU0PRb0KvDF9OdduOT+qKILQZhhu1IYBLkyPOmmVCaB7rFX1mbP+7nOgBFonLGdsbIQH
         USaA3JSnk7cK4ANbASBr0LvZcGA2Z6X7aqomFySr9SS1c00PviIF8DSK/Ygfv998sk4n
         1bfdlBbwdpHE/8Vaw4ZS/P6A4vY5VujyM1npVj1KeLEDLhkJs+pMDrkBS6lqQsq5vqcZ
         VbvaIgoZhfCZ+JlfMouPpK25GB+Jy6lPP+XTTtOJI7avI/R+FvqPyaKhm9j+E3i8D/vL
         UdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619878; x=1792224678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Y/fF6+yWSNp7n7WrJyW9ic7hhZX15xNpxqUx5k4mho=;
        b=S0urXUUbn2S1k+pWF+VQyGv/VbBSC2femBW83ZS8zLzgJXr2dM/aexKeKTlM0SpAUr
         kriOdMvAPSn0LcO52vesbJvdZ8bAxHJogjj+S7SF7T+5OJ/of0zoyjt6De+RqHYqzGgm
         L092EUlIcbzBNtOV//Un3djqOXQS1vpoxfIERMSMSwnvdb3m9I4+5GVP4clSwEeHi40T
         w6+UCS+MJ91dCVQ5PYu5cOT5WCTFWEbWXrx8DilgQ/9KLFqKNPO3zJv7dgEPksX789GG
         fYrKy0XmkUnQLjV86gZCmp1Usk56KNEkFZDl41ExRIFTYIwaLvObK7I/rro2YP+KhSnf
         NFHg==
X-Forwarded-Encrypted: i=1; AKwUvBzqBHWM7eykR4YvufescRaTfsEYjPgAq35HHfoJsXkC0wc8sIeJKTFe0ozMaCxssKAiPSCieelrpzWEck0=@vger.kernel.org
X-Gm-Message-State: AFq9FYINgL4/pIz44+Uj3oSwqIbVBuqyUOv+44JGL7oRsaeM5v0KYQH/
	Q7jOpKnhARebPTu4jF9n7AibJxDu7LIrc8FYCrKDFLxlkO8RKflfoM6xSr5Mxz220Kkcfp97Aoi
	+EuO3x8kd5KDa7vy8G3q4EqMb5Dg3skw=
X-Gm-Gg: AYBFou3iRbhf+mGYAxlv6eG3Ns2wFyklpwtnhDbC/oeQmcFjqNcXKe1N0hwFotdazGC
	wotnEEDBHNyhPQN7md12CKG7ZhBhJf5pkQcVyX43dhQ3WGF6t9RQYzf5lok2RciO9s2OGoZvMx1
	gx6ljmeEB7tdMZOne+NaFlAZs3ZCpiszubncQBHQfwerZdEn3B2p3iRP1XClFdGfbRwc5cgWGvM
	YPb9TTEHZdA3cpGPGqyfgDgJoCohniT5L0SJPlYbZatMfTfPqQTanJtpebbQKG0t5Kd9RVd2aGR
	Ot12Vf67c/DrY3bCEJQH/rqF+QXkzD4r6Y8bmOYJ6924MUumTXUUqgSFs7UPdepfvw1luKDRY7D
	29I+6R2oisAtToQdPrOFV8EmjZvU0BwaKiuULTZItFQ5Impx4kdAOwApMdsQKHboaUUJaa/ngtI
	9R2dV4dks/KTlRqpV1YufjUGn2GaSAPcz6aXCATXE=
X-Received: by 2002:a17:907:d0b:b0:c2a:f439:f028 with SMTP id
 a640c23a62f3a-c31aa062933mr436250066b.24.1791619877631; Sat, 10 Oct 2026
 01:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com> <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
In-Reply-To: <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Oct 2026 11:10:41 +0300
X-Gm-Features: AclHuK-dIO95E4MKMHhfgONiaVmppwEdlr0lng2Exqtg0ehIlNhsjdfo0t3-x7w
Message-ID: <CAHp75VdmMwXRQFKLG8c4yAsVA5=eFZA3jagtMGb-qVswcQ88Wg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over PCIe
To: Phil Rosenthal <phil@phil.gs>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Corey Minyard <corey@minyard.net>, 
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, 
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, Ninad Palsule <ninad@linux.ibm.com>, 
	Andrew Lunn <andrew@lunn.ch>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:45=E2=80=AFPM Phil Rosenthal <phil@phil.gs> wrote:
> > On Oct 9, 2026, at 4:57=E2=80=AFAM, Andy Shevchenko <andy.shevchenko@gm=
ail.com> wrote:
> >
> > There is already a driver for this 8250_aspeed_vuart.c. Please, do not
> > add new quirks to 8250_pci.c.
>
> Thanks for the review.
>
> As far as I can tell, 8250_aspeed_vuart.c drives the other end of the
> VUART. It is an OF platform driver (aspeed,ast2400-vuart and
> aspeed,ast2500-vuart) for Linux running on the BMC itself: it depends on
> ARCH_ASPEED, has no PCI ID table, and programs the BMC-side GCRA/GCRB
> registers (VUART enable, host SIRQ routing), which the host cannot
> reach.
>
> This patch is for the host side. There the VUART appears as 16550
> registers in BAR1 of the BMC's PCIe function (1a03:2402), and nothing
> binds that function today,

In the comments to the patch you told that ipmi_si matches it.

> so SOL goes quiet once Linux starts. I don't
> see a way to reuse 8250_aspeed_vuart.c for it, but please correct me if
> I'm missing something.
>
> Understood about 8250_pci.c. Would a separate driver be acceptable,
> e.g. drivers/tty/serial/8250/8250_aspeed_pci.c using 8250_pcilib, along
> the lines of 8250_pericom.c? It would do the same as this patch: find
> the VUARTs the BMC has enabled in BAR1 and register them as polled
> ports. If that works for you, I'll send it as v2.

What has Pericom to do with all this?

...

I will look into this deeper when I return from the LPC 2026 trip, but
what you are doing sounds really wrong.

--=20
With Best Regards,
Andy Shevchenko
