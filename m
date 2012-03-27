From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] amba-pl011: fix panic introduced by "clear pending interrupts"
Date: Tue, 27 Mar 2012 09:07:22 +0200
Message-ID: <CACRpkdZXhJn241n8wMU8yUFwL7mpWrV3hP6C-_r_P1GGWgd_Og@mail.gmail.com>
References: <20120326203209.GA8182@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47746 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2C0HHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 03:07:23 -0400
Received: by obbeh20 with SMTP id eh20so6161715obb.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Mar 2012 00:07:22 -0700 (PDT)
In-Reply-To: <20120326203209.GA8182@mail.gnudd.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Mar 26, 2012 at 10:32 PM, Alessandro Rubini <rubini@gnudd.com> =
wrote:

> patch 9b96fba, currently in linux-next, clears interrupts using
> uap->port.membase that has not been assigned. =A0My x86 system,
> that uses a pci-to-amba bridge, panics with a message like:
>
> =A0 BUG: unable to handle kernel NULL pointer dereference at 00000038
> =A0 IP: [<c12c85ed>] pl011_probe+0x119/0x303
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Yep I know, already sent the remedy, just waiting for Greg to pick it u=
p:
http://marc.info/?l=3Dlinux-serial&m=3D133235774423240&w=3D2

But thanks for the quick attention :-)

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
