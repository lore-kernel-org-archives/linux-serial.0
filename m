Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FA4437C;
	Mon, 13 Jan 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735411; cv=none; b=rbRtqRcgMywyXnwp8fuG26jVXt7HHDNGVENDpXBtne2wa48s/wOcs1/J/Gp4ox+r19nd6+TknpB+L/quIXdT/ksapPicbpcL0y7p9eetjn6/RkgAzfusUziJ7UtDzCsmu/0OernFZHGeV086jO1pBdUNJcekxNDWFQJvG5d5OgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735411; c=relaxed/simple;
	bh=PtfUn7cZmYaeSpaUd7Sr5mc3mhx3/NibQ2HxWVlpETw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRlx/en/cnksf5XcUhBZZxaxl2Qc7J+kbY+vd9kbKro803haIzARBVTZZJrlH1tr7F/sTWVkUmQrVhNKhTQLewfJY5HhhZZ8NFKmJ9sfxB5b6WX/Gi+fH4g7pW+x3DK3EO1PDmPZyvEGUfg2M3xgYSxuLeFhtCMWkUiImWHfNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdgQSS0u; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdgQSS0u"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so6349852a91.3;
        Sun, 12 Jan 2025 18:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736735409; x=1737340209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5SQzgJvOvq9xan3sACDPyANmXwc+1N/eigLAptFZDg=;
        b=mdgQSS0u0xbl7gvijmKNZBAO1iAV96R1UIFaU5YJywuQ2Pa00j5s5nFbe4isoRjNmq
         uHr+jWSfBbv5TiAKlHQdOTkNpAOdqiBlKArZLQfZmjEW51AQp07kY3WU358d363FgDfO
         0vfu1mbzLDbIbyRgc2N1tM8Ka6Bu2mHn8+WS1YmXoIsZ3Rxb/dvD7WGYGen030R4U7WZ
         pg8ugJV1yCHUPQFHDBYSd9rBERanaSwxb3XWPpemI9kP3A+Mm1G2iAHmDJKKmgD9SedF
         CL1K80ZUPopbKZfFXqLI0kepzjX1dP65Ssm/mhBcj5IyfS+jW9n7tXVHOEl0+g/MD5o1
         IZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735409; x=1737340209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5SQzgJvOvq9xan3sACDPyANmXwc+1N/eigLAptFZDg=;
        b=c9nK69cf3FAwlyeDFBzYmJdfzEiC3yooq/4c1I0nbdla1Ylde64rgL9P2t4yUBdDFt
         JB6yRS/llSgCJmK+1XscsI0NJpa353ofiZwrm5fz/UU0pNuRfTI6FDki9UIXH5QfWvOx
         viaao2v7HPuwAzAHzoQcGUGCWF1LcpAWlMY8Do3dGaf08IFR54y3kkIvFAb4hP5mBJfI
         lCZgZC2thPg+TgAXkzYRLOMQfmqmDG+PHHlJjV38SkCa88FizytHTgtt/NTp+Nuy2Wod
         KRTYh82AHxEMzmctyFg6iRYpGEt+tLnHJmWeMCbuqcKuKl6hqZ1/UQI/SelsnQf9KawF
         UHWA==
X-Forwarded-Encrypted: i=1; AJvYcCXFpq6Y5dY9lxAevxFf/xLE7QsfmaWBJ1Sgem+4a7eufNKWyCZUWgnMBl9LbyKEg+33VfuCOJRit9xF0lEk@vger.kernel.org, AJvYcCXShL+IyfaNcAX/W2w6tjW/FWLDpRXygJagHgP50f93CGecjEefoI/9bPtbYWk29WYdFTSfNevVV+bZgwJX@vger.kernel.org, AJvYcCXyD7C2EFEp/yUtqP8UJCg0nz1jqIhf478u9ihEiseAjDbOUBPPzY4nb6HN0glUfEx1V6zFGBj8vKTP@vger.kernel.org
X-Gm-Message-State: AOJu0YzTt41n6h0Sm9MbHcthhIXCahZUEl3jrXWoFWVo9mIsDSqf53VP
	vs8aVmDG4EQkgeJ8U3e9iJs4L648RR3j03ezafF8vkqJMhRapvZtDmLaMU785OiZCdf0EUqcwOj
	w5mTjC/rt+AcsLjDlAGXka6EZKas=
X-Gm-Gg: ASbGncsQ7cJZVa7aoinkDeumDN7vX5gtlY0J5ni3os4UW0ymMDy/i5xcPurBU6/pfbO
	d+IRznLZSBGmGLJibtfdof9neRmFrKkil4WYXWEs=
X-Google-Smtp-Source: AGHT+IG2V/U2siqdnQWpyz7XCLMt3TgtWxUGbVZaRPBZ0shQ2HICE/yPUGfQnlnMV3Ll22WZrLkvGPBgreNfBTE5cL4=
X-Received: by 2002:a17:90b:4a50:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f548f2a154mr33159744a91.12.1736735409465; Sun, 12 Jan 2025
 18:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zz8m8PqHX_7VzgoP@standask-GA-A55M-S2HP> <0b9495e8-b89e-4fff-b7a0-060d7631522a@kernel.org>
In-Reply-To: <0b9495e8-b89e-4fff-b7a0-060d7631522a@kernel.org>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 13 Jan 2025 10:29:58 +0800
X-Gm-Features: AbW1kvaolkD-qj4kY47WZpornl-_ex3emAvuqI94SYXKt7q9__KpGFB9oRuoEk8
Message-ID: <CAB9BWhdAQS5f2OpH8-PZXCWtWWybPJ+UaLvQNu4UacPF_sCg2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for ums9632
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, wenhua.lin@unisoc.com, Zhaochen.Su@unisoc.com, 
	Zhirong.Qiu@unisoc.com, baolin.wang@linux.alibaba.com, brgl@bgdev.pl, 
	cixi.geng@linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	orsonzhai@gmail.com, robh@kernel.org, xiongpeng.wu@unisoc.com, 
	zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:34=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 21/11/2024 13:26, Stanislav Jakubek wrote:
> > Correct me if I'm wrong, but this patch seems incorrect to me.
> > The 1st patch suggets that the sc9632-uart is incompatible with sc9836-=
uart,
> > but here you make it fallback to it anyway.
> >
> > Also, both of the patches seem to have made it to linux-next without th=
e
> > reviews/Acks from maintainers. Maybe Greg was a bit too fast here :)
>
> Yeah, this looks odd and considering totally empty commit msg (nothing
> useful there), it looks like wrong choice.
>
> Please explain the compatibility aspects. In the future: you have entire
> commit msg to describe the hardware, instead of repeating the obvious -
> what is visible from the diff.
>
> Best regards,
> Krzysztof

Hi Krzysztof:
   Thank you very much for your review, we will correct it in patch v2.
Thanks
