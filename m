Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FA2620F1
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585794; cv=none; b=JAD7D2nBcDwtPWMeydGBycjC6X/JWItnzWGKPN1FWybb8WcbjwwhDF92uoOhLhDnWekAmvtbMUSHy/ItSWT7SLs3RAsJaIfogtwxkAumzT8eNT/pFNyY4WrC8RZnBuCJfZsvOHrUz/chfIEeBMzvFla9ubBq6LFoeBy8yXDNdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585794; c=relaxed/simple;
	bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+mEK67xUYNbQ8VgmUGBTaXRNZ+/dlcYLgqUBmItE7vOtJInHjzr+oS/XQeXJRPasBmId01eLlpQjk3wizviu/fEivcZkSYCyO6qyVeheRbO3ATorzBoB1BkUKXurb9ilUZzVRAyk95f4nunhc70oROE58tGu9xXxGEFZgZgoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JQ0BMac/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JQ0BMac/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a36748920cso5183806f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749585790; x=1750190590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=;
        b=JQ0BMac/myFnKgIVsEGjYdvKS8gJkfsLNkbReik3SqapjYxGO1NmjI4eYtbv2XaDyh
         5PxvD5Gmp2iUvsXnTQPufDei61Hjfg+LbwcanIaSq/xvWWzXwYY0mkibwgh3vh9tDi64
         0+y38ECtymXBT9JZw8qJAUuJUuzXiwUCAgiPGS7FLkwXL2PqfJgDO5/Iz4zMekXEhYo/
         WJ40tlPmcCrQpSVUZSVU78tgw1AezAW5/BQ0GWszKyWBkxYKOU4CeiMCvWj5VKjmqsz4
         Wa4VQosJZHIKCuYYKGoGh+d0VCuaY1nNSMF87a3r3MxLIL15urED+esXcXsziXlWV09N
         KvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585790; x=1750190590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGQrwjvbxP5TElWRzftoyq5VMQ1P3z0T9KV3nef+RkU=;
        b=IElGK/UkVC4c+sHQsttsiBI27OJRlJWU5QQMrf00yj8q5IW2an8T+ROaW5yWgiwXrI
         w/lCfP+BFo1piTUWjXbwqKAfI04BaCcL1o4iYM4QsU5c3jw1el6SL0CXp03qND0YknpB
         RAT/x06FbeHc/M8WoOPe+0/Dnljf/D5/Ic3I2nFcacV001HRABteN0tl7DtrH115fxwn
         Po7SI2Omqmz/znAyNWTQOkPzDSdv4x31ODc90BpZZg6MUNvkFy/L0apmg2ZPXoSbDF5H
         uH/krSJ7pyazkxm5AlOLCwuKbO1aGTd9sNxws5bJVwhJzr5o9OuC0SjNpu13xCw/Bkjk
         QN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1m8QrZtV3MkFp2pDVH0rg9MYnswCslsTz8CEnYjSFO4sJ2wvmIbLoB4d/C08qcWYAwzSMlKy784wY9bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwqok0/EX9cLVCemDETr3/CXrZFfCGUhbb6a5HuTswiKpbt/p8
	6EIJRe7mSpmnvM1gK/w/XWxiAyBy9VFoWWcBnKbdSRCtckN66S+VQydsCeFyEgpxjQs=
X-Gm-Gg: ASbGncva4SNUjMYAln77W+TkCH04X/Iy2L2thXf/n3DGfDVIpghD36G4xEM1EjpgOfn
	XbbHWMRtYdv0Mh92mjBsuRm8BAEKXcXvKwmVsdHpXQiye2uskK4T3tYvu83iCM0w8zB1+ksFx3l
	vGOC/UGarEQTpY5+yK4FQLEGjzsu9lO/Shj6fCoka2pS0N9yJPG2Qk2ZapOc0dYq3u+o6Ja6ltL
	WvB0SmawEc+WLGQdxPdunB8MXn92hsS8hBJAx2dln7Q2k/oVitTAxQafA3Gq1WE1cRQy8rAIwEI
	Syo/7OoVK/pW3/Uw88v5U3oc+SJXBfeZczyHpr3B3N3/EaFWHacJpNO83dGTyran8J/sYjxP75j
	y2jNHkB3XclSmTpVl
X-Google-Smtp-Source: AGHT+IEtm22Ya9JUV8ulYRQRT6vYHBjx+q7IOEDUr9BMoA+Edf/n/UDiFasL+UkKEL9+F1awgGEj8Q==
X-Received: by 2002:a05:6000:40d9:b0:3a4:d31e:4af3 with SMTP id ffacd0b85a97d-3a558ad6e98mr181211f8f.37.1749585790019;
        Tue, 10 Jun 2025 13:03:10 -0700 (PDT)
Received: from [192.168.3.33] (115.39.160.45.gramnet.com.br. [45.160.39.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de48sm13364311f8f.10.2025.06.10.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:03:09 -0700 (PDT)
Message-ID: <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED
 instead of CON_ENABLED
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Jason
 Wessel	 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Date: Tue, 10 Jun 2025 17:03:02 -0300
In-Reply-To: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
	 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> Hi,
>=20
> On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza
> <mpdesouza@suse.com> wrote:
> >=20
> > All consoles found on for_each_console are registered, meaning that
> > all of
> > them are CON_ENABLED. The code tries to find an active console, so
> > check if the
> > console is not suspended instead.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0drivers/tty/serial/kgdboc.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/kgdboc.c
> > b/drivers/tty/serial/kgdboc.c
> > index
> > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > 006b2923583a0d2 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > *opt)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_list_lock();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_console(con) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (con->write && con->read &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (con->flags & (CON_BOOT | CON_ENABL=
ED)) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (con->flags & CON_BOOT) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((con->flags & CON_SUSPENDED) =3D=
=3D 0) &&
>=20
> I haven't tried running the code, so I could easily be mistaken,
> but...
>=20
> ...the above doesn't seem like the correct conversion. The old
> expression was:
>=20
> (con->flags & (CON_BOOT | CON_ENABLED))
>=20
> That would evaluate to non-zero (true) if the console was _either_
> "boot" or "enabled".
>=20
> The new expression is is:
>=20
> (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
>=20
> That's only true if the console is _both_ "boot" and "not suspended".

My idea here was that the users of for_each_console would find the
first available console, and by available I would expect them to be
usable. In this case, is there any value for kgdboc to use a console
that is suspended? Would it work in this case?

I never really used kgdboc, but only checking if the console was
enabled (which it's always the case here) was something that needed to
be fixed.

Maybe I'm missing something here as well, so please let me know if I
should remove the new check.

>=20
> -Doug
