Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CB1CF91
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429122; cv=none; b=cajMoFxNm4J8Y7habT4qBrvQh26HPSBpsNk8LoytAV2Kdi0TynzlF/tdcXXZwEvXoOGCK3yDKv/DicLmEJpXoSPxVo7CUMFurbL17UgepD6nKJbYDRu1N7z7MAal4FVNzD9z7GqtxDfp26WJvwNLPgL3xoJzNO1+sJXsB0KoRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429122; c=relaxed/simple;
	bh=9LCtHhuBxXswmvcVt20Vs3SsXEZWkZxwdcjfucQiMgM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=GNWDI/2Js7MAWcABomx6k4ne9jBfgB5YGdCoyraxzN6cDwsOyPOaPSU0HvtxCirSVzT4oAoimrr+SDWsm4stI7kdXk9upvxCRYQavhitOfvSw8I9YJO3k9t9992j/yhf6JZnM4dgflp1Zav5EDkIDmNdiSnNVj6YCixNEqA4REY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+Uiei5A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+Uiei5A"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3f29fea66so57627775ad.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429120; x=1706033920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAhjgUfJByTS52hcNwXo1XRbsYtHCOeab0hYvWz4vCc=;
        b=j+Uiei5AD7qe8SFinb1i4uze6GeheuG7zuf1OLs05nuw4HbkxEanAuGSeNW+UYNIXf
         imjh+cyTGasUMp/4Kh6f7Xcucv60vTSur4Udb0aDMD6o/RyhDLKuB0BmZDtQwSnoezXW
         Qjclz/uKPHLjpciLOKI1t8G7voBF4mnylvp3s8sjfGzWbYcil1eASXJkizO6J/lela/H
         o8JiXXdDntj8gF1omf1hgblKIL9MPYKH/RC2cICOXRf6RKT8J4JKXzNep4806HgwLW7v
         cbNvlq5dtuhPFh0eLwYio2XsHgsDXKcq03udKkKIo6odkWETCZXrNLfFTW3zY+qy+NVc
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429120; x=1706033920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAhjgUfJByTS52hcNwXo1XRbsYtHCOeab0hYvWz4vCc=;
        b=Kzmha/BNMLUG5a+Odp4I0KImugTGtq3mTGDHa2SiKR9eeFWPDgH89Dl/HXFvRTKHfO
         ewTe9bdEsKVpqctJBjvOXPHzfODVtP9maGcO1JYoT8/FpByr8J45H1jAQspMPgu9rGPI
         3Ic7vIn/o4DXTZ4p0WTz/zL4kRje523LWDoHxtAhUSxsYhAv/VfagzmF8DH3X/vNZVTB
         c4U7r3XigrVOjndBwAlGich5efBCzhlZMwiRt7H/7/xnuDd0ShspEjKgZxOWV7y6qmBB
         kbJ1vz7XLE1lBqjnS3od3VX1WdceCttwFrOcO4VhBhhJH1sLYWLMbHGDZOvix3wGLWV5
         QxEw==
X-Gm-Message-State: AOJu0YzN/6pKjk1E5GQlQciwCUEb9yAnNHxEsk96wsfuYJgv/Yb6sdhA
	YOu95I5IatuPLEMokcWrKbYn8fK9+418yOrBIWFRNrCgEqS+4Q==
X-Google-Smtp-Source: AGHT+IEfexzqZKM1MUiibGWNM+CK1iYq5GFuz8TAA9Jxp0kMBk0KePbVvTge5xjyIEdLfYcwiesHqxPs1kRT46+thsI=
X-Received: by 2002:a17:902:f68f:b0:1d4:2f1c:825a with SMTP id
 l15-20020a170902f68f00b001d42f1c825amr5323807plg.102.1705429119955; Tue, 16
 Jan 2024 10:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-10-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-10-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:18:28 -0600
Message-ID: <CAPLW+4nJALwC=ri-jgOWktkd74xJoGyYPeGvf1sY_tjYX_40wg@mail.gmail.com>
Subject: Re: [PATCH 09/18] tty: serial: samsung: drop superfluous comment
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The comment brings no benefit as we can already see from the method's
> name, ``s3c24xx_serial_pm``, that it deals with power management.
> Drop the superfluous comment.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index b9d1ef67468c..90c49197efc7 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1296,8 +1296,6 @@ static int apple_s5l_serial_startup(struct uart_por=
t *port)
>         return ret;
>  }
>
> -/* power power management control */
> -
>  static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level=
,
>                               unsigned int old)
>  {
> --
> 2.43.0.472.g3155946c3a-goog
>
>
