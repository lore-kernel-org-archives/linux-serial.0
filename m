From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] serial: PL011: clear pending interrupts
Date: Wed, 21 Mar 2012 20:08:43 +0100
Message-ID: <CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
	<CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61930 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2CUTIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Mar 2012 15:08:43 -0400
Received: by yhmm54 with SMTP id m54so1243445yhm.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Mar 2012 12:08:43 -0700 (PDT)
In-Reply-To: <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Wed, Mar 21, 2012 at 12:58 PM, viresh kumar <viresh.linux@gmail.com>=
 wrote:
> On Tue, Mar 13, 2012 at 5:57 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/am=
ba-pl011.c
>> @@ -1927,6 +1930,10 @@ static int pl011_probe(struct amba_device *de=
v, const struct amba_id *id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and cle=
ared */
>> + =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
>> + =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
>> +
>
> I was working on v3.3 and found a crash for my SoC. When i checked i =
got a crash
> due to above changes.

Strange, because these changes are not even in 3.3. Did you mean 3.4
HEAD?

> There are two issues here
> =A0- uap->port is uninitialized
> =A0- clk is not enabled.
>
> How is this working for you?

The uap->port is likely the problem. The clock does not need to be
enabled for this, the clock that need to be enabled is the pclk and tha=
t
should be taken care of by the amba/primecell core.

It worked because I had some system which didn't scream when it wrote
into that NULL-address for some reason :-(

I'm sending a fixup patch to sort out my own screwing up.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
