Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1176347532
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063173; cv=pass; b=EtTDeRlzz3UiTv7+l33aJNT0IEmFP+y6Hzo4oJAWgt7KktBTPr4yWYEG3AcQRCxYWMZlhvIhzsX/iLmecSSE05EiFI4/LzOyTGqn0ufoghvc7O3qsWQ8ztmsXM8ZzmQgCah/GtcNzKpIrXptFO40Z+Y4/M+8Vf+9N3QfCVIPs0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063173; c=relaxed/simple;
	bh=Vhg9CdEH7+btjINehl2B/FEThVqkGiUPVHx1dzpGa+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQBzQAOh+U0MwgFb+4zGHUxub3lTYa+IwzfuYGg44Yg9QTlpjyZ7hafxoIe5gy5YiFL3C3HTCmhSmoEJ3LdotpKpTOPA1cZgh6XW7IQGg7jujs9hpnx3j5bp73jqPZ8J93vRsKF8HWAXMcXARRncT9nJZLrb3GkxmAXUljm748w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UozZgL2J; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UozZgL2J"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so839210a12.0
        for <linux-serial@vger.kernel.org>; Sat, 03 Oct 2026 14:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791063170; cv=none;
        d=google.com; s=arc-20260327;
        b=e2tkrj75VBnOA5O4B8BIJsH9nwwKkuApbKVdbZrwj5ghsLtgRjtbGL0kgzSNcubZ+J
         QjufHLOtbtKCN4UuALzXWTrRngHpgQmv79CtSbJeCdrMXIvLxOIHWRkeVPxHvgTHkTOU
         QhzAD5KRQWItZDoLAxlR+My+8Qj21KNPjrvHk4PFQ+IhAq6QwIClSr4nr1GHPyFMZsNt
         /8oB++xQ2JeTfh7VOa50exItCjCEBNWWsiixe3PVS0nQJGyGsZBzSVoVL+o5C7OsNjI+
         2/G6d+SG8BeQKwyroFIq1GwaD1NejrmArZauEW2DBN2kR1ScV1f2uMAjlyuuFeAF714j
         4W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=af+0t3iUGS2/6SKpeL3Rck7lTZ4b3LAtconFKbgLekw=;
        fh=Qs8o4c02DbEnLt6ItQ0zf2/0vp3J+hILC3S+ZClGB8s=;
        b=C9U2pBY23XAIaiABUMXwNtFdUt8HAcbbJitYMxhiuuYYBZmZ62EO1BVROsr7JbPAzH
         GrGMV5OavTlI+soiys1e32BzdUuuaxqr4CY89bzTImvFtaOpIVGLsaF1RY8lYIIEcobB
         oQTZs90AnqYF6wjauygHhuS/KWf8TGuPHhJsZONHw9hdqQb94Wej+gvOi/oM+k/vvjwl
         w41PvvVxRkTj7gWb1WrCqIx6nuJz7Y46J3ALOf2u4NMnTLD2FVg1nVi2Es/9ecDGRvMx
         guxwRsLHMW5AFtHy90pbPJr+j8fxHVNCZ7QXcuPpJ8LR3dmIQsFv6TD3T5sfRcFZpATt
         nAAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791063170; x=1791667970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=af+0t3iUGS2/6SKpeL3Rck7lTZ4b3LAtconFKbgLekw=;
        b=UozZgL2JiWuflMMze8QKvwevHxL6AkoMXRBpPyLxrrLrI9qdGm9P5RPUkz4jQESRUO
         f28vwqCQyCaImI+BgbILgk/G46wcEBf6RlPTkH6oHlZQS+2bS0C0qotqRs+MPe1DKj6o
         oRMJQ7I2VdoNCQPXXgKhe0Ybta+eGXyioazihk8LXi/qCyNZUoOzpJlRr9ncYMEL3XES
         ciXW5KdQOfajwc0+CARD6NUxWIx4WNAuWY63dKDr6vF55t2Xvsb7zNqgkT9EVABKoHhF
         Ocp6FpTjusrpiNsLxkSxqXpzzOQ546bI580BIrw8TEW4QEJcxbhsTg2EtSmtqGoNgJhG
         UBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791063170; x=1791667970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=af+0t3iUGS2/6SKpeL3Rck7lTZ4b3LAtconFKbgLekw=;
        b=trsa3eRp19qBWGEPCH+lX5F+f7Coa8/k4FvtP94gaUmy0Zm3Zw+inhCPsXF/3KPLNp
         eJxc4T4ecWUm6Gk8ZnHWyeU5sfnWkCrFU4a+AP6X47dRrV2Dz/XSw4KwbSAMjJvJ6X8G
         DrFT4oB6FRaXhHeO5+lySrg1kTHNwVDePs7v/2jRqZHTY+vhphu+2qiejHVXYz7WdzNe
         sTHiGl0pOkKBAG9Fj4y4HmGbZ7cTl4fdyjl4a3cCg5hj3oHWRYLfEer2sIljEy+4zUXm
         XlFNgD9zXZQ8GWF1jMnUpMxnQmmT92R5iIbrYdKeBn8VAorMsm26+SL2+gd3JFOaBoTL
         56qQ==
