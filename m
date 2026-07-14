Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283362BEC5E
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010848; cv=pass; b=IKOxE2+SXdsTPIehatj9WIOSPUtPI5NkYrhRfHwmIn2dgxNpVgHOpkwxwwhOWjrl2rQaoG9RhkU9UU/oohIUw9yisjfE65ok7cyzI+xIv3BqJJwMuK4jjpDZLVbOkjdrkCoAvplvXBmEgjZSvH5pXw18GfjfDSnrElmj/BwCWaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010848; c=relaxed/simple;
	bh=SQQvHJDR4N2zN8m1faM8ZV3aU2WZpjICcmUzTDU83P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDRg2QJo82jA3x4+RXbXi2LBWwdr/yFukKmmTwn6YPhDSmB81l5FYB/iSHFyBjl8YD88uzvT/wcLlUR/BNMKg2zyBk0nzPBXwxaCBCj3c40cotPDhB5nuGiMU9TymVhraxnF2qwJznLoEc5uywu1NSNBq2+rL8e3ffAhAvXtl88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CqJin4JL; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CqJin4JL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47362928f65so3662123f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2026 23:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784010844; cv=none;
        d=google.com; s=arc-20260327;
        b=Rz75Z/HYvLQOIiVlQaTglpE0jqi2VbX8Nn4oHHhgaD44fk9vTud0lcTdc0DlVdc8cm
         8LJrzJaZFHJIIG/z/cLKSu5wAqE/bJezRo9a7c9y85GJkdqIS++HNrtC3i+d0sjZpvRs
         dU97gJxoMDfJRJkLfce6pLMLZNd0NQA+GejO9aKcq99Rv7mB8QEUomweRkvo2Q/fBWDL
         wwB+oZ8PqC/Nw6vP+e8IcQxkJS6mM+om5yWGyvAx9IgoNF2M8BMsaZO4XBRbfr0qA2LM
         1l2MXn68SiYgkGBJ/YD/l40Ffu9JHpi/fdfacoTV4IBswGomknyCB4y/llgisULlpafF
         6JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        fh=z2bguSFYcy0HDkjOjOM1cDw4R8h5qj78mB8/L0GN6pU=;
        b=hyQPUpCfLVueNZqLM+kr9vVZiyAMTjsM1maycN0h/EaNr0DHNym2X9bcIu9JJjFsVU
         7UnsxbL7akegU58SKYhZ/UHrtnB3+RXEfyl8Pptf3e6fGhzOZ5OVj2SFOnMFptMKqM70
         nJnfwvRIp1RL/d3ckT1dWUVIQL72uzBQtHMCX9KU+UBevX95Ru9jUq1w4yRUqYDQKflp
         tqhJmhZvA8SR/MViRSlDMUZavnQ8s5/9hfdd3dVDeQE//V4yecYB/WKXZLcGsLus+Iju
         +dOfBcf42s5YecxfGXAApP38FwQIORrPl3IBvAa+pyDdmZhhdpqkQc/5cxwKuYoMJ2Py
         4uVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784010844; x=1784615644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        b=CqJin4JL7vzZ4VJeP5HucHG9CU4mHtJN3YmTOoPoSlQrgoFxGeY6vkDRVpc8aJMfWM
         sI7r+tzlLq323FaQb9bh2MPXUxiphBv+XqrgZKQXYE7YNUY456B6EZtiOxBp7eKuTrZ7
         UFJjG110LQLndIUBTKXQ7bYCkMdBDuOHlK2+8AeQiTnFbvI1aCJcHKW7KboPH2FM73E3
         Fn3je1Q36OFpyqErmaw2fn9S2uWb2o4Ew00f91SZejJBprvgBgbMZcI7srfYjQrvdmbM
         ZaF7eKrbxDW5VW67/O7xDiI25yzhP7rGB34LNuehiQe5wI/a1fzWTXd1BWqyW1EqTr1P
         Injw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010844; x=1784615644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        b=Bwfbu+p/9O7/emQB42HtjgyBH7S+shDalc0IjljtnO9z/fk5+VtqlL+4yusncClPz9
         oOPFWagiMRG5un9ILQ1G3ukYpzjj6sc4Kll4E7kha6IWdjfIN5e/Z0a3PP5KyFEmxA1N
         GwGV/H2sBnfRCOeUhpq5sK6GypDoS3m4dalKAP6gUO2I+cNYn3NIIEKutK7QrD4jnFTr
         fKv7n8XhM+YPPnlc9R+YGEVH/B0E9Bjx24lfa2WnE7GmwEYac5H/Nxc4WmB+ctyeeHMB
         9otQBjb9+3iKIAHGjZt48V4wtewN+5AQru2AaR4AgMrZYAwXSK8L1sNTq2tFJPhOhs1j
         cS8w==
