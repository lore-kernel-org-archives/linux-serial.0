Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B200136991
	for <linux-serial@vger.kernel.org>; Thu, 18 Apr 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431144; cv=none; b=ZE+ktcigBuTFOl+wSccb6N5MwvrlMOi+6G+RmXvGbu1fwxLgn7RU8wq0Ji5unTU1jfYODdewXQVGU4Yky/pAfmkNcyirhrHFegSt/tRNGKvactZ1Nr/z+xKzieMzWpnz5arq4PZgQ+5IVao0+UaAN79dZJIO6KDYQQE6adhtSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431144; c=relaxed/simple;
	bh=ePckogndbT/HMJ6Dkb0NZIGm65xXskRus//486LRAjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhWGSCZJ+433OOUQ5SA3i1K2KFwXro8+NknTqo/kWJ6u5dsAsZBrnb+QF9MDVX3AE1D6lE7gkzDYzZ1axMCiV7PbdZ0sH3xKsQwqbU2yoBqr1GAsHYgWTIEYAhL4kt/FQYc03MTBra0t4483K57OnIg0HXVyPxx4/Tg3Rw7tkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBrmcrLk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBrmcrLk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418c2bf2f90so3486815e9.1
        for <linux-serial@vger.kernel.org>; Thu, 18 Apr 2024 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713431141; x=1714035941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euB3vcyNRkqSsujp1rBWtIUz95ZDQeOsD0X15ArXVN8=;
        b=CBrmcrLk/ovs2ABxT0cXYt1PpOu/cfPoycdKTlppbhZT93KsoSc8My+yyDEZbQNzJA
         jCZkh0arON1rZoxu25X062rq4XjS6rYmlR25CBUTuH5H0F02UPDlPm7FObx+wZWUj6fG
         DkahhAJcYdfybPWs2olLJw9gGh3oCrRoxt6MRNLi98WitTuG784kINf/H1uYyxJeRB+f
         kvcFaRRo9LP1uzj0Flq4U7Dls0+uxOMO/1s7Ud6FvY33Swyh6SASXpO1vvhBk8KewF6a
         HveSTyE4+d5IpFeyY+eA5/siXbs1V2dP2Y2neU69jEsT3+iAOSzufHkngoP8daKBPBpU
         K4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713431141; x=1714035941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euB3vcyNRkqSsujp1rBWtIUz95ZDQeOsD0X15ArXVN8=;
        b=l/bc1o98VTpbszz+FwCnBhqZHZa4dxMi0VXMd8WjiULBCHCsOZ4wNO7jFpDbZNVav5
         C1P4rP2+RXYRDQ15VlEIfbh9AYbCFr0MOo71pSrZl4xFnBaeItdRAfc85CrNWtbWCj7G
         l/8gM/+mzIIyX4ZDiC7itX9VMSnfQLqh2rcX8lThA8Uc/ubqON+LvSt4N9b3FUOP7GhE
         BdApJgA/vRFCv6Q9dRgr1Wu5deo0ZuMzIDJ44XhJEiE4Or9TGgd3kUIirjivdVik+rpn
         AtaKSFjXuSkCTA7/j9IMvgLqpl2ytlCkGP9fvksF8bIsdSG8J9XmG6ie8rCenpOD1Bxt
         E10g==
X-Forwarded-Encrypted: i=1; AJvYcCVXJqFM5QlXv/j8rXmDudNggfCT0gc/c2T2ImItPGNaflQVXS6BVndbSRLuhWBtVhy3ZyPDVrYx3O/kjaywRjWrHdiSqFK5erRQ3cmh
X-Gm-Message-State: AOJu0YycpuOBnTivN3x0TjEzkjokQpjoOmpLjWgdQygKQDmckbdI+a8n
	Sa3ZA6daYEXCA0J+3dY0a6laI7X1B/tWGTK9cNtjZEAogufkoK2vDi1b0mbQtf4=
X-Google-Smtp-Source: AGHT+IG5HhSMVcn1nLDLtOfxsytHEqcveQ4MV1aOv60X6+6dklq/C+iAIIstaQcJbkGV6ywa6bgoKQ==
X-Received: by 2002:a05:600c:3554:b0:418:3ad0:742 with SMTP id i20-20020a05600c355400b004183ad00742mr1223954wmq.4.1713431141344;
        Thu, 18 Apr 2024 02:05:41 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b00418effbc4f7sm557536wmb.38.2024.04.18.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 02:05:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:05:43 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpbUEFUQw==?= =?utf-8?Q?H?= V11] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <20240418090543.GC162404@aspen.lan>
References: <186cdeea58094d06b351b07eefa2189d@h3c.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186cdeea58094d06b351b07eefa2189d@h3c.com>

On Wed, Apr 17, 2024 at 11:01:56AM +0000, Liuye wrote:
> >---
> >V10 -> V11: Revert to V9
> >V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, Acked
> >            by of Daniel Thompson
> >V8 -> V9: Modify call trace format and move irq_work.h before module.h
> >V7 -> V8: Update the description information and comments in the code.
> >	   : Submit this patch based on version linux-6.9-rc2.
> >V6 -> V7: Add comments in the code.
> >V5 -> V6: Replace with a more professional and accurate answer.
> >V4 -> V5: Answer why schedule another work in the irq_work and not do
> >          the job directly.
> >V3 -> V4: Add changelogs
> >V2 -> V3: Add description information
> >V1 -> V2: using irq_work to solve this properly.
> >---
>
> What is the current status of PATCH V11? Are there any additional
> modifications needed?

I understood that is blocked pending outcome of the legal matters
raised by v10...  and that this is why you were asked not to post
v11 until they had been resolved.

To be honest given that [I wrote all of the C code][1] for the most
recent version of the patch and that I'd like to see the bug fixed,
then I will probably have to give up on co-authorship. Instead I can
post my code with a new comment and patch description and credit you
with a Reported-by:. That should take the pressure off in terms of
landing this bug fix.

However, the legal issues do still need to be resolved or there is a
risk that other upstream contributions from your company will be
delayed.


Daniel.


[1]: https://lore.kernel.org/all/20240314130916.GE202685@aspen.lan/