X-Gm-Message-State: AFq9FYJ6mUC+dBLZuej/DUws3ImJqdzwpohzhEYExdLa7qBSUNm5W+o+
	HHWBACxYLPvfxQms1tb/gZ2V7LCwDWo7vNTLEBrdEgD5sGrbj/QZPqx9M9FcbZfzUKlhX5MUG4O
	U7dYlRnSLpklHIm1V4Uw6rT2/UO3Bq4o=
X-Gm-Gg: AYBFou1e+Kyz8wLMj2MIKDFpVeBPEyO++jTM8yLhU3Zm46YiV6jTtmP1f0Rdv/y7rrh
	D6hBG1SFuE3eHOV2JovWkaRGYv1DDB8AM3DRRWSQlA4iphNCa3dfpBSAXrLxdRaN6DauPojWxJ8
	Z+ZhxS7J1/bGK837hNgnGEq5KQt0vOzCxHSt+kuYjwmtW5qcrvYZeDKuORGqsd9t4xcwsYfPTvy
	FiSfy21oyqslg3FwC8Z9s2TUKz9TLwl+Clr8aJrae51thzZDf+mbyOPFOXxQ4mCnKFZC1T2A9SC
	bNS3tc9yBSeiHk+YiPs9w0cfkG6p95DXUYI7FIS25YPIF/He81n7Dt1i2a8RWvpEBLldTgIm2GR
	+JoeSZZLY9hvMa1gGgHuTnY+lqJ9EOLSuEDY4oYMJ6fCeoXo2cih8+tZ5/LzKpd/6mNXtkHfvyr
	LV3B4atiqcs/l+O/0f/iAtv+EBU1xqqTX6Xe3gELFULghJekadFg+RnAcf6xX2yAxa9w==
X-Received: by 2002:a05:6402:460a:b0:6ac:62c2:bd35 with SMTP id
 4fb4d7f45d1cf-6afad8bd818mr2550666a12.13.1791063169767; Sat, 03 Oct 2026
 14:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925181530.52953-1-rosenp@gmail.com> <2026100157-unleash-anime-e2cf@gregkh>
 <DLTSHPPY40S4.1G7I24UTEFX9C@gmail.com> <2026100212-massager-hardware-db44@gregkh>
In-Reply-To: <2026100212-massager-hardware-db44@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 3 Oct 2026 14:32:37 -0700
X-Gm-Features: AclHuK-g7Fqct_KQ4yY2h0ysuh8vENWPp09pevlntRadjvfUbDGiPGme2jGtvE0
Message-ID: <CAKxU2N9SVNL3747nJT-FQgis1O7iBrWzS3XGfXcyM78mUG7fGA@mail.gmail.com>
Subject: Re: [PATCH] serial: cpm_uart: use irq variable for platform_get_irq()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 01, 2026 at 01:38:15PM -0700, Rosen Penev wrote:
> > On Thu Oct 1, 2026 at 1:46 AM PDT, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 25, 2026 at 11:15:30AM -0700, Rosen Penev wrote:
> > >> struct uart_port has its irq member as an unsigned int, which does n=
ot
> > >> work when platform_get_irq() returns an error.
> > >>
> > >> Use a local irq variable to handle this and write to struct uart_por=
t's
> > >> irq member when platform_get_irq() succeeds. On success, it returns =
an
> > >> IRQ >=3D 0, which is representable by unsigned int.
> > >>
> > >> Fixes: 831603b3e8aa ("serial: cpm_uart: replace irq_of_parse_and_map=
 with platform_get_irq")
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> Closes: https://lore.kernel.org/oe-kbuild-all/202609251916.1XlVHLwd-=
lkp@intel.com/
> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >> ---
> > >>  drivers/tty/serial/cpm_uart.c | 10 ++++++----
> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_=
uart.c
> > >> index 39f54bb7b485..ca0acccd3dd8 100644
> > >> --- a/drivers/tty/serial/cpm_uart.c
> > >> +++ b/drivers/tty/serial/cpm_uart.c
> > >> @@ -1517,6 +1517,7 @@ static int cpm_uart_probe(struct platform_devi=
ce *ofdev)
> > >>  {
> > >>    int index =3D probe_index++;
> > >>    struct uart_cpm_port *pinfo =3D &cpm_uart_ports[index];
> > >> +  int irq;
> > >>    int ret;
> > >>
> > >>    pinfo->port.line =3D index;
> > >> @@ -1524,14 +1525,15 @@ static int cpm_uart_probe(struct platform_de=
vice *ofdev)
> > >>    if (index >=3D UART_NR)
> > >>            return -ENODEV;
> > >>
> > >> +  irq =3D platform_get_irq(ofdev, 0);
> > >> +  if (irq < 0)
> > >> +          return irq;
> > >> +
> > >>    platform_set_drvdata(ofdev, pinfo);
> > >>
> > >>    /* initialize the device pointer for the port */
> > >>    pinfo->port.dev =3D &ofdev->dev;
> > >> -
> > >> -  pinfo->port.irq =3D platform_get_irq(ofdev, 0);
> > >> -  if (pinfo->port.irq < 0)
> > >> -          return pinfo->port.irq;
> > >> +  pinfo->port.irq =3D irq;
> > >
> > > Why did you move where platform_get_irq() is called?
> >
> > So that platform_set_drvdata does not get called on failure.
>
> Why does that matter?
To avoid doing unnecessary work.
