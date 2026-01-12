Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0A322B66
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208946; cv=none; b=tZrNGDiN7LYTSqR2+rPLyOcw0F8uc2IRe0F1RXqnyzXshbuJ9ZP+RVqv9XQxkW3elArXKA64k1rHSaLkV9CB8ZDX3in7uTQMd+LQdCFl1vd+5ocVqwESw+ZMNlSlICeRmj1FuMdh9yOc26eKRtdESxvQXeTFl2vmJ8vwpMfrwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208946; c=relaxed/simple;
	bh=/5k9fMZ8XMwYsuJe//ZW+X3cSNsdAFHvfuVmY+FHxtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjaAtf9B0PPZ0IlblM/M23eH6kYvc7fA3KcJbOpDoTf3JpcMR1zclEaMZFr+JtxOBK6YaTVukZ5t3tO7sJfvALJYiPtIOc2psfPrJOAyfBH64nwEFJVmfE3KOLjJKjXG1VM8LMLwwuksuiYcf9do4qFDVz8HKN+rXAiYZ3v8AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DTcG5mmd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DTcG5mmd"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so1782790e87.1
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 01:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768208943; x=1768813743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5k9fMZ8XMwYsuJe//ZW+X3cSNsdAFHvfuVmY+FHxtI=;
        b=DTcG5mmdzjsb0b0xmxBRNn1BJy4Jg0ariHgDsuynFhLgN0ReWWgU+cmV1eSIPaQHxQ
         CRrkvtEWJutEKJZlsN8B+SQtdtY8SvmMhbK0Sr7/GPEqA26DEOaHC4tTB+q3mL3Z/AkZ
         yuOsJFSZJAxcoXz3olLBMcghaADi1XAKro1igVDwIQSXb5ReRtp98q9Gggz/r17hEcFC
         6QGox/zUHuPJBmXW1aM+w/TldkqgZr4bT9K7g0Gr0e5wb2CfVEupfAVKlifs8BYaQr1h
         Ysyg8M8ViWhW2s2rt1LV6XSWuocagtJvCs4AudvhHJtjgrWNEnVSZ0/Hk39irUG/ocrW
         5zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208943; x=1768813743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5k9fMZ8XMwYsuJe//ZW+X3cSNsdAFHvfuVmY+FHxtI=;
        b=Eo+pfPBCOA+VIjX2oozdDEebcoUrY60OeFVQy5xc7piHaPpeg8DrppuVhlH8LWwG8E
         D0O1ZDCktghaMeBHlj6l3Ciwii/UV+BjWorT9fUsfD7SN9szsNdvNQK+KhpNlt0b3YTq
         tUt8LkbsJyprTI8F5U3ywEuExZhyhHAlKF0LYWQ7PHJX4e5CueWB4UOfYia2WaJSv1Ud
         aQCcJFA/AE5Ef8Pv2xyhcLOzYdB7JTQEWkRRh88XeqGz5f0XX3DI3DZoZ1PLjRSQjWKI
         vUwbb7v1UGXfa2D83oDVk4Yo6r2kcfC9o7/sa783ZY0p8qrfgeU3KLliH0UeTB45cQeR
         JhHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdJplABlEOgiD0+dQrTWnRNOqLZUeXrsWWnhIFRVOeYNGygVpSmcp11fhWg6IQUo76uyNv9UinKfe7lqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NToGj8mzdVJ0xZt4J7C85Bf/PzE8SdF8N8zM5puXtK9NUgM2
	U323tUM5DvDnyBQr7Ms40vXiIc8XuLFz2jBbIjr/5GJIoim7DZszX3f2j99RzUIn4hvDpC3HvCb
	sTIJ1OMm2VKud+F4hF/7PATitb6sP8gIFBJxWusTncA==
X-Gm-Gg: AY/fxX4p4fBA0EFxPyWkyWSlqPfKOGRQ/wQ3aDfnmI5gt6KrssoTL1oFnzBxXbrtVem
	BHDBDjF3Dyxv9UE4twEdaoWJmkuD7Jypy7Hi5Lmyd75fq4QtzkqDqU74ERixI74Ba1iEVrDcB0k
	+JFBrfwkcc6sdI3XLkEEwb9r8geqZaFi5GWQ+iUUJthkZkKME/RZmXibQa2KQ9uV0Y56zwsL3Ey
	L5gPW9tySL/Xdd/5rBN6zj2b9h4O7CAXp/EPmauO1oOnSRR2EENJgiagKwyb8ifhU3yaSZYbsfd
	CcxsEwWWy4SqpfUiX4x8VGR6ipM/
X-Google-Smtp-Source: AGHT+IGAl6Q23WWbKnl+BSA4Xuf1yyRYHXILClIMUfhVSOW/jQoR1RjudvCC3YMn+S5pMETf+TMQ002SSG5aLLdwbew=
X-Received: by 2002:ac2:44b2:0:b0:59b:6f3a:9c7f with SMTP id
 2adb3069b0e04-59b6f3a9d9emr3925814e87.4.1768208943033; Mon, 12 Jan 2026
 01:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104105446.110884-1-marco.crivellari@suse.com>
 <CAAofZF6DCmHnpT8mNGiYRJdeQc9yBooRf=N+WVEw371-ZP06Zw@mail.gmail.com> <2026011107--0bfc@gregkh>
In-Reply-To: <2026011107--0bfc@gregkh>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 12 Jan 2026 10:08:51 +0100
X-Gm-Features: AZwV_QhC7fpy4yggJ_FrRIYLm-tP-25KsSWZQboYMrzYCvhr429VJsM2YNGjSo0
Message-ID: <CAAofZF6RA8GcFazMDY-bgYQfEXo02Fj1ug8UsOF4QkJV4GzxOg@mail.gmail.com>
Subject: Re: [PATCH] tty: replace use of system_unbound_wq with system_dfl_wq
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 11:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> [...]
> This isn't in my queue anymore, are you sure I didn't apply it (sorry,
> don't have access to my devel tree at the moment...)
>
> if not, can you resend it?
>
> thanks,

Hi Greg,

I checked, it is already applied!
Sorry for the noise.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