X-Forwarded-Encrypted: i=1; AHgh+RqMzU192Pz3KTde2tLzlKMpxTwYWBDTLXKd9HyamE8Uw3fkeL3ph7l7GWQjqJ2ogF/khafOd7UulJxgST4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwZa3Bm49b00EYUE/K66VI8LytbMfdgStS+/KMWlr5ZP9Zn5b
	8tvgX5O2IPPn8JtYBDj00bz3JcTRbCC0CRXdMvND9ozsAiDAYYYj//jKGDvlGadAKWU6ycZ+s7A
	Kj2hqz7Augn3VkCU7J/VrLb0Fkfp5oi1AYjTEENAwPA==
X-Gm-Gg: AfdE7ckvv0p6WY+IKedpsgrOuB4swo53lvLzAuyiKdRMoPLrC2WonD+u2+7bTATKwY6
	PgKyhAHdlMBfGx7T1s8ndaA2N6GJ6UUtCVRV2VRWq3DYycU8cYydFmvZrj8OlZfaJjUqeqpMHRZ
	fu1nTxWqZ2cjNV8/6LiH/mx6v1zEgXX9Rs1j2H7pfPuzCYoXqQjIsIczl4snuzzoQcFMQljq6yA
	iZSHQT4g44xAnm1mz0kgIc6D0QUKMHrRXEXrgZ1zJuj/Ot+d2WSAi0URLemTZCkDLT8cvscpR0J
	L4m8vHXMDWfzGWa6yQfIOschlJYCP1FP6iIDAda9w4s+Tg52KStYw5M70Q==
X-Received: by 2002:a05:6000:40ca:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-47f488488a5mr1165528f8f.9.1784010844468; Mon, 13 Jul 2026
 23:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
 <1af9eb75-fcab-4541-8ba7-ec620546f031@kernel.org>
In-Reply-To: <1af9eb75-fcab-4541-8ba7-ec620546f031@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:33:53 +0200
X-Gm-Features: AUfX_mwqF2s0XWJlIYVM5Zbx0O-qqVqJE0SWnGYK8fsSsk4VE3pkV1cTIOFg11A
Message-ID: <CAFi2wKZRVbmCwprkxGZoxib8BrFd9kDS3H2cDmykEorB5S7Xrw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
To: Jiri Slaby <jirislaby@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Thu, 9 Jul 2026 at 07:17, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 08. 07. 26, 17:35, Gr=C3=A9goire Layet wrote:
> ...
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -32,6 +32,26 @@
> >   #define ASPEED_VUART_DEFAULT_SIRQ   4
> >   #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY  IRQ_TYPE_LEVEL_LOW
> >
> > +#define ASPEED_SCU_SILICON_REVISION_ID                       0x04
> > +#define AST2600A3_REVISION_ID                                0x0503030=
3
> > +
> > +#define ASPEED_SCUC24                        0xC24
> > +#define  ASPEED_SCUC24_MSI_ROUTING_MASK                      GENMASK(1=
1, 10)
> > +#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1          (0x2 << 1=
0)
>
> So is this
> FIELD_PREP(ASPEED_SCUC24_MSI_ROUTING_MASK, 2)
> ?

Yes, replaced

>
> > +#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN          BIT(18)
> > +#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN                    B=
IT(17)
>
> Perhaps switch the two (to be in asc order)? And define 14 as _RESERVED
> as well?

Acknowledged. I have also removed the comment afterwards.

> > +#define ASPEED_SCU_PCIE_CONF_CTRL    0xC20
>
> Hmm, should these go before 0xC24?

Yes

Thanks for the feedback, I have made the changes for the next revision.

Regards,
Gr=C3=A9goire
