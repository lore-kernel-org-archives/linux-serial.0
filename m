Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC1220687
	for <linux-serial@vger.kernel.org>; Tue,  2 Dec 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696064; cv=none; b=JIyPsuWYpf3fGf6bv7xH2mUjtOv7xgnBJ6P/ejxmXuSnDq41QVY6oqNzOSkz04tNEugO/srSuzlC1rBjkD181yw4jcg7XE21WnM3akAYelbCiE1HKoFL6jxsR31h7+KsV3128qkX70JD7gi4HuHm3CHAfyUSF9V2RpPMiggZPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696064; c=relaxed/simple;
	bh=D6cujDhDtOcbt7TUxe8KHjkX83CszqubAOZwa97WWXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVya1tuzpwm9Ff4BwIv/1tx1QU7cEbgFSKDJ47eVIbykvnabVqJIGReUsT8U6u5Xkn63/Q3QPCalD8pEtMXHiYwJL7xKvR9JvT5jPAtWqVBqJfD6pV62de580RlHNbE86djsCCt2cZv4Nr3ZgoXtMON0CNKJdkHMtMJPb79FIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly1r69ba; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly1r69ba"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so3995128f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 02 Dec 2025 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696058; x=1765300858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1BT7EHXNzu1vkfANQoOALlxYL5lcX+7Z2Q/CxBrAT0=;
        b=ly1r69badI3ROHxjqMV05WTAhosZgkViLC7/YkDx32LNHRhlbfHvEd0d5M85zfBGES
         P4t/+dbOPskuLJJF0GSkjstczqmKFsWJLZlRCE87NALT+yLD+8CRqeUu91yDjpUPZj/+
         WHTaaOz8bjEwHO3tD+BCzxyA+A/h6Jz6qAheabsGViR8EaIqM54kAgK4QtTjQ3+jjn9e
         UcxAY8Stf0bHQu2oUU+45ySq2gofchB+Vag1EIXD1qYnh3vepRFrvpWP2H2CZp4nZaU4
         XaiOX06kKbY4lXzE64T2XDIi2EBhNGjEmLrdBcN6XO7GNSLODsOBk47ykFxdxPP2QFsN
         RK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696058; x=1765300858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1BT7EHXNzu1vkfANQoOALlxYL5lcX+7Z2Q/CxBrAT0=;
        b=VPmWXxlz9TMDKVWKfNMkarQU1WIXRsJvNoa+fEbIepAmxVciAe6gDJtFr4YiVc0SbV
         GVhIdR6Nx0iy1sFiR2fed/kWLGkTueYxZhYwnC8jc+nwFitJF5X/Ets34nMXJ9pu1WAU
         AVEWm2OjejEOnQ5d/PK8YEtUo6TnVpY+Wh9IKe2NBeXC8sd7AxbvVeks0VRw7RV0nSq7
         BGvaihPhfpblH/r4d8434+xHqB3Yt0GDSb3nmsSpy8ccqtzDoTc7sF/iQlSqwe0SJ/o/
         /Iy/QToVo+6XY5nAEIfBLF675TAwxpXs64G4Sl327ulJyTw/gjkIuFSUwXnQr5795k+f
         ynJA==
X-Forwarded-Encrypted: i=1; AJvYcCX7J/PZnSZoBPwt3lN2LjiTtJB4nrg+yvq8NNBQ46miFLU+nOzlpXhxvaO1cf6mRrBMFkq5uj7oQU6zzwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8k1jzZ/qkaK1+wZHnABt3dJlFb/bzsTySdgELBZZ4DNoZNm9Q
	nn/0xtG+8TfyEHhkzw4WV+pUASN1rnhL4IfzLjkvm9BotBSJ4Qx7NCeS8j5zsg5qUMq/0+yTp+H
	vGdFDIIHhajsioDvB64VzGd2xjIOH0uU=
X-Gm-Gg: ASbGncuwVm3We7VE7ZO9stO5LFXlTcw20rVrKjS34Ca2TGVb8N5nns76CGB9Z5joGwk
	GGp8rZnRRW1LwnOG/quyiuzN3hTf0DnMoAc2gSyLQTfaVwGZPXyZRJSdOKtbMS8UtihCT67lPR+
	beXvvGAwCWpUCkuVhmMFWbmni/N2A4+WCuYbMhCoE75BDGYXMxJ6atlh/Qb/qfCaU4ioh5bijnr
	V+AvFjyNjvkec/ltmqV+sWsWdT//6UfTqzM+E7o2diPPweOM/3mx5GtXJFy+H1P+FG0SIspm2gr
	s+0r9q/agfbBSl3Ehe35Vb0sH6/gblGbNENZXg==
X-Google-Smtp-Source: AGHT+IHHkzquubDncEgzKAjffld+KGygoMEWTgQ02TjxZ1n7kHuWGvQfDuCUieNWJWiu1doe66mEBlRuj1GGu1Sb+Kk=
X-Received: by 2002:a05:6000:230f:b0:42b:4223:e62a with SMTP id
 ffacd0b85a97d-42cc1cbe219mr45227224f8f.23.1764696057923; Tue, 02 Dec 2025
 09:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 2 Dec 2025 17:20:31 +0000
