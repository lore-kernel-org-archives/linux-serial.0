Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527850;
	b=bLZf6c5Nmg2lQtfWRJC6K9QzQu7CQxukLZLIY5pu38+sKj8nsf4du5hLKYyCmdmyKqIr
	 EWxR29DUO/V9oXL2mrmsCjAihMLWWd54yENaFw08E5xzv9XBojQmaHCeM9fKNJX0mL9pr
	 Ox6VR7zSl4IubgsS5496xiliG19SZ8+jMprmttP99Lves4HQPfQ7rAWioQLqvYMCznL41
	 YsdiQUJNIeALRU41skVR/4WT/dIvx/I19c9sav2keRXDFJERz/U+uZ0vqbuYyUapnA5+A
	 KuKvJngnKWn7yBc/Q9q+1kfvaa0TSmtA9NuLqh1/Jvrf8d/c2Af9XXE8PoyUw6EC+FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527850;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VCAQg3UxYZNeau7J2CKEJUMFRL+RaFjODA4ITuoDI0E=;
	b=nBGxm59EXjlByT8l1RZD0V/DyQDbZpb9vp7LRAmLdVgWEDxk3bVtp67SB0VH+Zt+L5TH
	 Nltg4iFirWaEbG/XaRH4Rs1aeZ718dYjfWKXMVivh/m9k3Rmh/EwnwBHFTKPsnw8d3PJg
	 lyiiCEYVZ6Z+Wl1Bk/6P1gdVr0X1VBfqBYaYYrg1gVM2uHPWEY9CN5LEWEIu+6V9JDQ3h
	 Ve8FGTnvzlZHH7MZ15jddjJ0Vb5ZO1GFpRp4HE518lpVI0exOllmC07UrpLLjd0cRNVWA
	 1gLojqkj23BpKn3eKd6bVW0ooo6fq3OGh179v6CeAoP9FNqeMQAOdYYHfdQh5qB65KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD08IbV4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C7606A321;
	Tue, 24 Nov 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD08IbV4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA2E1F000D0;
	Tue, 24 Nov 2026 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527849;
	bh=VCAQg3UxYZNeau7J2CKEJUMFRL+RaFjODA4ITuoDI0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kD08IbV4sPP6wimci9DX0lIlUPXWYZKoNRo87fPcvWuRRQVESpbutF1+imZyrsBb1
	 HbIRCzo1Fyhfuc2/95jfJIhxpkQibRsB0C/7dyFJSv9cMXrC3NOvb5XVz36NSH4Z6T
	 enogkVgJbQfmP1oj9TmjDyS3hraXXlULEINIOVZZePtgp/SbcUY0dDAizRyIayCcJ5
	 gCLq8AP+cZrq5ieQtheqW8g/Zh89BTZYYJrfFBuW2y/HRrkQDncDQqk5+B7x9Tz41d
	 7eaWFlp8/GFo6uQGLzXaZ+++/aY04vzcU4b/LtC7OFoDQkUOYJS76Ys07SL6PZhgRd
	 4EGeZJuQLNYEg==
Date: Tue, 24 Nov 2026 07:44:07 -0600
From: Rob Herring <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, conor+dt@kernel.org,
	Binbin Zhou <zhoubb.aaron@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated
 Loongson-2K3000 UART compatible
Message-ID: <20261124134407.GC3404231-robh@kernel.org>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
 <sashiko-outbox-196836@kernel.org>
 <20261119214532.GA757146-robh@kernel.org>
 <0009e3c5-dfff-4254-a06f-13c8664a1543@loongson.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0009e3c5-dfff-4254-a06f-13c8664a1543@loongson.cn>

On Tue, Nov 24, 2026 at 02:58:40PM +0800, Binbin Zhou wrote:
> Hi Rob:
> 
> Sorry for the late reply.
> 
> On 2026/11/20 05:45, Rob Herring wrote:
> > On Wed, Nov 04, 2026 at 07:52:04AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Low] dt-bindings: serial: 8250: duplicate ns16550a fallback block for ls2k3000
> > > --
> > > 
> > > commit 71974153fe22bc00d365059be9198364c9cfaa86
> > > Author: Binbin Zhou <zhoubinbin@loongson.cn>
> > > 
> > > dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compatible
> > > 
> > > This commit documents the loongson,ls2k3000-uart compatible string with
> > > ns16550a as a fallback so the driver can distinguish the Loongson-2K3000 UART
> > > from earlier Loongson UARTs that require MCR/MSR signal inversion.
> > > 
> > > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > > > index 01abd39509a7a..33c13c48ed56e 100644
> > > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > > @@ -196,6 +196,9 @@ properties:
> > > >                 - loongson,ls2k2000-uart
> > > >             - const: loongson,ls2k1500-uart
> > > >             - const: ns16550a
> > > > +      - items:
> > > > +          - const: loongson,ls2k3000-uart
> > > > +          - const: ns16550a
> > > 
> > > [Severity: Low]
> > > This isn't a bug, but properties:compatible in
> > > Documentation/devicetree/bindings/serial/8250.yaml already has a two-item
> > > block with const: ns16550a as the fallback that includes the other base
> > > Loongson UART compatibles:
> > > 
> > >        - items:
> > >            - enum:
> > >                ...
> > >                - loongson,ls2k0500-uart
> > >                - loongson,ls2k1500-uart
> > >            - const: ns16550a
> > > 
> > > Could loongson,ls2k3000-uart be added to that existing enum instead of adding
> > > a separate two-item block?
> 
> Let me briefly explain why Loongson UART `compatible` is necessary at this
> time.
> First, as described in the driver, each `compatible` type defines different
> driver data:
> struct loongson_uart_ddata {
>         bool has_frac;
>         u8 mcr_invert;
>         u8 msr_invert;
> };
> Since the Loongson-2k3000 has already fixed the hardware issues with
> mcr/msr, we need a new `compatible` to correspond to the updated
> `driver_data`.
> 
> static const struct loongson_uart_ddata ls2k3000_uart_data = {
>         .has_frac = true,
>         .mcr_invert = 0,
>         .msr_invert = 0,
> };
> 
> As for why a fallback to `ns16550a` is required in all cases, the DTS files
> for the Loongson-2K1000 and similar devices were merged into the repository
> before `8250_loongson.c`, and this approach was used at the time to maintain
> compatibility[1].

No one is questioning what the compatibles are, just where you add the 
new schema entry. Use the existing one with the ns16550a fallback 
instead of a new oneOf entry:

      - items:
          - enum:
              - altr,16550-FIFO32
              - altr,16550-FIFO64
              - altr,16550-FIFO128
              - fsl,16550-FIFO64
              - andestech,uart16550
              - nxp,lpc1850-uart
              - opencores,uart16550-rtlsvn105
              - ti,da830-uart
              - loongson,ls2k0500-uart
              - loongson,ls2k1500-uart
          - const: ns16550a

Rob
