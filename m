Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95342155743
	for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872645; cv=none; b=SQeohotg7lFp2s387HKuYE38ereGrqnid9ipZHTDjzrT0yM+xTdBV8fUxXNK+sT/c9gPnvN4zWu6szbwOZDlAn3NrhnxxJ6FcGk0WJQjC3sbPGWEY7YD8ppYV5ecBii0a/jPM1Ss+KMCScInGy1AbXzFLJ6S4uhL9YSovz0F15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872645; c=relaxed/simple;
	bh=WJQF1e1lGe1DHP8xXL81uq1JAQ4RrIakU9ICRRYsaow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ0XbFD0iqBTLri1UlmuXyAAtPwmKdJ9gs2Q5ljYPcE3P02c3NV0I4MEAHAuIjAPDrvhUGl+JJ5kgxhIKT7dsGNq1u4n220Nc1njilovCr9tNiLZ4QZ6Pmhcc4B/o0iC+Inij2Pzg0nHeynr2oafM7TrYSP3zi3z+qPtj8ovG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=og23Hsjg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="og23Hsjg"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d066a5daso706298285a.3
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872641; x=1723477441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=og23HsjgcEU8+Gw4PGnAUjmUSuzeceuk/AtVeyQ9EfrchF99wN6bCXSI5BDbIdRYZ+
         p8xZazfZjOdPqkzPuHkcS+5BxZ4WSHttr3Rkw84/I1AMNTixDpbuu3ToGMWRyh5xYm3k
         LTD+fZOkLhuV0CA3UmIVXixRJEf6qW6irnPtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872641; x=1723477441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=ejkrWPrqcGHTidVhc0Mg9sm5VpzRwUij+htMxq50QaFrcbQiKRbg3qDhKSooWlVlbY
         HrjhB5wMHgkWmGEhfCQI3maVoCAze3gV6gA+Lo0Q/EHo2SBGoPf5GJGJPTqmcFGc6a0N
         +tvlBiAMrzcev+xtjpEelDnfXt3Xo/5sR2mPc+fYCrikMUlVySyLoz6nu57IjpGiKwr/
         pXlnJuiQM+M2Y6lJqH0vmeG8k1ClCR+y8SRVrPnpo8E8kLuf0KurSNnYs98LMnULLj5h
         y+tLVfLbl4uUyiNKXPfVLjLq0Yn+XR3G2KcWtBvbAE4Ln9zVDpmCpLJoROrlFfSHQLlB
         xGrw==
X-Forwarded-Encrypted: i=1; AJvYcCXagkRxV81pB1bf6IuqL9GW2lQTwTGZtwgNdtyguEuqamZMID1U1vEOs6qJ+T/qE1Mq5xJt7k3ym9sQ9yl4XP8bHw3k5BqJl7y86Ni+
X-Gm-Message-State: AOJu0YwAsWw6HP+Jj7RdNFbU8/fXprXXuTHl9TtWNFiziYJF0gQc/hGm
	hiJBHkGXKrhZ3gI86MLJDJTpBURsvTrbrXfOJ/6WkMmmAvgGIUZ/CvBhuoH/FpoA8Bcwk6adzyY
	=
X-Google-Smtp-Source: AGHT+IGYA84C9G/PSAmGjWmRDaRurvIrfoq0jvliV+wbHsfj4vCWWyU7WlTYBzwQE16eHnKeHGoNvw==
X-Received: by 2002:a05:620a:4548:b0:79f:b34:9edc with SMTP id af79cd13be357-7a34f00b23fmr1577398285a.66.1722872641507;
        Mon, 05 Aug 2024 08:44:01 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6e9dd2sm364634185a.39.2024.08.05.08.44.00
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4518d9fa2f4so848521cf.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAcob6TAKecVFQ1a6k+OUA3DJ9zsXga+SvK8273yYabjdELBLPdeM0DcYAPdq7ZRSpZxdd2ew6zqzyGX0MR/PK6DKNy+Se3HQI7sIZ
X-Received: by 2002:a05:622a:591:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-4519ae21848mr5655501cf.18.1722872639887; Mon, 05 Aug 2024
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
In-Reply-To: <20240805102046.307511-4-jirislaby@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:43:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 3:21=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
>
> Coverity reports (as CID 1536978) that uart_poll_init() passes
> uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
> takes the true branch (does "goto out;").
>
> Fix this and simplify the function by simple guard(mutex). The code
> needs no labels after this at all. And it is pretty clear that the code
> has not fiddled with pm_state at that point.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> Cc: stable@vger.kernel.org
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/serial_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Thanks for the fix! Looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: I'm happy to defer to others, but personally I'd consider
breaking this into two changes: one that fixes the problem without
using guard() (which should be pretty simple) and one that switches to
guard(). The issue is that at the time the bug was introduced the
guard() syntax didn't exist and that means backporting will be a bit
of a pain.

Oh, though I guess maybe it doesn't matter since the bug was
introduced in 6.4 and that's not an LTS kernel so nobody cares? ...and
guard() is in 6.6, so maybe things are fine the way you have it.
