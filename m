Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E671E573A
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599823; cv=none; b=Tqe0YQWl9S3lzVqSSKjV1zlHEIr8nbKcm/rhmdJEdakAx2BJQD1I0Gx+lyRvTa8faDYHXUKNnK91vEHnw38XfvdyQDtXuA80PIMYQLju/UFVtM6ZZmTWGSfmGHSAsSsQ1J1JH9I4XNts4ufPP93RLzvDJN+Ipjo30T2zDzcieww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599823; c=relaxed/simple;
	bh=ELTIZpa/nLA7FG1SYG2wR8cL7xe3VKiueavOjWMz2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL8Iy7ZiPox9y+maHwIgi7vjzHTsz1eA67Hf/nq4SMNKTXD410+66WCKB+JIbmcnJO+LbUKCkKH7/WOPEyuagiEi5JAQNGh+UbJixySTzuOo4IGvYIPaZnHwERodVzsmJVU/XRy619iumHq7Yd4gjct9XuLKr5hQ9UFN0mGDnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l5v+C3bF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5v+C3bF"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so16085651fa.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599819; x=1729204619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otakXsanXUr8ItyEhwzCKI/sGAGwRsLWsuVYvQjRYBk=;
        b=l5v+C3bFFbbTIfTum+xLlonRWPHEWLB+De1cGtkdEak5P4Y2+S3bkUzik1Lglrwtvg
         48/sAq3s/I7aLZcd4kSBrEVTQv5Iph0D/8E/+H8NVNjsNjLjExrl+7iLeUnKjCABCVA+
         dKmISEKLSr1GZQIqZMGx/Dw34T/uUOYogELjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599819; x=1729204619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otakXsanXUr8ItyEhwzCKI/sGAGwRsLWsuVYvQjRYBk=;
        b=NTEyMf1JHkiV3DE6zFDuNTsOx18D+B1JgB9r/XYZs0k0fui9gJmE9XcwbAUbEpmnbb
         Kc8hCGNuvBYYScVMN8bSw1WmCN+cHO4H0Km5TlF2c3QRztruatnMdo0pNWlhxvxeO4U/
         IxxJZuJkJRpQB4JxEAMvxnSSmcXEhZiWGjN+lWyfxv0cHNVvGRepSsgHELWZQejerOkK
         QcGjX961w8DCPcn1EFLCCbw1bt46j7BXHUO+Cy8O+6Rj02daeN+kezVBra6opAYRF5zi
         CGIWKdxUer8cLHZgJawJm3uGRC7UleQd2HY7vTam3xr9T+Yja7S9f52cOm+tLdS7PQnV
         AqJA==
X-Forwarded-Encrypted: i=1; AJvYcCVjW6GvlesCdZ95MVFqi+k9iZUwVGzm7HAfAZ6OFe8r1hP0MIjSldPRer178l/mCwqZWaDkNWqLKz/1PaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQia5Yo0pPr7ZD4T2jl0g2G/xq2eIBxx3yY7SSp4/KpNfhPmv
	p2mSfsk1EN/vz4sTrdAcr8OTsdjfxS1W4f142alpXouc+Ae1nl30IKpxVqygxQ8eG5PORgUOpE0
	gPiPv
X-Google-Smtp-Source: AGHT+IHX/djkJ2jGclUHFKNWuxN25zg66YLuLvNWSWMfNJhIi4UGbk7RroaLSbkKZKFYLMMGc/6R/Q==
X-Received: by 2002:a05:651c:198e:b0:2f3:e2f0:af15 with SMTP id 38308e7fff4ca-2fb327a47e2mr1423791fa.30.1728599819178;
        Thu, 10 Oct 2024 15:36:59 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb245ab69dsm3420451fa.57.2024.10.10.15.36.56
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:56 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2facaa16826so13185591fa.0
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/VMOBVwC/zZRDoEdTP2dA/Lw8cN//z6IHI//EpK/5JjwWghYXb1vQ0hv7mhoRTCEH64GCrh0Y2hF2ktc=@vger.kernel.org
X-Received: by 2002:a05:651c:221b:b0:2f7:663c:48d7 with SMTP id
 38308e7fff4ca-2fb329b2a84mr1316951fa.39.1728599816013; Thu, 10 Oct 2024
 15:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-10-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-10-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDjZWLDt=1rJWvwt=QWNWhJeNYAfhgDmLBiH0xiq+FjA@mail.gmail.com>
Message-ID: <CAD=FV=VDjZWLDt=1rJWvwt=QWNWhJeNYAfhgDmLBiH0xiq+FjA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] serial: qcom-geni: rename suspend functions
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the unnecessary "_sys" infix from the suspend PM ops.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
