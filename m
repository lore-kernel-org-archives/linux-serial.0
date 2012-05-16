From: David Herrmann <dh.herrmann@googlemail.com>
Subject: kmscon: replacing CONFIG_VT
Date: Wed, 16 May 2012 17:58:11 +0200
Message-ID: <CANq1E4SGoRZaGjNZqPOA6g4COQmXxNr4kFBPMhxAonZqO_aOtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34655 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2EPP6M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 May 2012 11:58:12 -0400
Received: by wgbdr13 with SMTP id dr13so895943wgb.1
        for <linux-serial@vger.kernel.org>; Wed, 16 May 2012 08:58:11 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi

I am currently working on replacing the VT layer with a user-space
implementation called "kmscon". It is based on KMS/DRM to control the
video display. I can now successfully run it with CONFIG_VT disabled
and a few hacks to avoid using /dev/ttyX in kmscon.

The idea is to move UI code out of the kernel and getting a full VT520
terminal (full Unicode/font support) implemented in user-space. There
are some other advantages that I will skip here.

I am now working on replacing missing features of the kernel VT. I've
had some deeper look into drivers/tty/vt/ and drivers/video/console/.
The main feature that is missing with CONFIG_VT=n is definitely an
(early-)boot console driver. fbcon and vgacon both provide the consw
driver which then provides the console driver. However, without consw
(tied to VTs) there will also be no
console driver.

I was wondering what the best way to replace them is. I could rewrite
fbcon.c to provide a "struct console" driver instead of a whole consw
driver. Or I could write a drmcon driver that uses the drm api to
provide a console driver. As KMSCON currently runs with DRM only, it
wouldn't matter that drmcon would depend on DRM, too. In short: I need
some shortcut from vgacon/fbcon directly to "struct console" and
dropping the VT-layer in between.

The driver itself would be pretty simply. It would have a ring-buffer
for the messages that are currently printed to the screen and rotate
it as new messages come in. It could then print it via drm
mode-setting if there is currently no other drm application running.
That is, if X/wayland/kmscon shows up, the drmcon driver will go to
sleep and do nothing. kmscon can then read /dev/kmsg and print the
messages if it wants to. If kmscon exits, drmcon will take over and
print the messages again.

Other parts missing with CONFIG_VT=n are probably some ioctls which
won't work with pty. However, all applications that run in xterm will
also run in kmscon. Only applications that use linux ioctl's will not.
However, I don't think that these are needed, but I will watch
carefully while testing it.
That's just some of my ideas on this topic. Maybe you can give me some
hints whether it actually makes sense ;)

Regards
David
