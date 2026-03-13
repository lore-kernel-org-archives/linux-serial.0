Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7031F9A0
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388618; cv=none; b=Ee1G2ulfRAQZfOfLTs8Gag7HCo9T8E6+XXHc3p45pnP9J/I1Tv88FCmjVo6SJD0ACKg2vapTlBNd9qeM0uJNAk40JZ7wSvQ5gRjbiLWfW5DqZ65AFxRCmSrvlf2+GxzBbCA77Wj9wsqRoqroLvgdxuDRb8FF8EDrJ15axz8WpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388618; c=relaxed/simple;
	bh=88oV/wY09RL1JT0C4MCkLhpCVxBd9308jToc+nygFPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4iomlMTaOIt/5tThFsb66eunfGWog2ImPRely/sv82zs0Z24oYLNZaqDi+ErMmV3Fs1+PNc83jeQpdc+Oj0j5E+1QfKS132cYLkmfLbucz+IbNRfJ8Wg3hi1yt4HTB7KR/pvPkTiIiZQOL2bNLwPdbBe1kWlxxJrQ6SPFCxjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yLoWfcsH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLoWfcsH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48540355459so16062595e9.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773388615; x=1773993415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88oV/wY09RL1JT0C4MCkLhpCVxBd9308jToc+nygFPU=;
        b=yLoWfcsH/hX8jMGHv5Z2oRgIWNjhaRbhzfsVVvBSHv0NJ3uz7xHxWRoebKlOsGJNYG
         dNGGsJxuecgofgPfz4QJGM8OasiNmO3A4h3KhxXB1Qx2zbGiog92BMzoFYp/CkdStaE5
         5R3HddBIfSOAYO6pMncpvIL7mIrGgpbcBFZoWRESlSY8CWAe6K7NyRHrWYr7FqelAk8d
         IQ3KYHVKWxV6sYoF/oUHUULVVjbxGwJyzF1eNyRLu9Q8m7mxFRVVIJe3aMPwTpNrjEi+
         0wNXn/8f22gII4eZHhXco6tzRRsIMQUuFF2lC4Oq3/djdaqjUK+0z4DqITvP436/oLeG
         wk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388615; x=1773993415;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88oV/wY09RL1JT0C4MCkLhpCVxBd9308jToc+nygFPU=;
        b=CF2eUzGe2E84J35hWkQW/5HChlZ4L7MBHecXZutM1BrhiPCc0pUQVRmlMZjf8TFWLz
         lJjxx72QeKdxg9JMmt7D2K8auNFiMlUeueXkehKV2SpsGw5aGqUz/wDAD64irpu/v0mb
         N9u5sHOiLFtjl0Yw+JvcVyRSRW9WGGOWbeJuVV7A5CyuHVVpEfzXNB8HCYYI4CVFFYJc
         QWO2fDf7yuWuYga7J+1GyV5/g6EUlbtWC0tRf0uBcBOSztxjpVN6XS/yqDkMNdBjo0hv
         CTDxGRx97Cq+RrazfqyV+xCWmeuaUZXuGwXf4yvbZ4BMwtTV2OKAJEBITN3tZ3U+uIBc
         26EA==
X-Forwarded-Encrypted: i=1; AJvYcCXMU7o6bi3LvHhHCr5wmiyBn5Jb0KCoarvn+QPCCTHtVr/AgVNj1jCLwCcWsot+58Gu1EIqab8ccpnge14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYGKAP8DK5mjJDPwkxaKEvXXX6HR8XXZrb32aEp6ztCXFr/+U
	WhHy88xqyIMh6ngl9N9lbNN9C6QgbzOpZcHCa+XR3+xk77k87Mnegt+DJO7/hZL/oAw=
X-Gm-Gg: ATEYQzz+VXwJIFI2/+5FLq4w1tmtKYVEofwLbZlIZIPekFyr7e7cHWH9jUvd/YY1ls/
	tNZpJjL7RPGv80XsuCT94VJQXXD4yTMBNhqzIhm34Z/Mbb3urLjdC63cKG8lQJjb7C1/gRweL9T
	fS35JFAECTbIZ+JVf8LJbrBTZ4UmdSj5+lrSteDequw8hIaNk2h9DDabPB4BjnXhpzWGWQMNkTF
	WnTQP5xEtfcNPsNDMhLw7+XWCrtCmHHVeMnThiVq/6Xd9gBzY6VH0QzN46uoXHkfWOT7tN64VNq
	wrH+Zp2xWsnZz6wnT8ODt7yJORHMR2V/SbK3V59T4LGswnQ9MT2aVvYXlkjj+xD2IVx6HRsf5Bc
	awcBACOgC22woAhcxSvz/MIMiLBHPUrs0pw0OBXzs5JR/S/y9LcgjK0s9q01Snjtced0NsbDkGs
	iMGWanHQ==
X-Received: by 2002:a05:600d:6444:20b0:485:4388:3492 with SMTP id 5b1f17b1804b1-485566d8d8fmr23777485e9.11.1773388614705;
        Fri, 13 Mar 2026 00:56:54 -0700 (PDT)
Received: from [10.128.148.22] ([151.47.92.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm186821945e9.14.2026.03.13.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:56:53 -0700 (PDT)
Message-ID: <2bdfaf42eacaaca8960589ccbb0a420f1e5c4aed.camel@baylibre.com>
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
From: Francesco Lavra <flavra@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kartik Rajput <kkartik@nvidia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Robert Marko <robert.marko@sartura.hr>,
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,  Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Date: Fri, 13 Mar 2026 08:56:49 +0100
In-Reply-To: <2026031248-devalue-diabetic-51ed@gregkh>
References: <20251126090759.4042709-1-flavra@baylibre.com>
	 <c850b374071b694e4c33ca091d124c0e90df02e1.camel@baylibre.com>
	 <2026031248-devalue-diabetic-51ed@gregkh>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-12 at 14:43 +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 25, 2026 at 12:35:53PM +0100, Francesco Lavra wrote:
> > Friendly ping
>=20
> Can you resend this, I don't have it around anymore, thanks.

I saw that it has been applied to the tty-testing branch already (thanks!),
anyway for reference the last version of the patch can be found at
https://patch.msgid.link/20260303111438.2691799-1-flavra@baylibre.com
