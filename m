Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7413F016
	for <linux-serial@vger.kernel.org>; Fri,  7 Jun 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755039; cv=none; b=BHEEBlzsODfjsAifx6mrROuipVZYQl5SYg9yotlssHkitPSmIlPuAGDJwi8/sX+wIA/2PzfJjRjARlYruLRpXbASdCv0WFExkV0Ae4vcg4oFQGGUb7rN0rJMfyHpyeXMEf8XBPonG3cwgg/XB8durYx/p34WzCrZ+T41JC7J4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755039; c=relaxed/simple;
	bh=SmXZqCtp0wdVhsjcLPxWk8x8DPUR9ocCfuzLpW6n4Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyFKPdnwyVFLVCynng1T1KN0XNOPl4jiXgHiK5pNX/WGDRVxJ6NYudYhl4BZOXosokmmCWxX3RSvhtgK+yyjBPN82agN53ZZjXWoy6SElkXvHIS1AQeWw6Bt/3lay0URqKJDflXd6mJTkdbPNCPlzHeG15y7EcTcKL4P5kGXv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6kfxtGS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6kfxtGS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6ab88dfaeso17101245ad.2
        for <linux-serial@vger.kernel.org>; Fri, 07 Jun 2024 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755037; x=1718359837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hz+iEMlXAUYw5hztg/otf3Bt1bUvor4wAsrXpYthds=;
        b=Y6kfxtGSVJF1D6aJ3YxLmS59R73EWufR3U87tz+vDGBu9SCXqkwLZOHk0hCVHXHCjJ
         uEV7pI2gTJ8Jy2x4KjcVnmwmZ1RRCIUTxBzgw7DyD9mpQXq/8rvmhq1MFLW5ZPLJtAO+
         nbYM5FPACvVDESZPnt7ePZoDQ8PkXIkvk15MuZ++2Lgiv7oOTyjsWLFGxEIFsHsBnmsg
         E4SOWweUdzGFC8SmCWfAtQN8z85yGtMFdMttPQU9AQF4gZOzBh/2HFkNB1Gedj031BMx
         C65BcLxcJ4+j1PaoSz2lr8KnjRl6IN+R9S6rZv+FN5blRNxlkqoZvMyjkehNuJXyf7/C
         C4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755037; x=1718359837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hz+iEMlXAUYw5hztg/otf3Bt1bUvor4wAsrXpYthds=;
        b=v02QjxvLRVJZzDd7rEW0g0xsQvjZVuUk5npMrSyfYp0EzSY2Wk1kWfCCRYLDPaY1Uw
         wlYxm7ARIEHgFrCIVjvTXIzaexnjBozn65dQ35a244ikPbTBkIjoy0+utIKIulhtBvNC
         oAjBwppqUzJWA/CPxX8QJSoUHaddSozPWL4Y471YwxlbzDRzz+dbj1DfU+2RHenzDrdn
         3h8n8IiMeU3mHDhvP2laxLn3hLYR5k2/Z1wJijFyod8WeSe9olwzju/FgWD0SBd36FeY
         irGLpymYZvFDVl1kc6Lr0jJrOtRT0PlggqHB6spyM4UUEbovIBgih3pxZKWdsDkRoMfU
         gGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcQKGcVgsiWq5guPQXRu9B9HvDJMgCPsAcsxasliRiOVtNYeLtJp20LvpFNdxNbIAsS8sD8e/OLZoSIVa9ndNpzzivGyxMnrSe/K27
X-Gm-Message-State: AOJu0YxayE22C4OGMj78iLGG6blEKKYu5qIeQt+CKsjGdNCGtD/3MQK1
	Ypm4wS8adZHXLrb5URuautAMLRHC6rk5dNbL2cft7fsXjBujiVBWei4rNIWapjP3eqkVWepbCUB
	vtMWArUh5m8ymYyHeaBKkt9nLay0=
X-Google-Smtp-Source: AGHT+IEQtX7G9/UW78XNWrtfnfyZCyo4wyoMp4OwKk/V19aNzk8xlznO6Kx9ATD6sO+V4mryFXHQd1fIYMSoHptyKo0=
X-Received: by 2002:a17:902:d4c4:b0:1f6:857b:b5c with SMTP id
 d9443c01a7336-1f6d02fdd2emr25492415ad.32.1717755036866; Fri, 07 Jun 2024
 03:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606195632.173255-1-doug@schmorgal.com>
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 7 Jun 2024 12:10:24 +0200
Message-ID: <CAOiHx==vwPnwZA0om91_1tPEHfnQQ1GOM6i1xOSmVGkgrfaJeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] serial: Fix regression in omap-serial and pxa
To: Doug Brown <doug@schmorgal.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Doug,

On Thu, 6 Jun 2024 at 21:58, Doug Brown <doug@schmorgal.com> wrote:
>
> This series fixes a problem observed starting with v6.9 on the PXA168
> Chumby 8 and the OMAP3530 BeagleBoard. The UART would hang and stop
> transmitting further data.
>
> The root cause ended up being the change in commit 7bfb915a597a
> ("serial: core: only stop transmit when HW fifo is empty") that
> restricted when tx_stop() could be called. It broke omap-serial and pxa.
>
> The change was intended to fix an issue with bcm63xx-uart after commit
> d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()"). Instead, go
> back to Jonas' original patch series that fixes the issue directly in
> the bcm63xx-uart driver [1].

Thanks for taking care of this.

 Changes since V1 [2]:
>
> - Revert the broken commit and apply Jonas' patches for bcm63xx-uart
>   instead of directly fixing the issue in the pxa driver (at the time, I
>   didn't realize omap-serial was also affected).

Note that this is technically a new V1 (or V3, depending on how you
count), since the V2 of the original patchset was what became
d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()") and you are
reverting in 1/3.

Not that this should be cause for a resend, just wanted to mention it.

Best Regards,
Jonas
