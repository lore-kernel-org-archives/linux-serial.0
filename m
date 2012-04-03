From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Tue, 3 Apr 2012 09:19:23 -0700
Message-ID: <20120403161923.GB4894@kroah.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
 <20120329213333.GA15231@kroah.com>
 <CAP=VYLrbZNxYWT-TQt6SzXc3OpYnFVgiQqW-2pM+9V=z4LREow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34656 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab2DCQT2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Apr 2012 12:19:28 -0400
Received: by pbcun15 with SMTP id un15so60545pbc.19
        for <linux-serial@vger.kernel.org>; Tue, 03 Apr 2012 09:19:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP=VYLrbZNxYWT-TQt6SzXc3OpYnFVgiQqW-2pM+9V=z4LREow@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Tue, Apr 03, 2012 at 11:36:23AM -0400, Paul Gortmaker wrote:
> On Thu, Mar 29, 2012 at 5:33 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Mar 29, 2012 at 02:49:37PM -0600, Grant Likely wrote:
> >> On Wed, Mar 21, 2012 at 1:15 PM, Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> >> > Commit 360f748b204275229f8398cb2f9f53955db1503b
> >> > "serial: PL011: clear pending interrupts"
> >> > attempts to clear interrupts by writing to a
> >> > yet-unassigned memory address. This fixes the issue.
> >> >
> >> > The breaking patch is marked for stable so should be
> >> > carried along with the other patch.
> >> >
> >> > Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> >> > Cc: Russell King <linux@arm.linux.org.uk>
> >> > Cc: stable <stable@vger.kernel.org>
> >> > Reported-by: Viresh Kumar <viresh.kumar@st.com>
> >> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Ugh; the original patch is obviously broken. =A0How did it get app=
lied
> >> without testing?
> >>
> >> Greg, can you get this out to Linus ASAP please? =A0I have one com=
ment
> >> below, but I don't think it should block merging this patch.
> >>
> >> Tested-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > Thanks, I'll get it to him after 3.4-rc1 is out, in a few days, alo=
ng
> > with other tty fixes being queued up.
>=20
> Hi Greg,
>=20
> Just wanted to check this didn't fall through the cracks, as I don't
> see it in your tty-next or tty-linus branches.
>=20
> The original bad commit causes Silent Boot Death on qemu ARM
> versatile, which is kind of nasty.  It pretty much forces a bisection=
,
> which I did, which then led me here.

It's still in my "to-apply" queue, don't worry, it's not lost.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
