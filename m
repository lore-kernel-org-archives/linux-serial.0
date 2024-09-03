Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14E2A1D6
	for <linux-serial@vger.kernel.org>; Tue,  3 Sep 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378602; cv=none; b=RhI89bkws5Bv5zm5PmWYH75zJnbn++ibBcqlRe/U468BsIKF1he4GEkiBOseIZ+c1/TVY2LPNu/7xEyQJPlC5qtPRSsYYt9HAtdntAPXiORF6ae4OmhTx74MpxSZzRaob1Dr3hh7DGqLTUMHqBesFNgN8K1H50ffIn12YcTx3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378602; c=relaxed/simple;
	bh=bVviEKPveTmpcX7L/OUEFDloCUYNhXrJHYHWwks6MUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpnmneHu/NAeY922YJcWeDjTRO44spoTP6vkraT8kY2BWF/+9Pk0yoN4Oyp4Lda9cWdZTTtNeqHw/dfMxkV4zNjmaYrp8sKdLgyx6TcJPDw9AREZvvGC0rYBCMh3WRcxK0IK7RQw0bVxy+OUXcwAF9r8bR3/M7zdhNEFaMU5K50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I/8BUarG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/8BUarG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86859e2fc0so618778366b.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2024 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725378598; x=1725983398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFhHwW1kAAGcV7OaaSbrjXWw+zX1uM2EQ/+cB02HHBY=;
        b=I/8BUarGh4WW1gmbpJ5o8y+e/K4cOeEA9TVwOLK8BggdSAUQdDiI9OVPk40tOEG7ry
         KvyGnANdJptjqcftsU+ChdII0/jcRZlkyrn2o5zOgMJ6U6N6wxXpYXN9PveExk13dodI
         cqtflnNr987AE1WR4Mrqy/wzj1DR0uCH5YyYgbmYY33mR/rfwuMBDJSehTVBhIvwbqDT
         dpNqST3f8vDXMDTo0TRy9DMdHePTqRbT0BvMFrjRUV9jBrhnM6Vjpi0VZZz/A6vmTokZ
         u/9nME2iwZoCT/eM9a1oe+0ynQwAeDShNxEnDkEkN5zZJ+CdhO+maWlfLPESUwKjCW/t
         a4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378598; x=1725983398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFhHwW1kAAGcV7OaaSbrjXWw+zX1uM2EQ/+cB02HHBY=;
        b=ZobG0x5VX4kT6fqRKrE4n5s56m2Uk4Dv0+TkCn+tgN+SHuSOsfjuQuAwbSbOsme5F7
         iofgs6G4+5KX5kh9BCTAWCmcYmVl2JjTaJ6Y6NOcufctPgkBUCjH6ksiV6ZLEDDWQPJ0
         vTCNHM55V9bdQUdAatdcSBPbB/8VXRzt6cdScLwQwVsKXGwBEqbB6CyCVtfZU6rekKos
         2FnUDJrMpl8wqKDE2jhkVOtyg7VBBBkIgGnpGVYuSgACJV8c3ptgWPkA4jud5wgeV2nt
         uXS0nKJVEgIIIgElr9JhVHiPtd+FsvotWV8khZwrYslvsXlyIXglKzvwdiM2gnTshF3R
         tT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkTBRpr5EACMJF3DpaMpesf4JbwpHDMrRhxGNz+9oq6PIzP/atf+DIeKCoFND7Nwodk48ySynX3YAtdJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPmOGwHMOeNRqkZbT3pxchcNDhaTNPo8wRphF37YLp5P/pZLg
	gE+BnkKfNS62ue5ueYsGuXFFoBSLDqfhls9/2gz81gYJmqirAAkFFBp+4wVvZ3U=
X-Google-Smtp-Source: AGHT+IEvdlu/j985eM+/rA5qaBqF1lyB3uR8LKAuX5UqTugImcvkKswP9Kfp18LHlYopPINQZZ8L0g==
X-Received: by 2002:a17:906:6a05:b0:a7a:a892:8e0b with SMTP id a640c23a62f3a-a8a32e717f8mr105078566b.19.1725378597538;
        Tue, 03 Sep 2024 08:49:57 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891daf9dsm695490866b.164.2024.09.03.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:49:55 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:49:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	andi.shyti@linux.intel.com, andriy.shevchenko@linux.intel.com, florian.fainelli@broadcom.com, 
	tglx@linutronix.de
Subject: Re: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
Message-ID: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
References: <20240903131503.961178-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxnfsshwxceyq7si"
Content-Disposition: inline
In-Reply-To: <20240903131503.961178-1-liaochen4@huawei.com>


--oxnfsshwxceyq7si
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>=20
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/se=
rial/8250/8250_aspeed_vuart.c
> index 53d8eee9b1c8..25c201cfb91e 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[]=
 =3D {
>  	{ .compatible =3D "aspeed,ast2500-vuart" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, aspeed_vuart_table);

I wonder if you found this entry missing by code review, or if you have
a machine with that UART and so you actually benefit.

Otherwise looks right to me.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--oxnfsshwxceyq7si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXMCAACgkQj4D7WH0S
/k4lmwf7B8rCxzF0mqdiYNNkbNIL3ffkntFrgpHxTr7Sgi7iSyeFIXO7tcZuG+5a
2cit024915U223OcuPwrk/CSeOWMVzLMcOMeHtcw/45I4oFNOsP30p+0AiDVGrqg
+iOyyaK2sFMVHfp4yu1NlYaM64Ez2aW+bKrvaNWjI1vK0S1/rpdGvzTcqvxkrW8i
sKXg+rOE2QPCSliNu0t6goxHQOGMOnhrloktKH/+k/8/FjVpJ6KTNLqdogSmnycn
qbkruy1osW223l8UfYtw55w8idpmZmJCSePvmRrePJx3j3IMLKrzD8vROhpP2j0Y
s8lqi37r7SkeGx++B5ny1hfeBp8VJg==
=dQsN
-----END PGP SIGNATURE-----

--oxnfsshwxceyq7si--
