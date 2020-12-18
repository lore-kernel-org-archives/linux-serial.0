Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB7C3526C
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 18:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5723B54
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLRSEm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 13:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgLRSEl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 13:04:41 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB51C0617A7;
        Fri, 18 Dec 2020 10:04:01 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id j140so1818958vsd.4;
        Fri, 18 Dec 2020 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4xV169XqZcW58uGX5CSlrQOHTBxyySGedbNHA+gkN0s=;
        b=kpt6MiFz0Gq51RDuJq72fnh+eZBIE9MQiMpfH3VNVrVrOS8lWG++XmPSl5lPNG3bKI
         eFnYlI/Anc3Dhkoue7cyqPCXDWvIlXH3lGOgldBaBNa15v9WJoovFYh7y2el7sFvXtGg
         pKKUPkLX+cEF5+29cs0LuXSIwnqDp70cTSFvpMIS+10nExGU7fG/hWjYN7o8t/HphAxL
         Pu5YaupYu9XQF7rYjKUii2ku1JDjB3FeSTM2xYuWT1qr6kaxonunGOavqP8XML8xreca
         6f4Es37Cwatg4WLVa0PrHwSi6P54Xuf16rg1qzbivLtqye6ObfURb0EdMoAwW3gnlKD2
         jWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4xV169XqZcW58uGX5CSlrQOHTBxyySGedbNHA+gkN0s=;
        b=qLBJmgZuvm+bLqNtXXCuvASYpq2nkFasVfyBXfKrCXd7A/o8HgknI1B4n0es4pyaYI
         T6qpIKQJD8k5F6RaT5lXfPFb2kfZS1CwR+Sa41uHNoVVSCDCwcMY/jIir6e8st0ACmM4
         shUg0yfeSaW2Rsm28GNG34/1PFVoTKynDsPbnSGGT+M6RtAWwULGP8idOtGQ3T7taIhB
         te11ROTiL07Iag0Gg+S3wzYk9V4n2OGeMhzB6E/x87J7RmwMonbwgY4ic1Cx3jKO4+W4
         RTmyMl+yDL0DG++2i6XPCNm/QYCr/SEcg/Wp/iwFBLMK1gJ3I63nKruy99AMfKxdXMxQ
         FVCg==
X-Gm-Message-State: AOAM532yyVO58BJcLt8kodvYdvtu7C1NsPi2uCULfxQb88EXFc65aKl8
        vhkIXixk+IkBDsKPgBCXtb3mm7I1wum0lHYqRUqjgYuh/Ao=
X-Google-Smtp-Source: ABdhPJx9AK16zQKCgSV1/S5MGevew8FZi+OBexVhRFge6WwqQXuDr8x2oH1WWB3fSOa428Xz13DnWXkCehtYnRSbqRY=
X-Received: by 2002:a67:f601:: with SMTP id k1mr5839327vso.46.1608314640197;
 Fri, 18 Dec 2020 10:04:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Fri, 18 Dec 2020 10:03:59
 -0800 (PST)
In-Reply-To: <X9d039qPr/LO/2R/@localhost>
References: <20201202113942.27024-1-johan@kernel.org> <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com> <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com> <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com> <X9d039qPr/LO/2R/@localhost>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Fri, 18 Dec 2020 10:03:59 -0800
Message-ID: <CA+uuBqZgq4KRZsqGRKDUbKAcQxYr1XPhYDrjzMNfWMYgDX8Wfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg K-H wrote:

> We see devices that are "obviously" not the real vid/pid all the time in
> the wild.  There's nothing "illegal" about another company using your
> vid/pid, look at all of the ones out there already that use the FTDI
> vendor id yet are "clones", same with pl2303 devices.

But are those reusers of someone else's VID or PID coming to Linux
kernel maintainers with requests to modify ftdi_sio or pl2303 drivers
to work with their clones?  Do you ever see LKML posts along the lines
of "Hi, I am so and so from such and such company, we are not FTDI but
we reuse FTDI's VID and PIDs, but our clone chip does not match the
original and we need to modify the ftdi_sio driver to work with our
poor man's clone chip" - do reusers of someone else's VID or PID come
here with such requests?

Let's apply this logic to the very specific example of USB VID:PID
0x0403:0x7152.  Right now I am asking you, esteemed maintainers, to
accept my patch to ftdi_sio adding support for this new custom ID
along with the necessary quirk.  If my patch were accepted and then
someone else squats on this USB ID, how would it be a problem for
anyone other than that squatter?  Are you expecting that someone is
going to file a bug report saying "I am using 0x0403:0x7152 for my own
USB device, but there is a quirk for this ID in ftdi_sio, and I don't
want that quirk for MY device using that ID" - is this what you are
anticipating?  If that scenario were to occur, how could it possibly
be right to choose that hypothetical complainant's interest over mine
if one can trivially check with FTDI and confirm that 0x0403:0x7152 is
officially allocated to Falconia and not to the other contesting party?

