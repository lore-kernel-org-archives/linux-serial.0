Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251C21A02
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505940; cv=none; b=VR2H407A4K7po94ZAxuubq0QhlsZR1U3DZiNnPRosUsvIgEJCArqi+xhtEWI4XV4K+QhpQdVS+1lSRTAJNEenvtf78W+wOMABxWijp3WiiiwfN0PlZjH8ZVAQ/VWshCg/A6AbpQ7cx6ULYhvpyyjvH4dY0riGU1Azfaavzhaj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505940; c=relaxed/simple;
	bh=iQ7itby43BSx0xynQMS8ijTGKazjAWAAhMKEoJglSwY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version; b=F7nQQkmhPSp+YjqZa8bwCoDxshwj1+RBT8bdmW09mSr+tcTkNagNPk/873fxJ1CwVPysyG1Ri7Pn8o+WFll/iv4AcenaoUhdlTvrB+LXeqtsRL70bmxynrgQ1QToG3KyWjQTVAbhVtdUI2efyfFnZRpDtOThR7MsYyYnmbAuk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V9BeD8wj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9BeD8wj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so4029375e9.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705505937; x=1706110737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AHIe76/zPrvtJ/ms59RFYFIDBYoX1+fcYvY/MxrSv1s=;
        b=V9BeD8wjEZYVJ14NKcZQGZqSDKsC87gqyftpYoJuy5DrROpEOp0ZDGD4SXq4h0Yc/6
         cEHDBIa2Fkp7zZYsyZ+BsOU8FCqm4+HVSL73ddQOxvC/T2JgA6pw7ZweJdLJ39GMZTZP
         GRjG4w5zJw6qIHYwix35C/OAgilvr85Wn9mTsybr0VSeSc34ullnJ2Y1z48Hmgc7q+26
         A8YdKuVmA88ovcEmvuUtzcH/P4V4JCfiOMhh00Tv51ce+e88y6+kKVtYPAdjd9FF0uTc
         7awLmJKZXdSR8BJBDFSUEBgUsPTxXSTOzsXDuf+7VYHUuXZ+nIuVRSFVimnvid5X/c+h
         UDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705505937; x=1706110737;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHIe76/zPrvtJ/ms59RFYFIDBYoX1+fcYvY/MxrSv1s=;
        b=RnUXVd79WQphCG3hFxNU804HsfOT268CJ04A9HIbQIZ4wU5oyc8ERKsh/Lkg8owddu
         gKR0fV7lPg4X/87Uy9lzNAy7pU6UK9zViCuyb5Y9Zr31Qq/ChBwl8oEnJEAsFYyGOKKu
         tTRqhUOPwXgQKrpanhRhwuJA39Lo75n6ZsRa+aRR2hrQ+RrNWJjHhSMW3QiZF0QPfK+e
         HNwiF20YHAB9sXo7xtb53bS9yEM3sLeONCHa8U3/tie6CTE6jWRRZiC08Q4VxKpXm8oC
         Ze9L2UbwiE/ZO4baLitrLfIFZufnlSMxYUdnbNKOfV4y1kn/9Cq8+nniOP1oQwHynEtI
         xS+g==
X-Gm-Message-State: AOJu0YyIbelnkbNwIYnfbrn2CefN9YDaM1zsbWmdyTot9OKmVyIlxY+B
	Os90dw5Zl6exz5/yX7L8Jxf4rLnr3jDD5w==
X-Google-Smtp-Source: AGHT+IFV/Y/QK8epiDPjRSEGlOZHxAJNe8EwHrV5tZVYNXXzxYIO5ZcLL+4nrYomezsBSeqVAKi/4Q==
X-Received: by 2002:a05:600c:24d3:b0:40c:3e6b:efe8 with SMTP id 19-20020a05600c24d300b0040c3e6befe8mr3113561wmu.241.1705505937181;
        Wed, 17 Jan 2024 07:38:57 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040e77ce8768sm10969236wmr.16.2024.01.17.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:38:56 -0800 (PST)
Message-ID: <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Sam Protsenko
	 <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Date: Wed, 17 Jan 2024 15:38:55 +0000
In-Reply-To: <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
	 <20240110102102.61587-11-tudor.ambarus@linaro.org>
	 <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
	 <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-01-17 at 15:21 +0000, Tudor Ambarus wrote:
>=20
>=20
> On 1/16/24 18:21, Sam Protsenko wrote:
> > On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> > >=20
> > > ``max_count`` negative values are not used. Since ``port->fifosize``
> > > is an unsigned int, make ``max_count`` the same.
> > >=20
> > > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > > ---
> > > =C2=A0drivers/tty/serial/samsung_tty.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/sa=
msung_tty.c
> > > index 90c49197efc7..dbbe6b8e3ceb 100644
> > > --- a/drivers/tty/serial/samsung_tty.c
> > > +++ b/drivers/tty/serial/samsung_tty.c
> > > @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(vo=
id *dev_id)
> > > =C2=A0static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_po=
rt *ourport)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uart_port *port =3D=
 &ourport->port;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max_count =3D port=
->fifosize;
> >=20
> > What if port->fifosize is 0? Then this code below:
> >=20
> > =C2=A0=C2=A0=C2=A0 while (max_count-- > 0) {
> >=20
> > would cause int overflow, if max_count is unsigned?
> >=20
>=20
> good catch, Sam!

Does it matter, though? As this is a post-decrement, the test is done first=
, and the
decrement after. Therefore, it'll still bail out as expected.

> I'm thinking of amending this and add at the beginning of the method:
>=20
> if (!max_count)
> 	return tty_flip_buffer_push(&port->state->port);

This will not help with overflow. It'll still have wrapped around after com=
pleting the
while() (always, no matter what start-value max_count had)

Cheers,
Andre'