X-Gm-Features: AWmQ_bmEp3rxLNkyPH2GbHJpGnJbWFjGlZQZl8dFFsPo6e9aZepSroMSoKsGvsY
Message-ID: <CA+V-a8skz6D__T3oeTq4vfikkxRKM=6MAEgsu_MK01RqVLrjkA@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] Add RZ/G3E RSCI support
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Thank you for the series.

On Sat, Nov 29, 2025 at 4:43=E2=80=AFPM Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
> 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the hardwa=
re
> flow control.
>
> v4->v5:
>  * Updated commit description related to IRQ difference in binding patch.
>  * Dropped the tag for binding patch as there are new changes.
>  * Added aed and bfd irqs for RZ/G3E.
>  * Moved reset: false to RZ/T2H SoC and dropped the else part for RZ/G3E.
>  * Updated conditional schema with interrupts and interrupts-names.
>  * Added new patch for set_rtrg() callback.
>  * Dropped checking port type for device file{create, remove} and instead
>    started checking the fifosize.
>  * Dropped sci_is_fifo_type() helper.
>  * Renamed rsci_port_params->rsci_rzt2h_port_params.
>  * Renamed rsci_rzg3e_scif_port_params->rsci_rzg3e_port_params.
> v3->v4:
>  * Collected tags.
>  * Dropped separate compatible for non-FIFO mode and instead using single
>    compatible "renesas,r9a09g047-rsci" as non-FIFO mode can be achieved
>    by software configuration.
>  * Dropped the non-FIFO mode support and will add this support later.
>  * Renamed clock-names from bus->pclk
>  * Rearranged the clock-names tclk{4, 16, 64}
>  * Added separate patch for sci_is_fifo_type() covering all SoCs that has
>    FIFO.
>  * Updated commit header and description for patch#{3,9,16}
>  * Dropped rsci_clear_SCxSR() instead of rsci_clear_CFC() as it clears th=
e
>    CFCLR register.
>  * Added separate patch for updating t2h rx_trigger size from 15->16.
>  * Added separate patch for renaming port SCI_PORT_RSCI->RSCI_PORT_SCIF16=
.
>  * Dropped enum RSCI_PORT_SCI
>  * Replaced the enum RSCI_PORT_SCIF->RSCI_PORT_SCIF32
>  * Moved rx_trigger update to later patch#16.
>  * Reduced the checks in sci_init_clocks() by avoid looking up clocks tha=
t
>    are not relevant for the port.
>  * Added separate patch for updating early_console data and callback()
>    names.
>  * Updated rsci_type() to drop "scif" type instead use "rsci"
>  * Replaced the compatible "renesas,r9a09g047-rscif" with
>    "renesas,r9a09g047-rsci"
>  * Renamed the port enum from RSCI_PORT_SCIF->RSCI_PORT_SCIF32.
>  * Renamed of_rsci_scif_data->of_rsci_rzg3e_data
>  * Renamed the funvtion rsci_rzg3e_scif_early_console_setup() with
>    rsci_rzg3e_early_console_setup().
> v2->v3:
>  * Dropped 1st and 3rd items from clk-names and added minItems for the
>    range for the binding patch.
>  * Added minItems for clk and clk-names for RZ/T2H as the range is 2-3
>  * Added maxItems for clk and clk-names for RZ/G3E as the range is 5-6
>  * Retained the tag as it is trivial change.
>  * Updated dev_err_probe() in sci_init_clocks() as it fits in 100-column
>    limit.
>  * Dropped cpu_relax() from rsci_finish_console_write() and added a
>    comment.
>  * Added sci_is_rsci_fifo_type() helper for reuse in probe() and remove()=
.
> v1->v2:
>  * Updated commit message for patch#1,#3,#9
>  * Added resets:false for non RZ/G3E SoCs in bindings.
>  * Increased line limit for error messages to 100-column limit for patch#=
3
>  * Updated multiline comment to fit into single line.
>  * Updated set_termios() for getting baud_rate()
>
> Biju Das (17):
>   dt-bindings: serial: renesas,rsci: Document RZ/G3E support
>   serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
>   serial: rsci: Add set_rtrg() callback
>   serial: sh-sci: Drop checking port type for device file{create,
>     remove}
>   serial: rsci: Drop rsci_clear_SCxSR()
>   serial: sh-sci: Drop extra lines
>   serial: rsci: Drop unused macro DCR
>   serial: rsci: Drop unused TDR register
>   serial: sh-sci: Use devm_reset_control_array_get_exclusive()
>   serial: sh-sci: Add sci_is_rsci_type()
>   serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
>   serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
>   serial: sh-sci: Add support for RZ/G3E RSCI clks
>   serial: sh-sci: Make sci_scbrr_calc() public
>   serial: sh-sci: Add finish_console_write() callback
>   serial: rsci: Rename early_console data, port_params and callback()
>     names
>   serial: sh-sci: Add support for RZ/G3E RSCI
>
>  .../bindings/serial/renesas,rsci.yaml         |  99 +++++-
>  drivers/tty/serial/rsci.c                     | 310 ++++++++++++++++--
>  drivers/tty/serial/rsci.h                     |   3 +-
>  drivers/tty/serial/sh-sci-common.h            |  10 +-
>  drivers/tty/serial/sh-sci.c                   |  80 +++--
>  5 files changed, 422 insertions(+), 80 deletions(-)
>
Tested on RZ/V2H and RZ/V2N EVKs,

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar


> --
> 2.43.0
>
>
