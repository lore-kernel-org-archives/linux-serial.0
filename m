Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C32628D
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554338; cv=none; b=PYhvyPOuUt9k5HbYNixnL6ujaERokPcm3tU2RpFhmZCzroCJ8r3nH4uRurEuc9c24w86p1kjItlFxJtF8mc3T2AZ4qB7ZxTffC00GqlIjxyq1dKAtLuSvAuGiLJV7ymZ8D20UroJdLb039e+PWdE5yT6usZ+DOm0lpuwJggIkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554338; c=relaxed/simple;
	bh=8CCCQag3DxyqAlz9SiWHNdhLgKoUr5li6zS6hGOxq6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk0sUgINaqGkFNNwyoud0V6Yb8pqRqNIilCpPvP9vGvGIqCJ5W/Uu/jc63u0dFCcJRbbj3OmvikzIk9rN9WjgDsx4sNMYajSJnIF7Ghbq5SpcfOyL3ydfnXkCC27BJB60h0oynwbnBfKlIGneLs5jyq5gQ+U94noFbiCHArTcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arwkw8pm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arwkw8pm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso5465498a12.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554335; x=1765159135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK7tp9apRnFQraglYw+L+qlQ8CnkHXf0SW2b9shneqw=;
        b=Arwkw8pmnCfNpL6IjD8BGh10DSdTQ0TQiWeq9UsIxJFNVuhRagNEVuPgZtI5Sur0hf
         +eCt3OXBOS9RjnLmW+b8RAGKAnKLTH44PBC9QOmanvxyGd+iZXBsEmngpE2UmFVayKd1
         OsKLoMc70V94qTeJUYdP+B1VjKGg54evO53ZazM4No8k8hfQbgg4jaqMaEMvX+oSR0Om
         No5miHW6bp1W/yn/l6pxDr5cO+ZSm0TIVvHVdpqvRN1wIeMRWR11DCyT3dNkwKPC3Ue5
         uq0K9CmJ1K5usM2COcyxoUGX699QYcRECRVURdX+m7knhAEImZ9UlqlvYzKaPS3jD/JD
         mQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554335; x=1765159135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bK7tp9apRnFQraglYw+L+qlQ8CnkHXf0SW2b9shneqw=;
        b=m7qkFhpMxCuYas28hwU1mmcxfk02uH/7zlF4RRXVl5HyHpf3xTY4WRrWqrtS9nbvtx
         p3bCWDnV9E5KKEnvvnBPJXnrPzkCcSmUV41OWgSSdGOdU2LTQPF/oZwvzM5YzTyibAl7
         ASJS+JPw2yGoLYwalnRBoSS5NXQOSQbBIIAP0mPoThCKK+MLopCJUDwQNIs3axahHVb3
         ooP3IyrAD2d985EjS237WceGA9msP7whFjieECbB8eF/3ZIehwaXUK0/85MGFIn/FKmI
         AIpjxvPuu+0uC0ZW6kNPEOFhSOJYbpK1TmM9sWibUZM4R0m7cekV3M0Z1yml7ujjEPBA
         Tk2g==
X-Forwarded-Encrypted: i=1; AJvYcCXq+6icj81lo7n+erh25Dr9EG/g+SxkygkCzE81YhdnzyH/YAEC5PwUjrXmbzg9A08jWwNFdiT4VZXYtxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4PabXlEKtGFm2eUPVmFLaK8CUDU+trmNkzlyD65AJQnZeeMO
	9mpPcUL7XYq/r+Eefm67UjH+W50rtwpjTE9uh8pwgMyQLDtFxitAoCqvIwItfd0Ux3gOqiA8uPZ
	W5n0phQLZHCEwp1gWaQRxJE1yKMXoJjuqWbJy4AY=
X-Gm-Gg: ASbGncvKwoDVEKfInMDx++sgvpldd3SgmpIL8UgzzLKFok+5RXNfbdzS8Ed9Te0EQUO
	6Y5+CHtg27bpupOK1ZdE27vwPOat+JaxNpnxVNslSGk8o2FG0JPhpcWj5jx1n+j/KhaCf+P2/XO
	l86kfr2rjuse75bcUvqZiYTElUM0te1bU6UDB+fT51AzQZXbBqt7yjsxKEl2zBWabAN5ofbM/dM
	vib5QROTRoU59Hw0Sd3UNB26a4qhJLHuMu11Yxcm5tun6PtlpRdCSJdLQF01WO6osDtjTWfpT+H
	Xjc4/sw5uB+33dqTltyPnxz7DlbBZ2geFLtPslBn5xOkD3kmwhu5NK15byR+V6/T7GU7CBA=
X-Google-Smtp-Source: AGHT+IFsFZiZVbnd080QX9/l4dZqV8oBHgjrgeTseK/IoLQp3vyTYbg3ARMkRwVvmkARV5YDBoNs3zcTCQ5qNgy7AVQ=
X-Received: by 2002:a17:907:7baa:b0:b73:758c:c96f with SMTP id
 a640c23a62f3a-b76719f8590mr3937074866b.52.1764554334519; Sun, 30 Nov 2025
 17:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-21-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-21-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:58:18 +0200
X-Gm-Features: AWmQ_bm9uJ7TiSFopYpgyWlYIUmuqGIvSH-Ld9esi3_489zEimYf9gdy0pdgEO8
Message-ID: <CAHp75Veqh2fbsMBeBEBJ_ook0jZz_y=WALrgjJ0skLR9SWC0pQ@mail.gmail.com>
Subject: Re: [PATCH v1 20/31] serial: 8250: add optional callbacks for rx_trig_bytes
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The rx_trig_bytes sysfs attribute adjusts the UART RX FIFO trigger
> level. Some modern 8250 variants require programming device-specific
> registers to change this threshold, which the generic (FCR-based) path
> does not cover.
>
> This patch adds two optional uart_port callbacks:
>   - set_rxtrig(port, bytes): program a device-specific RX trigger thresho=
ld
>   - get_rxtrig(port):        read back the current RX trigger threshold
>
> When these callbacks are provided, the 8250 core will use them to
> set/read the hardware-specific threshold. If the callbacks are not
> implemented, the code falls back to the legacy generic path, so existing
> drivers keep their current behavior.
>
> No functional change for drivers that do not implement the new
> callbacks.

...

> -       rxtrig_bytes =3D do_serial8250_get_rxtrig(port);
> +       if (uport->get_rxtrig)
> +               rxtrig_bytes =3D uport->get_rxtrig(uport);
> +       else
> +               rxtrig_bytes =3D do_serial8250_get_rxtrig(port);

> +

Unneeded blank line.

>         if (rxtrig_bytes < 0)
>                 return rxtrig_bytes;

...

> -       ret =3D do_serial8250_set_rxtrig(port, bytes);
> +       if (uport->set_rxtrig)
> +               ret =3D uport->set_rxtrig(uport, bytes);
> +       else
> +               ret =3D do_serial8250_set_rxtrig(port, bytes);

> +

Ditto.

>         if (ret < 0)
>                 return ret;

--=20
With Best Regards,
Andy Shevchenko
