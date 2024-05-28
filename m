Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAF16F270;
	Tue, 28 May 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902379; cv=none; b=R/VXQzxGTCHsSb4Mihf6xuLRUpKFhAik2jdG8KHs+f0kOryMtVG92q4wsWxIEgaL9kYZmVYcHeSsup9+jYE++cJRfA/enQ3h9WDTQ8fdh6qInIjbkaNAP8hHbRGtY82i7s1J4vaFyj52iLLkjpaT6U7Pb4sOT8XFheRi2C2e5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902379; c=relaxed/simple;
	bh=5cMzI+v8sDAeyKiAtvYu0nmQOVHCMm5QhUO/fz8L32w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpIcqLdSjnXUT9GWRUDfoRvbAdab3FN2qN5iFOA7Pah5f0SzDEQigpuMbJUMOEYXN6kM3oafAHhS8cGGHWWimA6ml6BRt8QfatH+xHUvK9kz5aL76Jq0iBNdJcFuNdjcBSaMhEGMYISpOcD9aoxctZPPM+ScgX0KbB8cE1jEWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFQXdHME; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFQXdHME"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bde882ab2bso151966a91.3;
        Tue, 28 May 2024 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716902378; x=1717507178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cMzI+v8sDAeyKiAtvYu0nmQOVHCMm5QhUO/fz8L32w=;
        b=XFQXdHME1EnAHSwGRVhun8I6iTmd82FNIuay0O5K35E1l/kdAXu+JhqD9CEpZrAHRP
         hfTW6TmgHxHt7MIyXqZGhXmB8LAUCWjdn1N2CRPOdEmFW7p160pI/FzQhHZjz/Ut2uQd
         8eZeY1cA7693Cj+nct1R8Jw03gyhnY6qRHhFsF1KZgSpDCso1HsM3SOy2NA3xBh3cNpZ
         s3E4VnrwW+CahY8icbfrxX8wb2Zjv3YAorVvrRJG3SyBVawRvhXaEGTlEaWc9b69Rd8q
         pP2i76r35Q+mmD7BwkBbbyaD1ocWFZMoAANMqG/Ag6xX3H66wfcRlaNPNhQMa3sMADCc
         q5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902378; x=1717507178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cMzI+v8sDAeyKiAtvYu0nmQOVHCMm5QhUO/fz8L32w=;
        b=lQNeGedDPkJg+1lvT0MLQxWrqgr+l5tCQfTlEqz2uuHrEJKh6VLJws5KBEvvYxKmFR
         ebOest1tlzzbhWM7aTSd+Am7ch8vPZU5SZ5dkJeF72duLdSVcEml7AZlVxSUPim9IgA6
         1BQ/sFrbTyxa0kvV4yrApT4ZOUB3jqpPM1HflneQVVOr8OshGfjXAClPUcituQgafLHA
         kCocxg1XZt6N7lX52oyd1AIziiZMFFmWc1GnxhxIeIsDOndoOe9p0CThB7LHehOfjzt+
         uSZUfWJ8uIQMGm9MFrH0NhahwVL49lnf89rA+sWhipWOseeu56uj1o0iBo7eF7UHX2HZ
         4Awg==
X-Forwarded-Encrypted: i=1; AJvYcCWl1hm+AD/9OnKyONU3BHpPuZvA1pz0iKW9egy0dgxZVc9h5+jUGm/YAmKhy6sgUDeNLg0cFqDfsNW/PDuQE9cCoI2q6OnP1RO5sQtHmejiqwRT+mdYls86NIvl8S7rH2GM0VoC7fQdjfPi
X-Gm-Message-State: AOJu0YzaNOclGZXFjJJNAkBFXexGaBZ2iucglAbOO5YXck7m3WAWTFhz
	/OVvAh4l7sIg1OpBc6GgON1K1kUYF2MdWrxbt7JagJxZYXrIggINia7bPRgTSomzG3uClUIJXVJ
	VosBDuejy/J/++xOJlxI9IuPUv8E=
X-Google-Smtp-Source: AGHT+IEX2lE0VCcvC7pGoKnB7c+rFQvdDWmPp7YXpTSFlvIP9+457a+iyNl7IkydoZmoCqXRmbTtbTKPReQBamn74Ic=
X-Received: by 2002:a17:90b:a58:b0:2bd:e950:dfa5 with SMTP id
 98e67ed59e1d1-2bf5ee1f6c6mr11120702a91.2.1716902377828; Tue, 28 May 2024
 06:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528094022.2161066-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20240528094022.2161066-1-linux@rasmusvillemoes.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 May 2024 10:19:26 -0300
Message-ID: <CAOMZO5BfwMrQGiaN07VC4ZUiTPjkW=epbckOWs2GAWG0fMXERw@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: stop casting struct uart_port to struct imx_port
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:40=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> struct imx_port does have a struct uart_port as its first member, so
> the current code works, but it is not how kernel code is usually
> written.
>
> Similar to many other serial drivers, introduce and use a
> to_imx_port() helper based on container_of(). No functional change.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
