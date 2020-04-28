Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B82CC83007
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593E620730
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MHaZ08rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD1Vcj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgD1Vcj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:32:39 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12FC03C1AD
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:32:37 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id s5so120563uad.4
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0x2OEHLyw3dGuzRqVeh/mjFEZ4zqan5dlSNU19wFYg=;
        b=MHaZ08rBAxgoYcWS2OrLnEUqnlmYV339yCnz+g8TSnpn58ph5ZnZMPbVoc9+rhd5gq
         GOLyObk9MRW7prio4GO8wfGYp9+63xiJgbYvDfYvYk5wXuuMwBANTM8m8GWMTvOdIoeV
         ATkMHFiykwpAcR6wJks9jC5tgaAT1qI/RPFVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0x2OEHLyw3dGuzRqVeh/mjFEZ4zqan5dlSNU19wFYg=;
        b=Sq84/1ygEN1+2jb1juqQGoxLQz384niuZHTz0noOMDT2GQKSBwfweHU3lpAyfn8SYu
         Lc3e/0ruyzXmdngTJ5hQmHU9u+FtPVyuFy/R8R07r8oDDzlM0zz2rSkPxZZLFhYDjJ/Y
         ZRvo0pR0kCamATeXVO8GVslbKE5MopCwQGKMtrUD2MsriSfcuF44O1p3uvpVR1gy/39N
         t6jLomt1c4/WgqHtudvV2w3cDIi9mHOetxfOBH0Lh/8eERW1oQDIkFFPneG+j39Ti9jp
         bZ3m9VaCzT3NFB24zW7ai/74lHBm7/kfNj9sH0NwhfD3xJJDpm0GtD2uHcTylPaZPNkB
         LpBA==
X-Gm-Message-State: AGi0PuZZyfIdY3kYeExVKPpymC/VQ4PQhIAxZhtQya5qRKOPnGu6AYzE
        6J7XMeXd1GpZMbOgK0bv8W7ITLwiHw0=
X-Google-Smtp-Source: APiQypJw7Z0JzVckgRSd38Z93uKtzfAC+hqvTT+9SLuk7jgf2ke/GRzPa6I48VUVasezFqCct8AzdA==
X-Received: by 2002:ab0:2544:: with SMTP id l4mr22284162uan.66.1588109555898;
        Tue, 28 Apr 2020 14:32:35 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id v1sm4059742uao.18.2020.04.28.14.32.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 14:32:34 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id y10so96202uao.8
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:32:34 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr23755292vsp.198.1588109553845;
 Tue, 28 Apr 2020 14:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.6.I8fba5961bf452ab92350654aa61957f23ecf0100@changeid> <20200427163644.pyolyoxdxo3u5w6e@holly.lan>
In-Reply-To: <20200427163644.pyolyoxdxo3u5w6e@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Apr 2020 14:32:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgDz=4_++QV_SWWgWLf0tm1MUyHQdPDUGSVSJzi8UrNQ@mail.gmail.com>
Message-ID: <CAD=FV=VgDz=4_++QV_SWWgWLf0tm1MUyHQdPDUGSVSJzi8UrNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kgdboc: Add earlycon_kgdboc to support early kgdb
 using boot consoles
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de,
        linux-serial@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Apr 27, 2020 at 9:36 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Apr 21, 2020 at 02:14:44PM -0700, Douglas Anderson wrote:
