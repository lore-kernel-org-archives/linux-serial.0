Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA1EC33C8C
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B442208C4
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 17:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnbD9Tgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAGRCW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:02:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36765 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgAGRCW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jan 2020 12:02:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id q20so357701qtp.3
        for <linux-serial@vger.kernel.org>; Tue, 07 Jan 2020 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8VDYNz3D8dzr8Paverc5SjU9MC05Ui8WU/rBztnqAI=;
        b=HnbD9TgpM1gX8/yRRcibYGO3YaJoMfAeK9M7RCCQ0MlaLha3X6NaZSAWW3HgddClRb
         n0qcgRfMHAYSdNg08AemgGd2qXtJtLTMOumHMhz+5a4acHL7osi0nrjKd3wRNdo3i4Ix
         X/Z3F6AqBA+4Qt0LupTfAThBFaIGZpqMpEWjxy6Ps9eKd8Ur7scj6em3JSTDqOfdfhGG
         uBDJSM+MRyFsqCzZMvt5HPR4WZ8E7eNDKTwW+TiZROg4Bd7ighfCaI4sP0Z6A8mI7B2c
         xAIfHs2ji+odU9V+F9FZ5xtt8I+v2vLRgZHZxj74raQZh4XIuO0p4qmSxISS5x4QOOuG
         JisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8VDYNz3D8dzr8Paverc5SjU9MC05Ui8WU/rBztnqAI=;
        b=DpL3/eSgvUx8j20cLSBp9sjIQhg1YkYGk5sYPw4mUVFZsL4L/H6TITdTRQwfqdyzLJ
         WJtmksGlpDhb6spbqi5MiifQAyRiGFbftgtTO0rfriXTzdiLjPPpWQu75d2Dl0ZKzOJP
         RMVwtqmVaD+Wl9X2bVDCOoGJeR1Ro37a9iSnI4NQ3apr6bTQ7mB06/qdz6FY+bARIBsr
         JTeqMxdbzRr514xm17AVq/T3E9UrdBOUB3rvmMj/syP1LmH6ix8/Ls0JxmJfs+X+UxmS
         T9jvNnvGmgFabDa3jiT8EP7SDwMnSYQ9mN9Xkh9Hw8MybwWFtdBo5tQqaqPCTKp5S9FU
         aQ6Q==
X-Gm-Message-State: APjAAAXJOeIwag/dBg+J/PVUTX34mJMJiZqxG18gjy3g84ZGetaXbrZ8
        7O+xcAGhJZwrZUJ+grwK6RI+yKkF7mQhBJk1otpT/A==
X-Google-Smtp-Source: APXvYqzpUiVk7KT8Gp/mQaZeAy1KjNia+efSxzvYBnoxAmHInYKLRwGZcy/W2SG1L66erDvVET+jWUaqNY7zhusmYkY=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr81437675qtp.50.1578416540765;
 Tue, 07 Jan 2020 09:02:20 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053539a0599173973@google.com> <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com> <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <20191213101021.GA2141429@kroah.com> <CACT4Y+ZW8oLfupDbQuk-Q-J=WtsXPEXTsqeZAPGhXXPu4gGrmg@mail.gmail.com>
 <20191213112648.GA2257852@kroah.com> <CACT4Y+aC+Phfj91wdWJPH+zKcHLXPXQE9Ycn--qKboFHPnMW+g@mail.gmail.com>
In-Reply-To: <CACT4Y+aC+Phfj91wdWJPH+zKcHLXPXQE9Ycn--qKboFHPnMW+g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jan 2020 18:02:09 +0100
Message-ID: <CACT4Y+YigHSLOM-e1O0bxf_8D4jkM51jQW4ReWRZgcp9xfqp_w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 17, 2019 at 11:48 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Dec 13, 2019 at 10:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Dec 13, 2019 at 11:39:54AM +0100, Dmitry Vyukov wrote:
> > > On Fri, Dec 13, 2019 at 11:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > > You set up a dubious memory base for your uart and then get upset when
> > > > > > > > you write to that location.
> > > > > > > >
> > > > > > > > I don't know what to really do about this, this is a root-only operation
> > > > > > > > and you are expected to know what you are doing when you attempt this.
> > > > > > >
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > Thanks for looking into this!
> > > > > > > Should we restrict the fuzzer from accessing /dev/ttyS* entirely?
> > > > > >
> > > > > > No, not at all.
> > > > > >
> > > > > > > Or only restrict TIOCSSERIAL on them? Something else?
> > > > > >
> > > > > > Try running not as root.  if you have CAP_SYS_ADMIN you can do a lot of
> > > > > > pretty bad things with tty ports, as you see here.  There's a reason the
> > > > > > LOCKDOWN_TIOCSSERIAL "security lockdown" check was added :)
> > > > > >
> > > > > > The TIOCSSERIAL ioctl is a nice one for a lot of things that are able to
> > > > > > be done as a normal user (baud rate changes, etc.), but there are also
> > > > > > things like setting io port memory locations that can cause random
> > > > > > hardware accesses and kernel crashes, as you instantly found out here :)
> > > > > >
> > > > > > So restrict the fuzzer to only run as a "normal" user of the serial
> > > > > > port, and if you find problems there, I'll be glad to look at them.
> > > > >
> > > > > Easier said than done. "normal user of the serial port" is not really
> > > > > a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
> > > > > not per-device...
> > > >
> > > > Not true, there's lots of users of serial port devices that do not have
> > > > CAP_SYS_ADMIN set.  That's why we have groups :)
> > > >
> > > > You can change the baud rate of your usb-serial device without root
> > > > permissions, right?  That's a "normal" user right there.
> > >
> > > Yes, but this requires dropping CAP_SYS_ADMIN. And one can't drop
> > > CAP_SYS_ADMIN only for ttyS. If it would be a separate capability, we
> > > could drop just that, but not CAP_SYS_ADMIN.
> >
> > Ok, I think we are talking past each other here.  I am saying that it is
> > fine to talk to a serial port without CAP_SYS_ADMIN.  That should be
> > "safe" and not cause bad things to happen.
> >
> > But if you do have CAP_SYS_ADMIN, you can do a lot more "bad" things
> > with a serial port (like setting memory addresses).
> >
> > Your tool always has this capability, which is fine, but does not mean
> > that serial port accesses by everyone has to have that capability, which
> > is what I thought you were saying.
>
> I mean that I don't see a realistic way to apply your "Try running not
> as root" suggestion.
> We can drop root, but that will dramatic effect on lots of other
> things that has nothing to do with serial console.

I've disabled testing of TIOCSSERIAL in syzkaller:
https://github.com/google/syzkaller/commit/af9047c60a3db32d5e43c29321f8f531db051a63

#syz invalid
