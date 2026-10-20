Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792510145;
	b=fBK9ymGkzmJ9qDEb63shFC7sKaO/JFC/xBGOu0l779OxAF5z1UTkpWXtK4TQmkG+f+4S
	 NiPekYRLtpnZkP1ABfYtQk0pb0h6wZNG2hVwdd+zXU99gdrKTbXcud5deSPAnSQw76YAO
	 o+8NOHsom+Hm/OF2k3iaVUjdUDlvXOF5Ati7vRu7r6A5oGEG1IjrVQO1uBPjCBPkR/b4f
	 AopSxEBUVKBTTMbpCdJUbdtJcTr28vZNDIBWDh6mSL9aUx2OWJozDHkHKPbTRMhQv01e1
	 8xt3+D+h9Xkc8kn2RD5O95R74A4OHRnKPZAy0DOzwU8LVbWKZaAcrH2XW/i0MPw8Htw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZyskLn72jxh0oFiWRj2z6aqvChztPyoLb2e2jTxBCSE=;
	b=WcbB5fl2bkg3w1uDizEebfdYXQXtemU2zCyJlY4PDDl/4JRl4P/4tQFMh8sBvCiVfI85
	 z2bkmc5uyN9eoXl3oME5ij5QrAfCnLmWCUqw5sMTF0sewYr5UAtCMJunfCuJsp36Aq7u/
	 yTNwr80rnR8LszTraPgnA2LW1Z26r152tk8ZQSyeY0i7Y5AVLiWPWW5rSF4OaD3ZrpZok
	 whwZmlzGrrFox9iAKs3d28VacRx2/cyWogJaQCWGEZF9lnhQm7wo+kOczGs4jd8ggATVp
	 te99obBNPv0XWpJYsNestR6O1WeDe9IREURq1zwMgAznZMXBCxTz95mvsni9EAQ2gXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZKVLSTfe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416860A3802
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 15:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A416860A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZKVLSTfe
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f1cf92c9eso335589585a.0
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792510143; cv=none;
        d=google.com; s=arc-20260327;
        b=n7wlYePQy5Kl+dWDiQ+sJRRa678zS17Lmec9VaqxiVDBE4FFGx1e+FgqMUiUOl3GaT
         7acOb5dSajJSU3iPogTSojmmQozw+TWv24Ge46Sqs47EM+1zsJ3yYNtTppZUp9wh82yi
         ybxK6eSQukEMNhYz4NDyybfmYYz3FvGJj2gxhBgcZfx2coDn5O9eGj3FaRQpvYGQDF6G
         tzTCdL/lJ73Q9jhun7MRZSRh9H/cJyd8y/5RY1jFKVa4CMGDH2UG/05iOkk3Y8F/1290
         8d7Pm3FAfI9O9277+2pdmJgj9qmABJ6fX4QXNsELYvu4ybSQvEdX0Fz6voBFXSGu5ieV
         dowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZyskLn72jxh0oFiWRj2z6aqvChztPyoLb2e2jTxBCSE=;
        fh=K09mVAA5iDE1tu8qBsamFJCsxPTUs6BoV/KXWdgAULA=;
        b=V7lqTVCRVctwRVsGbW2YoLtSpfxJojKXeMpV2IuhN9roL0yRq9JjFhdtRdvGy2l2xk
         T4FPLXrbWHdurPdSQK/TfCO496yW2uHMhwuBgF7JyKRvPxqkDVF1HE4taG6BA0LvIV9x
         A3nY5usohhvOI/53OcBTVy7G4a0NelYX0HNLp1mBW2i1tOBYLaJpwaY+YOdCh8Y1dMiz
         QUxWT4qTJnoodn8JhvqzRkmQhqLc/8G9EZXk1ix4U6/5jHd7ihPTPerOXS0Zi7WMp5kn
         mhGyAQ7/y9HLRWrk9u9nhqz9SVtS9qePQC0a4V3YTeho8rdszQTaRvlTvwleq6x70o5J
         8FCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510143; x=1793114943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZyskLn72jxh0oFiWRj2z6aqvChztPyoLb2e2jTxBCSE=;
        b=ZKVLSTferKQ7DgS60tdcrV8WmCTxGoR2AYT/pKqRSfxJzU9IIac5FuK5TyvO7N5Pas
         x6U/YxcSI400Y80lKkwC764lKCIxGJzFCVQiObLaXlY8W1sxBNcokRu2MRyYyRSrVqTz
         XzQYD2hVO0splMY8SZ0qG1OSLc02pfR54KWrf2yvkgtw53RfEZXWTooCYlXn9OWYXR7E
         Ns12lbK5X3KLO/OempjaG/uM4MStPQkTW53kBe+r2fj5a2VQRQ1NZz7uVYuzpT7+vz6i
         0hNRQrFVkZVWxnHdip3vyxYCjuae9uxG9qOS5c4bIyQm1hrIVWxLKQxqQBVaI36hZhOE
         jIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510143; x=1793114943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZyskLn72jxh0oFiWRj2z6aqvChztPyoLb2e2jTxBCSE=;
        b=wJ7OVUhRxgrTxipsmFqnua93mRsJodx8BIK+3R3Az3CQPPSt9reZSb8UwCCD2/e12K
         xe9qcFv/RDY5p56oITkQXY5abw2QNkeUFqxlv9p5iCP8XKU+IMcYuGv0eFUX9MVxEILn
         Y3xjZVBK1yB+HZ2nEBss8p8l3xFb6NE+K2A1qdrMm0+ctdWB4GzZ7ENi4d2xWN/Vd1Y6
         YQovJ0giKKyHY7PFwH9bhvFBeZ8C9BIBqXQYgTrCu1yGKhqJSrxAkNXPKZyw9P03QRMr
         QVQ3KeogU18nxPfr0Y7wTxsXdauuICrX146oP62MR2v1IWXZBtaqc4s1XC2M+HUXnba3
         2Wsg==
