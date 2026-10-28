Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171861;
	b=Lh30hIqr2GObcRM6Bk+4vpJfwog8QXC+IWyaqyawjNxNpdOsh/3MOUGYuQBVwsxNhRFU
	 7M9/mlxfMGRt9BSUgaDHNryYLf2qR81NwO6Mw7pAjDtPfAVeBi7MzcuYU6fy7KclrptZx
	 ZR/uNBo7Z1FePAscGHA+y255trpWotdy6/lf94qJtLC19FSPkErk/lgFtglHyEil5+p9f
	 G1qThvpKkKY6QnWh3n0KTsSQCCxrnZ7E/FjoYrruL3W3P/wwNVtyyUab8nMAHG8aRBOJV
	 2ZZG1TmuQSIPKedreSyZ+FRdaHqVMXzZpvT4K+25ZXk2uF/XRPYLvBxQNFJFplRyFLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=X3qKYmW+KpgKThN2slX/odFU810T68LPK+2Pye7ps2w=;
	b=yjOJnDfS4ydT6N7mdmYrPhYz7fClZrXiRXd0YTRHb2REMmFnsWZoLsfsKqVq4DfJWl22
	 auDT6AAKMX2Pr2FvR4S0+q1zFRvDURaSi5kVLYhYUy4xABpUFuM0aE0hIJI5qZxe3DCot
	 eWiEQG/t1uLFP7bUzDu6cMaj13RDYEiCo4fXSZF1AcZ7imWgKztajNtBqGcnDqSC8bwr1
	 +nPJ9R7oDNghB+kW5FQRD1qSMUcKSBtsDFPfXJjn09H7gLa+w/a0GPb683/BCB6eGP221
	 oAdAAIqZZntoWZVhBh1GAmWLleHH5ifz2r3vgVmJux7PFtlT8WdFyamE1S0x3vU++6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mXYTeY1D;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CA606A324
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 07:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mXYTeY1D
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so5128005e9.3
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793171859; x=1793776659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3qKYmW+KpgKThN2slX/odFU810T68LPK+2Pye7ps2w=;
        b=mXYTeY1DFU0B3UNUDpGvH1++9XqRCHBN2c55fDs3gaMOQO47WsY0IeKIoXEOK7phre
         qDRnMs8ytOMr0qtfMOSb8TiEdkTuTi3zrvIo29YjRcHCIyNVRu5jvmrnw+c/7+ZTnZdu
         g+m+dlrewe4oGQ7cM44EPt9kdHQxTNGMX2vBj7nmA41j8BZlObfZrV/xzfLKEfzFF9JV
         zX00cy7U2P/7MMHvf57mTP9FPWSpdqrAGPOP7VFbEtS+I5HsiFc5gBOTKp40co7SyViU
         LmvhwSbNkcVsBfy3XytO1tE7SOLtX0a18awiJgg9Nhufe0Sw0QKxI65RIMv39zTiKOBc
         rFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793171859; x=1793776659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3qKYmW+KpgKThN2slX/odFU810T68LPK+2Pye7ps2w=;
        b=EU6YQsZL3owBrgjd/01RvViqWQn4X5lCwbPNHPK9Gg1fSOEZdBmR75J5oZMXM+vK8q
         4i6CQAKnh6wzKoHnNgVSyv+MZBXtG1WuNKwU8TuOuep38mwUSvTM2ySCIe/M0CjF5AH5
         f4axodor3ayzsn2+P6wuAxwzBF8WPX/acOJCC9o33u962cByM4G066j9cChk4qxc1CpR
         CFXervHZhH8I27ln57A+h1WY88bBr586E05mvDn49RabuHOdN9yzfVmXh9WEzDY2qpxb
         VkH2umOn1LnKe8mwdyRsHX0jMdWGExKfWBZ4Qqp6he/zpgZ5OO6NGfjtkjuCGngwoIrM
         bF8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwrKXPFew2V/eM98VNzUTbBUKXBiUUydRHWpypKWBY0GxpZKOcW/zYb8LMb9eLckoGmIo+wN9cMsicLep4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW1tFJ3dmdwQDwnyQwtK/cPa2/PT6S7MEH7CY8tqdpDi9zSI9R
	fXrHKoRlFVLjv8vw79LBMGKrQhBFbdgyhiuFHDsfCfgnB7WXFkh89ilm/I1RfO32Rj8=