> We also have fuzzing devices that spoof vid/pid pairs in order to test
> kernel code, as well as being used as malicious devices to hack systems
> or do other "fun" things.

And where is the harm?  If my patch adding ftdi_sio support for
0x0403:0x7152 with the special quirk I am asking for were to be
accepted, and then someone presents this USB ID to a target system as
a form of hack or fuzzing test, where is the harm?  If anything, such
action would be a good thing, as it would exercise the quirk function
and ensure that it doesn't crash the kernel or anything like that.
Yes, the quirk flag will be set on that ttyUSB device - but if they
are deliberately presenting a USB ID whose owner said "this ID means
that this quirk is needed", then how is it a bad thing to apply the
quirk when that ID is detected, fuzzing/hacking or not?

> Blindly trusting these numbers are something
> we can no longer do.

Please clarify what you mean by "blindly trusting" in this very
specific context.  Suppose some company makes an entirely new USB-
interfaced chip, they assign it a unique ID (obtained officially
through proper channels, not taking squatting on else's), and they
submit a brand new Linux driver for their brand new chip, a driver
that naturally binds to that chip's new unique ID - are you going to
reject that driver and keep the new chip forever unsupported by Linux
because you are concerned that someone else will reuse that same USB
ID for something completely different?  How is my case any different?
The only difference is that in my case the custom hw product is a
board and not a chip - but how are board-level designs any less worthy
of mainline Linux support than chip-level ones?

Johan Hovold wrote:

> My reasons for proposing the NORDY sysfs interface *and* termios flag
> are as follows:

The patch series presented so far provides the sysfs interface and the
ftdi_sio ID-code-specific quirk for DUART28C (which would make me
happy), but does not add any new termios flag.  Are you planning to
present a new patch series that also adds the new termios flag?

> You cannot generally rely on the state of these lines before opening
> the port at least once,

I disagree.  Manufacturers of USB-serial chips like FT232x/FT2232x
*guarantee* (see FTDI's AN 184) that their DTR/RTS CMOS outputs *will
not* drive low (they will either drive high or be tristated) until and
unless an explicit command comes in on the USB control pipe to change
those signals to the "on" state of CMOS low output.  Therefore,
hardware engineers have a right to demand from OS maintainers that
OSes (who are middlemen between applications and hw) provide a way to
NOT issue that particular USB control pipe command if it is not wanted
by the application.

> but for applications where this is possible
> and where even toggling them once is undesirable

s/undesirable/killer/, for the specific case of UART Channel B on
FreeCalypso DUART28C, the custom board with the custom USB ID at the
crux of my quest.

> we *can* provide
> some out-of-band mechanism to change the default state of the NORDY
> flag (but we could also ignore this use case, keeping the status
> quo).

In the case of the parenthetical option, are you basically saying
"screw you" to me and my users, refusing to mainline our zero-effect-
on-others USB ID-driven quirk patch, the one without which the device
cannot work with Linux?

> This could be an interface to control just the initial state of this
> flag after probe() or it can be used in parallel with the termios
> interface. The latter is what is implemented here.

My concern with the termios flag idea is that in the absence of a
specific proposed patch to review, I don't have a clear view of
exactly where this new flag will be inserted, and I have a concern
about this new flag breaking things.

Right now my custom userspace programs initialize termios like this:

#include <asm/ioctls.h>
#include <asm/termbits.h>

...

	struct termios2 target_termios;

	target_termios.c_iflag = IGNBRK;
	target_termios.c_oflag = 0;
	target_termios.c_cflag = br->termios_code | CLOCAL|HUPCL|CREAD|CS8;
	target_termios.c_lflag = 0;
	target_termios.c_cc[VMIN] = 1;
	target_termios.c_cc[VTIME] = 0;
	target_termios.c_ispeed = br->nonstd_speed;
	target_termios.c_ospeed = br->nonstd_speed;
	if (ioctl(target_fd, TCSETSF2, &target_termios) < 0) {
		perror("TCSETSF2");
		exit(1);
	}

br->termios_code will be codes like B115200 for standard baud rates,
or BOTHER for GSM-specific baud rates like 812500, with the actual bps
number going into br->nonstd_speed.  You mention C libraries below,
and there is an important lesson to be learned here: as I understand
it, support for non-standard baud rates via BOTHER was added to Linux
as in kernel ages ago (at the urging of embedded systems folks like
me), but libc people (whichever libc it is, I don't care for their
politics) apparently never got the memo, and it appears to be
impossible to set non-standard serial baud rates using standard libc
headers and termios APIs.  It appears that the *only* way to set a
non-standard serial port baud rate from a lowly Linux userspace app is
to use <asm/xxx.h> kernel headers and raw ioctls - and as I quickly
found out, the necessary <asm/xxx.h> headers *conflict* with standard
libc ones, hence the necessary code needs to be moved out into its own
compilation unit that doesn't need much in the way of other libc
headers.

Back to your proposed new termios flag: are you thinking about adding
it to c_cflag, where CLOCAL and HUPCL currently live?  If so, it would
be pretty much impossible for userspace code like mine to not clear
this new flag.  You could argue that my approach of absolutely setting
all termios fields is wrong, that I should read the previous termios
state and make my desired changes, but considering that most termios
flags are just unwanted noise for raw byte I/O applications, approaches
like mine (init termios from scratch) are probably commonplace.  OK,
I could read previous termios just to read and preserve the NORDY flag
- but how would I do it when it will be years (if ever) before the new
flag definition appears in userspace-available headers?

So here is my concern: suppose that the "generic" solution you guys
end up implementing and merging will revolve around a new termios flag
added to c_cflag or some similar place, along with a sysfs interface,
and maybe even an ftdi_sio driver quirk to set this flag automatically
when DUART28C custom USB ID is detected.  The first open will be good
- but the termios flag will get reset, and breakage will occur with
subsequent runs of the same userspace programs messing up the hw.  I
suppose I could implement a workaround by adding code to my FC host
tools userspace sw suite to always do a sysfs write before opening the
serial port, but it certainly isn't anywhere near clean.

If you still insist on a termios flag rather than just sysfs, one
possible clean solution would be to have two separate flags in the
kernel's internal data structures: the new termios flag would end up
inside struct ktermios in the kernel, whereas the flag manipulated via
sysfs or set in my DUART28C USB ID quirk goes into struct tty_port
iflags like in Johan's current patch.  If either flag is set, suppress
automatic DTR & RTS assertion on open.  Alternatively, put the new
flag under getserial/setserial Linux-specific ioctls, rather than
termios - then it won't get inadvertently cleared so easily.

> As a bonus, using sysfs for this allows this feature to be used also
> before NORDY support has been added to the c libraries.

This part is absolutely crucial: the new kernel feature will be
essentially useless if the lack of support in userspace-available
headers makes it inaccessible.  For devices other than my specific
DUART28C which I still argue should be covered by an ftdi_sio driver
quirk, sysfs is the only viable option for immediate relief of users'
suffering.

Oh, and here is another reason why a USB-ID-driven ftdi_sio quirk
patch is pretty much an absolute requirement for me: even if some
generic solution that works for "any" serial port were to be implemented
in current bleeding edge mainline, it will be years before these new
kernels percolate to end users to a sufficient degree to be considered
ubiquitous.  Thus for the foreseeable future, I *must* support users
of old kernels, and because the necessary feature does not exist there,
directing users to apply a local patch is the only option.  And if I
am telling users to apply a local patch to their kernels, that patch
needs to be minimally-invasive-surgical, self-contained entirely within
the ftdi_sio driver and not touching anything outside of it, and as
easy as possible to apply to a very wide range of old kernel versions.

Whatever solution you guys are going to come up with in terms of new
termios flags and/or sysfs, it will be infeasible to package it in a
form of a retro-patch which any Joe End User can trivially apply to
his or her old system running whatever random old kernel version - but
my self-contained ftdi_sio patch adding support for my custom USB ID
with the needed quirk *is* trivially applicable by end users on just
about any old system.  Thus I am begging and pleading with you to
accept my DUART28C USB ID quirk *in addition* to whatever "generic" or
"works for anyone" solution you esteemed gentlemen come up with.

> Note that one of the BSDs recently added a termios flag with the same
> semantics as the proposed NORDY which seems to suggest that this is
> interface is indeed a natural one.

Would you happen to have a link or at least some specific search
terms?  I would like to know which BSD it is, how they named their new
termios flag which you say does the same thing, and where they inserted
it, to get an idea of what to expect if going this route.

> Side note: Also the Windows API has a setting for the state of these
> lines *after* open (i.e. similar to a termios flag),

I would not describe it as being similar to a termios flag, instead I
would describe it as similar to TIOCMBIS and TIOCMBIC.  Perhaps they
retain the state on close-then-reopen sequences - I don't know that
part.

> and there are
> reports of Windows users not expecting the lines to be raised on first
> open

I read reports from Python users who were migrating apps from Windows
to Linux, expecting easy portability because it's Python, and they got
bitten by automatic DTR & RTS assertion under Linux which didn't
happen for them under Windows.  I don't work with Python at all, so I
don't know much in the way of details, but supposedly Python maintainers
responded that it is a known Linux limitation, that they can control
the state of lines only after initial open, and can't avoid an initial
glitch - whereas under Windows they did avoid that initial glitch,
going through layers of Python, not even using Win32 API directly.

> (and behaviour changing between OS releases). For FTDI devices
> there appears to be some driver-specific out-of-band mechanism in the
> system properties for setting the default behaviour.

I didn't know this part.

Mychaela,
she/her/hers
