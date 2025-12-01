Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC872628D
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554669; cv=none; b=YHcNih/sMJ5LMLoAr3YNhRgA79YvFHQFGmD/Cp0vbQbPZJqePuaamvlIY6i2AV0om1hzBU+eZoR/vIO1W5mbHc2fy5APwTxmIhM+B1vgj4JCvPWD1oGfuri4YMS5a6Ybu0xTjdfjh+qaUfuIaspajMNvn/zCL6RyXR5d/4vNt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554669; c=relaxed/simple;
	bh=ctEjs9/LIjanpOiFZuJdGOAvpQOF8b3rlXWiUlG07LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIv3fez+87+EzcFVqVHc0ghYr8CwtGejWvrEGeEkfOtIsA9uxeoreiTmUbl0ZUTrD4RgbaX5IKN0d9tZDYi0KlgRQDIfyLcKKNjo64vUYQX9vEcq/s4Owt3s91dPkfFHcRpTkJAZjqvxYwkKzxdPWsLVRI66A6giFS2zsS78ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVzB88c5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVzB88c5"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso5524914a12.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554666; x=1765159466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23q8rPt9NFvd7Y7SdnlrseGwLKKlDsb7aR0cYtkN5eY=;
        b=QVzB88c5AH6UTZoH49lwGGI0QfKIRJ6jKII1OiMXVzi4fiRcN+jhKmq5rL+FRh62ys
         mgSA8kAY08AZCZQq+taY95cub5LALMEmNAttA7kXKupDWJEAH0tmflLCkzYoaOr+1C/e
         uW/83+hrde4DfGwbekfaTl7gshXcYDVRja0QB1iwckSZ/+8O6g4sMqqHB8wHtZlsQIEY
         CRyt48WsszP/ODt0lOZueL+LuLT+7fefdiQZzvYmlaeZ1BHvcn+hBKsc/HOkqqOXTwW5
         cA/S9/qLdMyplMdPVPSluAA2hCLTtSV9mYp4sYsZHNZ0xc2J7hZCzPri+fTvMaSF+p/L
         DrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554666; x=1765159466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23q8rPt9NFvd7Y7SdnlrseGwLKKlDsb7aR0cYtkN5eY=;
        b=eNip4ok3nmjrvOjQNj7OjxHGV1XR5D/vGb1D6vWCSbKantk1VGCZ1GEfclKlRV0PEV
         qANCKHYskVLRYswwyIiYqEW3Dj7PTaNlgJwbrG3GjfmypW2YRLygNAFkmTjNrK4w8uyS
         vZxyNn5jYTOgDIy1fwR2kHbY5DJ/OeV53Ss75ogapB+tC264XCkRW1YYAXHpO2WFFjaI
         ygK48cjOqlG5SHk8KesnttBfzdww5cGMq/5/xSMraO3hqnJrY1KiUvZEYAPMxkNKVAxa
         1wE/hbnHXXsvWf9d69icnfNUU3iopUP0Jjg2DYum0p7Sne8h5xeM6oEykj9ZoKu1wWX/
         mxyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcd7pJDmCfl0pqOcj371HI5av28y9cbW9ECE+n1RRMpmZN0Z0YQQXbl1e8BOnbmoQ7NMwkUIUJOPomnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvCcSOiV1uir2Uv8NDIQK7WaZv7JLerwm9gVQbg1I9F+QVpqL
	S4sFr5zSEhzwQp4/IEQS//rd+CN/eSe3Q0F416xZUw+OX+ZtWjng0QH0wvw9012hT9HHvfV2/65
	5cyZmEhoQkonVitupPAex+qZgp+n9ehc=
X-Gm-Gg: ASbGnct+gKazWLmeo3rKvApFCOMutZNLJfBJHI8XbhNaSItq/RGbCRNVnlp0nQWC0xq
	rD47EpK6BtKhJgg5PUcaC26Jfgr/YrouBzktOBdx+GyK+JLujmA1CRRlLBWdI9lxuwaejjtUTNj
	mRQKO9BZodCfCtm43QJYkZgDAcmfbTgbMANRi6Qqtzy4kOtEPJs/K03T31joB/Vi5/+SY2f+H3v
	8cQuYZjp6J/A1D/0r6+HwUb8B1lx/hdN2m7eHPSJ4eT5yrc8DK45DU6AXECtPaU7Nz9j2eKbEy2
	lxgs0PM+PFny7f4JiMVE80g/r9EHlnjvfkX3k2cxujgvzaO8SGOgE9DSR//Sy+O82kb//eoBy70
	BFrqlqA==
X-Google-Smtp-Source: AGHT+IFKw00AcX+8r8foVDZy5mJU2NVqfh/zGI4VuPgZf6uQg7lirQsdjguk5Q22RhqfhSXyPjglj3xnxtAzGIeTlOU=
X-Received: by 2002:a17:906:17cd:b0:b76:84d1:5dc9 with SMTP id
 a640c23a62f3a-b7684d1609cmr2643569666b.45.1764554665886; Sun, 30 Nov 2025
 18:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-23-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-23-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:03:49 +0200
X-Gm-Features: AWmQ_bn4FbPd5PhtDPSB-D3x_ped-kID_FsqDtb-D6bJlZjJsVcAP4QJYrccygA
Message-ID: <CAHp75VeUXNW1tN6MKp6jNebtS+Ek05yszADVr6sgME+G0jzUhw@mail.gmail.com>
Subject: Re: [PATCH v1 22/31] serial: 8250_mxupci: implement rx_trig_bytes
 callbacks and persist per-port level
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Implement device-specific RX trigger handling for the rx_trig_bytes sysfs
> attribute on MXUPCI parts by programming the vendor registers directly.
>
> Changes:
> - Introduce a per-port structure to persist the registered line and the
>   RX trigger level, so the level can be restored on startup.
> - Implement uart_port callbacks:
>     - set_rxtrig(port, bytes): program MOXA_UART_RBRTI and cache the leve=
l
>     - get_rxtrig(port):        return the cached RX trigger level
> - Use the cached RX trigger level during startup instead of a fixed
>   default, while keeping the initial default at 96 for backward
>   compatibility.
>
> With these callbacks, writes to rx_trig_bytes update the hardware-specifi=
c
> register and the selected threshold is preserved across open/close cycles=
.
>
> No functional change for other 8250 drivers.

Same comments applied here as per previous patch.

--=20
With Best Regards,
Andy Shevchenko