X-Gm-Gg: AYBFou16fNfq0O4ftG5PccAABiFPXABiToDxf3ny9AmXl8z4T4RV5fuKfvxRiscEHk8
	WmwR2ZdT44rQJv7YA/WU8ZCBMRv12z5wYRp8JuLP3arAlW4PHSqhLBEqvIMrtAv41kJjp5K7iQ+
	5X15rUglj9WCcR2p2tteG9aExzgc4OB+5N+IYAHJuoprZh+A9oTh9GwMj1lbIG1OCPGUlGthudW
	5AOYLsBtCMFhp4lrb/wt1TGYPLZVjP0feapPg2NiEDo+J/+4HsFrIbIdERXuU1vJ/PnR3XPKMS9
	Myo4LZrCePaHmXEWdShUyiZ3MffNSj2QQqotQLBM5Tfpn9G0ka9QdcXfvtqxBArwsWAmIlFs1AT
	sG5RLuQ9p4ct6aUXadeIErstDVACIIcLz6QYiURzV5hPAkx9sMXje5SWNjA3Vob3XProoHOmfGr
	qS0NmpUkKyS96wf75Ed2TEc/QLuO0Zt7uOuo5+1VLW2qRY5pmIIjSC+lVU/7AxCWfRsHdrlsNVJ
	vFOUnFWMIaLWZN6ZtV3oqj+qWkTuhaBVnYSa3FM7oAUJ5W55a06GqEAoj62wmxwEItsBgbfk2Ck
	PzlpA3SAAvgqOEE55Z/oAbJzLm+lYIDxQAciguvjyHqoeLYLdeNx7M1IFLunE22Xxilo8Tqrvwl
	CcsXH+FWA6NeIjMQ=
X-Received: by 2002:a05:600c:198e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a967ba8856mr25106675e9.33.1793171859280;
        Wed, 28 Oct 2026 00:17:39 -0700 (PDT)
Received: from localhost (p200300f65f19a904c16506b94501b867.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c165:6b9:4501:b867])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a97bf5d7cdsm20719315e9.3.2026.10.28.00.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:17:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:17:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
	Inochi Amaoto <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 07/18] pinctrl: zhihe: add A210 support
Message-ID: <auGhPHjanNTkkzG-@monoceros>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bf4vux6swhzzilrx"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>


--bf4vux6swhzzilrx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC 07/18] pinctrl: zhihe: add A210 support
MIME-Version: 1.0

Hello,

On Tue, Oct 27, 2026 at 11:36:58PM +0800, Han Gao via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't use <linux/mod_devicetable.h>. <linux/platform_device.h>
already provides of_device_id without introducing a lot of unneeded
build dependencies.

Best regards
Uwe

--bf4vux6swhzzilrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrhoY0ACgkQj4D7WH0S
/k4lEQf/aQompiZrE8lzHamk+WXWr2kv9iqPDmKByLu358ny9EKvV3eNOG0y3m2B
hMQ9inmxBjyfz0TMb3NkQtmXVKnu41A8A6mcl3B97akrhcvKxPDgsn8FWhhNJiBs
s0jrcYuMILEssk5h7k5Ah8fEdVAXbDTp88j/afUmb9QfOZxjaW+SXfLYigacUFT0
U8Hy6rX3B+GESX5uvdxOY69bn4dHt7Qwr56FksGQtIi7Y9DbyRhhMRnwCy4pCLnw
ZD9t3GwAHwOm1fdsdqP0zLsJPukoZPNmbT58FjRf45TfYHmOSulG5O3oszd4ElAw
wrbitVSdlgy1G4VvYAZKJRQLV5gF2Q==
=JnXH
-----END PGP SIGNATURE-----

--bf4vux6swhzzilrx--
