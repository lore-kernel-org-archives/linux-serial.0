Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE456179647
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486702; cv=none; b=BWgp9/j2oBHqW7tj+rNesUDJig6Pnm2h5UiTeKSgLSG/a4+KqbG6tZ3hw7ACVzygC3OlnQH8RBRcgTgCjLNvsSaAkOyF5XR3vL3xRfprRr4oIli1JX3kdMrv3+WsUB3WJQs+KhkaTHr+bhuT+8y/eO+sCszavA/Q3zwn4qTSDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486702; c=relaxed/simple;
	bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiaoubACfEYZ+Jnf2PRUNGKSdo5dQqTlb8twXxZ8DTMH1w/J3k8RBQ2YidG5aJyu/83mdvYN5fSRUNenONzdiNeZ7uKTz9sz1gfjC3G5Bhlnn+AnAvMQav+tTwP8Itfv+fWr4LabC6L3Vg/YcSNwJPhO3Sf7JiByB5pGH5ADiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DbyohPtG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DbyohPtG"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a7fe683c99so5832985a.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486698; x=1726091498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
        b=DbyohPtGfB3vtB5oTI2/rK4SHcKdaPnFUMyb/rGr2CgCFE3gWT3px9OWjqU8T/pbp6
         6Qb/p2nsA6qESSTuh5t700TcVdXqMTQRL6P/Q4Y4GIWPLxJHpczzlbi0WDOmfyk4pXL2
         EwwtwLR3lutGqqh+C5zJcSAdGxwj/m0RAJNA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486698; x=1726091498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
        b=g/WQlfNxfR5YfPaY9QtrprQfIehSi5I+1JDwEKNTDcRefAIgymVd0q0IeZh4eTjGuv
         o03oiosHc05hsu29owV60FLXfTdUDrYymlboe6uKVjG69qqpHZbsOjCman92ZEC+M4Xv
         KWVwokSydKfvyv2xUqmoq3tJisA+1uM895TuqXlPA3+53oK/3DMy8fmZCs7zrJD8bDUb
         vykfp4wzq73/IShmeIMOVfcnWiMIqscr6tThlwUdDQ4JcuUKWAJxKzfo2Cv2Y9AeAGZN
         wZ/aV5HaHJlU0GJ2b+0CHotsmvQiwQxo5rkT/9OeDuePGT8WIBhPD5QQWUS2GygBzSER
         o93w==
X-Forwarded-Encrypted: i=1; AJvYcCV2lhVjpuNc7wLQ7+dvc9RwxuEkIBhWdLqoLVx2WrFh26Rx2sKG3sReiafCJJdaIiUzln8TeEpnhVkctX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtK9JIgOOIDr0HazXzxAfJP5vQv8ayJZnOSzmJZ6NtrnM3Cty0
	6epzMP/r07NTyzTXhubjlfEVScnRkOqL82fjTiQF0rzt/kNneEeFLMeF823SYZSQhNQsbIhLTDQ
	=
X-Google-Smtp-Source: AGHT+IGKl3yyF7qXv5vQzOF7h7PSSNrCLZoZlucYENKgilGxY8ZoBJYdH3khO2Y9m9hTessQ1APj1A==
X-Received: by 2002:a05:6214:3107:b0:6c3:5afa:e6e5 with SMTP id 6a1803df08f44-6c35afae8afmr174129296d6.10.1725486698553;
        Wed, 04 Sep 2024 14:51:38 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520317307sm2252646d6.82.2024.09.04.14.51.37
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:37 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf6606363fso463456d6.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzPTD3ik5T2TQ9rw4aCDwfXBU1occ8QCiHMmfqip/ypU59UWQOaMhfEEZMRXgFZr0Vg4CaAlJjvPkT4T8=@vger.kernel.org
X-Received: by 2002:a05:6214:5f0c:b0:6c3:6ab0:9dab with SMTP id
 6a1803df08f44-6c36ab09febmr118827336d6.48.1725486697181; Wed, 04 Sep 2024
 14:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-8-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-8-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UX_knVfrei4UPiR3DT=H81ybSjGeDGAsWc3n6q=PiFJg@mail.gmail.com>
Message-ID: <CAD=FV=UX_knVfrei4UPiR3DT=H81ybSjGeDGAsWc3n6q=PiFJg@mail.gmail.com>
Subject: Re: [PATCH 7/8] serial: qcom-geni: disable interrupts during console writes
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Disable the GENI interrupts during console writes to reduce the risk of
> having interrupt handlers spinning on the port lock on other cores for
> extended periods of time.
>
> This can, for example, reduce the total amount of time spent in the
> interrupt handler during boot of the x1e80100 CRD by up to a factor nine
> (e.g. from 274 ms to 30 ms) while the worst case processing time drops
> from 19 ms to 8 ms.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
