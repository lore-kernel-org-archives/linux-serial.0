Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AC18D651;
	Tue, 10 Sep 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982388; cv=none; b=I6tXr8udYDBt1kZpT7XuEyqUCg+GLfcDVHLmF2QtvafIlt6WhOTKLhfAwpNW0hzqdKh89GOE7I1RC869tdqRkHwOPgHOxdMiujTthHBRGr+d8NFEifQMNnApKRd87aES84Q0cZstMX8BVlOoFVzfy+A9gHOH82thqTxE7G5Rym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982388; c=relaxed/simple;
	bh=Q/k+muZNZABHT9TSMic+6ur+MGo7XG9CsgrNSrCiEXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E18oiW8ZvYefxgnKWzJ6QrSZ0TsQnGJlir8Aol4PY2eqG+aH9YH3vjjOH5xq5jkVe/B9uQREFVsFDjU6yUEL3j+ZQ1uW6UW/7ZR8deCy41uXwFGH7P4FmAMWTuEG3o9s76kf4izr6al6Pv25ju6loKJGPmrcXbXlP5xqdWmu4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpA9dXga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpA9dXga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758A6C4CEC3;
	Tue, 10 Sep 2024 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982388;
	bh=Q/k+muZNZABHT9TSMic+6ur+MGo7XG9CsgrNSrCiEXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpA9dXgago9cBUpCrezhycNUjGkJ0Q5u3/faibcLd3b1tDj8GT23gZIdPbExXC5uA
	 8hnRGr4HbAdjK12T5SyNTPrsyIGXMcCwlhWYza+wKIXANEXycW6SnXBkGVJYlkiWCy
	 oLpxpFrWKrsq43D5+ZN/FEYDLLdcyNn2vFl8EmvvORdu2NVI6G59RZquLR3wRBZPfB
	 8CUVJuSIIwbf7TfxWY2bJFhta1p6dEiUqR1/kdZX6cY9YBIgQBFVDC7tZa1b4fVx7h
	 xRJdsBdWQ44NSuA0Z1+x37lhjDPV15QI2tknfJDaRB1TZjhK3rSQBmg5TfF1baTzy+
	 QM+DjFiRb/iIw==
Date: Tue, 10 Sep 2024 17:33:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev
Subject: Re: [PATCH v4 1/3] tty: serial: samsung: Use BIT() macro for
 APPLE_S5L_*
Message-ID: <5c27uuusoxkl3v3qm5vnof6pyfrua4mtwf7w4ffzyvv265rve5@ns5ggy2gwyfa>
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-2-towinchenmi@gmail.com>
 <lbyvuozxjywyt46w2imk2jvwfas3p43wooj2ioyhufwkyg72da@d6stk7xk4rx4>
 <a7f7ccb0-1dd2-4df5-a2ad-1fe4c98d67e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f7ccb0-1dd2-4df5-a2ad-1fe4c98d67e0@gmail.com>

Hi Nick,

On Tue, Sep 10, 2024 at 10:26:44PM GMT, Nick Chan wrote:
> On 10/9/2024 20:48, Andi Shyti wrote:
> > On Mon, Sep 09, 2024 at 04:37:25PM GMT, Nick Chan wrote:
> >> New entries using BIT() will be added soon, so change the existing ones
> >> for consistency.
> >>
> >> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > 
> > I think this is:
> > 
> > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> We will see... Got a bit paranoid after bad things happened with v2 and v3.

ahaha... in this case it's fine. The whole patch was suggested by
Krzysztof, so that it makes sense to add this tag.

What Krzysztof complained about is that you accidentally added
his r-b without him telling you explicitely.

> > 
> >> ---
> >>  include/linux/serial_s3c.h | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> >> index 1672cf0810ef..1e8686695487 100644
> >> --- a/include/linux/serial_s3c.h
> >> +++ b/include/linux/serial_s3c.h
> >> @@ -249,9 +249,9 @@
> >>  #define APPLE_S5L_UCON_RXTO_ENA		9
> >>  #define APPLE_S5L_UCON_RXTHRESH_ENA	12
> >>  #define APPLE_S5L_UCON_TXTHRESH_ENA	13
> >> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
> >> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
> >> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
> >> +#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
> >> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
> >> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
> >>  
> >>  #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
> >>  					 S3C2410_UCON_RXIRQMODE | \
> >> @@ -260,9 +260,9 @@
> >>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
> >>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
> >>  
> >> -#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
> >> -#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
> >> -#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
> >> +#define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
> >> +#define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
> >> +#define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> >>  #define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> > 
> > You could make this GENMASK(0x3f, 4)
> Good idea, given the above context I think I may add
> 
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>

ehm... not in this case. Mine is a suggestion as reviewer and
this little comment does not deserve a "Suggested-by" like
in Krzysztof's case.

> too. And actually it should be GENMASK(9, 3)

You find out the right parameters :-)

Thanks,
Andi

> > 
> > Andi
> 
> Nick Chan
> 
