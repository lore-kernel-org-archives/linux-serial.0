Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F406DDD7;
	Mon, 17 Jun 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657059; cv=none; b=no92sUFWTEsx3GKnIBGqDF6rJS6i+lfiWZs03yKO3D1LWPxKeBSdyAFo9MR5rOZqfgpybAPON3YwtMNpI712X4pqPF++QEW9DcCXM67NcMKCYMz1QXy+S2eIMhpHJm/VlA/1gMk/7L0HqSOhHQ5ZcSd3EsggWYhtoHnzYo6oZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657059; c=relaxed/simple;
	bh=W8iIc5qhkqkINfKQNN/EjMnm6fnzz724bCAZOq4GB6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OspTHJwPxW7b2bc/LgA6A5imkJcn9XsjzgQIyJa3Dz5l7A4QmP3InusVtxkfN8Em7AwhgHUUSDHQaBPQttUHzbolIMeKbAfmoCvZc7JVXEvTvhdJJ1PQIy7WxpcFoJGgyYv9HVBBZ7NOddkUbwDL1Y4ixatjwi9V8keG/mvLfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYVquqPq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYVquqPq"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so53757471fa.2;
        Mon, 17 Jun 2024 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718657056; x=1719261856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8iIc5qhkqkINfKQNN/EjMnm6fnzz724bCAZOq4GB6A=;
        b=bYVquqPqAdJheeZT71tls1SYvGDKMwpmsTULfkIIVeL6KcSDlHcklkBM9Fzc3BIHAI
         MkvmfSZ/bOldOn/OnHe7A4JsrtMV/vNZHydO8jRayvVhaiOtbvpc+LEnu8SzksXcYCjY
         dmf8vgGdz65HU3LoRkMRfC7w3oYo8th98zOHLwxkUKpXSS7VdvOoVqaXQomaHwAewyH3
         OWicyre0ZhUcmbR0n3xPdmbDU1+hjE2kS/TQxVKgLlDobJTHDA7X7G+cDevO0wWk6sNS
         qo7ND4IF20vpuIIIAnvKHN3FD5Dxf8f6AhnY8pqHVh79x98XkPud+03CEHdY+AAYE4pe
         goSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718657056; x=1719261856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8iIc5qhkqkINfKQNN/EjMnm6fnzz724bCAZOq4GB6A=;
        b=dA+pDw6Orqdl7noPLx7p8aE0QE1OukawR4NHSj0oXZvb+ORWwuE3EabhkMWQr+mV3P
         Nnml+39dXNoLgxUNKVJkiohwFFNKLeDArr7ZzzrHMlQcWKK2uBraLMgfSKXJ0Qk0gJtT
         jBOI3U3H53uhW9sw+hQIBJeqeQnKlE35U8HMQonV+J825vNOkMRerc584N5P24qeMaZp
         NaR3iroeY0I0otd2L5FwxNfHt46V9ldN09LhxAOb+seZ5UAbtlKhA3ekWXh73gFybZir
         7Uw+qsoEXpU2jOVarrAmUwYJhR+8BC0It0zBxO+JWA96P6OLcw6tPRVy6LbjGokdDhl2
         cpLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdZ7D4uxHkAiBxE1TySH4gIIV0bEoxADMegi1QCs2BzGh13Gmk85n6ZsEYfBuRNpROTEE+lRMf6dP7qa5uSX4lJo1NlkKJ3YjOYHT4zDF+C7tnf4f42n6seYy0SDOgYO779XddG+pZZQ==
X-Gm-Message-State: AOJu0Yz/zc9C35UH7IDKqVs6DtqaU99gnnnCZXBEhfcJErKwqGbDuMMB
	A38sSwOO1Dkacl6L26N602gFSLlNuZsj1HiJQT5lNmmRJUdCkzYyvfa3Ump5rvRWfrjI2J1fIYJ
	4spwDaae8ov1R1N9IPBoROwBvSSk=
X-Google-Smtp-Source: AGHT+IE4RZo3/SD0sNa5Y0pH0ocAVmsUWsfs8YhWunn+YJsNin9DjD9ZIKp0Oo2hXdLOTP4QvA+OrGx310R4ntSil9c=
X-Received: by 2002:a2e:968c:0:b0:2eb:d963:d8cc with SMTP id
 38308e7fff4ca-2ec0e5c9e20mr80476691fa.49.1718657055314; Mon, 17 Jun 2024
 13:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102952.679806-1-hui.wang@canonical.com>
 <20240614102952.679806-2-hui.wang@canonical.com> <20240617120347.907e8e1e8eae5824930dcc48@hugovil.com>
 <274b7ed0-28fd-4348-adfe-c4302fea0c09@camlingroup.com>
In-Reply-To: <274b7ed0-28fd-4348-adfe-c4302fea0c09@camlingroup.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Jun 2024 22:43:38 +0200
Message-ID: <CAHp75VeGnpqKNKaK_nUm+HXuqqTX3SzbkjgH4ki6-m=j2O-YbQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, Hui Wang <hui.wang@canonical.com>, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, 
	Maarten.Brock@sttls.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:49=E2=80=AFPM Lech Perczak
<lech.perczak@camlingroup.com> wrote:
> W dniu 17.06.2024 o 18:03, Hugo Villeneuve pisze:
> On Fri, 14 Jun 2024 18:29:52 +0800
> Hui Wang <hui.wang@canonical.com> wrote:

...

> My hardware doesn't connect this line to the CPU's GPIOs, so I couldn't t=
est this properly - but you can at least have my R-b tag.

Lech, you need to provide a formal tag as it's described in Submitting Patc=
hes.


--=20
With Best Regards,
Andy Shevchenko
