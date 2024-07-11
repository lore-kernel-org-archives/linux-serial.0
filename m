Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BC8BFC;
	Thu, 11 Jul 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733043; cv=none; b=Qk2zb5tVb+xVhgGHV0jgDVj64ygYiH54J6V4zZpyzKqvdLO2NWUXPHtnhRRZlHl2nLaVLvNbw9AoLRsLG4m9EGDmq1r88wS21xh2fI9FhkYftToeMsuyQ5WLavgR24F1021zknG80QLZEgx+ZNcqj8OZ9vqAOAzpT0bWie859IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733043; c=relaxed/simple;
	bh=tONXDGQEnzgYHvUIcdVRKmZ+qkXQZBDcbzc9cL4jKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+3j8sbXSCZ0JLdKbohWnlK3TRrVWb+pzRgE6XQC1+YZv+X6WJl/nvYKg3ALYmJYvs/3ziQF7sH6QqrIbb9PD2YPm9gkuK5Cajl/cZ/A3UPYEogxDZ7Cdo62Eja+tGtkL/91iIQKcTe9wHTduHNWqkMm+mjHEKXLIK8acmDDDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImcPSGDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImcPSGDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F616C116B1;
	Thu, 11 Jul 2024 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733042;
	bh=tONXDGQEnzgYHvUIcdVRKmZ+qkXQZBDcbzc9cL4jKGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImcPSGDuw5KT0wetwjjqwxxtGD2PO6zwpd0vgJjp27ozbSehM+XktxefFnU6Kmx0F
	 eUWFW0/YI4NRf5gI1kHldqAKE+Q2yET1RehrqVs/cKPCUVElf+MN34JAwpWq3CSmZc
	 S3Ym7DJa3obJcIhd36Gjf+Nha/A4tsA2mp9BL0aKNTGziPOt36k1Ts/U6wkFIIEf/y
	 YaggNnpqpYN2J8GH3hzKoTJSbjqWD8S06B2GDe8+iHG325t7yvQ7MTbHexHsIJcSp6
	 zMLebEGx86b+IJyup/Zz83eBLuD1sW0kyga3G4NIXGIbLrXuD4DNl09+24pwSGPeR4
	 UEQviRVu1kzDw==
Date: Thu, 11 Jul 2024 15:23:59 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: samsung: fix maxItems for
 gs101 & document earlycon requirements
Message-ID: <20240711212359.GA3023490-robh@kernel.org>
References: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
 <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
 <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
 <e2f4a37e7c31d26449125a6265239c88162a1085.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2f4a37e7c31d26449125a6265239c88162a1085.camel@linaro.org>

On Thu, Jul 11, 2024 at 05:09:50PM +0100, André Draszik wrote:
> Hi Rob,
> 
> On Thu, 2024-07-11 at 09:51 -0600, Rob Herring wrote:
> > On Wed, Jul 10, 2024 at 7:29 AM André Draszik <andre.draszik@linaro.org> wrote:
> > > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > > @@ -145,6 +145,20 @@ allOf:
> > >          - samsung,uart-fifosize
> > >        properties:
> > >          reg-io-width: false
> > 
> > blank line between properties
> 
> Do mean before clocks: below and before clock-names: below? 

Yes.

> We don't do that normally,
> at least none of the bindings I looked at do that. Or did I misunderstand?

That style is pretty universal. If in doubt, look at example-schema.yaml 
for best practices. The exception is only for cases like this:

  foo: true
  bar: true

> > > +        clocks:
> > > +          description: |
> > > +            Note that for earlycon to work, the respective ipclk and pclk need
> > > +            to be running! The bootloader normally leaves them enabled, but the
> > > +            serial driver will start handling those clocks before the console
> > > +            driver takes over from earlycon, breaking earlycon. If earlycon is
> > > +            required, please revert the patch "clk: samsung: gs101: don't mark
> > > +            non-essential (UART) clocks critical" locally first to mark them
> > > +            CLK_IS_CRITICAL and avoid this problem.
> > 
> > That's a whole bunch of details that are Linux specific which have
> > little to do with the binding.
> 
> You're right - I had been asked to add this to the binding and didn't consider
> that. I think I found a much better alternative in the meantime and this
> description can go away.

I hope so because asking someone to revert a patch to use earlycon is 
not a great experience. I wouldn't want to use that platform.

> 
> > > +          maxItems: 2
> > > +        clock-names:
> > > +          items:
> > > +            - const: uart
> > > +            - const: clk_uart_baud0
> > 
> > Which clock is pclk and ipclk?
> 
> uart is pclk, clk_uart_baud0 is ipclk.
> 
> > 'baud' would be sufficient for the
> > name. 'clk_' and 'uart' are redundant because it's all clocks and they
> > are all for the uart.
> 
> TBH, this patch is just following the existing style & names as already exist for
> various other SoCs in this same file. Furthermore, up until this patch the default
> from this file applies, which is:
> 
>   clock-names:
>     description: N = 0 is allowed for SoCs without internal baud clock mux.
>     minItems: 2
>     items:
>       - const: uart
>       - pattern: '^clk_uart_baud[0-3]$'
>       - pattern: '^clk_uart_baud[0-3]$'
>       - pattern: '^clk_uart_baud[0-3]$'
>       - pattern: '^clk_uart_baud[0-3]$'

Then don't duplicate it. Ideally, the names are defined at the top level 
and the conditional schema just limits the number of clocks, and this is 
an example of why we want it that way. I have no context to see if this 
is consistent or not.

> 
> so of course the existing gs101 DTs had followed this scheme. Other SoCs that are
> described in this same binding also keep the name as per the default in case
> they limit the maximum number like this patch does.
> 
> Changing the name now would be a bit disruptive and make gs101 differ from other
> Exynos SoCs in this respect, I'd rather not :-)

Agreed.

Rob