> > We want to enable kgdb to debug the early parts of the kernel.
> > Unfortunately kgdb normally is a client of the tty API in the kernel
> > and serial drivers don't register to the tty layer until fairly late
> > in the boot process.
> >
> > Serial drivers do, however, commonly register a boot console.  Let's
> > enable the kgdboc driver to work with boot consoles to provide early
> > debugging.
> >
> > This change co-opts the existing read() function pointer that's part
> > of "struct console".  It's assumed that if a boot console (with the
> > flag CON_BOOT) has implemented read() that both the read() and write()
> > function are polling functions.  That means they work without
> > interrupts and read() will return immediately (with 0 bytes read) if
> > there's nothing to read.  This should be a safe assumption since it
> > appears that no current boot consoles implement read() right now and
> > there seems no reason to do so unless they wanted to support
> > "earlycon_kgdboc".
> >
> > The console API isn't really intended to have clients work with it
> > like we're doing.  Specifically there doesn't appear to be any way for
> > clients to be notified about a boot console being unregistered.  We'll
> > work around this by checking that our console is still valid before
> > using it.  We'll also try to transition off of the boot console and
> > onto the "tty" API as quickly as possible.
> >
> > The normal/expected way to make all this work is to use
> > "earlycon_kgdboc" and "kgdboc" together.  You should point them both
> > to the same physical serial connection.  At boot time, as the system
> > transitions from the boot console to the normal console, kgdb will
> > switch over.  If you don't use things in the normal/expected way it's
> > a bit of a buyer-beware situation.  Things thought about:
> >
> > - If you specify only "earlycon_kgdboc" but not "kgdboc" you still
> >   might end up dropping into kgdb upon a crash/sysrq but you may not
> >   be able to type.
> > - If you use "keep_bootcon" (which is already a bit of a buyer-beware
> >   option) and specify "earlycon_kgdboc" but not "kgdboc" we'll keep
> >   trying to use your boot console for kgdb.
> > - If your "earlycon_kgdboc" and "kgdboc" devices are not the same
> >   device things should work OK, but it'll be your job to switch over
> >   which device you're monitoring (including figuring out how to switch
> >   over gdb in-flight if you're using it).
> >
> > When trying to enable "earlycon_kgdboc" it should be noted that the
> > names that are registered through the boot console layer and the tty
> > layer are not the same for the same port.  For example when debugging
> > on one board I'd need to pass "earlycon_kgdboc=qcom_geni
> > kgdboc=ttyMSM0" to enable things properly.  Since digging up the boot
> > console name is a pain and there will rarely be more than one boot
> > console enabled, you can provide the "earlycon_kgdboc" parameter
> > without specifying the name of the boot console.  In this case we'll
> > just pick the first boot that implements read() that we find.
> >
> > This new "earlycon_kgdboc" parameter should be contrasted to the
> > existing "ekgdboc" parameter.  While both provide a way to debug very
> > early, the usage and mechanisms are quite different.  Specifically
> > "earlycon_kgdboc" is meant to be used in tandem with "kgdboc" and
> > there is a transition from one to the other.  The "ekgdboc" parameter,
> > on the other hand, replaces the "kgdboc" parameter.  It runs the same
> > logic as the "kgdboc" parameter but just relies on your TTY driver
> > being present super early.  The only known usage of the old "ekgdboc"
> > parameter is documented as "ekgdboc=kbd earlyprintk=vga".  It should
> > be noted that "kbd" has special treatment allowing it to init early as
> > a tty device.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Again, very happy with the overall approach, just a few quibbles.
>
>
> > ---
> > This patch touches files in several different subsystems, but it
> > touches a single line and that line is related to kgdb.  I'm assuming
> > this can all go through the kgdb tree, but if needed I can always
> > introduce a new API call instead of modifying the old one and then
> > just have the old API call be a thin wrapper on the new one.
>
> Funny you should say that!
>
> I don't really like that extra argument although it is nothing to do
> with simplifying merges...
>
>
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index 519d8cfbfbed..2f526f2d2bea 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -409,6 +465,80 @@ static int __init kgdboc_early_init(char *opt)
> >  }
> >
> >  early_param("ekgdboc", kgdboc_early_init);
> > +
> > +static int earlycon_kgdboc_get_char(void)
> > +{
> > +     char c;
> > +
> > +     if (earlycon_neutered || !earlycon->read(earlycon, &c, 1))
> > +             return NO_POLL_CHAR;
> > +
> > +     return c;
> > +}
> > +
> > +static void earlycon_kgdboc_put_char(u8 chr)
> > +{
> > +     if (!earlycon_neutered)
> > +             earlycon->write(earlycon, &chr, 1);
> > +}
> > +
> > +static void earlycon_kgdboc_pre_exp_handler(void)
> > +{
> > +     /*
> > +      * We don't get notified when the boot console is unregistered.
> > +      * Double-check when we enter the debugger.  Unfortunately we
> > +      * can't really unregister ourselves now, but at least don't crash.
> > +      */
> > +     if (earlycon && !earlycon_neutered && !is_earlycon_still_valid()) {
> > +             pr_warn("Neutering kgdb since boot console vanished\n");
> > +             earlycon_neutered = true;
>
> This is, IMHO, too subtle.
>
> I don't think this is merely a warning with a gentle message about
> neutering. IIUC the system is (or will shortly be) dead in the water.
> After diligently stopping all the CPUs the debug-core will then start
> waiting for a character that cannot possibly come!
>
> I think this might be one of those vanishingly rare places where
> panicing might actually the right thing to do... although only after
> neutering" the kgdb panic handler first ;-).

OK.  I ended up adding a patch that makes our general re-entry
handling better and then relying on that since there's no other great
way to neuter the kgdb panic handler.  Then I just called panic().

NOTE: it's actually quite hard to reproduce this.  If you specify
"earlycon_kgdboc" but not "kgdboc" it'll notice at configure_kgdboc()
that the boot console vanished.  I could reproduce this by hacking
configure_kgdboc() not to do this, but otherwise it was hard.

...oh, but I did realize that there's a window where the boot console
has vanished and our init function hasn't yet been called.  That's a
pretty small window on the systems I tested, probably owing to the
fact that kgdboc itself is listed in the serial drivers and is listed
last, so it'll typically probe right after serial drivers do.  ...and
if I hit deferred probing again I should run after the deferred probe
of the serial driver I needed.  It's slightly fragile but maybe it'll
do for now.  I guess if people start hitting this panic we'll have to
figure out what to do.  If we don't want to add hooks in for the
kernel to tell us about this event we could always do something hacky
like poll every millisecond and it's probably work.  For now I'll just
document that people should use "keep_bootcon" if they end up in this
situation.


> > +     }
> > +}
> > +
> > +static struct kgdb_io earlycon_kgdboc_io_ops = {
> > +     .name                   = "earlycon_kgdboc",
> > +     .read_char              = earlycon_kgdboc_get_char,
> > +     .write_char             = earlycon_kgdboc_put_char,
> > +     .pre_exception          = earlycon_kgdboc_pre_exp_handler,
> > +     .is_console             = true,
> > +};
> > +
> > +static int __init earlycon_kgdboc_init(char *opt)
> > +{
> > +     struct console *con;
> > +
> > +     kdb_init(KDB_INIT_EARLY);
>
> This is normally taken care of by debug-core.c . Could this be
> integrated into kgdb_register_io_module() ?

Unfortunately it's not totally trivial.  At least one problem that
feels difficult to solve is that kdb_init() (and all its
sub-functions) are marked "__init" but kgdb_register_io_module() isn't
(and can't be).

One possible solution: I could totally remove this call and things
will work fine, but only if you do "kgdbwait" or if you make sure your
code doesn't crash or hit any hardcoded kgdb_breakpoint() until
dbg_late_init() is called.  That's not totally ideal.  I'm going to
assume it's OK for me to leave the kdb_init() here.

NOTE: I believe that the existing "ekgdboc" has the same issues but
I'm not setup to use "ekgdboc" and so I haven't tested.  If you can
reproduce the "ekgdboc" issue that is there (in theory) I can also
post up a patch that'll fix that the same way...


> > +
> > +     /*
> > +      * Look for a matching console, or if the name was left blank just
> > +      * pick the first one we find.
> > +      */
> > +     console_lock();
> > +     for_each_console(con) {
> > +             if (con->write && con->read &&
> > +                 (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > +                 (!opt || !opt[0] || strcmp(con->name, opt) == 0))
> > +                     break;
> > +     }
> > +     console_unlock();
> > +
> > +     if (!con) {
> > +             pr_info("Couldn't find kgdb earlycon\n");
> > +             return 0;
> > +     }
> > +
> > +     earlycon = con;
> > +     pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> > +     if (kgdb_register_io_module(&earlycon_kgdboc_io_ops, false) != 0) {
> > +             earlycon = NULL;
> > +             pr_info("Failed to register kgdb with earlycon\n");
> > +             return 0;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +early_param("earlycon_kgdboc", earlycon_kgdboc_init);
> >  #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
> >
> >  module_init(init_kgdboc);
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 8f178239856d..1b5435c6d92a 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -1074,16 +1074,21 @@ EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
> >  /**
> >   *   kgdb_register_io_module - register KGDB IO module
> >   *   @new_dbg_io_ops: the io ops vector
> > + *   @replace: If true it's OK if there were old ops.  This is used
> > + *             to transition from early kgdb to normal kgdb.  It's
> > + *             assumed these are the same device so kgdb can continue.
> >   *
> >   *   Register it with the KGDB core.
> >   */
> > -int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
> > +int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops, bool replace)
>
> As I said I'm not a big fan of the extra argument. It makes the call
> sites harder to read.
>
> Could earlycon_kgdboc be registered with a boolean flag set so that
> a subsequent register will automatically replace the old one
> (maybe "is_replaceable" or "is_temporary")?
>
> For bonus marks the core could also enforce that a replaceable io ops
> table must have init set to null (because there is no deinit).

OK.  I ended up adding a "deinit" function call and using that as an
indication that the ops are replaceable.  This cleaned up some of the
earlycon_kgdb code and seemed sane.


-Doug