X-Gm-Message-State: AFq9FYLcKlVB8T1iFHu9j2Wi8q2efEGGANv/pur1uevI/uNl/pLPqmKz
	PCu3m7X2QE+dej3KJEOaz4D8ACHAM/DPVou+XyxauSReu94A8aHhjFpaOMq8LJcyH46JKh87dAR
	H4eVWgzo0I5jXOjfH+NLwTGnYGJv3qUHAzFjj
X-Gm-Gg: AYBFou1o280/JbwIMfoAcyVu+vU0PMTlaNj/naTsYV+hYfx2wDT0te/sKF05ARQncRr
	0y2BkqLpftRUECvK/lxVjdVw0Sb4zDJo/9Y+ndsBSLPwjn20fbMrgML0f7W2ccaZ2Z70IiWIdn9
	o4N+TjTdgW+7sxt2RaSdQLAC0W22RmMbyQvlYgu5VnCQMXeS8jPV8scDS7auKAcN5W1yiZhfQTy
	kEOar5HtOnxnBh/2ZZufwEytjn4DS5S0HuZPviL2W4uZDmg6qRmZ5KBpb3yzFVjWnECgLblPx5Z
	u3KrVEd2m5GOEUUvAeB56/7mk/irgggpgyXWRBFi8BwXQbT+xHBkDI7jIpPG28AGobXr2prtL1R
	l/+u/NrJDJ//q5uOXc1YTjbUKug==
X-Received: by 2002:a05:620a:2a16:b0:93e:920c:c00e with SMTP id
 af79cd13be357-93f29ceecb2mr1897331885a.21.1792510143334; Tue, 20 Oct 2026
 08:29:03 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-4-biju.das.jz@bp.renesas.com> <sashiko-outbox-178011@kernel.org>
In-Reply-To: <sashiko-outbox-178011@kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 20 Oct 2026 16:28:52 +0100
X-Gm-Features: AclHuK8LDeYH5plS4ObWqQu99C_hUhcvhaaMFjueV1TDvngZn9eDNEhrMl-PxcY
Message-ID: <CADT+UeB520ehCMt4Yv6Q9aWNsE+v-aUKyjbuzCxLNiwKwC+jfA@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] serial: sh-sci: broken TX on SuperH PORT_SCI from skipping clear=
_SCxSR()
> - [Medium] serial: sh-sci: unlocked control register RMW in sci_tx_end_in=
terrupt()
> --
>
> commit c9eeab42d1c45b13adb330fd8baab03f6ddbfeb6
> Author: Au Dang <au.dang.jx@renesas.com>
>
> serial: sh-sci: Skip TDxE status clear for PORT_SCI
>
> This commit skips calling clear_SCxSR() to clear the TDxE status bit for
> PORT_SCI in sci_poll_put_char() and sci_transmit_chars(), relying on hard=
ware
> to automatically clear the bit when data is written to TDR.
>
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index d577f9de62595..e4c7a3e146884 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *por=
t, unsigned char c)
> >       } while (!(status & SCxSR_TDxE(port)));
> >
> >       sci_serial_out(port, SCxTDR, c);
> > -     s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(po=
rt));
> > +     if (s->type !=3D PORT_SCI)
> > +             s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR=
_TEND(port));
> >  }
> >  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
> >         CONFIG_SERIAL_SH_SCI_EARLYCON */
>
> [Severity: High]
> Will skipping clear_SCxSR() for all PORT_SCI ports break transmission on
> classic SuperH SCI hardware?
>
> In drivers/tty/serial/sh-sci.c, PORT_SCI is shared between DT-based Renes=
as
> RZ/G2L SCIg ports (such as renesas,r9a07g044-sci matching renesas,sci) an=
d
> classic non-DT SuperH SCI ports (SH770x, SH7750, and SH7760 registered vi=
a
> plat_sci_port with .type =3D PORT_SCI).
>
> While RZ/G2L SCIg hardware automatically clears SSR.TDRE when transmit da=
ta is
> written to TDR, classic SuperH SCI hardware does not clear SCSSR.TDRE (or
> TEND) on CPU writes to SCTDR. On classic SuperH SCI, software must read S=
CSSR
> with TDRE =3D=3D 1, write the byte to SCTDR, and then explicitly clear TD=
RE to 0
> via clear_SCxSR() before the hardware transfers SCTDR to the transmit shi=
ft
> register (SCTSR) and begins shifting.

I will introduce tdxe_autoclear to handle this for RZ/G2UL based SCI IPs


Cheers,
Biju
